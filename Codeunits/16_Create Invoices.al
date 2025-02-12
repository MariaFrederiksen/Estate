codeunit 50066 "SVA Create Invoice Estate"
{
    // Opsamling af opkrævningslinjer til ordre og automatisk fakturering.
    // Hver lejeaftale opkræves med hver sin faktura.

    Permissions = TableData "Dimension Set Entry" = rm;

    trigger OnRun();
    begin

        Codeunit.Run(Codeunit::"SVA Retrieve");

        IF DATE2DMY(WorkDate(), 2) = 12 THEN
            SalesInvoiceHeaderDate := DMY2DATE(1, 1, DATE2DMY(WorkDate(), 3) + 1)
        ELSE
            SalesInvoiceHeaderDate := DMY2DATE(1, DATE2DMY(WorkDate(), 2) + 1, DATE2DMY(WorkDate(), 3));

        if Answer = Dialog.Confirm('Der dannes faktura pr. ' + FORMAT(SalesInvoiceHeaderDate)) = true then
            Error('Kørslen afbrydes');

        TestBeforeInvoicing();

        //Actual Invoicing
        MonthCollection();
        QtYrCollection();
        HalfYrCollection();
        YrCollection();

        //Journal posting
        Posting_GenJournalLine.Reset();
        Posting_GenJournalLine.SetRange(Posting_GenJournalLine."Journal Template Name", JournalType);
        Posting_GenJournalLine.SetRange(Posting_GenJournalLine."Journal Batch Name", JournalName);
        if Posting_GenJournalLine.FindFirst() and Paragraf22 = true then
            CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post Batch", Posting_GenJournalLine);


    end;

    var
        Posting_GenJournalLine: Record "Gen. Journal LIne";
        TextPeriod: Text[22];
        Days: Integer;
        Answer: Boolean;
        AccountFrom: Code[10];
        JournalName: Code[10];
        JournalType: Code[10];
        Paragraf22: Boolean;
        SalesInvoiceHeaderDate: Date;



    local procedure TestBeforeInvoicing()
    var
        Test_SVAOccupant: Record "SVA Occupant";
        Test_SVASubscriptionlines: Record "SVA Subscription Lines";
        Test_SVAProperty: Record "SVA Property";
        Test_SVACosttype: Record "SVA Cost type";
        Test_SVAParameters: Record "SVA Parameters";
        Ready: Integer;
        SubscriptionLinesMissIngErr: Label '%1 mangler opkrævningslinjer. Kørslen afbrydes.', Comment = '%1 = Occupant number';
        CosttypeMissingErr: label 'Konteringsart %1 mangler', Comment = '%1 = SVASubscriptionlines.Cost types';
        CosttypeMissingAccountErr: label 'Konteringsart %1  mangler opsætnIng af Finanskonto', Comment = '%1 = SVASubscriptionlines."Cost Types"';
        PaymentMethodErr: Label 'Der mangler opsætning af betalingsmetode på Opsætning af ejendom.';
        PaymentTermsErr: Label 'Der mangler opsætning af betalIngsbetIngelser på Opsætning af ejendom.';

    begin
        //Test. Is there a ledaccount for every active SVASubscriptionlinesline
        Test_SVASubscriptionlines.Reset();
        IF Test_SVASubscriptionlines.FindSet() THEN
            repeat
                if (Test_SVASubscriptionlines."Date To" = 0D) OR (Test_SVASubscriptionlines."Date To" > SalesInvoiceHeaderDate) then begin
                    Test_SVACosttype.Reset();
                    Test_SVACosttype.SetRange(Costtype, Test_SVASubscriptionlines."Cost Types");
                    if not Test_SVACosttype.FindFirst() then
                        Error(CosttypeMissIngErr, Test_SVASubscriptionlines."Cost Types");
                    if Test_SVACosttype.FindFirst() then
                        if Test_SVACosttype.Account = '' then
                            Error(CosttypeMissIngAccountErr, Test_SVASubscriptionlines."Cost Types");
                end;
            until Test_SVASubscriptionlines.NEXT() = 0;
        //<--TEST of SVASubscriptionlineslines

        //Test that setup has a paymentmethod
        Test_SVAParameters.Reset();
        if Test_SVAParameters.FindFirst() then begIn
            if Test_SVAParameters.PaymentMethodForNets = '' then
                Error(PaymentMethodErr);
            if Test_SVAParameters.PaymentTerms = '' then
                Error(PaymentTermsErr);
        end;
        //Is there active SVASubscriptionlineslines for all contracts without enddate
        Test_SVAProperty.Reset();
        if Test_SVAProperty.FindSet() then
            repeat
                if (Test_SVAProperty.ArchiveDate < DMY2Date(1, 1, 1960)) OR (Test_SVAProperty.ArchiveDate > SalesInvoiceHeaderDate) then begin
                    Ready := 0;
                    Test_SVAOccupant.Reset();
                    Test_SVAOccupant.SetRange(Test_SVAOccupant.PropertyNo, Test_SVAProperty.Property);
                    Test_SVAOccupant.SETRANGE(Test_SVAOccupant.StartDate, SalesInvoiceHeaderDate - 20000, SalesInvoiceHeaderDate); //startdate before or at SalesInvoiceHeaderDate
                    Test_SVAOccupant.SETRANGE(Test_SVAOccupant.EndDate, 0D); //No enddate
                    Test_SVAOccupant.SETRANGE(Test_SVAOccupant.FirstNets, 0D, SalesInvoiceHeaderDate); //FirstNets before or at SalesInvoiceHeaderDate
                    IF Test_SVAOccupant.FindSet() then
                        repeat
                            Test_SVASubscriptionlines.Reset();
                            Test_SVASubscriptionlines.SETRANGE(Test_SVASubscriptionlines.Tenancies, Test_SVAOccupant.TenancyNo);
                            if Test_SVASubscriptionlines.FindSet() then begin
                                Ready := 0;
                                repeat
                                    IF ((Test_SVASubscriptionlines."Date To" = 0D) OR (Test_SVASubscriptionlines."Date To" > SalesInvoiceHeaderDate)) and (Test_SVASubscriptionlines."Date From" <= SalesInvoiceHeaderDate) then
                                        Ready := 1;
                                until Test_SVASubscriptionlines.NEXT() = 0;
                            end;
                            IF Ready = 0 THEN
                                Error(SubscriptionLinesMissIngErr, Test_SVAOccupant.Number);
                        UNTIL Test_SVAOccupant.NEXT() = 0;
                end;
            until Test_SVAProperty.Next() = 0;

        //Is there active SVASubscriptionlines for contracts with an enddate
        Test_SVAProperty.Reset();
        if Test_SVAProperty.FindSet() then
            repeat
                if (Test_SVAProperty.ArchiveDate < DMY2Date(1, 1, 1960)) OR (Test_SVAProperty.ArchiveDate > SalesInvoiceHeaderDate) then begin
                    Ready := 0;
                    Test_SVAOccupant.Reset();
                    Test_SVAOccupant.SetRange(Test_SVAOccupant.PropertyNo, Test_SVAProperty.Property);
                    Test_SVAOccupant.SETRANGE(Test_SVAOccupant.StartDate, SalesInvoiceHeaderDate - 20000, SalesInvoiceHeaderDate); //startdate before today
                    Test_SVAOccupant.SETRANGE(Test_SVAOccupant.EndDate, SalesInvoiceHeaderDate + 1, SalesInvoiceHeaderDate + 10000);
                    Test_SVAOccupant.SETRANGE(Test_SVAOccupant.FirstNets, 0D, SalesInvoiceHeaderDate); //FirstNets before or at SalesInvoiceHeaderDate        
                    if Test_SVAOccupant.FindSet() then
                        repeat
                            Test_SVASubscriptionlines.Reset();
                            Test_SVASubscriptionlines.SETRANGE(Test_SVASubscriptionlines.Tenancies, Test_SVAOccupant.TenancyNo);
                            IF Test_SVASubscriptionlines.FindSet() then begin
                                ready := 0;
                                repeat
                                    IF ((Test_SVASubscriptionlines."Date To" = 0D) OR (Test_SVASubscriptionlines."Date To" > SalesInvoiceHeaderDate)) and (Test_SVASubscriptionlines."Date From" <= SalesInvoiceHeaderDate) then
                                        Ready := 1
                                until Test_SVASubscriptionlines.NEXT() = 0;
                                if Ready = 0 then
                                    Error(SubscriptionLinesMissIngErr, Test_SVAOccupant.Number);

                            end;
                        until Test_SVAOccupant.Next() = 0;
                end;
            until Test_SVAProperty.Next() = 0;
    end;

    local procedure TestForSalesInvoiceHeader(Factor: Decimal; TenancyNumber: Code[20]; OccupantNumber: Code[20]);
    //SalesInvoiceHeader or CrMemo
    var
        SVASubscriptionlines: Record "SVA Subscription Lines";
        SalesInvoiceHeaderAmount: Decimal;
        Qty: Decimal;
    begin
        SVASubscriptionlines.Reset();
        SVASubscriptionlines.SETRANGE(SVASubscriptionlines.Tenancies, TenancyNumber);
        SVASubscriptionlines.SetRange("Date From", SalesInvoiceHeaderDate - 20000, SalesInvoiceHeaderDate);
        if SVASubscriptionlines.FindSet() then begin
            repeat
                if (SVASubscriptionlines."Date To" = 0D) OR (SVASubscriptionlines."Date To" > SalesInvoiceHeaderDate) then begin
                    Qty := 1 * Factor;
                    SalesInvoiceHeaderAmount := SalesInvoiceHeaderAmount + (SVASubscriptionlines."Amount Period" * Qty);
                end;
            until SVASubscriptionlines.NEXT() = 0;
            if SalesInvoiceHeaderAmount >= 0 then
                MakeSalesInvoiceHeader(Factor, true, OccupantNumber);
            if SalesInvoiceHeaderAmount < 0 then
                MakeSalesInvoiceHeader(Factor, false, OccupantNumber);
        end;
    end;


    local procedure MakeSalesInvoiceHeader(Factor: Decimal; Choise: Boolean; OccupantNumber: code[20]);
    var
        SVASubscriptionlines: Record "SVA Subscription Lines";
        SVAOccupant: Record "SVA Occupant";
        SVACosttype: Record "SVA Cost type";
        SalesHeader: Record "Sales Header";
        Salesline: Record "Sales Line";
        Customer: Record "Customer";
        Test_SalesInvoiceHeader: Record "Sales Invoice Header";
        DoSalesInvoiceHeader: Boolean;
        LineNo: Integer;
    begin
        SVAOccupant.Get(OccupantNumber);
        //Test for SalesInvoiceHeader on same date
        DoSalesInvoiceHeader := false;
        Test_SalesInvoiceHeader.Reset();
        Test_SalesInvoiceHeader.SETRANGE(Test_SalesInvoiceHeader."PostIng Date", SalesInvoiceHeaderDate);
        Test_SalesInvoiceHeader.SETRANGE(Test_SalesInvoiceHeader."SVA Occupant", OccupantNumber);
        if Test_SalesInvoiceHeader.IsEmpty then
            DoSalesInvoiceHeader := true;
        //End test

        IF DoSalesInvoiceHeader = true then begIn
            //Dan ordrehoved
            SalesHeader.Init();
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
            SalesHeader."Due Date" := SalesInvoiceHeaderDate;
            SalesHeader."PostIng Date" := SalesInvoiceHeaderDate;
            SalesHeader."SVA Included" := TRUE;
            SalesHeader."SVA Occupant" := SVAOccupant.Number;
            SalesHeader."Dimension Set ID" := SVAOccupant."Dimension Set Id";
            SalesHeader.Validate("Dimension Set ID");
            SalesHeader.Invoice := Choise;
            Customer.Reset();
            Customer.SETRANGE(Customer."No.", SVAOccupant."Customer No");
            if Customer.FindFirst() then begin
                SalesHeader."Payment Terms Code" := Customer."Payment Terms Code";
                SalesHeader."Currency Code" := Customer."Currency Code";
                SalesHeader."Customer PostIng Group" := Customer."Customer PostIng Group";
                SalesHeader.Validate("Customer PostIng Group");
                SalesHeader."Payment Method Code" := Customer."Payment Method Code";
                SalesHeader."VAT Bus. PostIng Group" := Customer."VAT Bus. PostIng Group";
                SalesHeader.Validate("VAT Bus. PostIng Group");
                SalesHeader."Gen. Bus. PostIng Group" := Customer."Gen. Bus. PostIng Group";
                SalesHeader.Validate("Gen. Bus. PostIng Group");
            end; //Customer
            SalesHeader.INSERT(TRUE);
            SalesHeader."Dimension Set ID" := SVAOccupant."Dimension Set Id";
            SalesHeader.Validate("Dimension Set ID");
            SalesHeader.Modify();

            LineNo := 0;
            //Dan ordrelInjer
            SVASubscriptionlines.Reset();
            SVASubscriptionlines.SETRANGE(SVASubscriptionlines.Tenancies, SVAOccupant.TenancyNo);
            SVASubscriptionlines.SetRange("Date From", SalesInvoiceHeaderDate - 20000, SalesInvoiceHeaderDate);
            IF SVASubscriptionlines.FindSet() THEN
                repeat
                    IF (SVASubscriptionlines."Date To" = 0D) OR (SVASubscriptionlines."Date To" > SalesInvoiceHeaderDate) then begIn
                        Salesline.InIT();
                        if Choise = true then
                            Salesline.VALIDATE(Salesline."Document Type", SalesHeader."Document Type"::Invoice);
                        if Choise = false then
                            Salesline.VALIDATE(Salesline."Document Type", SalesHeader."Document Type"::"Credit Memo");
                        Salesline."Line No." := LineNo + 1;
                        LineNo := LineNo + 1;
                        Salesline.Type := "Sales LIne Type"::"G/L Account";
                        Salesline."Document No." := SalesHeader."No.";
                        //Amount and qty at SalesInvoiceHeaders
                        if Choise = true then begIn
                            if SVASubscriptionlines."Amount Period" > 0 then begIn
                                Salesline."Unit Price" := SVASubscriptionlines."Amount Period";
                                Salesline.Quantity := 1 * Factor;
                                Salesline."Qty. to Invoice" := Salesline.Quantity;
                                Salesline."Qty. to Ship" := Salesline.Quantity;
                                //Salesline."Qty. Shipped (Base)" := Salesline.Quantity;
                            end;
                            if SVASubscriptionlines."Amount Period" < 0 then begIn
                                Salesline."Unit Price" := SVASubscriptionlines."Amount Period" * -1;
                                Salesline.Quantity := -1 * Factor;
                                Salesline."Qty. to Invoice" := Salesline.Quantity;
                                Salesline."Qty. to Ship" := Salesline.Quantity;
                                //Salesline."Qty. Shipped (Base)" := Salesline.Quantity;
                            end;
                        end;
                        //Amount and qty at credit memo
                        if Choise = false then begIn
                            if SVASubscriptionlines."Amount Period" > 0 then begIn
                                Salesline."Unit Price" := SVASubscriptionlines."Amount Period";
                                Salesline.Quantity := -1 * Factor;
                                Salesline."Qty. to Invoice" := Salesline.Quantity;
                                Salesline."Qty. to Ship" := 0;
                                Salesline."Qty. Shipped (Base)" := 0;
                            end;
                            if SVASubscriptionlines."Amount Period" < 0 then begIn
                                Salesline."Unit Price" := SVASubscriptionlines."Amount Period" * -1;
                                Salesline.Quantity := 1 * Factor;
                                Salesline."Qty. to Invoice" := Salesline.Quantity;
                                Salesline."Qty. to Ship" := 0;
                                Salesline."Qty. Shipped (Base)" := 0;
                            end;
                        end;
                        Salesline.Validate(Quantity);
                        Salesline.Amount := SVASubscriptionlines."Amount Period" * Salesline.Quantity;
                        Salesline."VAT Base Amount" := Salesline.Amount;
                        Salesline."LIne Amount" := Salesline.Amount;
                        Salesline."Unit of Measure" := 'STK';
                        Salesline."SVA Costtype" := SVASubscriptionlines."Cost Types";
                        Salesline."Dimension Set ID" := SalesHeader."Dimension Set ID";
                        Salesline."Gen. Bus. PostIng Group" := SalesHeader."Gen. Bus. PostIng Group";
                        Salesline.Validate(Salesline."Gen. Bus. PostIng Group");
                        Salesline."VAT Bus. PostIng Group" := SalesHeader."VAT Bus. PostIng Group";
                        Salesline."VAT Prod. PostIng Group" := SVASubscriptionlines.VatGroup;
                        Salesline.Validate(Salesline."VAT Prod. PostIng Group");
                        Salesline."Gen. Prod. PostIng Group" := SVASubscriptionlines.ProductPostIngGroup;
                        Salesline.Validate("Gen. Prod. PostIng Group");
                        Salesline.Description := SVASubscriptionlines.Description;
                        Salesline."Description 2" := TextPeriod; //

                        SVACosttype.Reset();
                        SVACosttype.SETRANGE(SVACosttype.Costtype, SVASubscriptionlines."Cost Types");
                        IF SVACosttype.FinDFIRST() THEN begIn
                            Salesline."No." := SVACosttype.Account;
                            IF Salesline.Description = '' THEN
                                Salesline.Description := SVACosttype.Description;
                            if SVACosttype.Type = 1 then
                                AccountFrom := SVACosttype.Account;
                        end;

                        IF Salesline.Amount <> 0 THEN
                            Salesline.InSERT();
                    end;
                UNTIL SVASubscriptionlines.NEXT() = 0;
            //SVASubscriptionlines Find    

            //Posting without send. 
            CODEUNIT.RUN(CODEUNIT::"Sales-Post", SalesHeader);
            //PostIng §22, Internal maintance
            InternalMaIntancePostIng(SVAOccupant.Number, AccountFrom);
        end; //DoSalesInvoiceHeader
    end;


    Local procedure InternalMaIntancePostIng(Contract: Text; AccountFrom22: text);
    var
        SVAOccupant: Record "SVA Occupant";
        SVALeaseContractA9: Record "SVA LeaseContract_A9";
        SVAParameters: Record "SVA Parameters";
        l_SVACosttype: Record "SVA Cost type";
        SourceCodeSetup: Record "Source Code Setup";
        GenJournalBatch: Record "Gen. Journal Batch";
        GenJournalLine: Record "Gen. Journal Line";
        NoSeriesManagement: Codeunit NoSeriesManagement;
        DocNo: Text[20];
        DoPostIng_IM: Boolean;
        Rate: Decimal;
        Costtype22: Code[10];
        AccountTo22: Code[10];
    begIn
        SVAParameters.Reset();
        if SVAParameters.FindFirst() then begIn
            JournalType := SVAParameters.IM_WorkSheetType;
            JournalName := SVAParameters.IM_WorkSheet;
            Costtype22 := SVAParameters.IM_Costtype;
            DoPostIng_IM := SVAParameters.IM_AutopostIng;
            Rate := SVAParameters.IntMaIntenance;
            if (Rate = 0) and (DoPostIng_IM = true) then
                Error('Rate is missIng.');
        end;
        l_SVACosttype.Reset();
        l_SVACosttype.SetRange(Costtype, Costtype22);
        if l_SVACosttype.FindFirst() then
            AccountTo22 := l_SVACosttype.Account;
        //Test
        if (AccountTo22 = '') and (DoPostIng_IM = true) then
            Error('Account to Internal maintance is missIng');

        if DoPostIng_IM = true then begIn
            SVALeaseContractA9.Reset();
            SVALeaseContractA9.SetRange(Number, Contract);
            if SVALeaseContractA9.FindFirst() then
                if SVALeaseContractA9.TypeA9_8_MaIntaInceInsideLandl = true then begIn
                    //For each contract with IM, make postingline
                    SourceCodeSetup.GET();
                    GenJournalBatch.Reset();
                    GenJournalBatch.SetRange(Name, JournalName);
                    GenJournalBatch.SetRange("Journal Template Name", JournalType);
                    if not GenJournalBatch.FindFirst() then
                        Message('Der er ikke opsat Finanskladde til bogførIng af §22. Der vil ikke blive dannet bogføringslinjer.');
                    if GenJournalBatch.FindFirst() then
                        if DocNo = '' then begIn
                            IF GenJournalBatch."No. Series" <> '' then begIn
                                Clear(NoSeriesManagement);
                                DocNo := NoSeriesManagement.GetNextNo(GenJournalBatch."No. Series", GenJournalLine."PostIng Date", false);
                            end;

                            GenJournalLine.Reset();
                            GenJournalLine."Journal Template Name" := JournalType;
                            GenJournalLine."Journal Batch Name" := JournalName;
                            GenJournalLine.Validate("Journal Batch Name");
                            GenJournalLine.Validate("LIne No.", GenJournalLine.GetNewLineNo(Journaltype, JournalName));
                            GenJournalLine."PostIng No. Series" := GenJournalBatch."PostIng No. Series";
                            GenJournalLine."Source Code" := SourceCodeSetup."General Journal";
                            GenJournalLine."Document Date" := SalesInvoiceHeaderDate;
                            GenJournalLine."PostIng Date" := SalesInvoiceHeaderDate;
                            GenJournalLine.Validate("PostIng Date");
                            GenJournalLine."Document No." := DocNo;
                            GenJournalLine."Document Type" := "Gen. Journal Document Type"::" ";
                            GenJournalLine.Validate("Document Type");
                            GenJournalLine."Account Type" := "Gen. Journal Account Type"::"G/L Account";
                            GenJournalLine.Validate("Account Type");
                            GenJournalLine."Account No." := AccountFrom22;
                            GenJournalLine.Validate("Account No.");
                            GenJournalLine.Description := SVAOccupant.Number + ' ' + '§22';
                            GenJournalLine.Amount := Rate / 12 * (SVALeaseContractA9.TypeA9_1_AreaTotal - SVALeaseContractA9.TypeA9_1_AreaProf);
                            GenJournalLine."Amount (LCY)" := GenJournalLine.Amount;
                            GenJournalLine.Validate(Amount);
                            GenJournalLine."Bal. Account No." := AccountTo22;
                            GenJournalLine."SVA Occupant" := SVAOccupant.Number;
                            if GenJournalLine.Amount <> 0 then begIn
                                GenJournalLine.Insert(true);
                                Paragraf22 := true;
                            end;
                        end;
                end;
        end;
    end;

    local procedure MonthCollection();
    var
        SVATenancy: Record "SVA Tenancy";
        SVAOccupant: Record "SVA Occupant";
        SVAParameters: Record "SVA Parameters";
    begin
        TextPeriod := ' ' + Format(SalesInvoiceHeaderDate) + ' til ' + Format(CalcDate('<1M-1D>', SalesInvoiceHeaderDate));
        Days := CalcDate('<1M-1D>', SalesInvoiceHeaderDate) - SalesInvoiceHeaderDate + 1;
        //Month
        SVATenancy.Reset();
        SVATenancy.SETRANGE(SVATenancy.PeriodYear, 0);
        if SVATenancy.FindSet() then
            repeat
                if (SVATenancy.ArchiveDate > SalesInvoiceHeaderDate) or (SVATenancy.ArchiveDate < DMY2Date(1, 1, 1960)) then begin
                    SVAOccupant.Reset();
                    SVAOccupant.SETRANGE(SVAOccupant.TenancyNo, SVATenancy.Number);
                    SVAOccupant.SETRANGE(SVAOccupant.StartDate, SalesInvoiceHeaderDate - 20000, SalesInvoiceHeaderDate);
                    SVAOccupant.SETRANGE(SVAOccupant.FirstNets, 0D, SalesInvoiceHeaderDate); //FirstNets before or at SalesInvoiceHeaderDate                    
                    SVAOccupant.SETRANGE(Blocked, 0D);
                    IF SVAOccupant.FindSet() THEN
                        REPEAT
                            TextPeriod := ' ' + Format(SalesInvoiceHeaderDate) + ' til ' + Format(CalcDate('<1M-1D>', SalesInvoiceHeaderDate));
                            //no end date
                            if SVAOccupant.EndDate = 0D then  //empty enddate
                                TestForSalesInvoiceHeader(1, SVAOccupant.TenancyNo, SVAOccupant.Number);

                            //Enddate after the SalesInvoiceHeader month
                            IF SVAOccupant.EndDate >= Calcdate('<1M-1D>', SalesInvoiceHeaderDate) then
                                TestForSalesInvoiceHeader(1, SVAOccupant.TenancyNo, SVAOccupant.Number);

                            //Enddate In the middle of SalesInvoiceHeader period
                            if (SVAOccupant.EndDate > SalesInvoiceHeaderDate) and (SVAOccupant.EndDate < Calcdate('<1M-1D>', SalesInvoiceHeaderDate)) then begIn
                                TextPeriod := ' ' + Format(SalesInvoiceHeaderDate) + ' til ' + Format(SVAOccupant.EndDate);
                                SVAParameters.Reset();
                                if SVAParameters.FindFirst() then begIn
                                    if SVAParameters.Splitcalc = false then
                                        TestForSalesInvoiceHeader(0.5, SVAOccupant.TenancyNo, SVAOccupant.Number);
                                    if SVAParameters.Splitcalc = true then
                                        TestForSalesInvoiceHeader(Date2DMY(SVAOccupant.EndDate, 1) / Days, SVAOccupant.TenancyNo, SVAOccupant.Number);
                                end;
                            end;
                        UNTIL SVAOccupant.NEXT() = 0; //SVAOccupant
                end;
            UNTIL SVATenancy.NEXT() = 0; //Tenancies
    end;

    local procedure QtYrCollection();
    var
        SVAOccupant: Record "SVA Occupant";
        SVATenancy: record "SVA Tenancy";
        Month: Integer;
    begIn
        TextPeriod := ' ' + Format(SalesInvoiceHeaderDate) + ' til ' + Format(CalcDate('<3M-1D>', SalesInvoiceHeaderDate));
        Days := CalcDate('<3M-1D>', SalesInvoiceHeaderDate) - SalesInvoiceHeaderDate + 1;
        Month := DATE2DMY(SalesInvoiceHeaderDate, 2); //1-12
        //Quarter
        SVATenancy.Reset();
        SVATenancy.SETRANGE(SVATenancy.PeriodYear, SVATenancy.PeriodYear::Kvartal);
        IF SVATenancy.FindSet() THEN
            REPEAT
                if (SVATenancy.ArchiveDate > SalesInvoiceHeaderDate) or (SVATenancy.ArchiveDate < DMY2Date(1, 1, 1960)) then begin
                    //Find lejer til lejemålet
                    SVAOccupant.Reset();
                    SVAOccupant.SETRANGE(SVAOccupant.TenancyNo, SVATenancy.Number);
                    SVAOccupant.SETRANGE(SVAOccupant.StartDate, SalesInvoiceHeaderDate - 20000, SalesInvoiceHeaderDate);
                    SVAOccupant.SETRANGE(SVAOccupant.FirstNets, 0D, SalesInvoiceHeaderDate); //FirstNets before or at SalesInvoiceHeaderDate                                
                    SVAOccupant.SETRANGE(Blocked, 0D);
                    IF SVAOccupant.FindSet() then
                        repeat
                            //mangler factor beregning
                            TextPeriod := ' ' + Format(SalesInvoiceHeaderDate) + ' til ' + Format(CalcDate('<3M-1D>', SalesInvoiceHeaderDate));
                            if (Month = 1) AND ((SVAOccupant."Collection Month" = SVAOccupant."Collection Month"::jan) OR
                                                (SVAOccupant."Collection Month" = SVAOccupant."Collection Month"::apr) OR
                                                (SVAOccupant."Collection Month" = SVAOccupant."Collection Month"::jul) OR
                                                (SVAOccupant."Collection Month" = SVAOccupant."Collection Month"::oct)) then
                                DoCreateHeader(SVAOccupant.Number);
                            //TestForSalesInvoiceHeader(1, SVAOccupant.TenancyNo, SVAOccupant.Number);
                            if (Month = 2) AND ((SVAOccupant."Collection Month" = SVAOccupant."Collection Month"::feb) OR
                                                (SVAOccupant."Collection Month" = SVAOccupant."Collection Month"::may) OR
                                                (SVAOccupant."Collection Month" = SVAOccupant."Collection Month"::aug) OR
                                                (SVAOccupant."Collection Month" = SVAOccupant."Collection Month"::nov)) then
                                DoCreateHeader(SVAOccupant.Number);

                            //MakeSalesInvoiceHeaderQT(SVAOccupant.Number);
                            if (Month = 3) AND ((SVAOccupant."Collection Month" = SVAOccupant."Collection Month"::mar) OR
                                            (SVAOccupant."Collection Month" = SVAOccupant."Collection Month"::jun) OR
                                            (SVAOccupant."Collection Month" = SVAOccupant."Collection Month"::sep) OR
                                            (SVAOccupant."Collection Month" = SVAOccupant."Collection Month"::dec)) then
                                DoCreateHeader(SVAOccupant.Number);

                            if (Month = 4) AND ((SVAOccupant."Collection Month" = SVAOccupant."Collection Month"::jan) OR
                                                (SVAOccupant."Collection Month" = SVAOccupant."Collection Month"::apr) OR
                                                (SVAOccupant."Collection Month" = SVAOccupant."Collection Month"::jul) OR
                                                (SVAOccupant."Collection Month" = SVAOccupant."Collection Month"::oct)) then
                                DoCreateHeader(SVAOccupant.Number);
                            if (Month = 5) AND ((SVAOccupant."Collection Month" = SVAOccupant."Collection Month"::feb) OR
                                            (SVAOccupant."Collection Month" = SVAOccupant."Collection Month"::may) OR
                                            (SVAOccupant."Collection Month" = SVAOccupant."Collection Month"::aug) OR
                                            (SVAOccupant."Collection Month" = SVAOccupant."Collection Month"::nov)) then
                                DoCreateHeader(SVAOccupant.Number);
                            if (Month = 6) AND ((SVAOccupant."Collection Month" = SVAOccupant."Collection Month"::mar) OR
                                        (SVAOccupant."Collection Month" = SVAOccupant."Collection Month"::jun) OR
                                        (SVAOccupant."Collection Month" = SVAOccupant."Collection Month"::sep) OR
                                        (SVAOccupant."Collection Month" = SVAOccupant."Collection Month"::dec)) then
                                DoCreateHeader(SVAOccupant.Number);

                            if (Month = 7) AND ((SVAOccupant."Collection Month" = SVAOccupant."Collection Month"::jan) OR
                                                (SVAOccupant."Collection Month" = SVAOccupant."Collection Month"::apr) OR
                                                (SVAOccupant."Collection Month" = SVAOccupant."Collection Month"::jul) OR
                                                (SVAOccupant."Collection Month" = SVAOccupant."Collection Month"::oct)) then
                                DoCreateHeader(SVAOccupant.Number);
                            if (Month = 8) AND ((SVAOccupant."Collection Month" = SVAOccupant."Collection Month"::feb) OR
                                            (SVAOccupant."Collection Month" = SVAOccupant."Collection Month"::may) OR
                                            (SVAOccupant."Collection Month" = SVAOccupant."Collection Month"::aug) OR
                                            (SVAOccupant."Collection Month" = SVAOccupant."Collection Month"::nov)) then
                                DoCreateHeader(SVAOccupant.Number);
                            if (Month = 9) AND ((SVAOccupant."Collection Month" = SVAOccupant."Collection Month"::mar) OR
                                        (SVAOccupant."Collection Month" = SVAOccupant."Collection Month"::jun) OR
                                        (SVAOccupant."Collection Month" = SVAOccupant."Collection Month"::sep) OR
                                        (SVAOccupant."Collection Month" = SVAOccupant."Collection Month"::dec)) then
                                DoCreateHeader(SVAOccupant.Number);
                            if (Month = 10) AND ((SVAOccupant."Collection Month" = SVAOccupant."Collection Month"::jan) OR
                                                (SVAOccupant."Collection Month" = SVAOccupant."Collection Month"::apr) OR
                                                (SVAOccupant."Collection Month" = SVAOccupant."Collection Month"::jul) OR
                                                (SVAOccupant."Collection Month" = SVAOccupant."Collection Month"::oct)) then
                                DoCreateHeader(SVAOccupant.Number);
                            if (Month = 11) AND ((SVAOccupant."Collection Month" = SVAOccupant."Collection Month"::feb) OR
                                            (SVAOccupant."Collection Month" = SVAOccupant."Collection Month"::may) OR
                                            (SVAOccupant."Collection Month" = SVAOccupant."Collection Month"::aug) OR
                                            (SVAOccupant."Collection Month" = SVAOccupant."Collection Month"::nov)) then
                                DoCreateHeader(SVAOccupant.Number);
                            if (Month = 12) AND ((SVAOccupant."Collection Month" = SVAOccupant."Collection Month"::mar) OR
                                        (SVAOccupant."Collection Month" = SVAOccupant."Collection Month"::jun) OR
                                        (SVAOccupant."Collection Month" = SVAOccupant."Collection Month"::sep) OR
                                        (SVAOccupant."Collection Month" = SVAOccupant."Collection Month"::dec)) then
                                DoCreateHeader(SVAOccupant.Number);
                        until SVAOccupant.Next() = 0;
                end;
            UNTIL SVATenancy.NEXT() = 0; //Quarter
    end;

    local procedure HalfYrCollection();
    var
        SVAOccupant: Record "SVA Occupant";
        SVATenancy: Record "SVA Tenancy";
    begIn
        TextPeriod := ' ' + Format(SalesInvoiceHeaderDate) + ' til ' + Format(CalcDate('<6M-1D>', SalesInvoiceHeaderDate));
        Days := CalcDate('<6M-1D>', SalesInvoiceHeaderDate) - SalesInvoiceHeaderDate + 1;
        //Half year
        SVATenancy.Reset();
        SVATenancy.SETRANGE(SVATenancy.PeriodYear, 2);
        IF SVATenancy.FindSet() THEN
            REPEAT
                if (SVATenancy.ArchiveDate > SalesInvoiceHeaderDate) or (SVATenancy.ArchiveDate < DMY2Date(1, 1, 1960)) then begIn
                    SVAOccupant.Reset();
                    SVAOccupant.SETRANGE(SVAOccupant.TenancyNo, SVATenancy.Number);
                    SVAOccupant.SETRANGE(SVAOccupant.StartDate, SalesInvoiceHeaderDate - 20000, SalesInvoiceHeaderDate);
                    SVAOccupant.SETRANGE(SVAOccupant."Collection Month", DATE2DMY(SalesInvoiceHeaderDate, 2) - 1);//collection mth = SalesInvoiceHeader mth.
                    SVAOccupant.SETRANGE(SVAOccupant.FirstNets, 0D, SalesInvoiceHeaderDate); //FirstNets before or at SalesInvoiceHeaderDate
                    SVAOccupant.SETRANGE(Blocked, 0D);
                    IF SVAOccupant.FindSet() THEN
                        REPEAT
                            MakeSalesInvoiceHeaderHY();
                        UNTIL SVAOccupant.NEXT() = 0;


                    SVAOccupant.Reset();
                    SVAOccupant.SETRANGE(SVAOccupant.TenancyNo, SVATenancy.Number);
                    SVAOccupant.SETRANGE(SVAOccupant.StartDate, SalesInvoiceHeaderDate - 20000, SalesInvoiceHeaderDate);
                    SVAOccupant.SETRANGE(SVAOccupant."Collection Month", DATE2DMY(SalesInvoiceHeaderDate, 2) - 7);//collecion mth = SalesInvoiceHeader mth - 6.
                    SVAOccupant.SETRANGE(SVAOccupant.FirstNets, 0D, SalesInvoiceHeaderDate); //FirstNets before or at SalesInvoiceHeaderDate
                    IF SVAOccupant.FindSet() THEN
                        REPEAT
                            MakeSalesInvoiceHeaderHY();
                        UNTIL SVAOccupant.NEXT() = 0;


                    SVAOccupant.Reset();
                    SVAOccupant.SETRANGE(SVAOccupant.TenancyNo, SVATenancy.Number);
                    SVAOccupant.SETRANGE(SVAOccupant.StartDate, SalesInvoiceHeaderDate - 20000, SalesInvoiceHeaderDate);
                    SVAOccupant.SETRANGE(SVAOccupant."Collection Month", DATE2DMY(SalesInvoiceHeaderDate, 2) + 5);//collecion mth = SalesInvoiceHeader mth + 6.
                    SVAOccupant.SETRANGE(SVAOccupant.FirstNets, 0D, SalesInvoiceHeaderDate); //FirstNets before or at SalesInvoiceHeaderDate
                    IF SVAOccupant.FindSet() THEN
                        REPEAT
                            MakeSalesInvoiceHeaderHY();
                        UNTIL SVAOccupant.NEXT() = 0;
                end;
            UNTIL SVATenancy.NEXT() = 0
        //half-year  
    end; //procedure

    local procedure YrCollection();
    var
        SVAOccupant: Record "SVA Occupant";
        SVATenancy: Record "SVA Tenancy";
        SVAParameters: Record "SVA Parameters";
    begIn
        TextPeriod := ' ' + Format(SalesInvoiceHeaderDate) + ' til ' + Format(CalcDate('<1Y-1D>', SalesInvoiceHeaderDate));
        Days := CalcDate('<1Y-1D>', SalesInvoiceHeaderDate) - SalesInvoiceHeaderDate + 1;
        //Year
        SVATenancy.Reset();
        SVATenancy.SETRANGE(SVATenancy.PeriodYear, 3);
        IF SVATenancy.FindSet() THEN
            REPEAT
                if (SVATenancy.ArchiveDate > SalesInvoiceHeaderDate) or (SVATenancy.ArchiveDate < DMY2Date(1, 1, 1960)) then begIn
                    SVAOccupant.Reset();
                    SVAOccupant.SETRANGE(SVAOccupant.TenancyNo, SVATenancy.Number);
                    SVAOccupant.SETRANGE(SVAOccupant.StartDate, SalesInvoiceHeaderDate - 20000, SalesInvoiceHeaderDate);
                    SVAOccupant.SETRANGE(SVAOccupant."Collection Month", DATE2DMY(SalesInvoiceHeaderDate, 2) - 1);//collecion mth = SalesInvoiceHeader mth.
                    SVAOccupant.SETRANGE(SVAOccupant.FirstNets, 0D, SalesInvoiceHeaderDate); //FirstNets before or at SalesInvoiceHeaderDate
                    SVAOccupant.SETRANGE(Blocked, 0D);
                    IF SVAOccupant.FindSet() THEN
                        REPEAT
                            //No enddate
                            IF SVAOccupant.EndDate = 0D THEN //empty enddate
                                TestForSalesInvoiceHeader(1, SVAOccupant.TenancyNo, SVAOccupant.Number);

                            //Enddate after SalesInvoiceHeader period
                            IF SVAOccupant.EndDate >= Calcdate('<12M-1D>', SalesInvoiceHeaderDate) then
                                TestForSalesInvoiceHeader(1, SVAOccupant.TenancyNo, SVAOccupant.Number);

                            //Enddate In SalesInvoiceHeader period
                            if (SVAOccupant.EndDate > SalesInvoiceHeaderDate) and (SVAOccupant.EndDate < Calcdate('<12M-1D>', SalesInvoiceHeaderDate)) then begIn
                                TextPeriod := ' ' + Format(SalesInvoiceHeaderDate) + ' til ' + Format(SVAOccupant.EndDate);
                                SVAParameters.Reset();
                                if SVAParameters.FindFirst() then begIn
                                    if SVAParameters.Splitcalc = false then begIn
                                        Days := ((SalesInvoiceHeaderDate - SVAOccupant.EndDate + 1)); //qty days payIng for rent
                                                                                                      //Only full months
                                        if (Days > 1) and (Days < 45) then
                                            TestForSalesInvoiceHeader(1 / 12, SVAOccupant.TenancyNo, SVAOccupant.Number);
                                        if (Days > 44) and (Days < 75) then
                                            TestForSalesInvoiceHeader(1 / 6, SVAOccupant.TenancyNo, SVAOccupant.Number);
                                        if (Days > 74) and (Days < 105) then
                                            TestForSalesInvoiceHeader(1 / 4, SVAOccupant.TenancyNo, SVAOccupant.Number);
                                        if (Days > 104) and (Days < 135) then
                                            TestForSalesInvoiceHeader(1 / 3, SVAOccupant.TenancyNo, SVAOccupant.Number);
                                        if (Days > 134) and (Days < 165) then
                                            TestForSalesInvoiceHeader(5 / 12, SVAOccupant.TenancyNo, SVAOccupant.Number);
                                        if (Days > 164) and (Days < 190) then
                                            TestForSalesInvoiceHeader(1 / 2, SVAOccupant.TenancyNo, SVAOccupant.Number);
                                        if (Days > 189) and (Days < 220) then
                                            TestForSalesInvoiceHeader(7 / 12, SVAOccupant.TenancyNo, SVAOccupant.Number);
                                        if (Days > 219) and (Days < 250) then
                                            TestForSalesInvoiceHeader(2 / 3, SVAOccupant.TenancyNo, SVAOccupant.Number);
                                        if (Days > 249) and (Days < 280) then
                                            TestForSalesInvoiceHeader(3 / 4, SVAOccupant.TenancyNo, SVAOccupant.Number);
                                        if (Days > 279) and (Days < 310) then
                                            TestForSalesInvoiceHeader(5 / 6, SVAOccupant.TenancyNo, SVAOccupant.Number);
                                        if (Days > 309) and (Days < 340) then
                                            TestForSalesInvoiceHeader(11 / 12, SVAOccupant.TenancyNo, SVAOccupant.Number);
                                        if (Days > 339) and (Days < 367) then
                                            TestForSalesInvoiceHeader(1, SVAOccupant.TenancyNo, SVAOccupant.Number);
                                    end;
                                    if SVAParameters.Splitcalc = true then begIn
                                        Days := CalcDate('<12M-1D>', SalesInvoiceHeaderDate) - SalesInvoiceHeaderDate + 1;
                                        TestForSalesInvoiceHeader(((SalesInvoiceHeaderDate - SVAOccupant.EndDate + 1) / Days), SVAOccupant.TenancyNo, SVAOccupant.Number);
                                    end;
                                end;
                            end;
                        UNTIL SVAOccupant.NEXT() = 0; //SVAOccupant
                end;
            UNTIL SVATenancy.NEXT() = 0 //tenancies
                                        //year  
    end; //procedure
    
    local procedure MakeSalesInvoiceHeaderHY()
    var
        SVAOccupant: Record "SVA Occupant";
        SVAParameters: Record "SVA Parameters";
        Days: Integer;
    begIn
        TextPeriod := ' ' + Format(SalesInvoiceHeaderDate) + ' til ' + Format(CalcDate('<6M-1D>', SalesInvoiceHeaderDate));
        //no end date
        IF SVAOccupant.EndDate = 0D THEN
            TestForSalesInvoiceHeader(1, SVAOccupant.TenancyNo, SVAOccupant.Number);

        //Enddate after the SalesInvoiceHeader period
        IF SVAOccupant.EndDate > Calcdate('<6M-1D>', SalesInvoiceHeaderDate) THEN
            TestForSalesInvoiceHeader(1, SVAOccupant.TenancyNo, SVAOccupant.Number);

        //Enddate In SalesInvoiceHeader period
        if (SVAOccupant.EndDate > SalesInvoiceHeaderDate) and (SVAOccupant.EndDate < Calcdate('<6M-1D>', SalesInvoiceHeaderDate)) then begIn
            TextPeriod := ' ' + Format(SalesInvoiceHeaderDate) + ' til ' + Format(SVAOccupant.EndDate);
            SVAParameters.Reset();
            if SVAParameters.FindFirst() then begIn
                if SVAParameters.Splitcalc = false then begIn
                    Days := ((SalesInvoiceHeaderDate - SVAOccupant.EndDate + 1)); //qty days payIng for rent
                    //Only full months
                    if (Days > 1) and (Days < 45) then
                        TestForSalesInvoiceHeader(1 / 6, SVAOccupant.TenancyNo, SVAOccupant.Number);
                    if (Days > 44) and (Days < 75) then
                        TestForSalesInvoiceHeader(1 / 3, SVAOccupant.TenancyNo, SVAOccupant.Number);
                    if (Days > 74) and (Days < 105) then
                        TestForSalesInvoiceHeader(1 / 2, SVAOccupant.TenancyNo, SVAOccupant.Number);
                    if (Days > 104) and (Days < 135) then
                        TestForSalesInvoiceHeader(2 / 3, SVAOccupant.TenancyNo, SVAOccupant.Number);
                    if (Days > 134) and (Days < 165) then
                        TestForSalesInvoiceHeader(5 / 6, SVAOccupant.TenancyNo, SVAOccupant.Number);
                    if (Days > 164) and (Days < 190) then
                        TestForSalesInvoiceHeader(1, SVAOccupant.TenancyNo, SVAOccupant.Number);
                end;
                if SVAParameters.Splitcalc = true then begIn
                    Days := CalcDate('<6M-1D>', SalesInvoiceHeaderDate) - SalesInvoiceHeaderDate + 1;
                    TestForSalesInvoiceHeader(((SalesInvoiceHeaderDate - SVAOccupant.EndDate + 1) / Days), SVAOccupant.TenancyNo, SVAOccupant.Number);
                end;
            end;
        end;
    end;

    local procedure DoCreateHeader(Number: Text[20])
    var
        SVAParameters: Record "SVA Parameters";
        SVAOccupant: Record "SVA Occupant";
    begin
        SVAOccupant.Reset();
        SVAOccupant.Get(Number);

        if SVAOccupant.EndDate = 0D then  //empty enddate
            TestForSalesInvoiceHeader(1, SVAOccupant.TenancyNo, SVAOccupant.Number);

        //Enddate after the SalesInvoiceHeader month
        IF SVAOccupant.EndDate >= Calcdate('<1M-1D>', SalesInvoiceHeaderDate) then
            TestForSalesInvoiceHeader(1, SVAOccupant.TenancyNo, SVAOccupant.Number);

        //Enddate In the middle of SalesInvoiceHeader period
        if (SVAOccupant.EndDate > SalesInvoiceHeaderDate) and (SVAOccupant.EndDate < Calcdate('<1M-1D>', SalesInvoiceHeaderDate)) then begIn
            TextPeriod := ' ' + Format(SalesInvoiceHeaderDate) + ' til ' + Format(SVAOccupant.EndDate);
            SVAParameters.Reset();
            if SVAParameters.FindFirst() then begIn
                if SVAParameters.Splitcalc = false then
                    TestForSalesInvoiceHeader(0.5, SVAOccupant.TenancyNo, SVAOccupant.Number);
                if SVAParameters.Splitcalc = true then
                    TestForSalesInvoiceHeader(Date2DMY(SVAOccupant.EndDate, 1) / Days, SVAOccupant.TenancyNo, SVAOccupant.Number);
            end;
        end;
    end;



}

