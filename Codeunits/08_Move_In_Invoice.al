codeunit 50008 "SVA Move In Invoice"
{
    TableNo = "SVA LeaseContract_A9";

    trigger OnRun();
    begin
        SVALeaseContractA9.Copy(Rec);
        Rec := SVALeaseContractA9;

        CLEAR(SVAOccupant);
        SVAOccupant.SETRANGE(Number, SVALeaseContractA9.Number);
        IF SVAOccupant.FindFirst() THEN BEGIN
            Factor := 1;
            //Split moving in
            if (DATE2DMY(SVAOccupant.StartDate, 1) > 1) AND (DATE2DMY(SVAOccupant.StartDate, 1) < 32) then begin
                SVAParameters.Reset();
                if SVAParameters.FindFirst() then begin
                    if SVAParameters.Splitcalc = false then
                        Factor := 0.5;
                    if SVAParameters.Splitcalc = true then begin
                        Days := CalcDate('<1M-1D>', SVAOccupant.Startdate) - SVAOccupant.Startdate + 1;//qty of days in month Sartdate
                        Factor := ((Days - Date2DMY(SVAOccupant.StartDate, 1) + 1) / Days);
                    end;
                end;
            end;

            //VAT - if rent is with VAT, all is with VAT at moving in.     
            SVASubscriptionLines.Reset();
            SVASubscriptionLines.Setrange(Tenancies, SVAOccupant.TenancyNo);
            SVASubscriptionLines.SetRange(type, 1);
            if SVASubscriptionLines.FindFirst() then begin
                SVACosttype.Reset();
                SVACosttype.SETRANGE(Costtype, SVASubscriptionLines."Cost Types");
                IF SVACosttype.FindFirst() then
                    VatType := SVACosttype.VatGroup;
            end;
            //if SVASubscriptionLinesline don't have a line of type Rent
            if VatType = '' then begin
                SVASubscriptionLines.Reset();
                SVASubscriptionLines.Setrange(Tenancies, SVAOccupant.TenancyNo);
                if SVASubscriptionLines.FindFirst() then begin
                    SVACosttype.Reset();
                    SVACosttype.SETRANGE(Costtype, SVASubscriptionLines."Cost Types");
                    IF SVACosttype.FindFirst() then
                        VatType := SVACosttype.VatGroup;
                end;
            end;


            //Make salesheader
            Salesheader.Init();
            Salesheader.VALIDATE("Document Type", Salesheader."Document Type"::Invoice);
            Salesheader."No." := '';
            Salesheader."Sell-to Customer No." := SVAOccupant."Customer No";
            Salesheader.Validate("Sell-to Customer No.");

            Salesheader."Posting Date" := TODAY;
            Salesheader."SVA Included" := false;
            Salesheader."SVA Occupant" := SVAOccupant.Number;
            Salesheader."Dimension Set ID" := SVAOccupant."Dimension Set Id";

            CLEAR(SVALeaseContractA9);
            SVALeaseContractA9.SETRANGE(Number, SVAOccupant.Number);
            IF SVALeaseContractA9.FindFirst() THEN
                Salesheader."Due Date" := TypeA9_4_DueDate;


            //If no adress, then use from SVAOccupant
            if Salesheader."Sell-to Address" = '' then begin
                Salesheader."Bill-to Address" := SVAOccupant.Address;
                Salesheader."Bill-to Address 2" := SVAOccupant.Address2;
                Salesheader."Bill-to Post Code" := SVAOccupant."Post Code";
                Salesheader."Bill-to City" := SVAOccupant.City;
                Salesheader."Bill-to Country/Region Code" := SVAOccupant."Country/Region Code";
                Salesheader."Sell-to Customer No." := SVAOccupant."Customer No";
                Salesheader."Sell-to Customer Name" := SVAOccupant.Name1;
                Salesheader."Sell-to Address" := SVAOccupant.Address;
                Salesheader."Sell-to Address 2" := SVAOccupant.Address2;
                Salesheader."Sell-to Post Code" := SVAOccupant."Post Code";
                Salesheader."Sell-to City" := SVAOccupant.City;
                Salesheader."Sell-to Country/Region Code" := SVAOccupant."Country/Region Code";
            end;
            if Salesheader."Gen. Bus. Posting Group" = '' then begin
                Customer.Reset();
                Customer.SETRANGE("No.", SVAOccupant."Customer No");
                IF Customer.FindFirst() THEN BEGIN
                    Salesheader."Payment Terms Code" := Customer."Payment Terms Code";
                    Salesheader."Currency Code" := Customer."Currency Code";
                    Salesheader."Customer Posting Group" := Customer."Customer Posting Group";
                    Salesheader."Gen. Bus. Posting Group" := Customer."Gen. Bus. Posting Group";
                    Salesheader."VAT Bus. Posting Group" := Customer."VAT Bus. Posting Group"
                END;
            end;
            Salesheader.INSERT(TRUE);
            SVAOccupant.FirstNets := CalcDate('<1M>', SVAOccupant.StartDate);
            SVAOccupant.Modify();
        END;

        //Make salesline
        LineNo := 0;
        CLEAR(SVALeaseContractA9);
        SVALeaseContractA9.SETRANGE(Number, SVAOccupant.Number);

        IF SVALeaseContractA9.FindFirst() THEN BEGIN
            //Depositum
            IF SVALeaseContractA9.TypeA9_4_DepMth > 0 THEN BEGIN
                MakeSalesLine();
                SalesLine.Quantity := SVALeaseContractA9.TypeA9_4_DepMth;
                SalesLine."Unit Price" := SVALeaseContractA9.TypeA9_4_DepAmount / SVALeaseContractA9.TypeA9_4_DepMth;
                SalesLine.Amount := SVALeaseContractA9.TypeA9_4_DepAmount;
                SalesLine."Line Amount" := SVALeaseContractA9.TypeA9_4_DepAmount;
                MakeSLFromCosttype(10);
                EndSalesLine();
            END;
            //Forudbetalt leje
            IF SVALeaseContractA9.TypeA9_4_PrepaidRentMth > 0 THEN BEGIN
                MakeSalesLine();
                SalesLine.Quantity := SVALeaseContractA9.TypeA9_4_PrepaidRentMth;
                SalesLine."Unit Price" := SVALeaseContractA9.TypeA9_4_PrepaidRent / SVALeaseContractA9.TypeA9_4_PrepaidRentMth;
                SalesLine.Amount := SVALeaseContractA9.TypeA9_4_PrepaidRent;
                SalesLine."Line Amount" := SVALeaseContractA9.TypeA9_4_PrepaidRent;
                MakeSLFromCosttype(11);
                EndSalesLine();
            END;
            //Første måneds leje
            IF (SVALeaseContractA9.TypeA9_3_RentPerPeriode > 0) and (SVALeaseContractA9.TypeA9_4_Rentetc <> 0) THEN BEGIN
                MakeSalesLine();
                SalesLine.Quantity := 1 * Factor;
                SalesLine."Unit Price" := SVALeaseContractA9.TypeA9_3_RentPerPeriode;
                SalesLine.Amount := SVALeaseContractA9.TypeA9_3_RentPerPeriode;
                SalesLine."Line Amount" := SVALeaseContractA9.TypeA9_3_RentPerPeriode;
                SVASubscriptionLines.Reset();
                SVASubscriptionLines.SetRange(Tenancies, SVAOccupant.TenancyNo);
                SVASubscriptionLines.SetRange(Type, 1); //husleje
                IF SVASubscriptionLines.FindFirst() THEN begin
                    SVACosttype.Reset();
                    SVACosttype.SETRANGE(Costtype, SVASubscriptionLines."Cost Types");
                    IF SVACosttype.FindFirst() THEN BEGIN
                        SalesLine."No." := SVACosttype.Account;
                        SalesLine.Description := 'Leje ' + FORMAT(TypeA9_4_RentFrom) + ' til ' + FORMAT(TypeA9_4_RentTo);
                        SalesLine."Gen. Prod. Posting Group" := SVACosttype.ProductPostingGroup;
                        SalesLine.Validate(SalesLine."Gen. Prod. Posting Group");
                        SalesLine."VAT Prod. Posting Group" := SVACosttype.VatGroup;
                        SalesLine.Validate(SalesLine."VAT Prod. Posting Group");
                        SalesLine."SVA Costtype" := SVACosttype.Costtype;
                    END;
                END;
                EndSalesLine();
            END;
            //ACVarme
            IF (SVALeaseContractA9.TypeA9_3_ACHeat > 0) and (SVALeaseContractA9.TypeA9_4_Rentetc <> 0) THEN BEGIN
                MakeSalesLine();
                SalesLine.Quantity := 1 * Factor;
                SalesLine."Unit Price" := SVALeaseContractA9.TypeA9_3_ACHeat;
                SalesLine.Amount := SVALeaseContractA9.TypeA9_3_ACHeat;
                SalesLine."Line Amount" := SVALeaseContractA9.TypeA9_3_ACHeat;
                MakeSLFromCosttype(2);
                EndSalesLine();
            END;
            //ACVand
            IF (SVALeaseContractA9.TypeA9_3_ACWater > 0) and (SVALeaseContractA9.TypeA9_4_Rentetc <> 0) THEN BEGIN
                MakeSalesLine();
                SalesLine.Quantity := 1 * Factor;
                SalesLine."Unit Price" := SVALeaseContractA9.TypeA9_3_ACWater;
                SalesLine.Amount := SVALeaseContractA9.TypeA9_3_ACWater;
                SalesLine."Line Amount" := SVALeaseContractA9.TypeA9_3_ACWater;
                MakeSLFromCosttype(3);
                EndSalesLine();
            END;
            //ACEl
            IF (SVALeaseContractA9.TypeA9_3_ACElectricity > 0) and (SVALeaseContractA9.TypeA9_4_Rentetc <> 0) THEN BEGIN
                MakeSalesLine();
                SalesLine.Quantity := 1 * factor;
                SalesLine."Unit Price" := SVALeaseContractA9.TypeA9_3_ACElectricity;
                SalesLine.Amount := SVALeaseContractA9.TypeA9_3_ACElectricity;
                SalesLine."Line Amount" := SVALeaseContractA9.TypeA9_3_ACElectricity;
                MakeSLFromCosttype(4);
                EndSalesLine();
            END;
            //ACkøling
            IF (SVALeaseContractA9.TypeA9_3_ACCooling > 0) and (SVALeaseContractA9.TypeA9_4_Rentetc <> 0) THEN BEGIN
                MakeSalesLine();
                SalesLine.Quantity := 1 * factor;
                SalesLine."Unit Price" := SVALeaseContractA9.TypeA9_3_ACCooling;
                SalesLine.Amount := SVALeaseContractA9.TypeA9_3_ACCooling;
                SalesLine."Line Amount" := SVALeaseContractA9.TypeA9_3_ACCooling;
                MakeSLFromCosttype(5);
                EndSalesLine();
            END;
            //Antenne
            IF (SVALeaseContractA9.TypeA9_3_Antenna > 0) and (SVALeaseContractA9.TypeA9_4_Rentetc <> 0) THEN BEGIN
                MakeSalesLine();
                SalesLine.Quantity := 1 * factor;
                SalesLine."Unit Price" := SVALeaseContractA9.TypeA9_3_Antenna;
                SalesLine.Amount := SVALeaseContractA9.TypeA9_3_Antenna;
                SalesLine."Line Amount" := SVALeaseContractA9.TypeA9_3_Antenna;
                MakeSLFromCosttype(7);
                endSalesLine();
            END;
            //Internet
            IF (SVALeaseContractA9.TypeA9_3_Internet > 0) and (SVALeaseContractA9.TypeA9_4_Rentetc <> 0) THEN BEGIN
                MakeSalesLine();
                SalesLine.Quantity := 1 * factor;
                SalesLine."Unit Price" := SVALeaseContractA9.TypeA9_3_Internet;
                SalesLine.Amount := SVALeaseContractA9.TypeA9_3_Internet;
                SalesLine."Line Amount" := SVALeaseContractA9.TypeA9_3_Internet;
                MakeSLFromCosttype(8);
                EndSalesLine();
            END;
            //Beboerrepræsentation
            IF (SVALeaseContractA9.TypeA9_3_TenantGroup > 0) and (SVALeaseContractA9.TypeA9_4_Rentetc <> 0) THEN BEGIN
                MakeSalesLine();
                SalesLine.Quantity := 1 * factor;
                SalesLine."Unit Price" := SVALeaseContractA9.TypeA9_3_TenantGroup;
                SalesLine.Amount := SVALeaseContractA9.TypeA9_3_TenantGroup;
                SalesLine."Line Amount" := SVALeaseContractA9.TypeA9_3_TenantGroup;
                MakeSLFromCosttype(9);
                EndSalesLine();
            END;
            //Andet 1
            IF SVALeaseContractA9.TypeA9_3_OtherAmount1 > 0 THEN BEGIN
                MakeSalesLine();
                SalesLine.Quantity := 1 * factor;
                SalesLine."Unit Price" := SVALeaseContractA9.TypeA9_3_OtherAmount1;
                SalesLine.Amount := SVALeaseContractA9.TypeA9_3_OtherAmount1;
                SalesLine."Line Amount" := SVALeaseContractA9.TypeA9_3_OtherAmount1;

                SVACosttype.Reset();
                SVACosttype.SETRANGE(Type, 1);
                SVACosttype.SETRANGE(VatGroup, VatType);
                IF SVACosttype.FindFirst() THEN BEGIN
                    SalesLine."No." := SVACosttype.Account;
                    SalesLine.Description := SVALeaseContractA9.TypeA9_3_OtherText1;
                    SalesLine."VAT Prod. Posting Group" := SVACosttype.VatGroup;
                    SalesLine."Gen. Prod. Posting Group" := SVACosttype.ProductPostingGroup;
                    SalesLine."SVA Costtype" := SVACosttype.Costtype;
                END;
                SalesLine.Validate(SalesLine."VAT Prod. Posting Group");
                SalesLine.Validate(SalesLine."Unit Price");
                EndSalesLine();
            END;
            //Andet 2
            IF SVALeaseContractA9.TypeA9_3_OtherAmount2 > 0 THEN BEGIN
                MakeSalesLine();
                SalesLine.Quantity := 1 * Factor;
                SalesLine."Unit Price" := SVALeaseContractA9.TypeA9_3_OtherAmount2;
                SalesLine.Amount := SVALeaseContractA9.TypeA9_3_OtherAmount2;
                SalesLine."Line Amount" := SVALeaseContractA9.TypeA9_3_OtherAmount2;

                SVACosttype.Reset();
                SVACosttype.SETRANGE(Type, 1);
                SVACosttype.SETRANGE(VatGroup, VatType);
                IF SVACosttype.FindFirst() THEN BEGIN
                    SalesLine."No." := SVACosttype.Account;
                    SalesLine.Description := SVALeaseContractA9.TypeA9_3_OtherText2;
                    SalesLine."VAT Prod. Posting Group" := SVACosttype.VatGroup;
                    SalesLine."Gen. Prod. Posting Group" := SVACosttype.ProductPostingGroup;
                    SalesLine."SVA Costtype" := SVACosttype.Costtype;
                END;
                SalesLine.Validate(SalesLine."VAT Prod. Posting Group");
                SalesLine.Validate(SalesLine."Unit Price");
                EndSalesLine();
            END;
            //One time invoicelines
            //Andet 1
            IF SVALeaseContractA9.TypeA9_4_Amount1 > 0 THEN BEGIN
                MakeSalesLine();
                SalesLine.Quantity := 1 * factor;
                SalesLine."Unit Price" := SVALeaseContractA9.TypeA9_4_Amount1;
                SalesLine.Amount := SVALeaseContractA9.TypeA9_4_Amount1;
                SalesLine."Line Amount" := SVALeaseContractA9.TypeA9_4_Amount1;

                SVACosttype.Reset();
                SVACosttype.SETRANGE(Type, 0);
                SVACosttype.SETRANGE(VatGroup, VatType);
                IF SVACosttype.FindFirst() THEN BEGIN
                    SalesLine."No." := SVACosttype.Account;
                    SalesLine.Description := SVALeaseContractA9.TypeA9_4_Text1;
                    SalesLine."VAT Prod. Posting Group" := SVACosttype.VatGroup;
                    SalesLine."Gen. Prod. Posting Group" := SVACosttype.ProductPostingGroup;
                    SalesLine."SVA Costtype" := SVACosttype.Costtype;
                END;
                SalesLine.Validate(SalesLine."VAT Prod. Posting Group");
                SalesLine.Validate(SalesLine."Unit Price");
                EndSalesLine();
            END;
            //Andet 2
            IF SVALeaseContractA9.TypeA9_4_Amount2 > 0 THEN BEGIN
                MakeSalesLine();
                SalesLine.Quantity := 1 * factor;
                SalesLine."Unit Price" := SVALeaseContractA9.TypeA9_4_Amount2;
                SalesLine.Amount := SVALeaseContractA9.TypeA9_4_Amount2;
                SalesLine."Line Amount" := SVALeaseContractA9.TypeA9_4_Amount2;

                SVACosttype.Reset();
                SVACosttype.SETRANGE(Type, 0);
                SVACosttype.SETRANGE(VatGroup, VatType);
                IF SVACosttype.FindFirst() THEN BEGIN
                    SalesLine."No." := SVACosttype.Account;
                    SalesLine.Description := SVALeaseContractA9.TypeA9_4_Text2;
                    SalesLine."VAT Prod. Posting Group" := SVACosttype.VatGroup;
                    SalesLine."Gen. Prod. Posting Group" := SVACosttype.ProductPostingGroup;
                    SalesLine."SVA Costtype" := SVACosttype.Costtype;
                END;
                SalesLine.Validate(SalesLine."VAT Prod. Posting Group");
                SalesLine.Validate(SalesLine."Unit Price");
                EndSalesLine();
            END;
            //Andet 3
            IF SVALeaseContractA9.TypeA9_4_Amount3 > 0 THEN BEGIN
                MakeSalesLine();
                SalesLine.Quantity := 1 * factor;
                SalesLine."Unit Price" := SVALeaseContractA9.TypeA9_4_Amount3;
                SalesLine.Amount := SVALeaseContractA9.TypeA9_4_Amount3;
                SalesLine."Line Amount" := SVALeaseContractA9.TypeA9_4_Amount3;

                SVACosttype.Reset();
                SVACosttype.SETRANGE(Type, 0);
                SVACosttype.SETRANGE(VatGroup, VatType);
                IF SVACosttype.FindFirst() THEN BEGIN
                    SalesLine."No." := SVACosttype.Account;
                    SalesLine.Description := SVALeaseContractA9.TypeA9_4_Text3;
                    SalesLine."VAT Prod. Posting Group" := SVACosttype.VatGroup;
                    SalesLine."Gen. Prod. Posting Group" := SVACosttype.ProductPostingGroup;
                    SalesLine."SVA Costtype" := SVACosttype.Costtype;
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
        SalesLine: Record "Sales Line";
        SalesHeader: Record "Sales Header";
        SVAParameters: Record "SVA Parameters";
        SVACosttype: Record "SVA Cost type";
        SVAOccupant: Record "SVA Occupant";
        SVASubscriptionLines: Record "SVA Subscription Lines";
        SVALeaseContractA9: Record "SVA LeaseContract_A9";
        Customer: Record Customer;
        Factor: Decimal;
        Days: Integer;
        LineNo: Integer;
        VatType: Code[10];

    local procedure MakeSalesLine()
    begin
        SalesLine.Init();
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
        SVACosttype.Reset();
        SVACosttype.SETRANGE(Type, CostType);
        SVACosttype.SETRANGE(VatGroup, VatType);
        IF SVACosttype.FindFirst() THEN BEGIN
            SalesLine."No." := SVACosttype.Account;
            SalesLine.Description := SVACosttype.Description;
            SalesLine."Gen. Prod. Posting Group" := SVACosttype.ProductPostingGroup;
            SalesLine."VAT Prod. Posting Group" := VatType;
            SalesLine.Validate(SalesLine."VAT Prod. Posting Group");
            SalesLine.Validate(SalesLine."Unit Price");
            SalesLine."SVA Costtype" := SVACosttype.Costtype;
        END;
    end;
}