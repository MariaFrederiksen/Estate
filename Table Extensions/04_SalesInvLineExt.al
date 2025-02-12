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
        SalesInvoiceHeader.SetRange("No.", "Document No.");
        if SalesInvoiceHeader.FindFirst() then
            Occupant := SalesInvoiceHeader."SVA Occupant";
        if (Occupant <> '') and (Rec."SVA CostType" <> '') then begin
            SVAOccupantTrans.Occupant := Occupant;
            SVAOccupantTrans.Date := "Posting Date";
            SVAOccupantTrans.Description := Description;
            SVAOccupantTrans."Invoice No" := "Document No." + '_' + Format("Line No.");
            SVAOccupantTrans.Price := "Unit Price";
            SVAOccupantTrans.Qty := Quantity;
            SVAOccupantTrans.Amount := SVAOccupantTrans.Price * SVAOccupantTrans.Qty;
            SVAOccupantTrans."Cost type Estate" := "SVA CostType";
            SVACosttype.Reset();
            SVACosttype.SETRANGE(Costtype, SVAOccupantTrans."Cost type Estate");
            IF SVACosttype.FINDFIRST() THEN
                SVAOccupantTrans.Type := SVACosttype.Type;
            SVAOccupantTrans.Insert();
        end;
    end;

}