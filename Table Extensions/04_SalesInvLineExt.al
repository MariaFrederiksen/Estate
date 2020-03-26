tableextension 50034 "SVA Sales Invoice Line" extends "Sales Invoice Line"
// SVA 1.00 - 17/9-2018 - Maria Frederiksen
//From standard posting Invoice, transferred lines to SVA Occupant Trans
{
    fields
    {
        field(50041; "SVA CostType"; Text[10])
        {
            Caption = 'Costtype';
            DataClassification = CustomerContent;
            Editable = true;
        }
    }
    trigger OnAfterInsert();
    var
        SalesinvHeader: Record "Sales Invoice Header";
        OccupantTrans: Record "SVA Occupant Trans";
        CostTypeAccounts: Record "SVA Cost type";
        Occupant: Text[10];

    begin

        SalesinvHeader.Reset;
        SalesinvHeader.SetRange("No.", Rec."Document No.");
        if SalesinvHeader.findfirst then
            Occupant := SalesinvHeader."SVA Occupant";
        if Occupant <> '' then begin
            OccupantTrans.Occupant := Occupant;
            OccupantTrans.Date := Rec."Posting Date";
            OccupantTrans.Description := Rec.Description;
            OccupantTrans."Invoice No" := Rec."Document No." + '_' + Format(Rec."Line No.");
            OccupantTrans.Price := Rec."Unit Price";
            OccupantTrans.Qty := Rec.Quantity;
            OccupantTrans.Amount := OccupantTrans.Price*OccupantTrans.Qty;           
            OccupantTrans."Cost type Estate" := Rec."SVA CostType";
            CostTypeAccounts.RESET;
            CostTypeAccounts.SETRANGE(Costtype, OccupantTrans."Cost type Estate");
            IF CostTypeAccounts.FINDFIRST() THEN
                OccupantTrans.Type := CostTypeAccounts.Type;
            OccupantTrans.Insert();
        end;
    end;

}