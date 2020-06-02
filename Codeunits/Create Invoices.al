codeunit 50001 "SVA Create Invoice Estate"
{
    // Opsamling af opkrævningslinjer til ordre og automatisk fakturering.
    // Hver lejeaftale opkræves med hver sin faktura.
    // Tilføjet §22

    trigger OnRun();
    begin
        Codeunit.Run(Codeunit::"SVA Retrieve");

        IF DATE2DMY(WorkDate(), 2) = 12 THEN
            InvoiceDate := DMY2DATE(1, 1, DATE2DMY(WorkDate, 3) + 1)
        ELSE
            InvoiceDate := DMY2DATE(1, DATE2DMY(WorkDate, 2) + 1, DATE2DMY(WorkDate, 3));

       //Message(Format(InvoiceDate));

        /* if Answer = Dialog.Confirm('Der dannes faktura pr. ' + FORMAT(InvoiceDate)) = true then
            Error('Kørslen afbrydes'); */

        //Message(Format(InvoiceDate));

        //Test. Is there active subscriptionlines for contracts without enddate
        Ready := 0;
        Occupants.RESET;
        Occupants.SETRANGE(Occupants.StartDate, InvoiceDate - 20000, InvoiceDate); //startdate before or at invoicedate
        Occupants.SETRANGE(Occupants.EndDate, 0D); //No enddate
        Occupants.SETRANGE(Occupants.FirstNets, 0D, InvoiceDate); //FirstNets before or at invoicedate
        IF Occupants.FindSet then begin
            REPEAT
                Subscription.RESET;
                Subscription.SETRANGE(Subscription.Tenancies, Occupants.TenancyNo);
                IF Subscription.FindSet THEN
                    Ready := 0;
                repeat
                    IF (Subscription."Date To" = 0D) OR (Subscription."Date To" > InvoiceDate) then
                        Ready := 1;
                until Subscription.Next = 0;


                IF Ready = 0 THEN BEGIN
                    Error(Occupants.Number + ' mangler opkrævningslinjer. Kørslen afbrydes.');
                end;
            UNTIL Occupants.NEXT = 0;
        end;

        //Test. Is there active subscriptionlines for contracts with an enddate
        Ready := 0;
        Occupants.RESET;
        Occupants.SETRANGE(Occupants.StartDate, InvoiceDate - 20000, InvoiceDate); //startdate before today
        Occupants.SETRANGE(Occupants.EndDate, InvoiceDate + 1, InvoiceDate + 10000);
        Occupants.SETRANGE(Occupants.FirstNets, 0D, InvoiceDate); //FirstNets before or at invoicedate        
        IF Occupants.FindSet THEN BEGIN
            REPEAT
                Subscription.RESET;
                Subscription.SETRANGE(Subscription.Tenancies, Occupants.TenancyNo);
                IF Subscription.FindSet THEN BEGIN
                    ready := 0;
                    repeat
                        IF (Subscription."Date To" = 0D) OR (Subscription."Date To" > InvoiceDate) then
                            Ready := 1
                    until Subscription.Next = 0;
                    IF Ready = 0 THEN BEGIN
                        Error(Occupants.Number + ' mangler opkrævningslinjer. Kørslen afbrydes.');
                    end;
                end;
            UNTIL Occupants.NEXT = 0;
        end;
        //Test. Is there a ledaccount for every active subscriptionline
        Subscription.Reset;
        IF Subscription.FindSet THEN BEGIN
            repeat
                if (Subscription."Date To" = 0D) OR (Subscription."Date To" > InvoiceDate) then begin
                    CostTypeAccounts.Reset;
                    CostTypeAccounts.SetRange(Costtype, Subscription."Cost Types");
                    if not CostTypeAccounts.FindFirst then
                        Error('Konterngsart ' + Subscription."Cost Types" + ' mangler');
                    if CostTypeAccounts.FindFirst then begin
                        if CostTypeAccounts.Account = '' then
                            Error('Konterngsart ' + Subscription."Cost Types" + ' mangler opsætning af finanskonto');
                    end;
                end;
            until Subscription.Next = 0;
        end;
        //Test of subscriptionlines end
        //Test that setup has a paymentmethod
        SetupEstate.Reset();
        if SetupEstate.FindFirst() then begin
            if SetupEstate.PaymentMethodForNets = '' then
                Error(('Der mangler opsætning af betalingsmetode på Opsætning af ejendom.'));
            if SetupEstate.PaymentTerms = '' then
                Error(('Der mangler opsætning af betalingsbetingelser på Opsætning af ejendom.'));
        end;
        //Actual invoicing
        MonthCollection();
        QtYrCollection();
        HalfYrCollection();
        YrCollection();
        //Message('Før journal posting.');
        //Journal posting
        Journal.Reset;
        Journal.SetRange(Journal."Journal Template Name", JournalType);
        Journal.SetRange(Journal."Journal Batch Name", JournalName);
        if Journal.findfirst and Paragraf22 = true then begin
            CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Batch", Journal);
        end;

    end;

    var
        Occupants: Record "SVA Occupant";
        InvoiceDate: Date;
        Subscription: Record "SVA Subscription Lines";
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        LineNo: Integer;
        CostTypeAccounts: Record "SVA Cost type";
        Invoice: Record "Sales Invoice Header";
        Tenancy: Record "SVA Tenancy";
        Cust: Record "Customer";
        Ready: Integer;
        OcNumber: Text[10];
        DoInvoice: Boolean;
        TextPeriod: Text[22];
        SetupEstate: Record "SVA Parameters";
        Days: Integer;
        Answer: Boolean;
        AccountFrom: Code[10];
        Journal: Record "Gen. Journal Line";
        JournalName: Code[10];
        JournalType: Code[10];
        Paragraf22: Boolean;

    local procedure TestForInvoice(Factor: Decimal);
    //Invoice or CrMemo
    var
        InvoiceAmount: Decimal;
        Qty: Decimal;
    begin
        Subscription.RESET;
        Subscription.SETRANGE(Subscription.Tenancies, Occupants.TenancyNo);
        Subscription.SetRange("Date From", InvoiceDate - 20000, InvoiceDate);
        IF Subscription.FindSet THEN BEGIN
            repeat
                IF (Subscription."Date To" = 0D) OR (Subscription."Date To" > InvoiceDate) then begin
                    Qty := 1 * Factor;
                    InvoiceAmount := InvoiceAmount + (Subscription."Amount Period" * Qty);
                end;
            until Subscription.next = 0;
            IF InvoiceAmount >= 0 THEN
                MakeInvoice(Factor, true);
            IF InvoiceAmount < 0 then
                MakeInvoice(Factor, false);
        end;
    end;


    local procedure MakeInvoice(Factor: Decimal; Choise: Boolean);
    begin
        //Test for invoiced on same date
        DoInvoice := true;
        Invoice.RESET;
        Invoice.SETRANGE(Invoice."Posting Date", InvoiceDate);
        Invoice.SETRANGE(Invoice."SVA Occupant", OcNumber);
        IF Invoice.FINDFIRST THEN
            DoInvoice := false;
        //End test
        IF DoInvoice = true then begin
            //Dan ordrehoved
            SalesHeader.INIT;
            if Choise = true then
                SalesHeader.VALIDATE("Document Type", SalesHeader."Document Type"::Invoice);
            if Choise = false then
                SalesHeader.VALIDATE("Document Type", SalesHeader."Document Type"::"Credit Memo");
            SalesHeader."No." := '';
            SalesHeader."Bill-to Customer No." := Occupants."Customer No";
            SalesHeader."Bill-to Name" := Occupants.Name1;
            SalesHeader."Bill-to Address" := Occupants.Address;
            SalesHeader."Bill-to Address 2" := Occupants.Address2;
            SalesHeader."Bill-to Post Code" := Occupants."Post Code";
            SalesHeader."Bill-to City" := Occupants.City;
            SalesHeader."Bill-to Country/Region Code" := Occupants."Country/Region Code";
            SalesHeader."Sell-to Customer No." := Occupants."Customer No";
            SalesHeader."Sell-to Customer Name" := Occupants.Name1;
            SalesHeader."Sell-to Address" := Occupants.Address;
            SalesHeader."Sell-to Address 2" := Occupants.Address2;
            SalesHeader."Sell-to Post Code" := Occupants."Post Code";
            SalesHeader."Sell-to City" := Occupants.City;
            SalesHeader."Sell-to Country/Region Code" := Occupants."Country/Region Code";
            SalesHeader."Due Date" := InvoiceDate;
            SalesHeader."Posting Date" := InvoiceDate;
            SalesHeader."SVA Included" := TRUE;
            SalesHeader."SVA Occupant" := Occupants.Number;
            SalesHeader."Dimension Set ID" := Occupants."Dimension Set Id";
            SalesHeader.Invoice := Choise;

            Cust.RESET;
            Cust.SETRANGE(cust."No.", Occupants."Customer No");
            IF Cust.FINDFIRST() THEN BEGIN
                SalesHeader."Payment Terms Code" := Cust."Payment Terms Code";
                SalesHeader."Currency Code" := Cust."Currency Code";
                SalesHeader."Customer Posting Group" := Cust."Customer Posting Group";
                SalesHeader.Validate("Customer Posting Group");
                SalesHeader."Payment Method Code" := Cust."Payment Method Code";
                SalesHeader."VAT Bus. Posting Group" := Cust."VAT Bus. Posting Group";
                SalesHeader.Validate("VAT Bus. Posting Group");
                SalesHeader."Gen. Bus. Posting Group" := Cust."Gen. Bus. Posting Group";
                SalesHeader.Validate("Gen. Bus. Posting Group");
            end; //Customer
            SalesHeader.INSERT(TRUE);

            LineNo := 0;
            //Dan ordrelinjer
            Subscription.RESET;
            Subscription.SETRANGE(Subscription.Tenancies, Occupants.TenancyNo);
            Subscription.SetRange("Date From", InvoiceDate - 20000, InvoiceDate);
            IF Subscription.FindSet THEN BEGIN
                repeat
                    IF (Subscription."Date To" = 0D) OR (Subscription."Date To" > InvoiceDate) then begin
                        SalesLine.INIT;
                        if Choise = true then
                            SalesLine.VALIDATE(SalesLine."Document Type", SalesHeader."Document Type"::Invoice);
                        if Choise = false then
                            SalesLine.VALIDATE(SalesLine."Document Type", SalesHeader."Document Type"::"Credit Memo");
                        SalesLine."Line No." := LineNo + 1;
                        LineNo := LineNo + 1;
                        SalesLine.Type := 1;
                        SalesLine."Document No." := SalesHeader."No.";
                        //Amount and qty at invoices
                        if Choise = true then begin
                            if Subscription."Amount Period" > 0 then begin
                                SalesLine."Unit Price" := Subscription."Amount Period";
                                Salesline.Quantity := 1 * Factor;
                                SalesLine."Qty. to Invoice" := SalesLine.Quantity;
                                SalesLine."Qty. to Ship" := SalesLine.Quantity;
                                Salesline."Qty. Shipped (Base)" := SalesLine.Quantity;
                            end;
                            if Subscription."Amount Period" < 0 then begin
                                SalesLine."Unit Price" := Subscription."Amount Period" * -1;
                                SalesLine.Quantity := -1 * Factor;
                                SalesLine."Qty. to Invoice" := SalesLine.Quantity;
                                SalesLine."Qty. to Ship" := SalesLine.Quantity;
                                Salesline."Qty. Shipped (Base)" := SalesLine.Quantity;
                            end;
                        end;
                        //Amount and qty at credit memo
                        if Choise = false then begin
                            if Subscription."Amount Period" > 0 then begin
                                SalesLine."Unit Price" := Subscription."Amount Period";
                                Salesline.Quantity := -1 * Factor;
                                SalesLine."Qty. to Invoice" := SalesLine.Quantity;
                                SalesLine."Qty. to Ship" := 0;
                                Salesline."Qty. Shipped (Base)" := 0;
                            end;
                            if Subscription."Amount Period" < 0 then begin
                                SalesLine."Unit Price" := Subscription."Amount Period" * -1;
                                SalesLine.Quantity := 1 * Factor;
                                SalesLine."Qty. to Invoice" := SalesLine.Quantity;
                                SalesLine."Qty. to Ship" := 0;
                                Salesline."Qty. Shipped (Base)" := 0;
                            end;
                        end;
                        SalesLine.Validate(Quantity);
                        SalesLine.Amount := Subscription."Amount Period" * SalesLine.Quantity;
                        SalesLine."VAT Base Amount" := Salesline.Amount;
                        SalesLine."Line Amount" := SalesLine.Amount;
                        SalesLine."Unit of Measure" := 'STK';
                        SalesLine."SVA Costtype" := Subscription."Cost Types";
                        SalesLine."Dimension Set ID" := SalesHeader."Dimension Set ID";
                        SalesLine."Gen. Bus. Posting Group" := SalesHeader."Gen. Bus. Posting Group";
                        Salesline.Validate(SalesLine."Gen. Bus. Posting Group");
                        SalesLine."VAT Bus. Posting Group" := SalesHeader."VAT Bus. Posting Group";
                        SalesLine."VAT Prod. Posting Group" := Subscription.VatGroup;
                        SalesLine.Validate(SalesLine."VAT Prod. Posting Group");
                        SalesLine."Gen. Prod. Posting Group" := Subscription.ProductPostingGroup;
                        SalesLine.Validate("Gen. Prod. Posting Group");
                        //SalesLine.Validate(SalesLine."VAT Bus. Posting Group");
                        SalesLine.Description := Subscription.Description;
                        Salesline."Description 2" := TextPeriod; //

                        CostTypeAccounts.RESET;
                        CostTypeAccounts.SETRANGE(CostTypeAccounts.Costtype, Subscription."Cost Types");
                        IF CostTypeAccounts.FINDFIRST() THEN begin
                            SalesLine."No." := CostTypeAccounts.Account;
                            IF SalesLine.Description = '' THEN
                                SalesLine.Description := CostTypeAccounts.Description;
                            if CostTypeAccounts.Type = 1 then
                                AccountFrom := CosttypeAccounts.Account;
                        end;

                        IF SalesLine.Amount <> 0 THEN
                            SalesLine.INSERT();
                    end;
                UNTIL Subscription.NEXT = 0;
            end; //Subscription find    

            //Posting without send. 
            CODEUNIT.RUN(CODEUNIT::"Sales-Post", SalesHeader);
            //Posting §22, internal maintance
            InternalMaintancePosting(Occupants.Number, AccountFrom);
        end; //DoInvoice
    end;


    Local procedure InternalMaintancePosting(Contract: Text; AccountFrom22: text);
    var
        ContractCard: Record "SVA LeaseContract_A9";
        Parameters: Record "SVA Parameters";
        CosttypeCard: Record "SVA Cost type";

        AccountTo22: Code[10];
        GeneralLedgerLine: Record "Gen. Journal Line";
        GeneralLedgerName: Record "Gen. Journal Batch";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        SourceCodeSetup: Record "Source Code Setup";
        Sektion: text[3];
        Ledaccount: Text[10];
        DocNo: Text[20];
        DoPosting: Boolean;
        Rate: Decimal;
        Costtype22: Code[10];


    begin

        Parameters.Reset;
        if Parameters.FindFirst then begin
            JournalType := Parameters.IM_WorkSheetType;
            JournalName := Parameters.IM_WorkSheet;
            Costtype22 := Parameters.IM_Costtype;
            DoPosting := Parameters.IM_Autoposting;
            Rate := Parameters.IntMaintenance;
            if Rate = 0 then
                Error('Rate is missing.');
        end;
        CosttypeCard.reset;
        CosttypeCard.SetRange(Costtype, Costtype22);
        if CosttypeCard.FindFirst() then
            AccountTo22 := CosttypeCard.Account;
        //Test
        if (AccountTo22 = '') and (DoPosting = true) then
            Error('Account to Internal maintance is missing');

        if DoPosting = true then begin
            ContractCard.Reset();
            ContractCard.SetRange(Number, Contract);
            if ContractCard.FindFirst() then begin
                if ContractCard.TypeA9_8_MaintainceInsideLandl = true then begin
                    //For each contract with IM, make postingline
                    SourceCodeSetup.Get;
                    GeneralLedgerName.Reset;
                    GeneralLedgerName.SetRange(Name, JournalName);
                    GeneralLedgerName.SetRange("Journal Template Name", JournalType);
                    if not GeneralLedgerName.FindFirst then
                        Message('Der er ikke opsat finanskladde til bogføring af §22. Der vil ikke blive dannet bogføringslinjer.');
                    if GeneralLedgerName.FindFirst then begin
                        if DocNo = '' then begin
                            IF GeneralLedgerName."No. Series" <> '' then begin
                                Clear(NoSeriesMgt);
                                DocNo := NoSeriesMgt.GetNextNo(GeneralLedgerName."No. Series", GeneralLedgerLine."Posting Date", false);
                            end;
                        end;
                        GeneralLedgerLine.Reset;
                        GeneralledgerLine."Journal Template Name" := JournalType;
                        GeneralLedgerLine."Journal Batch Name" := JournalName;
                        GeneralLedgerLine.Validate("Journal Batch Name");
                        GeneralLedgerLine.Validate("Line No.", GeneralLedgerLine.GetNewLineNo(Journaltype, JournalName));
                        GeneralLedgerLine."Posting No. Series" := GeneralLedgerName."Posting No. Series";
                        GeneralLedgerLine."Source Code" := SourceCodeSetup."General Journal";
                        GeneralLedgerLine."Document Date" := InvoiceDate;
                        GeneralLedgerLine."Posting Date" := InvoiceDate;
                        GeneralLedgerLine.Validate("Posting Date");
                        GeneralLedgerLine."Document No." := DocNo;
                        GeneralLedgerLine."Document Type" := 0;
                        GeneralLedgerLine.Validate("Document Type");
                        GeneralLedgerLine."Account Type" := 0;
                        GeneralLedgerLine.Validate("Account Type");
                        GeneralLedgerLine."Account No." := AccountFrom22;
                        GeneralLedgerLine.Validate("Account No.");
                        GeneralLedgerLine.Description := Occupants.Number + ' ' + '§22';
                        GeneralLedgerLine.Amount := Rate / 12 * (ContractCard.TypeA9_1_AreaTotal - ContractCard.TypeA9_1_AreaProf);
                        GeneralLedgerLine."Amount (LCY)" := Generalledgerline.Amount;
                        GeneralLedgerLine.Validate(Amount);
                        GeneralLedgerLine."Bal. Account No." := AccountTo22;
                        GeneralLedgerLine."SVA Occupant" := Occupants.Number;
                        if GeneralLedgerLine.Amount <> 0 then begin
                            GeneralLedgerLine.Insert(true);
                            Paragraf22 := true;
                        end;
                    end;

                end;
            end;
        end;
    end;

    local procedure MonthCollection();
    begin
        TextPeriod := ' ' + Format(InvoiceDate) + ' til ' + Format(CalcDate('<1M-1D>', InvoiceDate));
        Days := CalcDate('<1M-1D>', InvoiceDate) - InvoiceDate + 1;
        //Month
        Tenancy.RESET;
        Tenancy.SETRANGE(Tenancy.PeriodYear, 0);
        IF Tenancy.FindSet THEN begin
            REPEAT
                Occupants.RESET;
                Occupants.SETRANGE(Occupants.TenancyNo, Tenancy.Number);
                Occupants.SETRANGE(Occupants.StartDate, InvoiceDate - 20000, InvoiceDate);
                Occupants.SETRANGE(Occupants.FirstNets, 0D, InvoiceDate); //FirstNets before or at invoicedate                    
                Occupants.SETRANGE(Blocked, 0D);
                IF Occupants.FindSet THEN begin
                    REPEAT
                        TextPeriod := ' ' + Format(InvoiceDate) + ' til ' + Format(CalcDate('<1M-1D>', InvoiceDate));
                        //no end date
                        IF Occupants.EndDate = 0D THEN begin //empty enddate
                            OcNumber := Occupants.Number;
                            TestForInvoice(1);
                        end;
                        //Enddate after the invoice month
                        IF Occupants.EndDate >= Calcdate('<1M-1D>', InvoiceDate) then begin
                            OcNumber := Occupants.Number;
                            TestForInvoice(1);
                        end;
                        //Enddate in the middle of invoice period
                        if (Occupants.EndDate > InvoiceDate) and (Occupants.EndDate < Calcdate('<1M-1D>', InvoiceDate)) then begin
                            TextPeriod := ' ' + Format(InvoiceDate) + ' til ' + Format(Occupants.EndDate);
                            SetupEstate.reset;
                            if SetupEstate.findfirst then begin
                                if SetupEstate.Splitcalc = false then begin
                                    OcNumber := Occupants.Number;
                                    TestForInvoice(0.5);
                                end;
                                if SetupEstate.Splitcalc = true then begin
                                    OcNumber := Occupants.Number;
                                    TestForInvoice(Date2DMY(Occupants.EndDate, 1) / Days);
                                end;
                            end;
                        end;

                    UNTIL Occupants.NEXT = 0; //Occupants
                end;
            UNTIL Tenancy.NEXT = 0; //Tenancies
        end;
    end;

    local procedure QtYrCollection();
    begin
        TextPeriod := ' ' + Format(InvoiceDate) + ' til ' + Format(CalcDate('<3M-1D>', InvoiceDate));
        Days := CalcDate('<3M-1D>', InvoiceDate) - InvoiceDate + 1;
        //Quarter
        Tenancy.RESET;
        Tenancy.SETRANGE(Tenancy.PeriodYear, 1);
        IF Tenancy.FindSet THEN begin
            REPEAT
                Occupants.RESET;
                Occupants.SETRANGE(Occupants.TenancyNo, Tenancy.Number);
                Occupants.SETRANGE(Occupants.StartDate, InvoiceDate - 20000, InvoiceDate);
                Occupants.SETRANGE(Occupants."Collection Month", DATE2DMY(InvoiceDate, 2) - 1);//collecion mth = invoice mth.
                Occupants.SETRANGE(Occupants.FirstNets, 0D, InvoiceDate); //FirstNets before or at invoicedate                                
                Occupants.SETRANGE(Blocked, 0D);
                IF Occupants.FindSet THEN begin
                    TextPeriod := ' ' + Format(InvoiceDate) + ' til ' + Format(CalcDate('<3M-1D>', InvoiceDate));
                    REPEAT
                        MakeInvoiceQT;
                    UNTIL Occupants.NEXT = 0; //Occupants this month
                end;

                Occupants.RESET;
                Occupants.SETRANGE(Occupants.TenancyNo, Tenancy.Number);
                Occupants.SETRANGE(Occupants.StartDate, InvoiceDate - 20000, InvoiceDate);
                Occupants.SETRANGE(Occupants."Collection Month", DATE2DMY(InvoiceDate, 2) - 4);//collecion mth = invoice mth - 3.
                Occupants.SETRANGE(Occupants.FirstNets, 0D, InvoiceDate); //FirstNets before or at invoicedate                                            
                IF Occupants.FindSet THEN begin
                    TextPeriod := ' ' + Format(InvoiceDate) + ' til ' + Format(CalcDate('<3M-1D>', InvoiceDate));
                    REPEAT
                        MakeInvoiceQT;
                    UNTIL Occupants.NEXT = 0; //Occupants invoicemonth - 3
                end;

                Occupants.RESET;
                Occupants.SETRANGE(Occupants.TenancyNo, Tenancy.Number);
                Occupants.SETRANGE(Occupants.StartDate, InvoiceDate - 20000, InvoiceDate);
                Occupants.SETRANGE(Occupants."Collection Month", DATE2DMY(InvoiceDate, 2) - 7);//collecion mth = invoice mth - 6.
                Occupants.SETRANGE(Occupants.FirstNets, 0D, InvoiceDate); //FirstNets before or at invoicedate
                IF Occupants.FindSet THEN begin
                    TextPeriod := ' ' + Format(InvoiceDate) + ' til ' + Format(CalcDate('<3M-1D>', InvoiceDate));
                    REPEAT
                        MakeInvoiceQT;
                    UNTIL Occupants.NEXT = 0; //Occupants invoicemonth - 6
                end;

                Occupants.RESET;
                Occupants.SETRANGE(Occupants.TenancyNo, Tenancy.Number);
                Occupants.SETRANGE(Occupants.StartDate, InvoiceDate - 20000, InvoiceDate);
                Occupants.SETRANGE(Occupants."Collection Month", DATE2DMY(InvoiceDate, 2) - 10);//collecion mth = invoice mth - 9.
                Occupants.SETRANGE(Occupants.FirstNets, 0D, InvoiceDate); //FirstNets before or at invoicedate
                IF Occupants.FindSet THEN begin
                    TextPeriod := ' ' + Format(InvoiceDate) + ' til ' + Format(CalcDate('<3M-1D>', InvoiceDate));
                    REPEAT
                        MakeInvoiceQT;
                    UNTIL Occupants.NEXT = 0; //Occupants invoicemonth - 9
                end;

                Occupants.RESET;
                Occupants.SETRANGE(Occupants.TenancyNo, Tenancy.Number);
                Occupants.SETRANGE(Occupants.StartDate, InvoiceDate - 20000, InvoiceDate);
                Occupants.SETRANGE(Occupants."Collection Month", DATE2DMY(InvoiceDate, 2) + 2);//collecion mth = invoice mth + 3.
                Occupants.SETRANGE(Occupants.FirstNets, 0D, InvoiceDate); //FirstNets before or at invoicedate
                IF Occupants.FindSet THEN begin
                    TextPeriod := ' ' + Format(InvoiceDate) + ' til ' + Format(CalcDate('<3M-1D>', InvoiceDate));
                    REPEAT
                        MakeInvoiceQT;
                    UNTIL Occupants.NEXT = 0; //Occupants invoicemonth + 3
                end;

                Occupants.RESET;
                Occupants.SETRANGE(Occupants.TenancyNo, Tenancy.Number);
                Occupants.SETRANGE(Occupants.StartDate, InvoiceDate - 20000, InvoiceDate);
                Occupants.SETRANGE(Occupants."Collection Month", DATE2DMY(InvoiceDate, 2) + 5);//collecion mth = invoice mth + 6.
                Occupants.SETRANGE(Occupants.FirstNets, 0D, InvoiceDate); //FirstNets before or at invoicedate
                IF Occupants.FindSet THEN begin
                    TextPeriod := ' ' + Format(InvoiceDate) + ' til ' + Format(CalcDate('<3M-1D>', InvoiceDate));
                    REPEAT
                        MakeInvoiceQT;
                    UNTIL Occupants.NEXT = 0; //Occupants invoicemonth + 6
                end;

                Occupants.RESET;
                Occupants.SETRANGE(Occupants.TenancyNo, Tenancy.Number);
                Occupants.SETRANGE(Occupants.StartDate, InvoiceDate - 20000, InvoiceDate);
                Occupants.SETRANGE(Occupants."Collection Month", DATE2DMY(InvoiceDate, 2) + 8);//collecion mth = invoice mth + 9.
                Occupants.SETRANGE(Occupants.FirstNets, 0D, InvoiceDate); //FirstNets before or at invoicedate
                IF Occupants.FindSet THEN begin
                    TextPeriod := ' ' + Format(InvoiceDate) + ' til ' + Format(CalcDate('<3M-1D>', InvoiceDate));
                    REPEAT
                        MakeInvoiceQT;
                    UNTIL Occupants.NEXT = 0; //Occupants invoicemonth + 9
                end;
            UNTIL Tenancy.NEXT = 0 //Quarter
        end;
    end;

    local procedure HalfYrCollection();
    begin
        TextPeriod := ' ' + Format(InvoiceDate) + ' til ' + Format(CalcDate('<6M-1D>', InvoiceDate));
        Days := CalcDate('<6M-1D>', InvoiceDate) - InvoiceDate + 1;
        //Half year
        Tenancy.RESET;
        Tenancy.SETRANGE(Tenancy.PeriodYear, 2);
        IF Tenancy.FindSet THEN begin
            REPEAT
                Occupants.RESET;
                Occupants.SETRANGE(Occupants.TenancyNo, Tenancy.Number);
                Occupants.SETRANGE(Occupants.StartDate, InvoiceDate - 20000, InvoiceDate);
                Occupants.SETRANGE(Occupants."Collection Month", DATE2DMY(InvoiceDate, 2) - 1);//collection mth = invoice mth.
                Occupants.SETRANGE(Occupants.FirstNets, 0D, InvoiceDate); //FirstNets before or at invoicedate
                Occupants.SETRANGE(Blocked, 0D);
                IF Occupants.FindSet THEN begin
                    REPEAT
                        MakeInvoiceHY;
                    UNTIL Occupants.NEXT = 0;
                end;

                Occupants.RESET;
                Occupants.SETRANGE(Occupants.TenancyNo, Tenancy.Number);
                Occupants.SETRANGE(Occupants.StartDate, InvoiceDate - 20000, InvoiceDate);
                Occupants.SETRANGE(Occupants."Collection Month", DATE2DMY(InvoiceDate, 2) - 7);//collecion mth = invoice mth - 6.
                Occupants.SETRANGE(Occupants.FirstNets, 0D, InvoiceDate); //FirstNets before or at invoicedate
                IF Occupants.FindSet THEN begin
                    REPEAT
                        MakeInvoiceHY;
                    UNTIL Occupants.NEXT = 0;
                end;

                Occupants.RESET;
                Occupants.SETRANGE(Occupants.TenancyNo, Tenancy.Number);
                Occupants.SETRANGE(Occupants.StartDate, InvoiceDate - 20000, InvoiceDate);
                Occupants.SETRANGE(Occupants."Collection Month", DATE2DMY(InvoiceDate, 2) + 5);//collecion mth = invoice mth + 6.
                Occupants.SETRANGE(Occupants.FirstNets, 0D, InvoiceDate); //FirstNets before or at invoicedate
                IF Occupants.FindSet THEN begin
                    REPEAT
                        MakeInvoiceHY;
                    UNTIL Occupants.NEXT = 0;
                end;
            UNTIL Tenancy.NEXT = 0
        end; //half-year  
    end; //procedure

    local procedure YrCollection();
    begin
        TextPeriod := ' ' + Format(InvoiceDate) + ' til ' + Format(CalcDate('<1Y-1D>', InvoiceDate));
        Days := CalcDate('<1Y-1D>', InvoiceDate) - InvoiceDate + 1;
        //Year
        Tenancy.RESET;
        Tenancy.SETRANGE(Tenancy.PeriodYear, 3);
        IF Tenancy.FindSet THEN begin
            REPEAT
                Occupants.RESET;
                Occupants.SETRANGE(Occupants.TenancyNo, Tenancy.Number);
                Occupants.SETRANGE(Occupants.StartDate, InvoiceDate - 20000, InvoiceDate);
                Occupants.SETRANGE(Occupants."Collection Month", DATE2DMY(InvoiceDate, 2) - 1);//collecion mth = invoice mth.
                Occupants.SETRANGE(Occupants.FirstNets, 0D, InvoiceDate); //FirstNets before or at invoicedate
                Occupants.SETRANGE(Blocked, 0D);
                IF Occupants.FindSet THEN begin
                    REPEAT
                        //No enddate
                        IF Occupants.EndDate = 0D THEN begin //empty enddate
                            OcNumber := Occupants.Number;
                            TestForInvoice(1);
                        end;
                        //Enddate after invoice period
                        IF Occupants.EndDate >= Calcdate('<12M-1D>', InvoiceDate) then begin
                            OcNumber := Occupants.Number;
                            TestForInvoice(1);
                        end;
                        //Enddate in invoice period
                        if (Occupants.EndDate > InvoiceDate) and (Occupants.EndDate < Calcdate('<12M-1D>', InvoiceDate)) then begin
                            TextPeriod := ' ' + Format(InvoiceDate) + ' til ' + Format(Occupants.EndDate);
                            SetupEstate.reset;
                            if SetupEstate.findfirst then begin
                                if SetupEstate.Splitcalc = false then begin
                                    OcNumber := Occupants.Number;
                                    Days := ((InvoiceDate - Occupants.EndDate + 1)); //qty days paying for rent
                                                                                     //Only full months
                                    if (Days > 1) and (Days < 45) then
                                        TestForInvoice(1 / 12);
                                    if (Days > 44) and (Days < 75) then
                                        TestForInvoice(1 / 6);
                                    if (Days > 74) and (Days < 105) then
                                        TestForInvoice(1 / 4);
                                    if (Days > 104) and (Days < 135) then
                                        TestForInvoice(1 / 3);
                                    if (Days > 134) and (Days < 165) then
                                        TestForInvoice(5 / 12);
                                    if (Days > 164) and (Days < 190) then
                                        TestForInvoice(1 / 2);
                                    if (Days > 189) and (Days < 220) then
                                        TestForInvoice(7 / 12);
                                    if (Days > 219) and (Days < 250) then
                                        TestForInvoice(2 / 3);
                                    if (Days > 249) and (Days < 280) then
                                        TestForInvoice(3 / 4);
                                    if (Days > 279) and (Days < 310) then
                                        TestForInvoice(5 / 6);
                                    if (Days > 309) and (Days < 340) then
                                        TestForInvoice(11 / 12);
                                    if (Days > 339) and (Days < 367) then
                                        TestForInvoice(1);
                                end;
                                if SetupEstate.Splitcalc = true then begin
                                    OcNumber := Occupants.Number;
                                    Days := CalcDate('<12M-1D>', Invoicedate) - InvoiceDate + 1;
                                    TestForInvoice((InvoiceDate - Occupants.EndDate + 1) / Days);
                                end;
                            end;
                        end;
                    UNTIL Occupants.NEXT = 0; //Occupants
                end;
            UNTIL Tenancy.NEXT = 0 //tenancies
        end; //year  
    end; //procedure

    local procedure MakeInvoiceQT()
    begin
        TextPeriod := ' ' + Format(InvoiceDate) + ' til ' + Format(CalcDate('<3M-1D>', InvoiceDate));
        //no end date
        IF Occupants.EndDate = 0D THEN begin
            OcNumber := Occupants.Number;
            TestForInvoice(1);
        end;
        //Enddate after the invoice period
        IF Occupants.EndDate > Calcdate('<3M-1D>', InvoiceDate) THEN begin
            OcNumber := Occupants.Number;
            TestForInvoice(1);
        end;
        //Enddate in invoice period
        if (Occupants.EndDate > InvoiceDate) and (Occupants.EndDate < Calcdate('<3M-1D>', InvoiceDate)) then begin
            TextPeriod := ' ' + Format(InvoiceDate) + ' til ' + Format(Occupants.EndDate);
            SetupEstate.reset;
            if SetupEstate.findfirst then begin
                if SetupEstate.Splitcalc = false then begin
                    OcNumber := Occupants.Number;
                    Days := ((InvoiceDate - Occupants.EndDate + 1)); //qty days paying for rent
                    if (Days > 1) and (Days < 18) then
                        TestForInvoice(1 / 6);
                    if (Days > 17) and (Days < 32) then
                        TestForInvoice(1 / 3);
                    if (Days > 31) and (Days < 50) then
                        TestForInvoice(0.5);
                    if (Days > 49) and (Days < 65) then
                        TestForInvoice(2 / 3);
                    if (Days > 64) and (Days < 80) then
                        TestForInvoice(5 / 6);
                    if (Days > 79) then
                        TestForInvoice(1);
                end;
                if SetupEstate.Splitcalc = true then begin
                    TextPeriod := ' ' + Format(InvoiceDate) + ' til ' + Format(Occupants.EndDate);
                    OcNumber := Occupants.Number;
                    //qty days in period 
                    Days := CalcDate('<3M-1D>', Invoicedate) - InvoiceDate + 1;
                    TestForInvoice((InvoiceDate - Occupants.EndDate + 1) / Days);
                end;
            end;
        end;
    end;

    local procedure MakeInvoiceHY()
    begin
        TextPeriod := ' ' + Format(InvoiceDate) + ' til ' + Format(CalcDate('<6M-1D>', InvoiceDate));
        //no end date
        IF Occupants.EndDate = 0D THEN begin
            OcNumber := Occupants.Number;
            TestForInvoice(1);
        end;
        //Enddate after the invoice period
        IF Occupants.EndDate > Calcdate('<6M-1D>', InvoiceDate) THEN begin
            OcNumber := Occupants.Number;
            TestForInvoice(1);
        end;
        //Enddate in invoice period
        if (Occupants.EndDate > InvoiceDate) and (Occupants.EndDate < Calcdate('<6M-1D>', InvoiceDate)) then begin
            TextPeriod := ' ' + Format(InvoiceDate) + ' til ' + Format(Occupants.EndDate);
            SetupEstate.reset;
            if SetupEstate.findfirst then begin
                if SetupEstate.Splitcalc = false then begin
                    OcNumber := Occupants.Number;
                    Days := ((InvoiceDate - Occupants.EndDate + 1)); //qty days paying for rent
                    //Only full months
                    if (Days > 1) and (Days < 45) then
                        TestForInvoice(1 / 6);
                    if (Days > 44) and (Days < 75) then
                        TestForInvoice(1 / 3);
                    if (Days > 74) and (Days < 105) then
                        TestForInvoice(1 / 2);
                    if (Days > 104) and (Days < 135) then
                        TestForInvoice(2 / 3);
                    if (Days > 134) and (Days < 165) then
                        TestForInvoice(5 / 6);
                    if (Days > 164) and (Days < 190) then
                        TestForInvoice(1);
                end;
                if SetupEstate.Splitcalc = true then begin
                    OcNumber := Occupants.Number;
                    Days := CalcDate('<6M-1D>', Invoicedate) - InvoiceDate + 1;
                    TestForInvoice((InvoiceDate - Occupants.EndDate + 1) / Days);
                end;
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 231, 'OnBeforeCode', '', false, false)]
    local procedure HideDialog_LP()
    var
        Journal1: Codeunit "Gen. Jnl.-Post";
        HideDialog: Boolean;
    begin

    end;

}

