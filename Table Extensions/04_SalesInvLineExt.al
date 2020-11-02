tableextension 50034 "SVA Sales Invoice Line" extends "Sales Invoice Line"
//From standard posting Invoice, transfer saleslines to SVA Occupant Trans
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
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SVAOccupantTrans: Record "SVA Occupant Trans";
        SVACosttype: Record "SVA Cost type";
        Occupant: Text[10];

    begin

        SalesInvoiceHeader.Reset();
        SalesInvoiceHeader.SetRange("No.", Rec."Document No.");
        if SalesInvoiceHeader.FindFirst() then
            Occupant := SalesInvoiceHeader."SVA Occupant";
        if Occupant <> '' then begin
            SVAOccupantTrans.Occupant := Occupant;
            SVAOccupantTrans.Date := Rec."Posting Date";
            SVAOccupantTrans.Description := Rec.Description;
            SVAOccupantTrans."Invoice No" := Rec."Document No." + '_' + Format(Rec."Line No.");
            SVAOccupantTrans.Price := Rec."Unit Price";
            SVAOccupantTrans.Qty := Rec.Quantity;
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