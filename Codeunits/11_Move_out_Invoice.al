codeunit 50011 "SVA Move Out Invoice"
{
    //We don't know wether is ends as a invoice or a Cr.memo, so we make the accounting basis away from standard BC
    //Create lines based on former entries deposit and prepaid rent.
    TableNo = "SVA Occupant";
    Permissions = TableData "Dimension Set Entry" = rm;

    trigger OnRun();
    begin
        SVAOccupant.Copy(Rec);
        Rec := SVAOccupant;

        if SVAOccupant.FindFirst() then begin
            //VAT - if rent is with VAT, all is with VAT at moving out
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
            //Find vatrate
            Customer.Reset();
            Customer.SetRange("No.", SVAOccupant."Customer No");
            if Customer.FindFirst() then begin
                VATPostingSetup.Reset();
                VATPostingSetup.SetRange("VAT Prod. Posting Group", VatType);
                VATPostingSetup.SetRange("VAT Bus. Posting Group", Customer."VAT Bus. Posting Group");
                IF VATPostingSetup.FindFirst() then
                    Vatrate := 1 + (VATPostingSetup."VAT %" / 100);
                IF Vatrate = 0 then
                    Vatrate := 1;
            end;

            //Make MoveOut invoice Header
            MoveOutInvoiceHeader.Reset();
            MoveOutInvoiceHeader.SetRange(Number, Rec.Number);
            if not MoveOutInvoiceHeader.FindFirst() then begin
                MoveOutInvoiceHeader.Init();
                MoveOutInvoiceHeader.Number := SVAOccupant.Number;
                MoveOutInvoiceHeader."Customer No" := SVAOccupant."Customer No";
                MoveOutInvoiceHeader.Name1 := SVAOccupant.Name1;
                MoveOutInvoiceHeader.Name2 := SVAOccupant.Name2;
                MoveOutInvoiceHeader.Address := SVAOccupant.Address;
                MoveOutInvoiceHeader.Address2 := SVAOccupant.Address2;
                MoveOutInvoiceHeader."Post Code" := SVAOccupant."Post Code";
                MoveOutInvoiceHeader.City := SVAOccupant.City;
                MoveOutInvoiceHeader."Country/Region Code" := SVAOccupant."Country/Region Code";
                MoveOutInvoiceHeader.StartDate := SVAOccupant.StartDate;
                MoveOutInvoiceHeader.EndDate := SVAOccupant.EndDate;
                MoveOutInvoiceHeader."Posting Date" := WorkDate();
                MoveOutInvoiceHeader.DueDate := WorkDate() + 14;
                MoveOutInvoiceHeader."Dimension Set Id" := SVAOccupant."Dimension Set Id";
                MoveOutInvoiceHeader.Insert();
                //Make MoveOut Invoice lines

                //Deposita
                LineNo := 1;
                CLEAR(SVAOccupantTrans);
                SVAOccupantTrans.Reset();
                SVAOccupantTrans.SETRANGE(Occupant, MoveOutInvoiceHeader.Number);
                SVAOccupantTrans.SETRANGE(Type, 10);
                IF SVAOccupantTrans.FindSet() THEN
                    REPEAT
                        IF SVAOccupantTrans.Occupant = MoveOutInvoiceHeader.Number THEN begin
                            MoveOutInvoiceLineInitTrans(10);
                            MoveOutInvoiceLine.INSERT(TRUE);
                        end;
                    UNTIL SVAOccupantTrans.Next() = 0;
                //Deposita
                //Prepaid rent
                CLEAR(SVAOccupantTrans);
                SVAOccupantTrans.Reset();
                SVAOccupantTrans.SETRANGE(Occupant, MoveOutInvoiceHeader.Number);
                SVAOccupantTrans.SETRANGE(Type, 11);
                IF SVAOccupantTrans.FindSet() THEN
                    REPEAT
                        IF SVAOccupantTrans.Occupant = MoveOutInvoiceHeader.Number THEN BEGIN
                            MoveOutInvoiceLineInitTrans(11);
                            MoveOutInvoiceLine.INSERT(TRUE);
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
                            MoveOutInvoiceLine.INIT();
                            MoveOutInvoiceLine."Line No." := LineNo;
                            LineNo := LineNo + 1;
                            MoveOutInvoiceLine."Line Number" := MoveOutInvoiceHeader.Number;
                            MoveOutInvoiceLine.Quantity := 1;
                            MoveOutInvoiceLine."Unit Price" := SVASubscriptionLines."Amount Period";
                            MoveOutInvoiceLine."Line Amount" := MoveOutInvoiceLine.Quantity * MoveOutInvoiceLine."Unit Price";
                            MoveOutInvoiceLine.Account := SVACosttype.Account;
                            MoveOutInvoiceLine.Description := SVASubscriptionLines.Description;
                            MoveOutInvoiceLine."VAT Prod. Posting Group" := SVACosttype.VatGroup;
                            MoveOutInvoiceLine."Gen. Prod. Posting Group" := SVACosttype.ProductPostingGroup;
                            MoveOutInvoiceLine."Cost Type" := SVACosttype.Costtype;
                            MoveOutInvoiceLine."Dimension Set Id" := MoveOutInvoiceHeader."Dimension Set Id";
                            IF MoveOutInvoiceLine."Line Amount" <> 0 THEN
                                MoveOutInvoiceLine.INSERT(TRUE);
                        UNTIL SVASubscriptionLines.NEXT() = 0
                END; //Moving out costs
                //Heat
                CLEAR(SVACosttype);
                SVACosttype.RESET();
                SVACosttype.SETRANGE(Type, 2);
                IF SVACosttype.FINDFIRST() THEN BEGIN
                    MoveOutInvoiceLine.INIT();
                    MoveOutInvoiceLine."Line No." := LineNo;
                    LineNo := LineNo + 1;
                    MoveOutInvoiceLine."Line Number" := MoveOutInvoiceHeader.Number;
                    MoveOutInvoiceLine.Quantity := 1;
                    MoveOutInvoiceLine."Unit Price" := 1500;
                    MoveOutInvoiceLine."Line Amount" := MoveOutInvoiceLine.Quantity * MoveOutInvoiceLine."Unit Price";
                    MoveOutInvoiceLine.Account := SVACosttype.Account;
                    MoveOutInvoiceLine.Description := 'Tilb. varmeregnskab';
                    MoveOutInvoiceLine."VAT Prod. Posting Group" := SVACosttype.VatGroup;
                    MoveOutInvoiceLine."Gen. Prod. Posting Group" := SVACosttype.ProductPostingGroup;
                    MoveOutInvoiceLine."Cost Type" := SVACosttype.Costtype;
                    MoveOutInvoiceLine."Dimension Set Id" := MoveOutInvoiceHeader."Dimension Set Id";
                    IF MoveOutInvoiceLine.Account <> '' THEN
                        MoveOutInvoiceLine.INSERT(TRUE);
                END; //Heat
                //Water
                CLEAR(SVACosttype);
                SVACosttype.RESET();
                SVACosttype.SETRANGE(Type, 3);
                IF SVACosttype.FINDFIRST() THEN BEGIN
                    MoveOutInvoiceLine.INIT();
                    MoveOutInvoiceLine."Line No." := LineNo;
                    LineNo := LineNo + 1;
                    MoveOutInvoiceLine."Line Number" := MoveOutInvoiceHeader.Number;
                    MoveOutInvoiceLine.Quantity := 1;
                    MoveOutInvoiceLine."Unit Price" := 1500;
                    MoveOutInvoiceLine."Line Amount" := MoveOutInvoiceLine.Quantity * MoveOutInvoiceLine."Unit Price";
                    MoveOutInvoiceLine.Account := SVACosttype.Account;
                    MoveOutInvoiceLine.Description := 'Tilb. vandregnskab';
                    MoveOutInvoiceLine."VAT Prod. Posting Group" := SVACosttype.VatGroup;
                    MoveOutInvoiceLine."Gen. Prod. Posting Group" := SVACosttype.ProductPostingGroup;
                    MoveOutInvoiceLine."Cost Type" := SVACosttype.Costtype;
                    MoveOutInvoiceLine."Dimension Set Id" := MoveOutInvoiceHeader."Dimension Set Id";
                    IF MoveOutInvoiceLine.Account <> '' THEN
                        MoveOutInvoiceLine.INSERT(TRUE);
                END; //Water
            end;
        end;
    end;

    var
        SVAOccupant: Record "SVA Occupant";
        SVASubscriptionLines: Record "SVA Subscription Lines";
        SVACosttype: Record "SVA Cost type";
        SVAOccupantTrans: Record "SVA Occupant Trans";
        MoveOutInvoiceHeader: Record "SVA MoveOut Invoice Header";
        MoveOutInvoiceLine: Record "SVA MoveOut Invoice Line";
        VatPostingSetup: Record "VAT Posting Setup";
        Customer: Record Customer;
        LineNo: Integer;
        VatType: Code[10];
        VATRate: Decimal;

    local procedure MoveOutInvoiceLineInitTrans(Costtype: Integer);
    begin
        MoveOutInvoiceLine.INIT();
        MoveOutInvoiceLine."Line No." := LineNo;
        LineNo := LineNo + 10000;
        MoveOutInvoiceLine."Line Number" := MoveOutInvoiceHeader.Number;
        MoveOutInvoiceLine.Quantity := SVAOccupantTrans.Qty * -1;
        MoveOutInvoiceLine."Unit Price" := SVAOccupantTrans.Price;
        MoveOutInvoiceLine."Line Amount" := MoveOutInvoiceLine.Quantity * MoveOutInvoiceLine."Unit Price";
        SVACosttype.Reset();
        SVACosttype.SETRANGE(Type, Costtype);
        IF SVACosttype.FINDFIRST() THEN BEGIN
            MoveOutInvoiceLine.Account := SVACosttype.Account;
            MoveOutInvoiceLine.Description := SVACosttype.Description;
            MoveOutInvoiceLine."Cost Type" := SVACosttype.Costtype;
            MoveOutInvoiceLine."VAT Prod. Posting Group" := SVACosttype.VatGroup;
            MoveOutInvoiceLine."Gen. Prod. Posting Group" := SVACosttype.ProductPostingGroup;
        END;
    end;
}