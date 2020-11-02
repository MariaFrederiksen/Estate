codeunit 50006 "SVA Create Invoice Estate"
{
    // Opsamling af opkrævningslinjer til ordre og automatisk fakturering.
    // Hver lejeaftale opkræves med hver sin faktura.
    // Tilføjet §22

    trigger OnRun();
    begin
        Codeunit.Run(Codeunit::"SVA Retrieve");

        IF DATE2DMY(WorkDate(), 2) = 12 THEN
            SalesINvoiceHeaderDate := DMY2DATE(1, 1, DATE2DMY(WorkDate(), 3) + 1)
        ELSE
            SalesINvoiceHeaderDate := DMY2DATE(1, DATE2DMY(WorkDate(), 2) + 1, DATE2DMY(WorkDate(), 3));



        if Answer = Dialog.Confirm('Der dannes faktura pr. ' + FORMAT(SalesINvoiceHeaderDate)) = true then
            Error('Kørslen afbrydes');

        //Test. Is there active SVASubscriptionLineslines for contracts without enddate
        Ready := 0;
        SVAOccupant.Reset();
        SVAOccupant.SETRANGE(SVAOccupant.StartDate, SalesINvoiceHeaderDate - 20000, SalesINvoiceHeaderDate); //startdate before or at SalesINvoiceHeaderdate
        SVAOccupant.SETRANGE(SVAOccupant.EndDate, 0D); //No enddate
        SVAOccupant.SETRANGE(SVAOccupant.FirstNets, 0D, SalesINvoiceHeaderDate); //FirstNets before or at SalesINvoiceHeaderdate
        IF SVAOccupant.FindSet() then
            REPEAT
                SVASubscriptionLines.Reset();
                SVASubscriptionLines.SETRANGE(SVASubscriptionLines.Tenancies, SVAOccupant.TenancyNo);
                IF SVASubscriptionLines.FindSet() THEN
                    Ready := 0;
                repeat
                    IF ((SVASubscriptionLines."Date To" = 0D) OR (SVASubscriptionLines."Date To" > SalesINvoiceHeaderDate)) and (SVASubscriptionLines."Date From" <= SalesINvoiceHeaderDate) then
                        Ready := 1;
                until SVASubscriptionLines.NEXT() = 0;


                IF Ready = 0 THEN
                    Error(SubscriptionLinesMissingErr, SVAOccupant.Number);

            UNTIL SVAOccupant.NEXT() = 0;


        //Test. Is there active SVASubscriptionLineslines for contracts with an enddate
        Ready := 0;
        SVAOccupant.Reset();
        SVAOccupant.SETRANGE(SVAOccupant.StartDate, SalesINvoiceHeaderDate - 20000, SalesINvoiceHeaderDate); //startdate before today
        SVAOccupant.SETRANGE(SVAOccupant.EndDate, SalesINvoiceHeaderDate + 1, SalesINvoiceHeaderDate + 10000);
        SVAOccupant.SETRANGE(SVAOccupant.FirstNets, 0D, SalesINvoiceHeaderDate); //FirstNets before or at SalesINvoiceHeaderdate        
        IF SVAOccupant.FindSet() THEN
            REPEAT
                SVASubscriptionLines.Reset();
                SVASubscriptionLines.SETRANGE(SVASubscriptionLines.Tenancies, SVAOccupant.TenancyNo);
                IF SVASubscriptionLines.FindSet() THEN BEGIN
                    ready := 0;
                    repeat
                        IF ((SVASubscriptionLines."Date To" = 0D) OR (SVASubscriptionLines."Date To" > SalesINvoiceHeaderDate)) and (SVASubscriptionLines."Date From" <= SalesINvoiceHeaderDate) then
                            Ready := 1
                    until SVASubscriptionLines.NEXT() = 0;
                    IF Ready = 0 THEN
                        Error(SubscriptionLinesMissingErr, SVAOccupant.Number);

                end;
            UNTIL SVAOccupant.NEXT() = 0;

        //Test. Is there a ledaccount for every active SVASubscriptionLinesline
        SVASubscriptionLines.Reset();
        IF SVASubscriptionLines.FindSet() THEN
            repeat
                if (SVASubscriptionLines."Date To" = 0D) OR (SVASubscriptionLines."Date To" > SalesINvoiceHeaderDate) then begin
                    SVACosttype.Reset();
                    SVACosttype.SetRange(Costtype, SVASubscriptionLines."Cost Types");
                    if not SVACosttype.FindFirst() then
                        Error(CosttypeMissingErr, SVASubscriptionLines."Cost Types");
                    if SVACosttype.FindFirst() then
                        if SVACosttype.Account = '' then
                            Error(CosttypeMissingAccountErr, SVASubscriptionLines."Cost Types");

                end;
            until SVASubscriptionLines.NEXT() = 0;

        //Test of SVASubscriptionLineslines end
        //Test that setup has a paymentmethod
        SVAParameters.Reset();
        if SVAParameters.FindFirst() then begin
            if SVAParameters.PaymentMethodForNets = '' then
                Error(PaymentMethodErr);
            if SVAParameters.PaymentTerms = '' then
                Error(PaymentTermsErr);
        end;
        //Actual invoicing
        MonthCollection();
        QtYrCollection();
        HalfYrCollection();
        YrCollection();

        //Journal posting
        GenJournalLine.Reset();
        GenJournalLine.SetRange(GenJournalLine."Journal Template Name", JournalType);
        GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", JournalName);
        if GenJournalLine.FindFirst() and Paragraf22 = true then
            CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Batch", GenJournalLine);


    end;

    var
        SVAOccupant: Record "SVA Occupant";
        SVASubscriptionLines: Record "SVA Subscription Lines";
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        SVACosttype: Record "SVA Cost type";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SVATenancy: Record "SVA Tenancy";
        Customer: Record "Customer";
        SVAParameters: Record "SVA Parameters";
        GenJournalLine: Record "Gen. Journal Line";
        Ready: Integer;
        OcNumber: Text[10];
        DoSalesINvoiceHeader: Boolean;
        TextPeriod: Text[22];

        Days: Integer;
        Answer: Boolean;
        AccountFrom: Code[10];

        JournalName: Code[10];
        JournalType: Code[10];
        Paragraf22: Boolean;
        SalesINvoiceHeaderDate: Date;
        LineNo: Integer;
        SubscriptionLinesMissingErr: Label '%1 mangler opkrævningslinjer. Kørslen afbrydes.', Comment = '%1 = Occupant number';
        CosttypeMissingErr: label 'Konteringsart %1 mangler', Comment = '%1 = SvaSubscriptionLines.Cost types';
        CosttypeMissingAccountErr: label 'Konteringsart %1  mangler opsætning af finanskonto', Comment = '%1 = SVASubscriptionLines."Cost Types"';
        PaymentMethodErr: Label 'Der mangler opsætning af betalingsmetode på Opsætning af ejendom.';
        PaymentTermsErr: Label 'Der mangler opsætning af betalingsbetingelser på Opsætning af ejendom.';



    local procedure TestForSalesINvoiceHeader(Factor: Decimal);
    //SalesINvoiceHeader or CrMemo
    var
        SalesINvoiceHeaderAmount: Decimal;
        Qty: Decimal;
    begin
        SVASubscriptionLines.Reset();
        SVASubscriptionLines.SETRANGE(SVASubscriptionLines.Tenancies, SVAOccupant.TenancyNo);
        SVASubscriptionLines.SetRange("Date From", SalesINvoiceHeaderDate - 20000, SalesINvoiceHeaderDate);
        IF SVASubscriptionLines.FindSet() THEN BEGIN
            repeat
                IF (SVASubscriptionLines."Date To" = 0D) OR (SVASubscriptionLines."Date To" > SalesINvoiceHeaderDate) then begin
                    Qty := 1 * Factor;
                    SalesINvoiceHeaderAmount := SalesINvoiceHeaderAmount + (SVASubscriptionLines."Amount Period" * Qty);
                end;
            until SVASubscriptionLines.NEXT() = 0;
            IF SalesINvoiceHeaderAmount >= 0 THEN
                MakeSalesINvoiceHeader(Factor, true);
            IF SalesINvoiceHeaderAmount < 0 then
                MakeSalesINvoiceHeader(Factor, false);
        end;
    end;


    local procedure MakeSalesINvoiceHeader(Factor: Decimal; Choise: Boolean);
    begin
        //Test for SalesINvoiceHeaderd on same date
        DoSalesINvoiceHeader := true;
        SalesINvoiceHeader.Reset();
        SalesINvoiceHeader.SETRANGE(SalesINvoiceHeader."Posting Date", SalesINvoiceHeaderDate);
        SalesINvoiceHeader.SETRANGE(SalesINvoiceHeader."SVA Occupant", OcNumber);
        IF SalesINvoiceHeader.FindFirst() THEN
            DoSalesINvoiceHeader := false;
        //End test

        IF DoSalesINvoiceHeader = true then begin
            //Dan ordrehoved
            SalesHeader.INIT();
            if Choise = true then
                SalesHeader.VALIDATE("Document Type", SalesHeader."Document Type"::Invoice);
            if Choise = false then
                SalesHeader.VALIDATE("Document Type", SalesHeader."Document Type"::"Credit Memo");
            SalesHeader."No." := '';
            SalesHeader."Bill-to Customer No." := SVAOccupant."Customer No";
            SalesHeader."Bill-to Name" := SVAOccupant.Name1;
            SalesHeader."Bill-to Address" := SVAOccupant.Address;
            SalesHeader."Bill-to Address 2" := SVAOccupant.Address2;
            SalesHeader."Bill-to Post Code" := SVAOccupant."Post Code";
            SalesHeader."Bill-to City" := SVAOccupant.City;
            SalesHeader."Bill-to Country/Region Code" := SVAOccupant."Country/Region Code";
            SalesHeader."Sell-to Customer No." := SVAOccupant."Customer No";
            SalesHeader."Sell-to Customer Name" := SVAOccupant.Name1;
            SalesHeader."Sell-to Address" := SVAOccupant.Address;
            SalesHeader."Sell-to Address 2" := SVAOccupant.Address2;
            SalesHeader."Sell-to Post Code" := SVAOccupant."Post Code";
            SalesHeader."Sell-to City" := SVAOccupant.City;
            SalesHeader."Sell-to Country/Region Code" := SVAOccupant."Country/Region Code";
            SalesHeader."Due Date" := SalesINvoiceHeaderDate;
            SalesHeader."Posting Date" := SalesINvoiceHeaderDate;
            SalesHeader."SVA Included" := TRUE;
            SalesHeader."SVA Occupant" := SVAOccupant.Number;
            SalesHeader."Dimension Set ID" := SVAOccupant."Dimension Set Id";
            SalesHeader.Invoice := Choise;
            Customer.Reset();
            Customer.SETRANGE(Customer."No.", SVAOccupant."Customer No");
            IF Customer.FINDFIRST() THEN BEGIN
                SalesHeader."Payment Terms Code" := Customer."Payment Terms Code";
                SalesHeader."Currency Code" := Customer."Currency Code";
                SalesHeader."Customer Posting Group" := Customer."Customer Posting Group";
                SalesHeader.Validate("Customer Posting Group");
                SalesHeader."Payment Method Code" := Customer."Payment Method Code";
                SalesHeader."VAT Bus. Posting Group" := Customer."VAT Bus. Posting Group";
                SalesHeader.Validate("VAT Bus. Posting Group");
                SalesHeader."Gen. Bus. Posting Group" := Customer."Gen. Bus. Posting Group";
                SalesHeader.Validate("Gen. Bus. Posting Group");
            end; //Customer
            SalesHeader.INSERT(TRUE);

            LineNo := 0;
            //Dan ordrelinjer
            SVASubscriptionLines.Reset();
            SVASubscriptionLines.SETRANGE(SVASubscriptionLines.Tenancies, SVAOccupant.TenancyNo);
            SVASubscriptionLines.SetRange("Date From", SalesINvoiceHeaderDate - 20000, SalesINvoiceHeaderDate);
            IF SVASubscriptionLines.FindSet() THEN
                repeat
                    IF (SVASubscriptionLines."Date To" = 0D) OR (SVASubscriptionLines."Date To" > SalesINvoiceHeaderDate) then begin
                        SalesLine.INIT();
                        if Choise = true then
                            SalesLine.VALIDATE(SalesLine."Document Type", SalesHeader."Document Type"::Invoice);
                        if Choise = false then
                            SalesLine.VALIDATE(SalesLine."Document Type", SalesHeader."Document Type"::"Credit Memo");
                        SalesLine."Line No." := LineNo + 1;
                        LineNo := LineNo + 1;
                        SalesLine.Type := 1;
                        SalesLine."Document No." := SalesHeader."No.";
                        //Amount and qty at SalesINvoiceHeaders
                        if Choise = true then begin
                            if SVASubscriptionLines."Amount Period" > 0 then begin
                                SalesLine."Unit Price" := SVASubscriptionLines."Amount Period";
                                Salesline.Quantity := 1 * Factor;
                                SalesLine."Qty. to Invoice" := SalesLine.Quantity;
                                SalesLine."Qty. to Ship" := SalesLine.Quantity;
                                Salesline."Qty. Shipped (Base)" := SalesLine.Quantity;
                            end;
                            if SVASubscriptionLines."Amount Period" < 0 then begin
                                SalesLine."Unit Price" := SVASubscriptionLines."Amount Period" * -1;
                                SalesLine.Quantity := -1 * Factor;
                                SalesLine."Qty. to Invoice" := SalesLine.Quantity;
                                SalesLine."Qty. to Ship" := SalesLine.Quantity;
                                Salesline."Qty. Shipped (Base)" := SalesLine.Quantity;
                            end;
                        end;
                        //Amount and qty at credit memo
                        if Choise = false then begin
                            if SVASubscriptionLines."Amount Period" > 0 then begin
                                SalesLine."Unit Price" := SVASubscriptionLines."Amount Period";
                                Salesline.Quantity := -1 * Factor;
                                SalesLine."Qty. to Invoice" := SalesLine.Quantity;
                                SalesLine."Qty. to Ship" := 0;
                                Salesline."Qty. Shipped (Base)" := 0;
                            end;
                            if SVASubscriptionLines."Amount Period" < 0 then begin
                                SalesLine."Unit Price" := SVASubscriptionLines."Amount Period" * -1;
                                SalesLine.Quantity := 1 * Factor;
                                SalesLine."Qty. to Invoice" := SalesLine.Quantity;
                                SalesLine."Qty. to Ship" := 0;
                                Salesline."Qty. Shipped (Base)" := 0;
                            end;
                        end;
                        SalesLine.Validate(Quantity);
                        SalesLine.Amount := SVASubscriptionLines."Amount Period" * SalesLine.Quantity;
                        SalesLine."VAT Base Amount" := Salesline.Amount;
                        SalesLine."Line Amount" := SalesLine.Amount;
                        SalesLine."Unit of Measure" := 'STK';
                        SalesLine."SVA Costtype" := SVASubscriptionLines."Cost Types";
                        SalesLine."Dimension Set ID" := SalesHeader."Dimension Set ID";
                        SalesLine."Gen. Bus. Posting Group" := SalesHeader."Gen. Bus. Posting Group";
                        Salesline.Validate(SalesLine."Gen. Bus. Posting Group");
                        SalesLine."VAT Bus. Posting Group" := SalesHeader."VAT Bus. Posting Group";
                        SalesLine."VAT Prod. Posting Group" := SVASubscriptionLines.VatGroup;
                        SalesLine.Validate(SalesLine."VAT Prod. Posting Group");
                        SalesLine."Gen. Prod. Posting Group" := SVASubscriptionLines.ProductPostingGroup;
                        SalesLine.Validate("Gen. Prod. Posting Group");
                        //SalesLine.Validate(SalesLine."VAT Bus. Posting Group");
                        SalesLine.Description := SVASubscriptionLines.Description;
                        Salesline."Description 2" := TextPeriod; //

                        SVACosttype.Reset();
                        SVACosttype.SETRANGE(SVACosttype.Costtype, SVASubscriptionLines."Cost Types");
                        IF SVACosttype.FINDFIRST() THEN begin
                            SalesLine."No." := SVACosttype.Account;
                            IF SalesLine.Description = '' THEN
                                SalesLine.Description := SVACosttype.Description;
                            if SVACosttype.Type = 1 then
                                AccountFrom := SVACosttype.Account;
                        end;

                        IF SalesLine.Amount <> 0 THEN
                            SalesLine.INSERT();
                    end;
                UNTIL SVASubscriptionLines.NEXT() = 0;
            //SVASubscriptionLines find    

            //Posting without send. 
            CODEUNIT.RUN(CODEUNIT::"Sales-Post", SalesHeader);
            //Posting §22, internal maintance
            InternalMaintancePosting(SVAOccupant.Number, AccountFrom);
        end; //DoSalesINvoiceHeader
    end;


    Local procedure InternalMaintancePosting(Contract: Text; AccountFrom22: text);
    var
        SVALeaseContractA9: Record "SVA LeaseContract_A9";
        l_SVAParameters: Record "SVA Parameters";
        l_SVACosttype: Record "SVA Cost type";
        SourceCodeSetup: Record "Source Code Setup";
        GenJournalBatch: Record "Gen. Journal Batch";
        NoSeriesManagement: Codeunit NoSeriesManagement;
        DocNo: Text[20];
        DoPosting_IM: Boolean;
        Rate: Decimal;
        Costtype22: Code[10];
        AccountTo22: Code[10];
    begin
        SVAParameters.Reset();
        if l_SVAParameters.FindFirst() then begin
            JournalType := l_SVAParameters.IM_WorkSheetType;
            JournalName := l_SVAParameters.IM_WorkSheet;
            Costtype22 := l_SVAParameters.IM_Costtype;
            DoPosting_IM := l_SVAParameters.IM_Autoposting;
            Rate := l_SVAParameters.IntMaintenance;
            if (Rate = 0) and (DoPosting_IM = true) then
                Error('Rate is missing.');
        end;
        l_SVACosttype.Reset();
        l_SVACosttype.SetRange(Costtype, Costtype22);
        if l_SVACosttype.FindFirst() then
            AccountTo22 := l_SVACosttype.Account;
        //Test
        if (AccountTo22 = '') and (DoPosting_IM = true) then
            Error('Account to Internal maintance is missing');

        if DoPosting_IM = true then begin
            SVALeaseContractA9.Reset();
            SVALeaseContractA9.SetRange(Number, Contract);
            if SVALeaseContractA9.FindFirst() then
                if SVALeaseContractA9.TypeA9_8_MaintainceInsideLandl = true then begin
                    //For each contract with IM, make postingline
                    SourceCodeSetup.GET();
                    GenJournalBatch.Reset();
                    GenJournalBatch.SetRange(Name, JournalName);
                    GenJournalBatch.SetRange("Journal Template Name", JournalType);
                    if not GenJournalBatch.FindFirst() then
                        Message('Der er ikke opsat finanskladde til bogføring af §22. Der vil ikke blive dannet bogføringslinjer.');
                    if GenJournalBatch.FindFirst() then
                        if DocNo = '' then begin
                            IF GenJournalBatch."No. Series" <> '' then begin
                                Clear(NoSeriesManagement);
                                DocNo := NoSeriesManagement.GetNextNo(GenJournalBatch."No. Series", GenJournalLine."Posting Date", false);
                            end;

                            GenJournalLine.Reset();
                            GenJournalLine."Journal Template Name" := JournalType;
                            GenJournalLine."Journal Batch Name" := JournalName;
                            GenJournalLine.Validate("Journal Batch Name");
                            GenJournalLine.Validate("Line No.", GenJournalLine.GetNewLineNo(Journaltype, JournalName));
                            GenJournalLine."Posting No. Series" := GenJournalBatch."Posting No. Series";
                            GenJournalLine."Source Code" := SourceCodeSetup."General Journal";
                            GenJournalLine."Document Date" := SalesInvoiceHeaderDate;
                            GenJournalLine."Posting Date" := SalesInvoiceHeaderDate;
                            GenJournalLine.Validate("Posting Date");
                            GenJournalLine."Document No." := DocNo;
                            GenJournalLine."Document Type" := 0;
                            GenJournalLine.Validate("Document Type");
                            GenJournalLine."Account Type" := 0;
                            GenJournalLine.Validate("Account Type");
                            GenJournalLine."Account No." := AccountFrom22;
                            GenJournalLine.Validate("Account No.");
                            GenJournalLine.Description := SVAOccupant.Number + ' ' + '§22';
                            GenJournalLine.Amount := Rate / 12 * (SVALeaseContractA9.TypeA9_1_AreaTotal - SVALeaseContractA9.TypeA9_1_AreaProf);
                            GenJournalLine."Amount (LCY)" := GenJournalLine.Amount;
                            GenJournalLine.Validate(Amount);
                            GenJournalLine."Bal. Account No." := AccountTo22;
                            GenJournalLine."SVA Occupant" := SVAOccupant.Number;
                            if GenJournalLine.Amount <> 0 then begin
                                GenJournalLine.Insert(true);
                                Paragraf22 := true;
                            end;
                        end;
                end;
        end;
    end;

    local procedure MonthCollection();
    begin
        TextPeriod := ' ' + Format(SalesINvoiceHeaderDate) + ' til ' + Format(CalcDate('<1M-1D>', SalesINvoiceHeaderDate));
        Days := CalcDate('<1M-1D>', SalesINvoiceHeaderDate) - SalesINvoiceHeaderDate + 1;
        //Month
        SVATenancy.Reset();
        SVATenancy.SETRANGE(SVATenancy.PeriodYear, 0);
        IF SVATenancy.FindSet() THEN
            REPEAT
                SVAOccupant.Reset();
                SVAOccupant.SETRANGE(SVAOccupant.TenancyNo, SVATenancy.Number);
                SVAOccupant.SETRANGE(SVAOccupant.StartDate, SalesINvoiceHeaderDate - 20000, SalesINvoiceHeaderDate);
                SVAOccupant.SETRANGE(SVAOccupant.FirstNets, 0D, SalesINvoiceHeaderDate); //FirstNets before or at SalesINvoiceHeaderdate                    
                SVAOccupant.SETRANGE(Blocked, 0D);
                IF SVAOccupant.FindSet() THEN
                    REPEAT
                        TextPeriod := ' ' + Format(SalesINvoiceHeaderDate) + ' til ' + Format(CalcDate('<1M-1D>', SalesINvoiceHeaderDate));
                        //no end date
                        IF SVAOccupant.EndDate = 0D THEN begin //empty enddate
                            OcNumber := SVAOccupant.Number;
                            TestForSalesINvoiceHeader(1);
                        end;
                        //Enddate after the SalesINvoiceHeader month
                        IF SVAOccupant.EndDate >= Calcdate('<1M-1D>', SalesINvoiceHeaderDate) then begin
                            OcNumber := SVAOccupant.Number;
                            TestForSalesINvoiceHeader(1);
                        end;
                        //Enddate in the middle of SalesINvoiceHeader period
                        if (SVAOccupant.EndDate > SalesINvoiceHeaderDate) and (SVAOccupant.EndDate < Calcdate('<1M-1D>', SalesINvoiceHeaderDate)) then begin
                            TextPeriod := ' ' + Format(SalesINvoiceHeaderDate) + ' til ' + Format(SVAOccupant.EndDate);
                            SVAParameters.Reset();
                            if SVAParameters.FindFirst() then begin
                                if SVAParameters.Splitcalc = false then begin
                                    OcNumber := SVAOccupant.Number;
                                    TestForSalesINvoiceHeader(0.5);
                                end;
                                if SVAParameters.Splitcalc = true then begin
                                    OcNumber := SVAOccupant.Number;
                                    TestForSalesINvoiceHeader(Date2DMY(SVAOccupant.EndDate, 1) / Days);
                                end;
                            end;
                        end;

                    UNTIL SVAOccupant.NEXT() = 0; //SVAOccupant

            UNTIL SVATenancy.NEXT() = 0; //Tenancies

    end;

    local procedure QtYrCollection();
    begin
        TextPeriod := ' ' + Format(SalesINvoiceHeaderDate) + ' til ' + Format(CalcDate('<3M-1D>', SalesINvoiceHeaderDate));
        Days := CalcDate('<3M-1D>', SalesINvoiceHeaderDate) - SalesINvoiceHeaderDate + 1;
        //Quarter
        SVATenancy.Reset();
        SVATenancy.SETRANGE(SVATenancy.PeriodYear, 1);
        IF SVATenancy.FindSet() THEN
            REPEAT
                SVAOccupant.Reset();
                SVAOccupant.SETRANGE(SVAOccupant.TenancyNo, SVATenancy.Number);
                SVAOccupant.SETRANGE(SVAOccupant.StartDate, SalesINvoiceHeaderDate - 20000, SalesINvoiceHeaderDate);
                SVAOccupant.SETRANGE(SVAOccupant."Collection Month", DATE2DMY(SalesINvoiceHeaderDate, 2) - 1);//collecion mth = SalesINvoiceHeader mth.
                SVAOccupant.SETRANGE(SVAOccupant.FirstNets, 0D, SalesINvoiceHeaderDate); //FirstNets before or at SalesINvoiceHeaderdate                                
                SVAOccupant.SETRANGE(Blocked, 0D);
                IF SVAOccupant.FindSet() THEN begin
                    TextPeriod := ' ' + Format(SalesINvoiceHeaderDate) + ' til ' + Format(CalcDate('<3M-1D>', SalesINvoiceHeaderDate));
                    REPEAT
                        MakeSalesINvoiceHeaderQT();
                    UNTIL SVAOccupant.NEXT() = 0; //SVAOccupant this month
                end;

                SVAOccupant.Reset();
                SVAOccupant.SETRANGE(SVAOccupant.TenancyNo, SVATenancy.Number);
                SVAOccupant.SETRANGE(SVAOccupant.StartDate, SalesINvoiceHeaderDate - 20000, SalesINvoiceHeaderDate);
                SVAOccupant.SETRANGE(SVAOccupant."Collection Month", DATE2DMY(SalesINvoiceHeaderDate, 2) - 4);//collecion mth = SalesINvoiceHeader mth - 3.
                SVAOccupant.SETRANGE(SVAOccupant.FirstNets, 0D, SalesINvoiceHeaderDate); //FirstNets before or at SalesINvoiceHeaderdate                                            
                IF SVAOccupant.FindSet() THEN begin
                    TextPeriod := ' ' + Format(SalesINvoiceHeaderDate) + ' til ' + Format(CalcDate('<3M-1D>', SalesINvoiceHeaderDate));
                    REPEAT
                        MakeSalesINvoiceHeaderQT();
                    UNTIL SVAOccupant.NEXT() = 0; //SVAOccupant SalesINvoiceHeadermonth - 3
                end;

                SVAOccupant.Reset();
                SVAOccupant.SETRANGE(SVAOccupant.TenancyNo, SVATenancy.Number);
                SVAOccupant.SETRANGE(SVAOccupant.StartDate, SalesINvoiceHeaderDate - 20000, SalesINvoiceHeaderDate);
                SVAOccupant.SETRANGE(SVAOccupant."Collection Month", DATE2DMY(SalesINvoiceHeaderDate, 2) - 7);//collecion mth = SalesINvoiceHeader mth - 6.
                SVAOccupant.SETRANGE(SVAOccupant.FirstNets, 0D, SalesINvoiceHeaderDate); //FirstNets before or at SalesINvoiceHeaderdate
                IF SVAOccupant.FindSet() THEN begin
                    TextPeriod := ' ' + Format(SalesINvoiceHeaderDate) + ' til ' + Format(CalcDate('<3M-1D>', SalesINvoiceHeaderDate));
                    REPEAT
                        MakeSalesINvoiceHeaderQT();
                    UNTIL SVAOccupant.NEXT() = 0; //SVAOccupant SalesINvoiceHeadermonth - 6
                end;

                SVAOccupant.Reset();
                SVAOccupant.SETRANGE(SVAOccupant.TenancyNo, SVATenancy.Number);
                SVAOccupant.SETRANGE(SVAOccupant.StartDate, SalesINvoiceHeaderDate - 20000, SalesINvoiceHeaderDate);
                SVAOccupant.SETRANGE(SVAOccupant."Collection Month", DATE2DMY(SalesINvoiceHeaderDate, 2) - 10);//collecion mth = SalesINvoiceHeader mth - 9.
                SVAOccupant.SETRANGE(SVAOccupant.FirstNets, 0D, SalesINvoiceHeaderDate); //FirstNets before or at SalesINvoiceHeaderdate
                IF SVAOccupant.FindSet() THEN begin
                    TextPeriod := ' ' + Format(SalesINvoiceHeaderDate) + ' til ' + Format(CalcDate('<3M-1D>', SalesINvoiceHeaderDate));
                    REPEAT
                        MakeSalesINvoiceHeaderQT();
                    UNTIL SVAOccupant.NEXT() = 0; //SVAOccupant SalesINvoiceHeadermonth - 9
                end;

                SVAOccupant.Reset();
                SVAOccupant.SETRANGE(SVAOccupant.TenancyNo, SVATenancy.Number);
                SVAOccupant.SETRANGE(SVAOccupant.StartDate, SalesINvoiceHeaderDate - 20000, SalesINvoiceHeaderDate);
                SVAOccupant.SETRANGE(SVAOccupant."Collection Month", DATE2DMY(SalesINvoiceHeaderDate, 2) + 2);//collecion mth = SalesINvoiceHeader mth + 3.
                SVAOccupant.SETRANGE(SVAOccupant.FirstNets, 0D, SalesINvoiceHeaderDate); //FirstNets before or at SalesINvoiceHeaderdate
                IF SVAOccupant.FindSet() THEN begin
                    TextPeriod := ' ' + Format(SalesINvoiceHeaderDate) + ' til ' + Format(CalcDate('<3M-1D>', SalesINvoiceHeaderDate));
                    REPEAT
                        MakeSalesINvoiceHeaderQT();
                    UNTIL SVAOccupant.NEXT() = 0; //SVAOccupant SalesINvoiceHeadermonth + 3
                end;

                SVAOccupant.Reset();
                SVAOccupant.SETRANGE(SVAOccupant.TenancyNo, SVATenancy.Number);
                SVAOccupant.SETRANGE(SVAOccupant.StartDate, SalesINvoiceHeaderDate - 20000, SalesINvoiceHeaderDate);
                SVAOccupant.SETRANGE(SVAOccupant."Collection Month", DATE2DMY(SalesINvoiceHeaderDate, 2) + 5);//collecion mth = SalesINvoiceHeader mth + 6.
                SVAOccupant.SETRANGE(SVAOccupant.FirstNets, 0D, SalesINvoiceHeaderDate); //FirstNets before or at SalesINvoiceHeaderdate
                IF SVAOccupant.FindSet() THEN begin
                    TextPeriod := ' ' + Format(SalesINvoiceHeaderDate) + ' til ' + Format(CalcDate('<3M-1D>', SalesINvoiceHeaderDate));
                    REPEAT
                        MakeSalesINvoiceHeaderQT();
                    UNTIL SVAOccupant.NEXT() = 0; //SVAOccupant SalesINvoiceHeadermonth + 6
                end;

                SVAOccupant.Reset();
                SVAOccupant.SETRANGE(SVAOccupant.TenancyNo, SVATenancy.Number);
                SVAOccupant.SETRANGE(SVAOccupant.StartDate, SalesINvoiceHeaderDate - 20000, SalesINvoiceHeaderDate);
                SVAOccupant.SETRANGE(SVAOccupant."Collection Month", DATE2DMY(SalesINvoiceHeaderDate, 2) + 8);//collecion mth = SalesINvoiceHeader mth + 9.
                SVAOccupant.SETRANGE(SVAOccupant.FirstNets, 0D, SalesINvoiceHeaderDate); //FirstNets before or at SalesINvoiceHeaderdate
                IF SVAOccupant.FindSet() THEN begin
                    TextPeriod := ' ' + Format(SalesINvoiceHeaderDate) + ' til ' + Format(CalcDate('<3M-1D>', SalesINvoiceHeaderDate));
                    REPEAT
                        MakeSalesINvoiceHeaderQT();
                    UNTIL SVAOccupant.NEXT() = 0; //SVAOccupant SalesINvoiceHeadermonth + 9
                end;
            UNTIL SVATenancy.NEXT() = 0 //Quarter

    end;

    local procedure HalfYrCollection();
    begin
        TextPeriod := ' ' + Format(SalesINvoiceHeaderDate) + ' til ' + Format(CalcDate('<6M-1D>', SalesINvoiceHeaderDate));
        Days := CalcDate('<6M-1D>', SalesINvoiceHeaderDate) - SalesINvoiceHeaderDate + 1;
        //Half year
        SVATenancy.Reset();
        SVATenancy.SETRANGE(SVATenancy.PeriodYear, 2);
        IF SVATenancy.FindSet() THEN
            REPEAT
                SVAOccupant.Reset();
                SVAOccupant.SETRANGE(SVAOccupant.TenancyNo, SVATenancy.Number);
                SVAOccupant.SETRANGE(SVAOccupant.StartDate, SalesINvoiceHeaderDate - 20000, SalesINvoiceHeaderDate);
                SVAOccupant.SETRANGE(SVAOccupant."Collection Month", DATE2DMY(SalesINvoiceHeaderDate, 2) - 1);//collection mth = SalesINvoiceHeader mth.
                SVAOccupant.SETRANGE(SVAOccupant.FirstNets, 0D, SalesINvoiceHeaderDate); //FirstNets before or at SalesINvoiceHeaderdate
                SVAOccupant.SETRANGE(Blocked, 0D);
                IF SVAOccupant.FindSet() THEN
                    REPEAT
                        MakeSalesINvoiceHeaderHY();
                    UNTIL SVAOccupant.NEXT() = 0;


                SVAOccupant.Reset();
                SVAOccupant.SETRANGE(SVAOccupant.TenancyNo, SVATenancy.Number);
                SVAOccupant.SETRANGE(SVAOccupant.StartDate, SalesINvoiceHeaderDate - 20000, SalesINvoiceHeaderDate);
                SVAOccupant.SETRANGE(SVAOccupant."Collection Month", DATE2DMY(SalesINvoiceHeaderDate, 2) - 7);//collecion mth = SalesINvoiceHeader mth - 6.
                SVAOccupant.SETRANGE(SVAOccupant.FirstNets, 0D, SalesINvoiceHeaderDate); //FirstNets before or at SalesINvoiceHeaderdate
                IF SVAOccupant.FindSet() THEN
                    REPEAT
                        MakeSalesINvoiceHeaderHY();
                    UNTIL SVAOccupant.NEXT() = 0;


                SVAOccupant.Reset();
                SVAOccupant.SETRANGE(SVAOccupant.TenancyNo, SVATenancy.Number);
                SVAOccupant.SETRANGE(SVAOccupant.StartDate, SalesINvoiceHeaderDate - 20000, SalesINvoiceHeaderDate);
                SVAOccupant.SETRANGE(SVAOccupant."Collection Month", DATE2DMY(SalesINvoiceHeaderDate, 2) + 5);//collecion mth = SalesINvoiceHeader mth + 6.
                SVAOccupant.SETRANGE(SVAOccupant.FirstNets, 0D, SalesINvoiceHeaderDate); //FirstNets before or at SalesINvoiceHeaderdate
                IF SVAOccupant.FindSet() THEN
                    REPEAT
                        MakeSalesINvoiceHeaderHY();
                    UNTIL SVAOccupant.NEXT() = 0;

            UNTIL SVATenancy.NEXT() = 0
        //half-year  
    end; //procedure

    local procedure YrCollection();
    begin
        TextPeriod := ' ' + Format(SalesINvoiceHeaderDate) + ' til ' + Format(CalcDate('<1Y-1D>', SalesINvoiceHeaderDate));
        Days := CalcDate('<1Y-1D>', SalesINvoiceHeaderDate) - SalesINvoiceHeaderDate + 1;
        //Year
        SVATenancy.Reset();
        SVATenancy.SETRANGE(SVATenancy.PeriodYear, 3);
        IF SVATenancy.FindSet() THEN
            REPEAT
                SVAOccupant.Reset();
                SVAOccupant.SETRANGE(SVAOccupant.TenancyNo, SVATenancy.Number);
                SVAOccupant.SETRANGE(SVAOccupant.StartDate, SalesINvoiceHeaderDate - 20000, SalesINvoiceHeaderDate);
                SVAOccupant.SETRANGE(SVAOccupant."Collection Month", DATE2DMY(SalesINvoiceHeaderDate, 2) - 1);//collecion mth = SalesINvoiceHeader mth.
                SVAOccupant.SETRANGE(SVAOccupant.FirstNets, 0D, SalesINvoiceHeaderDate); //FirstNets before or at SalesINvoiceHeaderdate
                SVAOccupant.SETRANGE(Blocked, 0D);
                IF SVAOccupant.FindSet() THEN
                    REPEAT
                        //No enddate
                        IF SVAOccupant.EndDate = 0D THEN begin //empty enddate
                            OcNumber := SVAOccupant.Number;
                            TestForSalesINvoiceHeader(1);
                        end;
                        //Enddate after SalesINvoiceHeader period
                        IF SVAOccupant.EndDate >= Calcdate('<12M-1D>', SalesINvoiceHeaderDate) then begin
                            OcNumber := SVAOccupant.Number;
                            TestForSalesINvoiceHeader(1);
                        end;
                        //Enddate in SalesINvoiceHeader period
                        if (SVAOccupant.EndDate > SalesINvoiceHeaderDate) and (SVAOccupant.EndDate < Calcdate('<12M-1D>', SalesINvoiceHeaderDate)) then begin
                            TextPeriod := ' ' + Format(SalesINvoiceHeaderDate) + ' til ' + Format(SVAOccupant.EndDate);
                            SVAParameters.Reset();
                            if SVAParameters.FindFirst() then begin
                                if SVAParameters.Splitcalc = false then begin
                                    OcNumber := SVAOccupant.Number;
                                    Days := ((SalesINvoiceHeaderDate - SVAOccupant.EndDate + 1)); //qty days paying for rent
                                                                                                  //Only full months
                                    if (Days > 1) and (Days < 45) then
                                        TestForSalesINvoiceHeader(1 / 12);
                                    if (Days > 44) and (Days < 75) then
                                        TestForSalesINvoiceHeader(1 / 6);
                                    if (Days > 74) and (Days < 105) then
                                        TestForSalesINvoiceHeader(1 / 4);
                                    if (Days > 104) and (Days < 135) then
                                        TestForSalesINvoiceHeader(1 / 3);
                                    if (Days > 134) and (Days < 165) then
                                        TestForSalesINvoiceHeader(5 / 12);
                                    if (Days > 164) and (Days < 190) then
                                        TestForSalesINvoiceHeader(1 / 2);
                                    if (Days > 189) and (Days < 220) then
                                        TestForSalesINvoiceHeader(7 / 12);
                                    if (Days > 219) and (Days < 250) then
                                        TestForSalesINvoiceHeader(2 / 3);
                                    if (Days > 249) and (Days < 280) then
                                        TestForSalesINvoiceHeader(3 / 4);
                                    if (Days > 279) and (Days < 310) then
                                        TestForSalesINvoiceHeader(5 / 6);
                                    if (Days > 309) and (Days < 340) then
                                        TestForSalesINvoiceHeader(11 / 12);
                                    if (Days > 339) and (Days < 367) then
                                        TestForSalesINvoiceHeader(1);
                                end;
                                if SVAParameters.Splitcalc = true then begin
                                    OcNumber := SVAOccupant.Number;
                                    Days := CalcDate('<12M-1D>', SalesINvoiceHeaderdate) - SalesINvoiceHeaderDate + 1;
                                    TestForSalesINvoiceHeader((SalesINvoiceHeaderDate - SVAOccupant.EndDate + 1) / Days);
                                end;
                            end;
                        end;
                    UNTIL SVAOccupant.NEXT() = 0; //SVAOccupant

            UNTIL SVATenancy.NEXT() = 0 //tenancies
                                        //year  
    end; //procedure

    local procedure MakeSalesINvoiceHeaderQT()
    begin
        TextPeriod := ' ' + Format(SalesINvoiceHeaderDate) + ' til ' + Format(CalcDate('<3M-1D>', SalesINvoiceHeaderDate));
        //no end date
        IF SVAOccupant.EndDate = 0D THEN begin
            OcNumber := SVAOccupant.Number;
            TestForSalesINvoiceHeader(1);
        end;
        //Enddate after the SalesINvoiceHeader period
        IF SVAOccupant.EndDate > Calcdate('<3M-1D>', SalesINvoiceHeaderDate) THEN begin
            OcNumber := SVAOccupant.Number;
            TestForSalesINvoiceHeader(1);
        end;
        //Enddate in SalesINvoiceHeader period
        if (SVAOccupant.EndDate > SalesINvoiceHeaderDate) and (SVAOccupant.EndDate < Calcdate('<3M-1D>', SalesINvoiceHeaderDate)) then begin
            TextPeriod := ' ' + Format(SalesINvoiceHeaderDate) + ' til ' + Format(SVAOccupant.EndDate);
            SVAParameters.Reset();
            if SVAParameters.FindFirst() then begin
                if SVAParameters.Splitcalc = false then begin
                    OcNumber := SVAOccupant.Number;
                    Days := ((SalesINvoiceHeaderDate - SVAOccupant.EndDate + 1)); //qty days paying for rent
                    if (Days > 1) and (Days < 18) then
                        TestForSalesINvoiceHeader(1 / 6);
                    if (Days > 17) and (Days < 32) then
                        TestForSalesINvoiceHeader(1 / 3);
                    if (Days > 31) and (Days < 50) then
                        TestForSalesINvoiceHeader(0.5);
                    if (Days > 49) and (Days < 65) then
                        TestForSalesINvoiceHeader(2 / 3);
                    if (Days > 64) and (Days < 80) then
                        TestForSalesINvoiceHeader(5 / 6);
                    if (Days > 79) then
                        TestForSalesINvoiceHeader(1);
                end;
                if SVAParameters.Splitcalc = true then begin
                    TextPeriod := ' ' + Format(SalesINvoiceHeaderDate) + ' til ' + Format(SVAOccupant.EndDate);
                    OcNumber := SVAOccupant.Number;
                    //qty days in period 
                    Days := CalcDate('<3M-1D>', SalesINvoiceHeaderdate) - SalesINvoiceHeaderDate + 1;
                    TestForSalesINvoiceHeader((SalesINvoiceHeaderDate - SVAOccupant.EndDate + 1) / Days);
                end;
            end;
        end;
    end;

    local procedure MakeSalesINvoiceHeaderHY()
    begin
        TextPeriod := ' ' + Format(SalesINvoiceHeaderDate) + ' til ' + Format(CalcDate('<6M-1D>', SalesINvoiceHeaderDate));
        //no end date
        IF SVAOccupant.EndDate = 0D THEN begin
            OcNumber := SVAOccupant.Number;
            TestForSalesINvoiceHeader(1);
        end;
        //Enddate after the SalesINvoiceHeader period
        IF SVAOccupant.EndDate > Calcdate('<6M-1D>', SalesINvoiceHeaderDate) THEN begin
            OcNumber := SVAOccupant.Number;
            TestForSalesINvoiceHeader(1);
        end;
        //Enddate in SalesINvoiceHeader period
        if (SVAOccupant.EndDate > SalesINvoiceHeaderDate) and (SVAOccupant.EndDate < Calcdate('<6M-1D>', SalesINvoiceHeaderDate)) then begin
            TextPeriod := ' ' + Format(SalesINvoiceHeaderDate) + ' til ' + Format(SVAOccupant.EndDate);
            SVAParameters.Reset();
            if SVAParameters.FindFirst() then begin
                if SVAParameters.Splitcalc = false then begin
                    OcNumber := SVAOccupant.Number;
                    Days := ((SalesINvoiceHeaderDate - SVAOccupant.EndDate + 1)); //qty days paying for rent
                    //Only full months
                    if (Days > 1) and (Days < 45) then
                        TestForSalesINvoiceHeader(1 / 6);
                    if (Days > 44) and (Days < 75) then
                        TestForSalesINvoiceHeader(1 / 3);
                    if (Days > 74) and (Days < 105) then
                        TestForSalesINvoiceHeader(1 / 2);
                    if (Days > 104) and (Days < 135) then
                        TestForSalesINvoiceHeader(2 / 3);
                    if (Days > 134) and (Days < 165) then
                        TestForSalesINvoiceHeader(5 / 6);
                    if (Days > 164) and (Days < 190) then
                        TestForSalesINvoiceHeader(1);
                end;
                if SVAParameters.Splitcalc = true then begin
                    OcNumber := SVAOccupant.Number;
                    Days := CalcDate('<6M-1D>', SalesINvoiceHeaderdate) - SalesINvoiceHeaderDate + 1;
                    TestForSalesINvoiceHeader((SalesINvoiceHeaderDate - SVAOccupant.EndDate + 1) / Days);
                end;
            end;
        end;
    end;



}

