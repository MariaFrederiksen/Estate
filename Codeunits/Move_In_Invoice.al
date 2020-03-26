codeunit 50008 "SVA Move In Invoice"
{
    TableNo = "SVA LeaseContract_A9";

    trigger OnRun();
    begin
        Contract.Copy(Rec);
        Rec := Contract;

        CLEAR(Occupant);
        Occupant.SETRANGE(Number, Contract.Number);
        IF Occupant.FINDFIRST() THEN BEGIN
            Factor := 1;
            //Split moving in
            if (DATE2DMY(Occupant.StartDate, 1) > 1) AND (DATE2DMY(Occupant.StartDate, 1) < 32) then begin
                SetupEstate.Reset;
                if SetupEstate.FindFirst then begin
                    if SetupEstate.Splitcalc = false then
                        Factor := 0.5;
                    if SetupEstate.Splitcalc = true then begin
                        Days := date2dmy(Calcdate('CM', DMY2Date(01, Date2DMY(Occupant.StartDate, 2), Date2DMY(Occupant.StartDate, 3))), 1);
                        Factor := ((Days - Date2DMY(Occupant.StartDate, 1) + 1) / Days);
                    end;
                end;
            end;

            //VAT - if rent is with VAT, all is with VAT at moving in.     
            Subscription.RESET;
            Subscription.Setrange(Tenancies, Occupant.TenancyNo);
            Subscription.SetRange(type, 1);
            if Subscription.findfirst then begin
                CostTypeEstate.RESET;
                CostTypeEstate.SETRANGE(Costtype, Subscription."Cost Types");
                IF CostTypeEstate.FindFirst() then
                    VatType := CostTypeEstate.VatGroup;
            end;

            //Make salesheader
            Salesheader.INIT;
            Salesheader.VALIDATE("Document Type", Salesheader."Document Type"::Invoice);
            Salesheader."No." := '';
            Salesheader."Sell-to Customer No." := Occupant."Customer No";
            Salesheader.Validate("Sell-to Customer No.");

            Salesheader."Posting Date" := TODAY;
            Salesheader."SVA Included" := false;
            Salesheader."SVA Occupant" := Occupant.Number;
            Salesheader."Dimension Set ID" := Occupant."Dimension Set Id";

            CLEAR(Contract);
            Contract.SETRANGE(Number, Occupant.Number);
            IF Contract.FINDFIRST() THEN BEGIN
                Salesheader."Due Date" := TypeA9_4_DueDate;
            END;

            //If no adress, then use from Occupant
            if Salesheader."Sell-to Address" = '' then begin
                Salesheader."Bill-to Address" := Occupant.Address;
                Salesheader."Bill-to Address 2" := Occupant.Address2;
                Salesheader."Bill-to Post Code" := Occupant."Post Code";
                Salesheader."Bill-to City" := Occupant.City;
                Salesheader."Bill-to Country/Region Code" := Occupant."Country/Region Code";
                Salesheader."Sell-to Customer No." := Occupant."Customer No";
                Salesheader."Sell-to Customer Name" := Occupant.Name1;
                Salesheader."Sell-to Address" := Occupant.Address;
                Salesheader."Sell-to Address 2" := Occupant.Address2;
                Salesheader."Sell-to Post Code" := Occupant."Post Code";
                Salesheader."Sell-to City" := Occupant.City;
                Salesheader."Sell-to Country/Region Code" := Occupant."Country/Region Code";
            end;
            if Salesheader."Gen. Bus. Posting Group" = '' then begin
                cust.RESET;
                cust.SETRANGE("No.", Occupant."Customer No");
                IF cust.FINDFIRST() THEN BEGIN
                    Salesheader."Payment Terms Code" := cust."Payment Terms Code";
                    Salesheader."Currency Code" := cust."Currency Code";
                    Salesheader."Customer Posting Group" := cust."Customer Posting Group";
                    Salesheader."Gen. Bus. Posting Group" := cust."Gen. Bus. Posting Group";
                    Salesheader."VAT Bus. Posting Group" := cust."VAT Bus. Posting Group"
                END;
            end;
            Salesheader.INSERT(TRUE);
            Occupant.FirstNets := CalcDate('<1M>', Occupant.StartDate);
            Occupant.Modify;
        END;

        //Make salesline
        LineNo := 0;
        CLEAR(Contract);
        Contract.SETRANGE(Number, Occupant.Number);

        IF Contract.FINDFIRST() THEN BEGIN
            //Depositum
            IF Contract.TypeA9_4_DepMth > 0 THEN BEGIN
                MakeSalesLine;
                SalesLine.Quantity := Contract.TypeA9_4_DepMth;
                SalesLine."Unit Price" := Contract.TypeA9_4_DepAmount / Contract.TypeA9_4_DepMth;
                SalesLine.Amount := Contract.TypeA9_4_DepAmount;
                SalesLine."Line Amount" := Contract.TypeA9_4_DepAmount;
                MakeSLFromCosttype(10);
                EndSalesLine;
            END;
            //Forudbetalt leje
            IF Contract.TypeA9_4_PrepaidRentMth > 0 THEN BEGIN
                MakeSalesLine;
                SalesLine.Quantity := Contract.TypeA9_4_PrepaidRentMth;
                SalesLine."Unit Price" := Contract.TypeA9_4_PrepaidRent / Contract.TypeA9_4_PrepaidRentMth;
                SalesLine.Amount := Contract.TypeA9_4_PrepaidRent;
                SalesLine."Line Amount" := Contract.TypeA9_4_PrepaidRent;
                MakeSLFromCosttype(11);
                EndSalesLine();
            END;
            //Første måneds leje
            IF (Contract.TypeA9_3_RentPerPeriode > 0) and (Contract.TypeA9_4_Rentetc <> 0) THEN BEGIN
                MakeSalesLine;
                SalesLine.Quantity := 1 * Factor;
                SalesLine."Unit Price" := Contract.TypeA9_3_RentPerPeriode;
                SalesLine.Amount := Contract.TypeA9_3_RentPerPeriode;
                SalesLine."Line Amount" := Contract.TypeA9_3_RentPerPeriode;
                Subscription.Reset;
                Subscription.SetRange(Tenancies, Occupant.TenancyNo);
                Subscription.SetRange(Type, 1); //husleje
                IF Subscription.FindFirst() THEN begin
                    CostTypeEstate.RESET;
                    CostTypeEstate.SETRANGE(Costtype, Subscription."Cost Types");
                    IF CostTypeEstate.FINDFIRST() THEN BEGIN
                        SalesLine."No." := CostTypeEstate.Account;
                        SalesLine.Description := 'Leje ' + FORMAT(TypeA9_4_RentFrom) + ' til ' + FORMAT(TypeA9_4_RentTo);
                        SalesLine."Gen. Prod. Posting Group" := CostTypeEstate.ProductPostingGroup;
                        SalesLine.Validate(SalesLine."Gen. Prod. Posting Group");
                        SalesLine."VAT Prod. Posting Group" := CostTypeEstate.VatGroup;
                        SalesLine.Validate(SalesLine."VAT Prod. Posting Group");
                        SalesLine."SVA Costtype" := CostTypeEstate.Costtype;
                    END;
                END;
                EndSalesLine();
            END;
            //ACVarme
            IF (Contract.TypeA9_3_ACHeat > 0) and (Contract.TypeA9_4_Rentetc <> 0) THEN BEGIN
                MakeSalesLine;
                SalesLine.Quantity := 1 * Factor;
                SalesLine."Unit Price" := Contract.TypeA9_3_ACHeat;
                SalesLine.Amount := Contract.TypeA9_3_ACHeat;
                SalesLine."Line Amount" := Contract.TypeA9_3_ACHeat;
                MakeSLFromCosttype(2);
                EndSalesLine;
            END;
            //ACVand
            IF (Contract.TypeA9_3_ACWater > 0) and (Contract.TypeA9_4_Rentetc <> 0) THEN BEGIN
                MakeSalesLine;
                SalesLine.Quantity := 1 * Factor;
                SalesLine."Unit Price" := Contract.TypeA9_3_ACWater;
                SalesLine.Amount := Contract.TypeA9_3_ACWater;
                SalesLine."Line Amount" := Contract.TypeA9_3_ACWater;
                MakeSLFromCosttype(3);
                EndSalesLine();
            END;
            //ACEl
            IF (Contract.TypeA9_3_ACElectricity > 0) and (Contract.TypeA9_4_Rentetc <> 0) THEN BEGIN
                MakeSalesLine;
                SalesLine.Quantity := 1 * factor;
                SalesLine."Unit Price" := Contract.TypeA9_3_ACElectricity;
                SalesLine.Amount := Contract.TypeA9_3_ACElectricity;
                SalesLine."Line Amount" := Contract.TypeA9_3_ACElectricity;
                MakeSLFromCosttype(4);
                EndSalesLine();
            END;
            //ACkøling
            IF (Contract.TypeA9_3_ACCooling > 0) and (Contract.TypeA9_4_Rentetc <> 0) THEN BEGIN
                MakeSalesLine;
                SalesLine.Quantity := 1 * factor;
                SalesLine."Unit Price" := Contract.TypeA9_3_ACCooling;
                SalesLine.Amount := Contract.TypeA9_3_ACCooling;
                SalesLine."Line Amount" := Contract.TypeA9_3_ACCooling;
                MakeSLFromCosttype(5);
                EndSalesLine();
            END;
            //Antenne
            IF (Contract.TypeA9_3_Antenna > 0) and (Contract.TypeA9_4_Rentetc <> 0) THEN BEGIN
                MakeSalesLine;
                SalesLine.Quantity := 1 * factor;
                SalesLine."Unit Price" := Contract.TypeA9_3_Antenna;
                SalesLine.Amount := Contract.TypeA9_3_Antenna;
                SalesLine."Line Amount" := Contract.TypeA9_3_Antenna;
                MakeSLFromCosttype(7);
                endSalesLine();
            END;
            //Internet
            IF (Contract.TypeA9_3_Internet > 0) and (Contract.TypeA9_4_Rentetc <> 0) THEN BEGIN
                MakeSalesLine;
                SalesLine.Quantity := 1 * factor;
                SalesLine."Unit Price" := Contract.TypeA9_3_Internet;
                SalesLine.Amount := Contract.TypeA9_3_Internet;
                SalesLine."Line Amount" := Contract.TypeA9_3_Internet;
                MakeSLFromCosttype(8);
                EndSalesLine();
            END;
            //Beboerrepræsentation
            IF (Contract.TypeA9_3_TenantGroup > 0) and (Contract.TypeA9_4_Rentetc <> 0) THEN BEGIN
                MakeSalesLine;
                SalesLine.Quantity := 1 * factor;
                SalesLine."Unit Price" := Contract.TypeA9_3_TenantGroup;
                SalesLine.Amount := Contract.TypeA9_3_TenantGroup;
                SalesLine."Line Amount" := Contract.TypeA9_3_TenantGroup;
                MakeSLFromCosttype(9);
                EndSalesLine();
            END;
            //Andet 1
            IF Contract.TypeA9_3_OtherAmount1 > 0 THEN BEGIN
                MakeSalesLine;
                SalesLine.Quantity := 1 * factor;
                SalesLine."Unit Price" := Contract.TypeA9_3_OtherAmount1;
                SalesLine.Amount := Contract.TypeA9_3_OtherAmount1;
                SalesLine."Line Amount" := Contract.TypeA9_3_OtherAmount1;

                CostTypeEstate.RESET;
                CostTypeEstate.SETRANGE(Type, 1);
                CostTypeEstate.SETRANGE(VatGroup, VatType);
                IF CostTypeEstate.FINDFIRST() THEN BEGIN
                    SalesLine."No." := CostTypeEstate.Account;
                    SalesLine.Description := Contract.TypeA9_3_OtherText1;
                    SalesLine."VAT Prod. Posting Group" := CostTypeEstate.VatGroup;
                    SalesLine."Gen. Prod. Posting Group" := CostTypeEstate.ProductPostingGroup;
                    SalesLine."SVA Costtype" := CostTypeEstate.Costtype;
                END;
                SalesLine.Validate(SalesLine."VAT Prod. Posting Group");
                SalesLine.Validate(SalesLine."Unit Price");
                EndSalesLine();
            END;
            //Andet 2
            IF Contract.TypeA9_3_OtherAmount2 > 0 THEN BEGIN
                MakeSalesLine;
                SalesLine.Quantity := 1 * Factor;
                SalesLine."Unit Price" := Contract.TypeA9_3_OtherAmount2;
                SalesLine.Amount := Contract.TypeA9_3_OtherAmount2;
                SalesLine."Line Amount" := Contract.TypeA9_3_OtherAmount2;

                CostTypeEstate.RESET;
                CostTypeEstate.SETRANGE(Type, 1);
                CostTypeEstate.SETRANGE(VatGroup, VatType);
                IF CostTypeEstate.FINDFIRST() THEN BEGIN
                    SalesLine."No." := CostTypeEstate.Account;
                    SalesLine.Description := Contract.TypeA9_3_OtherText2;
                    SalesLine."VAT Prod. Posting Group" := CostTypeEstate.VatGroup;
                    SalesLine."Gen. Prod. Posting Group" := CostTypeEstate.ProductPostingGroup;
                    SalesLine."SVA Costtype" := CostTypeEstate.Costtype;
                END;
                SalesLine.Validate(SalesLine."VAT Prod. Posting Group");
                SalesLine.Validate(SalesLine."Unit Price");
                EndSalesLine();
            END;
            //One time invoicelines
            //Andet 1
            IF Contract.TypeA9_4_Amount1 > 0 THEN BEGIN
                MakeSalesLine;
                SalesLine.Quantity := 1 * factor;
                SalesLine."Unit Price" := Contract.TypeA9_4_Amount1;
                SalesLine.Amount := Contract.TypeA9_4_Amount1;
                SalesLine."Line Amount" := Contract.TypeA9_4_Amount1;

                CostTypeEstate.RESET;
                CostTypeEstate.SETRANGE(Type, 0);
                CostTypeEstate.SETRANGE(VatGroup, VatType);
                IF CostTypeEstate.FINDFIRST() THEN BEGIN
                    SalesLine."No." := CostTypeEstate.Account;
                    SalesLine.Description := Contract.TypeA9_4_Text1;
                    SalesLine."VAT Prod. Posting Group" := CostTypeEstate.VatGroup;
                    SalesLine."Gen. Prod. Posting Group" := CostTypeEstate.ProductPostingGroup;
                    SalesLine."SVA Costtype" := CostTypeEstate.Costtype;
                END;
                SalesLine.Validate(SalesLine."VAT Prod. Posting Group");
                SalesLine.Validate(SalesLine."Unit Price");
                EndSalesLine();
            END;
            //Andet 2
            IF Contract.TypeA9_4_Amount2 > 0 THEN BEGIN
                MakeSalesLine;
                SalesLine.Quantity := 1 * factor;
                SalesLine."Unit Price" := Contract.TypeA9_4_Amount2;
                SalesLine.Amount := Contract.TypeA9_4_Amount2;
                SalesLine."Line Amount" := Contract.TypeA9_4_Amount2;

                CostTypeEstate.RESET;
                CostTypeEstate.SETRANGE(Type, 0);
                CostTypeEstate.SETRANGE(VatGroup, VatType);
                IF CostTypeEstate.FINDFIRST() THEN BEGIN
                    SalesLine."No." := CostTypeEstate.Account;
                    SalesLine.Description := Contract.TypeA9_4_Text2;
                    SalesLine."VAT Prod. Posting Group" := CostTypeEstate.VatGroup;
                    SalesLine."Gen. Prod. Posting Group" := CostTypeEstate.ProductPostingGroup;
                    SalesLine."SVA Costtype" := CostTypeEstate.Costtype;
                END;
                SalesLine.Validate(SalesLine."VAT Prod. Posting Group");
                SalesLine.Validate(SalesLine."Unit Price");
                EndSalesLine();
            END;
            //Andet 3
            IF Contract.TypeA9_4_Amount3 > 0 THEN BEGIN
                MakeSalesLine;
                SalesLine.Quantity := 1 * factor;
                SalesLine."Unit Price" := Contract.TypeA9_4_Amount3;
                SalesLine.Amount := Contract.TypeA9_4_Amount3;
                SalesLine."Line Amount" := Contract.TypeA9_4_Amount3;

                CostTypeEstate.RESET;
                CostTypeEstate.SETRANGE(Type, 0);
                CostTypeEstate.SETRANGE(VatGroup, VatType);
                IF CostTypeEstate.FINDFIRST() THEN BEGIN
                    SalesLine."No." := CostTypeEstate.Account;
                    SalesLine.Description := Contract.TypeA9_4_Text3;
                    SalesLine."VAT Prod. Posting Group" := CostTypeEstate.VatGroup;
                    SalesLine."Gen. Prod. Posting Group" := CostTypeEstate.ProductPostingGroup;
                    SalesLine."SVA Costtype" := CostTypeEstate.Costtype;
                END;
                SalesLine.Validate(SalesLine."VAT Prod. Posting Group");
                SalesLine.Validate(SalesLine."Unit Price");
                EndSalesLine();
            END;

        END;

        //to be Posted
        Page.Run(page::"Sales Invoice List");
    end;

    var

        Occupant: Record "SVA Occupant";
        Subscription: Record "SVA Subscription Lines";
        Contract: Record "SVA LeaseContract_A9";
        Salesheader: Record "Sales header";
        LineNo: Integer;
        cust: Record Customer;
        SalesLine: Record "Sales Line";
        CostTypeEstate: Record "SVA Cost type";
        Invoice: Record "Sales Invoice Header";
        InvoiceLine: Record "Sales Invoice Line";
        OcTrans: Record "SVA Occupant Trans";
        VatType: Code[10];
        Factor: Decimal;
        SetupEstate: Record "SVA Parameters";
        Days: Integer;

    local procedure MakeSalesLine()
    begin
        SalesLine.INIT;
        SalesLine.VALIDATE(SalesLine."Document Type", Salesheader."Document Type"::Invoice);
        SalesLine."Line No." := LineNo + 1;
        LineNo := LineNo + 1;
        SalesLine.Type := 1;
        SalesLine."Document No." := Salesheader."No.";
        SalesLine."Gen. Bus. Posting Group" := Salesheader."Gen. Bus. Posting Group";
        SalesLine."VAT Bus. Posting Group" := Salesheader."VAT Bus. Posting Group";
        SalesLine."Dimension Set ID" := Salesheader."Dimension Set ID";
        SalesLine.Validate("Dimension Set ID");
    end;

    local procedure EndSalesLine()
    begin
        SalesLine."Qty. to Ship" := SalesLine.Quantity;
        SalesLine."Qty. to Invoice" := SalesLine.Quantity;
        IF SalesLine.Amount > 0 then
            SalesLine.Insert(true);
    end;

    local procedure MakeSLFromCosttype(CostType: Integer) //konteringsartens type
    begin
        CostTypeEstate.RESET;
        CostTypeEstate.SETRANGE(Type, CostType);
        CostTypeEstate.SETRANGE(VatGroup, VatType);
        IF CostTypeEstate.FINDFIRST() THEN BEGIN
            SalesLine."No." := CostTypeEstate.Account;
            SalesLine.Description := CostTypeEstate.Description;
            SalesLine."Gen. Prod. Posting Group" := CostTypeEstate.ProductPostingGroup;
            SalesLine."VAT Prod. Posting Group" := VatType;
            SalesLine.Validate(SalesLine."VAT Prod. Posting Group");
            SalesLine."SVA Costtype" := CostTypeEstate.Costtype;
            SalesLine.Validate(SalesLine."Unit Price");
        END;
    end;
}