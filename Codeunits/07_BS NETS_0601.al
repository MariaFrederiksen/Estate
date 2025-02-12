codeunit 50007 "SVA NETS BS 0601"
{
    // Flere ejendomme med forskellige aftalenr eller debitorgrupper i regnskabet, men samme dataleverandør
    // Windows encoding. (korrekt æøå)
    Permissions = tabledata 112 = rimd;

    trigger OnRun();
    begin
        Codeunit.Run(Codeunit::"SVA Send");
        SVAExport.Reset();
        SVAExport.SetRange(Name, 'BS0601');
        if SVAExport.FindSet() then
            SVAExport.DeleteAll();

        IF DATE2DMY(TODAY, 2) = 12 THEN
            FromDate := DMY2DATE(1, 1, DATE2DMY(TODAY, 3) + 1)
        ELSE
            FromDate := DMY2DATE(1, DATE2DMY(TODAY, 2) + 1, DATE2DMY(TODAY, 3));

        ToDate := CALCDATE('<1M-1D>', FromDate);

        SVAParameters.Reset();
        IF SVAParameters.Findfirst() then begin
            Datasupplier := SVAParameters.BS_Dataprovider;
            Subsystem := SVAParameters.BS_Delsystem;
            CreditorPBSno := SVAParameters.BS_AftaleNo;
            Arrears := SVAParameters.CustomerArrears;
            DebtorGroupNo := SVAParameters.BS_DebGrp;
            Advis := SVAParameters.BS_Advis;
            PaymentMethod := SVAParameters.PaymentMethodForNets;
        end;
        IF StrLen(Datasupplier) = 0 then
            Error('Der mangler opsætning. Kørslen afbrydes.');

        CompanyInformation.GET();

        F002();

        //Search property
        SVAProperty.Reset();
        if SVAProperty.FindSet() then
            repeat
                Customer.Reset();
                Customer.SetRange("Payment Method Code", PaymentMethod);
                if Customer.FindSet() then
                    repeat
                        //Dueamount
                        DueAmount := 0;
                        if Arrears = true then
                            DueAmount := Customer.CalcOverdueBalance();
                        //SVAContractregulations
                        Repayment := 0;
                        SalesInvoiceHeader.Reset();
                        SalesInvoiceHeader.SETRANGE(SalesInvoiceHeader."Bill-to Customer No.", Customer."No.");
                        SalesInvoiceHeader.SETRANGE(SalesInvoiceHeader."SVA Included", TRUE);
                        SalesInvoiceHeader.SETRANGE(SalesInvoiceHeader."SVA Send", FALSE);
                        SalesInvoiceHeader.SETRANGE(SalesInvoiceHeader."Due Date", FromDate, ToDate);
                        SalesInvoiceHeader.SetRange(SalesInvoiceHeader.Closed, false);
                        if SalesInvoiceHeader.FindSet() then
                            repeat
                                SVAContractregulations.Reset();
                                SVAContractregulations.SetRange(SVAContractregulations.Number, SalesinvoiceHeader."SVA Occupant");
                                IF SVAContractregulations.FindFirst() then
                                    if (SVAContractregulations.RepaymentPeriod <> 0) and (SVAContractregulations.StartRepayment <= FromDate) and (SVAContractregulations.EndRepayment >= FromDate) then
                                        Repayment += SVAContractregulations.RepaymentPeriod;


                            until SalesInvoiceHeader.NEXT() = 0;


                        Out042 := false;
                        SalesInvoiceHeader.Reset();
                        SalesInvoiceHeader.SETRANGE(SalesInvoiceHeader."Bill-to Customer No.", Customer."No.");
                        SalesInvoiceHeader.SETRANGE(SalesInvoiceHeader."SVA Included", TRUE);
                        SalesInvoiceHeader.SETRANGE(SalesInvoiceHeader."SVA Send", FALSE);
                        SalesInvoiceHeader.SETRANGE(SalesInvoiceHeader."Due Date", FromDate, ToDate);
                        SalesInvoiceHeader.SetRange(SalesInvoiceHeader.Closed, false);
                        if SalesInvoiceHeader.FindSet() then begin
                            F012();
                            RecordNo := '00001';
                            AddressInto := SalesInvoiceHeader."Bill-to Name";
                            F022();

                            RecordNo := '00002'; //navn 2 eller adresse 1
                            AddressInto := SalesInvoiceHeader."Bill-to Name 2";
                            IF STRLEN(AddressInto) = 0 THEN
                                AddressInto := SalesInvoiceHeader."Bill-to Address";
                            F022();

                            RecordNo := '00003'; //adresse eller tom
                            IF STRLEN(SalesInvoiceHeader."Bill-to Name 2") > 0 THEN
                                AddressInto := SalesInvoiceHeader."Bill-to Address"
                            ELSE
                                AddressInto := SalesInvoiceHeader."Bill-to Address 2";
                            IF STRLEN(AddressInto) <> 0 THEN
                                F022();

                            RecordNo := '00004'; //Adresse 2 eller tom
                            IF STRLEN(SalesInvoiceHeader."Bill-to Name 2") > 0 THEN
                                AddressInto := SalesInvoiceHeader."Bill-to Address 2";
                            If STRLEN(AddressInto) <> 0 THEN
                                F022();

                            RecordNo := '00009';
                            AddressInto := '               ' + SalesInvoiceHeader."Bill-to Post Code";
                            IF SalesInvoiceHeader."Bill-to Country/Region Code" <> 'DK' THEN
                                AddressInto := '               ' + '0000' + SalesInvoiceHeader."Bill-to Country/Region Code";
                            F022();

                            IF SalesInvoiceHeader."VAT Registration No." <> '' THEN BEGIN
                                RecordNo := '00010';
                                AddressInto := '                               ' + SalesInvoiceHeader."VAT Registration No.";
                                F022();
                            END;
                            Out042 := true;
                        end;
                        //Amount from all invoicesmust be in type 042
                        Amount42 := 0;
                        SalesInvoiceHeader.Reset();
                        SalesInvoiceHeader.SETRANGE(SalesInvoiceHeader."Bill-to Customer No.", Customer."No.");
                        SalesInvoiceHeader.SETRANGE(SalesInvoiceHeader."SVA Included", TRUE);
                        SalesInvoiceHeader.SETRANGE(SalesInvoiceHeader."SVA Send", FALSE);
                        SalesInvoiceHeader.SETRANGE(SalesInvoiceHeader."Due Date", FromDate, ToDate);
                        SalesInvoiceHeader.SetRange(SalesInvoiceHeader.Closed, false);
                        if SalesInvoiceHeader.FindSet() then
                            //Find amount for F042
                            repeat
                                SalesInvoiceLine.Reset();
                                SalesInvoiceLine.SetRange("Document No.", SalesInvoiceHeader."No.");
                                if SalesInvoiceLine.FindSet() then
                                    REPEAT
                                        Amount42 += SalesInvoiceLine."Amount Including VAT";
                                    UNTIL SalesInvoiceLine.NEXT() = 0;
                            until SalesInvoiceHeader.NEXT() = 0;

                        if Out042 = true then
                            Amount42 := Amount42 + DueAmount + Repayment;
                        if Amount42 <> 0 then
                            F042();
                        if (Amount42 = 0) and (Out042 = true) then begin
                            F042();
                            Out042 := false;
                        end;

                        //Find invoice lines from all invoices
                        //if Amount42 <> 0 then begin
                        if Customer."No." <> '' then begin

                            SalesInvoiceHeader.Reset();
                            SalesInvoiceHeader.SETRANGE(SalesInvoiceHeader."Bill-to Customer No.", Customer."No.");
                            SalesInvoiceHeader.SETRANGE(SalesInvoiceHeader."SVA Included", TRUE);
                            SalesInvoiceHeader.SETRANGE(SalesInvoiceHeader."SVA Send", FALSE);
                            SalesInvoiceHeader.SETRANGE(SalesInvoiceHeader."Due Date", FromDate, ToDate);
                            SalesInvoiceHeader.SetRange(SalesInvoiceHeader.Closed, false);
                            if SalesInvoiceHeader.FindSet() then
                                repeat
                                    //Find lejemålets adresse
                                    SVAOccupant.Reset();
                                    SVAOccupant.SetRange(SVAOccupant.Number, SalesInvoiceHeader."SVA Occupant");
                                    if SVAOccupant.FindFirst() then begin
                                        SVATenancy.Reset();
                                        SVATenancy.SetRange(Number, SVAOccupant.TenancyNo);
                                        IF SVATenancy.FindFirst() then
                                            TenAdd := SVATenancy.Address1 + ' ' + SVATenancy.Address2 + ', ' + SVATenancy."Post Code" + ' ' + SVATenancy.City;
                                    end; //Occupant

                                    SpecText := 'Opkrævning nr.: ' + SalesInvoiceHeader."No." + ' fra CVRnr. ' + CompanyInformation."VAT Registration No.";
                                    SpecText := PADSTR(SpecText, 60, ' ');
                                    CountRecord += 1;
                                    IF CountRecord > 9 THEN
                                        RecordNo := '000' + FORMAT(CountRecord, 2)
                                    ELSE
                                        RecordNo := '0000' + FORMAT(CountRecord, 1);
                                    F052(RecordNo);
                                    //Second line
                                    SpecText := 'Vedr.: ' + TenAdd;
                                    SpecText := PADSTR(SpecText, 60, ' ');
                                    CountRecord += 1;
                                    IF CountRecord > 9 THEN
                                        RecordNo := '000' + FORMAT(CountRecord, 2)
                                    ELSE
                                        RecordNo := '0000' + FORMAT(CountRecord, 1);
                                    F052(RecordNo);
                                    SalesInvoiceLine.Reset();
                                    SalesInvoiceLine.SETRANGE(SalesInvoiceLine."Document No.", SalesInvoiceHeader."No.");
                                    CLEAR(Amount52_ExVat);
                                    CLEAR(Amount52_InVat);
                                    if SalesInvoiceLine.FindSet() then
                                        REPEAT
                                            CLEAR(SpecText);
                                            SalesInvoiceLine.Description := DelStr(SalesInvoiceLine.Description, 29, 22);
                                            SpecText := SalesInvoiceLine.Description + ' ' + SalesInvoiceLine."Description 2";
                                            SpecText := PADSTR(SpecText, 60, ' ');
                                            SpecText := INSSTR(SpecText, FORMAT(SalesInvoiceLine.Amount, 10, '<Precision,2:2><Standard Format,0>'), 50);
                                            SpecText := DELSTR(SpecText, 60, 50);
                                            CountRecord += 1;
                                            IF CountRecord > 9 THEN
                                                RecordNo := '000' + FORMAT(CountRecord, 2)
                                            ELSE
                                                RecordNo := '0000' + FORMAT(CountRecord, 1);
                                            F052(RecordNo);
                                            Amount52_InVat += SalesInvoiceLine."Amount Including VAT";
                                            Amount52_ExVat += SalesInvoiceLine.Amount;
                                        UNTIL SalesInvoiceLine.NEXT() = 0;

                                    IF Amount52_InVat - Amount52_ExVat <> 0 THEN BEGIN
                                        SpecText := 'Momsbeløb';
                                        SpecText := PADSTR(SpecText, 60, ' ');
                                        SpecText := INSSTR(SpecText, FORMAT(Amount52_InVat - Amount52_ExVat, 10, '<Precision,2:2><Standard Format,0>'), 50);
                                        SpecText := DELSTR(SpecText, 60, 50);
                                        CountRecord += 1;
                                        IF CountRecord > 9 THEN
                                            RecordNo := '000' + FORMAT(CountRecord, 2)
                                        ELSE
                                            RecordNo := '0000' + FORMAT(CountRecord, 1);
                                        F052(RecordNo);
                                    END;
                                    SpecText := 'I alt opkrævning ' + SalesInvoiceHeader."No.";
                                    SpecText := PADSTR(SpecText, 60, ' ');
                                    SpecText := INSSTR(SpecText, FORMAT(Amount52_InVat, 10, '<Precision,2:2><Standard Format,0>'), 50);
                                    SpecText := DELSTR(SpecText, 60, 50);
                                    CountRecord += 1;
                                    IF CountRecord > 9 THEN
                                        RecordNo := '000' + FORMAT(CountRecord, 2)
                                    ELSE
                                        RecordNo := '0000' + FORMAT(CountRecord, 1);
                                    F052(RecordNo);
                                    Amount52_ExVat := 0;
                                    Amount52_InVat := 0;
                                    Marked();
                                until SalesInvoiceHeader.NEXT() = 0;

                            if (DueAmount <> 0) and (amount42 <> 0) then begin
                                SpecText := 'Restance/tilgodehavende';
                                SpecText := PADSTR(SpecText, 60, ' ');
                                SpecText := INSSTR(SpecText, FORMAT(DueAmount, 10, '<Precision,2:2><Standard Format,0>'), 50);
                                SpecText := DELSTR(SpecText, 60, 50);
                                CountRecord += 1;
                                IF CountRecord > 9 THEN
                                    RecordNo := '000' + FORMAT(CountRecord, 2)
                                ELSE
                                    RecordNo := '0000' + FORMAT(CountRecord, 1);
                                F052(RecordNo);
                                DueAmount := 0;
                            end;
                            if Repayment <> 0 then begin
                                SpecText := SVAContractregulations.Description;
                                if SpecText = '' then
                                    SpecText := 'Afdragsordning';
                                SpecText := PADSTR(SpecText, 60, ' ');
                                SpecText := INSSTR(SpecText, FORMAT(SVAContractregulations.RepaymentPeriod, 10, '<Precision,2:2><Standard Format,0>'), 50);
                                SpecText := DELSTR(SpecText, 60, 50);
                                CountRecord += 1;
                                IF CountRecord > 9 THEN
                                    RecordNo := '000' + FORMAT(CountRecord, 2)
                                ELSE
                                    RecordNo := '0000' + FORMAT(CountRecord, 1);
                                F052(RecordNo);
                                Repayment := 0
                            end;
                        end;
                        CountRecord := 0;
                        DueAmount := 0;
                        Repayment := 0;
                    until Customer.NEXT() = 0;

                F092(); //section end
            until SVAProperty.NEXT() = 0;
        F992(); //File End
    end;

    var
        SVAParameters: Record "SVA Parameters";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesInvoiceLine: Record "Sales Invoice Line";
        Customer: Record "Customer";
        SVAExport: Record "SVA Export Temp";
        CompanyInformation: Record "Company Information";
        SVATenancy: Record "SVA Tenancy";
        SVAOccupant: Record "SVA Occupant";
        SVAProperty: record "SVA Property";
        SVAContractregulations: Record "SVA Contract regulations";
        STR002: Text[128];
        TMP: Text[128];
        STR012: Text[128];
        STR022: Text[128];
        STR042: Text[128];
        STR052: Text[128];
        STR092: Text[128];
        STR992: Text[150];
        CountSection: Integer;
        Count22: Integer;
        Count22_all: Integer;
        Count42: Integer;
        Count42_all: Integer;
        CountAmount42: Decimal;
        CountAmount42_all: Decimal;
        Count52: Integer;
        count52_all: Integer;
        CountRecord: Integer;
        RecordNo: Text[5];
        AddressInto: Text[50];
        Amount42: Decimal;
        Amount52_ExVat: Decimal;
        Amount52_InVat: Decimal;
        SpecText: Text[128];
        FromDate: Date;
        ToDate: Date;
        TempCount: Integer;
        Datasupplier: text[8];
        Subsystem: text[3];
        CreditorPBSno: text[8];
        DebtorGroupNo: text[5];
        Advis: text[30];

        TenAdd: Text[50];
        AmountInt: Integer;

        OnceF012: Integer;
        OnceF092: Integer;
        Arrears: Boolean;
        DueAmount: Decimal;

        Repayment: Decimal;
        PaymentMethod: Text[10];
        Out042: Boolean;


    local procedure F002();
    begin
        CLEAR(TMP);
        CLEAR(STR002);
        STR002 := 'BS002';

        IF STRLEN(Datasupplier) > 8 THEN
            TMP := DELSTR(Datasupplier, 9, 2)
        ELSE
            TMP := Datasupplier;

        STR002 := INSSTR(STR002, TMP, 6);
        TMP := Subsystem;
        STR002 := INSSTR(STR002, TMP, 14);
        TMP := '0601';
        STR002 := INSSTR(STR002, TMP, 17);
        TMP := '0000' + FORMAT(TODAY, 6, 2);
        STR002 := INSSTR(STR002, TMP, 21);
        TMP := '                   ';
        STR002 := INSSTR(STR002, TMP, 31);
        TMP := FORMAT(TODAY, 6, 2);
        STR002 := INSSTR(STR002, TMP, 50);
        TMP := PADSTR(TMP, 73, ' ');
        STR002 := INSSTR(STR002, TMP, 50);
        STR002 := DELSTR(STR002, 129, 100);
        F_Save_Table(STR002);
    end;

    local procedure F012();
    begin
        if OnceF012 = 0 then begin
            CLEAR(TMP);
            CLEAR(STR012);
            STR012 := 'BS012';
            TMP := CreditorPBSno;
            STR012 := INSSTR(STR012, TMP, 6);
            TMP := '0112     ';
            STR012 := INSSTR(STR012, TMP, 14);
            TMP := DebtorGroupNo;
            STR012 := INSSTR(STR012, TMP, 23);
            TMP := '000000000' + FORMAT(TODAY, 6, 2);
            STR012 := INSSTR(STR012, TMP, 28);
            TMP := '    ';
            STR012 := INSSTR(STR012, TMP, 43);
            TMP := FORMAT(TODAY, 6, 2);
            TMP := INSSTR(TMP, '20', 5);
            STR012 := INSSTR(STR012, TMP, 47);
            TMP := '    ';
            STR012 := INSSTR(STR012, TMP, 55);
            TMP := '          ';
            STR012 := INSSTR(STR012, TMP, 59);
            TMP := Advis + PADSTR(TMP, 60 - Strlen(advis), ' ');
            STR012 := INSSTR(STR012, TMP, 69);
            F_Save_Table(STR012);
            CountSection := CountSection + 1;
            CLEAR(SpecText);
            OnceF012 := 1;
        end;
    end;

    local procedure F022();
    begin
        //Customer info
        CLEAR(TMP);
        CLEAR(STR022);
        STR022 := 'BS022';
        TMP := CreditorPBSno;
        STR022 := INSSTR(STR022, TMP, 6);
        TMP := '0240';
        STR022 := INSSTR(STR022, TMP, 14);
        TMP := RecordNo;
        STR022 := INSSTR(STR022, TMP, 18);
        TMP := DebtorGroupNo;
        STR022 := INSSTR(STR022, TMP, 23);
        TMP := '000000000000000';
        TMP := INSSTR(TMP, SalesInvoiceHeader."Bill-to Customer No.", 16 - STRLEN(SalesInvoiceHeader."Bill-to Customer No."));
        TMP := DELSTR(TMP, 16, 15);
        STR022 := INSSTR(STR022, TMP, 28);
        CLEAR(TMP);
        IF RecordNo <> '00010' THEN BEGIN
            TMP := '000000000';
            STR022 := INSSTR(STR022, TMP, 43);
        END;
        IF RecordNo = '00010' THEN BEGIN
            TMP := '';
            TMP := PADSTR(TMP, 11, ' ');
            STR022 := INSSTR(STR022, TMP, 43);
        END;
        CLEAR(TMP);
        TMP := AddressInto + PADSTR(TMP, 60 - StrLen(AddressInto), ' ');
        STR022 := INSSTR(STR022, TMP, 52);
        Count22 += 1;
        Count22_all += 1;
        F_Save_Table(STR022);
        Clear(SpecText);
        Clear(AddressInto);
    end;

    local procedure F042();
    begin
        CLEAR(TMP);
        CLEAR(STR042);
        STR042 := 'BS042';
        TMP := CreditorPBSno;
        STR042 := INSSTR(STR042, TMP, 6);
        TMP := '0280';
        STR042 := INSSTR(STR042, TMP, 14);
        TMP := '00000';
        STR042 := INSSTR(STR042, TMP, 18);
        TMP := DebtorGroupNo;
        STR042 := INSSTR(STR042, TMP, 23);
        TMP := '000000000000000';
        TMP := INSSTR(TMP, SalesInvoiceHeader."Bill-to Customer No.", 16 - STRLEN(SalesInvoiceHeader."Bill-to Customer No."));
        STR042 := INSSTR(STR042, TMP, 28);
        TMP := '000000000';
        STR042 := INSSTR(STR042, TMP, 43);
        TMP := FORMAT(SalesInvoiceHeader."Due Date", 6, 2);
        TMP := INSSTR(TMP, '20', 5);
        STR042 := INSSTR(STR042, TMP, 52);
        IF Amount42 > 0 THEN
            TMP := '1';
        If Amount42 < 0 then
            TMP := '2';
        if Amount42 = 0 then
            TMP := '0';
        STR042 := INSSTR(STR042, TMP, 60);
        STR042 := DelStr(STR042, 61, 10);
        TMP := '0000000000000';
        STR042 := INSSTR(STR042, TMP, 61);
        AmountInt := 0;
        AmountInt := Amount42 * 100;
        TMP := FORMAT(AmountInt);
        STR042 := INSSTR(STR042, TMP, 74 - STRLEN(TMP));
        STR042 := DelStr(STR042, 74, 15);
        TMP := '';
        TMP := SalesInvoiceHeader."No.";
        STR042 := INSSTR(STR042, TMP, 74);
        TMP := '';
        TMP := PADSTR(TMP, 30 - Strlen(SalesInvoiceHeader."No."), ' ');
        STR042 := INSSTR(STR042, TMP, 74 + Strlen(SalesInvoiceHeader."No."));
        TMP := '00';
        STR042 := INSSTR(STR042, TMP, 104);
        TMP := '';
        TMP := PADSTR(TMP, 15, ' ');
        STR042 := INSSTR(STR042, TMP, 106);
        TMP := '';
        TMP := PADSTR(TMP, 8, ' ');
        STR042 := INSSTR(STR042, TMP, 121);

        Count42 := Count42 + 1;
        Count42_all := Count42_all + 1;
        CountAmount42 += Amount42;
        CountAmount42_all += Amount42;
        F_Save_Table(STR042);
        CLEAR(SpecText);
    end;

    local procedure Marked()
    begin
        //mark invoice as send
        SalesInvoiceHeader."SVA Send" := TRUE;
        SalesInvoiceHeader."SVA Send date" := WorkDate();
        SalesinvoiceHeader.Modify();

    end;

    local procedure F052(Counter: Text[5]);
    begin
        CLEAR(TMP);
        CLEAR(STR052);
        STR052 := 'BS052';
        TMP := CreditorPBSno;
        STR052 := INSSTR(STR052, TMP, 6);
        TMP := '0241';
        STR052 := INSSTR(STR052, TMP, 14);
        TMP := Counter;
        STR052 := INSSTR(STR052, TMP, 18);
        TMP := DebtorGroupNo;
        STR052 := INSSTR(STR052, TMP, 23);
        TMP := '000000000000000';
        TMP := INSSTR(TMP, SalesInvoiceHeader."Bill-to Customer No.", 16 - STRLEN(SalesInvoiceHeader."Bill-to Customer No."));
        TMP := DELSTR(TMP, 16, 15);
        STR052 := INSSTR(STR052, TMP, 28);
        TMP := '000000000';
        STR052 := INSSTR(STR052, TMP, 43);
        TMP := ' ';
        STR052 := INSSTR(STR052, TMP, 52);
        TMP := SpecText + PADSTR(TMP, 60 - StrLen(SpecText), ' ');
        STR052 := INSSTR(STR052, TMP, 53);
        STR052 := Delstr(STR052, 112, 50);
        TMP := '';
        TMP := PADSTR(TMP, 16, ' ');
        STR052 := INSSTR(STR052, TMP, 113);

        Count52 := Count52 + 1;
        count52_all := count52_all + 1;
        F_Save_Table(STR052);
        CLEAR(SpecText);
    end;

    local procedure F092();
    begin
        IF OnceF092 = 0 then begin
            CLEAR(TMP);
            CLEAR(STR092);
            STR092 := 'BS092';
            TMP := CreditorPBSno;
            STR092 := INSSTR(STR092, TMP, 6);
            TMP := '011200000';
            STR092 := INSSTR(STR092, TMP, 14);
            TMP := DebtorGroupNo;
            STR092 := INSSTR(STR092, TMP, 23);
            TMP := '    ';
            STR092 := INSSTR(STR092, TMP, 28);

            TMP := '';
            TMP := PADSTR(TMP, 11, '0');
            IF Count42 < 10 THEN BEGIN
                SpecText := FORMAT(Count42, 1);
                TMP := INSSTR(TMP, SpecText, 11);
            END;
            IF Count42 > 9 THEN
                IF Count42 < 100 THEN BEGIN
                    SpecText := FORMAT(Count42, 2);
                    TMP := INSSTR(TMP, SpecText, 10);
                END;
            IF Count42 > 99 THEN
                IF Count42 < 1000 THEN BEGIN
                    SpecText := FORMAT(Count42, 3);
                    TMP := INSSTR(TMP, SpecText, 9);
                END;
            IF Count42 > 999 THEN
                IF Count42 < 10000 THEN BEGIN
                    SpecText := FORMAT(Count42, 4);
                    TMP := INSSTR(TMP, SpecText, 8);
                END;
            IF Count42 > 9999 THEN
                IF Count42 < 100000 THEN BEGIN
                    SpecText := FORMAT(Count42, 5);
                    TMP := INSSTR(TMP, SpecText, 7);
                END;
            STR092 := INSSTR(STR092, TMP, 32);

            TMP := '';
            TMP := PADSTR(TMP, 11, '0');
            IF CountAmount42 * 100 > 999 THEN
                IF CountAmount42 < 10000 THEN BEGIN
                    SpecText := FORMAT(CountAmount42 * 100, 4, 4);
                    TMP := INSSTR(TMP, SpecText, 12);
                END;
            IF CountAmount42 * 100 > 9999 THEN
                IF CountAmount42 < 100000 THEN BEGIN
                    SpecText := FORMAT(CountAmount42 * 100, 5, 4);
                    TMP := INSSTR(TMP, SpecText, 11);
                END;
            IF CountAmount42 * 100 > 99999 THEN
                IF CountAmount42 < 1000000 THEN BEGIN
                    SpecText := FORMAT(CountAmount42 * 100, 6, 4);
                    TMP := INSSTR(TMP, SpecText, 10);
                END;
            IF CountAmount42 * 100 > 999999 THEN
                IF CountAmount42 < 10000000 THEN BEGIN
                    SpecText := FORMAT(CountAmount42 * 100, 7, 4);
                    TMP := INSSTR(TMP, SpecText, 9);
                END;
            IF CountAmount42 * 100 > 9999999 THEN
                IF CountAmount42 < 100000000 THEN BEGIN
                    SpecText := FORMAT(CountAmount42 * 100, 8, 4);
                    TMP := INSSTR(TMP, SpecText, 8);
                END;
            IF CountAmount42 * 100 > 99999999 THEN
                IF CountAmount42 < 1000000000 THEN BEGIN
                    SpecText := FORMAT(CountAmount42 * 100, 9, 4);
                    TMP := INSSTR(TMP, SpecText, 7);
                END;
            IF CountAmount42 * 100 > 999999999 THEN
                IF CountAmount42 < 10000000000.0 THEN BEGIN
                    SpecText := FORMAT(CountAmount42 * 100, 10, 4);
                    TMP := INSSTR(TMP, SpecText, 6);
                END;
            STR092 := INSSTR(STR092, TMP, 43);

            TMP := '';
            TMP := PADSTR(TMP, 15, '0');
            IF Count52 < 10 THEN BEGIN
                SpecText := FORMAT(Count52, 1);
                TMP := INSSTR(TMP, SpecText, 11);
            END;
            IF Count52 > 9 THEN
                IF Count52 < 100 THEN BEGIN
                    SpecText := FORMAT(Count52, 2);
                    TMP := INSSTR(TMP, SpecText, 10);
                END;
            IF Count52 > 99 THEN
                IF Count52 < 1000 THEN BEGIN
                    SpecText := FORMAT(Count52, 3);
                    TMP := INSSTR(TMP, SpecText, 9);
                END;
            IF Count52 > 999 THEN
                IF Count52 < 10000 THEN BEGIN
                    SpecText := FORMAT(Count52, 4);
                    TMP := INSSTR(TMP, SpecText, 8);
                END;
            IF Count52 > 9999 THEN
                IF Count52 < 100000 THEN BEGIN
                    SpecText := FORMAT(Count52, 5);
                    TMP := INSSTR(TMP, SpecText, 7);
                END;
            STR092 := INSSTR(STR092, TMP, 58);

            TMP := PADSTR(' ', 15);
            STR092 := INSSTR(STR092, TMP, 69);

            TMP := '';
            TMP := PADSTR(TMP, 11, '0');
            IF Count22 < 10 THEN BEGIN
                SpecText := FORMAT(Count22, 1);
                TMP := INSSTR(TMP, SpecText, 11);
            END;
            IF Count22 > 9 THEN
                IF Count22 < 100 THEN BEGIN
                    SpecText := FORMAT(Count22, 2);
                    TMP := INSSTR(TMP, SpecText, 10);
                END;
            IF Count22 > 99 THEN
                IF Count22 < 1000 THEN BEGIN
                    SpecText := FORMAT(Count22, 3);
                    TMP := INSSTR(TMP, SpecText, 9);
                END;
            IF Count22 > 999 THEN
                IF Count22 < 10000 THEN BEGIN
                    SpecText := FORMAT(Count22, 4);
                    TMP := INSSTR(TMP, SpecText, 8);
                END;
            IF Count22 > 9999 THEN
                IF Count22 < 100000 THEN BEGIN
                    SpecText := FORMAT(Count22, 5);
                    TMP := INSSTR(TMP, SpecText, 7);
                END;
            STR092 := INSSTR(STR092, TMP, 84);
            STR092 := DELSTR(STR092, 95, 100);
            Count22 := 0;
            TMP := '';
            TMP := PADSTR(TMP, 34, ' ');
            STR092 := INSSTR(STR092, TMP, 95);
            F_Save_Table(STR092);
            Count42 := 0;
            Count52 := 0;
            CountAmount42 := 0;
            OnceF092 := 1;
        end;
    end;

    local procedure F992();
    begin
        CLEAR(TMP);
        CLEAR(STR992);
        STR992 := 'BS992';
        TMP := Datasupplier;
        STR992 := INSSTR(STR992, TMP, 6);

        TMP := Subsystem;
        STR992 := INSSTR(STR992, TMP, 14);

        TMP := '0601';
        STR992 := INSSTR(STR992, TMP, 17);

        TMP := '';
        TMP := PADSTR(TMP, 11, '0');
        IF CountSection < 10 THEN
            SpecText := FORMAT(CountSection, 1);
        TMP := INSSTR(TMP, SpecText, 11);
        IF CountSection > 9 THEN
            IF CountSection < 100 THEN BEGIN
                SpecText := FORMAT(CountSection, 2);
                TMP := INSSTR(TMP, SpecText, 10);
            END;
        STR992 := INSSTR(STR992, TMP, 21);

        TMP := '';
        TMP := PADSTR(TMP, 11, '0');
        IF Count42_all < 10 THEN BEGIN
            SpecText := FORMAT(Count42_all, 1);
            TMP := INSSTR(TMP, SpecText, 11);
        END;
        IF Count42_all > 9 THEN
            IF Count42_all < 100 THEN BEGIN
                SpecText := FORMAT(Count42_all, 2);
                TMP := INSSTR(TMP, SpecText, 10);
            END;
        IF Count42_all > 99 THEN
            IF Count42_all < 1000 THEN BEGIN
                SpecText := FORMAT(Count42_all, 3);
                TMP := INSSTR(TMP, SpecText, 9);
            END;
        IF Count42_all > 999 THEN
            IF Count42_all < 10000 THEN BEGIN
                SpecText := FORMAT(Count42_all, 4);
                TMP := INSSTR(TMP, SpecText, 8);
            END;
        IF Count42_all > 9999 THEN
            IF Count42_all < 100000 THEN BEGIN
                SpecText := FORMAT(Count42_all, 5);
                TMP := INSSTR(TMP, SpecText, 7);
            END;
        STR992 := INSSTR(STR992, TMP, 32);
        TMP := '';
        TMP := PADSTR(TMP, 11, '0');
        IF CountAmount42_all * 100 > 999 THEN
            IF CountAmount42_all < 10000 THEN BEGIN
                SpecText := FORMAT(CountAmount42_all * 100, 4, 4);
                TMP := INSSTR(TMP, SpecText, 12);
            END;
        IF CountAmount42_all * 100 > 9999 THEN
            IF CountAmount42_all < 100000 THEN BEGIN
                SpecText := FORMAT(CountAmount42_all * 100, 5, 4);
                TMP := INSSTR(TMP, SpecText, 11);
            END;
        IF CountAmount42_all * 100 > 99999 THEN
            IF CountAmount42_all < 1000000 THEN BEGIN
                SpecText := FORMAT(CountAmount42_all * 100, 6, 4);
                TMP := INSSTR(TMP, SpecText, 10);
            END;
        IF CountAmount42_all * 100 > 999999 THEN
            IF CountAmount42_all < 10000000 THEN BEGIN
                SpecText := FORMAT(CountAmount42_all * 100, 7, 4);
                TMP := INSSTR(TMP, SpecText, 9);
            END;
        IF CountAmount42_all * 100 > 9999999 THEN
            IF CountAmount42_all < 100000000 THEN BEGIN
                SpecText := FORMAT(CountAmount42_all * 100, 8, 4);
                TMP := INSSTR(TMP, SpecText, 8);
            END;
        IF CountAmount42_all * 100 > 99999999 THEN
            IF CountAmount42_all < 1000000000 THEN BEGIN
                SpecText := FORMAT(CountAmount42_all * 100, 9, 4);
                TMP := INSSTR(TMP, SpecText, 7);
            END;
        IF CountAmount42_all * 100 > 999999999 THEN
            IF CountAmount42_all < 10000000000.0 THEN BEGIN
                SpecText := FORMAT(CountAmount42_all * 100, 10, 4);
                TMP := INSSTR(TMP, SpecText, 6);
            END;
        STR992 := INSSTR(STR992, TMP, 43);
        TMP := '';
        TMP := PADSTR(TMP, 15, '0');
        IF count52_all < 10 THEN BEGIN
            SpecText := FORMAT(count52_all, 1);
            TMP := INSSTR(TMP, SpecText, 11);
        END;
        IF count52_all > 9 THEN
            IF count52_all < 100 THEN BEGIN
                SpecText := FORMAT(count52_all, 2);
                TMP := INSSTR(TMP, SpecText, 10);
            END;
        IF count52_all > 99 THEN
            IF count52_all < 1000 THEN BEGIN
                SpecText := FORMAT(count52_all, 3);
                TMP := INSSTR(TMP, SpecText, 9);
            END;
        IF count52_all > 999 THEN
            IF count52_all < 10000 THEN BEGIN
                SpecText := FORMAT(count52_all, 4);
                TMP := INSSTR(TMP, SpecText, 8);
            END;
        IF count52_all > 9999 THEN
            IF count52_all < 100000 THEN BEGIN
                SpecText := FORMAT(count52_all, 5);
                TMP := INSSTR(TMP, SpecText, 7);
            END;
        STR992 := INSSTR(STR992, TMP, 58);

        TMP := '';
        TMP := PADSTR(TMP, 15, '0');
        STR992 := INSSTR(STR992, TMP, 69);
        TMP := '';
        TMP := PADSTR(TMP, 11, '0');
        IF Count22_all < 10 THEN BEGIN
            SpecText := FORMAT(Count22_all, 1);
            TMP := INSSTR(TMP, SpecText, 11);
        END;
        IF Count22_all > 9 THEN
            IF Count22_all < 100 THEN BEGIN
                SpecText := FORMAT(Count22_all, 2);
                TMP := INSSTR(TMP, SpecText, 10);
            END;
        IF Count22_all > 99 THEN
            IF Count22_all < 1000 THEN BEGIN
                SpecText := FORMAT(Count22_all, 3);
                TMP := INSSTR(TMP, SpecText, 9);
            END;
        IF Count22_all > 999 THEN
            IF Count22_all < 10000 THEN BEGIN
                SpecText := FORMAT(Count22_all, 4);
                TMP := INSSTR(TMP, SpecText, 8);
            END;
        IF Count22_all > 9999 THEN
            IF Count22_all < 100000 THEN BEGIN
                SpecText := FORMAT(Count42, 5);
                TMP := INSSTR(TMP, SpecText, 7);
            END;
        IF Count22_all > 99999 THEN
            IF Count22_all < 1000000 THEN BEGIN
                SpecText := FORMAT(Count42, 6);
                TMP := INSSTR(TMP, SpecText, 6);
            END;
        STR992 := INSSTR(STR992, TMP, 84);
        STR992 := DELSTR(STR992, 95, 100);
        TMP := '';
        TMP := PADSTR(TMP, 34, '0');
        STR992 := DELSTR(STR992, 95, 150);
        STR992 := INSSTR(STR992, TMP, 95);
        F_Save_Table(STR992);
        IF Count22_all = 0 THEN
            MESSAGE('Der er ingen faktura til NETS.');
        IF Count22_all <> 0 then
            MESSAGE('Fil til NETS med opkrævninger for kr ' + Format(CountAmount42_all, 15, '<Precision,2:2><Standard Format,0>') + ' er klar.');
    end;

    local procedure F_Save_Table(Text128: Text[128]);
    begin
        SVAExport.Init();
        TempCount += 1;
        SVAExport."Line No." := TempCount;
        SVAExport.Name := 'BS0601';
        SVAExport."Output Line 128" := Text128;
        SVAExport.Insert();
    end;
}

