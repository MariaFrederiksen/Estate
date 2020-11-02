codeunit 50011 "SVA Move Out Invoice"
{
    TableNo = "SVA Occupant";

    trigger OnRun();
    begin
        SVAOccupant.Copy(Rec);
        Rec := SVAOccupant;
        IF SVAOccupant.FINDFIRST() THEN BEGIN
            //VAT - if rent is with VAT, all is with VAT at moving out.     
            SVASubscriptionLines.Reset();
            SVASubscriptionLines.Setrange(Tenancies, SVAOccupant.TenancyNo);
            SVASubscriptionLines.SetRange(type, 1);
            if SVASubscriptionLines.findfirst() then begin
                SVACosttype.Reset();
                SVACosttype.SETRANGE(Costtype, SVASubscriptionLines."Cost Types");
                IF SVACosttype.FindFirst() then
                    VatType := SVACosttype.VatGroup;
            end;
            //if subscriptionline don't have a line of type Rent
            if VatType = '' then begin
                SVASubscriptionLines.Reset();
                SVASubscriptionLines.Setrange(Tenancies, SVAOccupant.TenancyNo);
                if SVASubscriptionLines.findfirst() then begin
                    SVACosttype.Reset();
                    SVACosttype.SETRANGE(Costtype, SVASubscriptionLines."Cost Types");
                    IF SVACosttype.FindFirst() then
                        VatType := SVACosttype.VatGroup;
                end;
            end;


            //Make salesheader
            Salesheader.INIT();
            Salesheader.VALIDATE("Document Type", Salesheader."Document Type"::Order);
            Salesheader."No." := '';
            Salesheader."Sell-to Customer No." := SVAOccupant."Customer No";
            Salesheader.Validate("Sell-to Customer No.");

            Salesheader."Posting Date" := Today();
            Salesheader."Due Date" := Today() + 14;   //RETTES
            Salesheader."SVA Included" := false;
            Salesheader."SVA Occupant" := SVAOccupant.Number;
            Salesheader."Dimension Set ID" := SVAOccupant."Dimension Set Id";

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
                IF Customer.FINDFIRST() THEN BEGIN
                    Salesheader."Payment Terms Code" := Customer."Payment Terms Code";
                    Salesheader."Currency Code" := Customer."Currency Code";
                    Salesheader."Customer Posting Group" := Customer."Customer Posting Group";
                    Salesheader."Gen. Bus. Posting Group" := Customer."Gen. Bus. Posting Group";
                    Salesheader."VAT Bus. Posting Group" := Customer."VAT Bus. Posting Group"
                END;
            end;
            Salesheader.INSERT(TRUE);
        END;
        //Deposita
        LineNo := 1;
        CLEAR(SVAOccupantTrans);
        SVAOccupantTrans.Reset();
        SVAOccupantTrans.SETRANGE(Occupant, SalesHeader."SVA Occupant");
        SVAOccupantTrans.SETRANGE(Type, 10);
        IF SVAOccupantTrans.FindSet() THEN
            REPEAT
                IF SVAOccupantTrans.Occupant = SalesHeader."SVA Occupant" THEN begin
                    SaleslineInitTrans(10);
                    SalesLine.INSERT(TRUE);
                end;
            UNTIL SVAOccupantTrans.Next() = 0;
        //Deposita
        //Prepaid rent
        CLEAR(SVAOccupantTrans);
        SVAOccupantTrans.Reset();
        SVAOccupantTrans.SETRANGE(Occupant, SalesHeader."SVA Occupant");
        SVAOccupantTrans.SETRANGE(Type, 11);
        IF SVAOccupantTrans.FindSet() THEN
            REPEAT
                IF SVAOccupantTrans.Occupant = SalesHeader."SVA Occupant" THEN BEGIN
                    SaleslineInitTrans(11);
                    SalesLine.INSERT(TRUE);
                END;
            UNTIL SVAOccupantTrans.NEXT() = 0;
        //Prepaid Rent
        //Moving out costs
        CLEAR(SVACosttype);
        SVACosttype.RESET();
        SVACosttype.SETRANGE(Type, 13, 14);
        IF SVACosttype.FINDFIRST() THEN BEGIN
            CLEAR(SVASubscriptionLines);
            SVASubscriptionLines.RESET();
            SVASubscriptionLines.SETRANGE(Tenancies, SVAOccupant.TenancyNo);
            SVASubscriptionLines.SETRANGE("Cost Types", SVACosttype.Costtype);
            IF SVASubscriptionLines.FindSet() THEN
                REPEAT
                    SalesLine.INIT();
                    SalesLine.VALIDATE(SalesLine."Document Type", Salesheader."Document Type"::Order);
                    SalesLine."Line No." := LineNo;
                    LineNo := LineNo + 1;
                    SalesLine.Type := 1;
                    SalesLine."Document No." := Salesheader."No.";
                    SalesLine.Quantity := 1;
                    SalesLine."Qty. to Ship" := SalesLine.Quantity;
                    SalesLine."Qty. to Invoice" := SalesLine.Quantity;
                    SalesLine."Unit Price" := SVASubscriptionLines."Amount Period";
                    SalesLine."Line Amount" := SalesLine.Quantity * SalesLine."Unit Price";
                    SalesLine.Amount := SalesLine.Quantity * SalesLine."Unit Price";
                    SalesLine."No." := SVACosttype.Account;
                    SalesLine.Description := SVASubscriptionLines.Description;
                    SalesLine."VAT Prod. Posting Group" := SVACosttype.VatGroup;
                    SalesLine."Gen. Prod. Posting Group" := SVACosttype.ProductPostingGroup;
                    SalesLine.Validate(SalesLine."Gen. Bus. Posting Group");
                    SalesLine."Dimension Set ID" := SalesHeader."Dimension Set ID";
                    Salesline.Validate("Dimension Set ID");
                    SalesLine."Gen. Bus. Posting Group" := SalesHeader."Gen. Bus. Posting Group";
                    SalesLine."VAT Bus. Posting Group" := SalesHeader."VAT Bus. Posting Group";
                    SalesLine."SVA Costtype" := SVACosttype.Costtype;
                    Salesline.Validate(SalesLine."Gen. Bus. Posting Group");
                    SalesLine.Validate("VAT Prod. Posting Group");
                    SalesLine.Validate("Gen. Prod. Posting Group");
                    IF SalesLine.Amount <> 0 THEN
                        SalesLine.INSERT(TRUE);
                UNTIL SVASubscriptionLines.NEXT() = 0

        END; //Moving out costs
        //to futher processing
        Page.Run(page::"Sales Order List");

    end;

    var
        SVAOccupant: Record "SVA Occupant";
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        SVAOccupantTrans: Record "SVA Occupant Trans";
        SVACosttype: Record "SVA Cost type";
        SVASubscriptionLines: Record "SVA Subscription Lines";
        Customer: Record Customer;
        LineNo: Integer;
        VatType: Code[10];

    local procedure SaleslineInitTrans(Costtype: Integer);
    begin
        SalesLine.INIT();
        SalesLine.VALIDATE(SalesLine."Document Type", Salesheader."Document Type"::Order);
        SalesLine."Line No." := LineNo;
        LineNo := LineNo + 1;
        SalesLine.Type := 1;
        SalesLine."Document No." := Salesheader."No.";
        SalesLine.Quantity := SVAOccupantTrans.Qty * -1;
        SalesLine."Qty. to Ship" := SalesLine.Quantity;
        SalesLine."Qty. to Invoice" := SalesLine.Quantity;
        SalesLine."Unit Price" := SVAOccupantTrans.Price;
        SalesLine."Line Amount" := SalesLine.Quantity * SalesLine."Unit Price";
        SalesLine.Amount := SalesLine.Quantity * SalesLine."Unit Price";
        SalesLine."Dimension Set ID" := SalesHeader."Dimension Set ID";
        Salesline.Validate("Dimension Set ID");
        SalesLine."Gen. Bus. Posting Group" := SalesHeader."Gen. Bus. Posting Group";
        Salesline.Validate(SalesLine."Gen. Bus. Posting Group");
        SalesLine."VAT Bus. Posting Group" := SalesHeader."VAT Bus. Posting Group";
        SVACosttype.Reset();
        SVACosttype.SETRANGE(Type, Costtype);
        IF SVACosttype.FINDFIRST() THEN BEGIN
            SalesLine."No." := SVACosttype.Account;
            SalesLine.Description := SVACosttype.Description;
            SalesLine."SVA CostType" := SVACosttype.Costtype;
            SalesLine."VAT Prod. Posting Group" := SVACosttype.VatGroup;
            SalesLine."Gen. Prod. Posting Group" := SVACosttype.ProductPostingGroup;
            SalesLine.Validate("VAT Prod. Posting Group");
            SalesLine.Validate("Gen. Prod. Posting Group");
        END;
    end;

}