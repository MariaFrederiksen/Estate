tableextension 50037 "SVA Cr.Memo Line" extends "Sales Cr.Memo Line"
// SVA 1.00 - 17/9-2018 - Maria Frederiksen
//From standard posting Credit Memo, transferred lines to SVA Occupant Trans
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
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        SVAOccupantTrans: Record "SVA Occupant Trans";
        SVACosttype: Record "SVA Cost type";
        Occupant: Text[10];

    begin
        SalesCrMemoHeader.Reset();
        SalesCrMemoHeader.SetRange("No.", Rec."Document No.");
        if SalesCrMemoHeader.FindFirst() then
            Occupant := SalesCrMemoHeader."SVA Occupant";

        if Occupant <> '' then begin
            SVAOccupantTrans.Occupant := Occupant;
            SVAOccupantTrans.Date := Rec."Posting Date";
            SVAOccupantTrans.Description := Rec.Description;
            SVAOccupantTrans."Invoice No" := Rec."Document No." + '_' + Format(Rec."Line No.");
            SVAOccupantTrans.Price := Rec."Unit Price";
            SVAOccupantTrans.Qty := Rec.Quantity * -1;
            SVAOccupantTrans.Amount := SVAOccupantTrans.Price * SVAOccupantTrans.Qty;
            SVAOccupantTrans."Cost type Estate" := Rec."SVA CostType";
            SVACosttype.Reset();
            SVACosttype.SETRANGE(Costtype, SVAOccupantTrans."Cost type Estate");
            IF SVACosttype.FINDFIRST() THEN
                SVAOccupantTrans.Type := SVACosttype.Type;
            SVAOccupantTrans.Insert();
        end;
    end;
}