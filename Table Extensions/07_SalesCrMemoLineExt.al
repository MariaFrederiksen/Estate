tableextension 50007 "SVA Cr.Memo Line" extends "Sales Cr.Memo Line"
// SVA 1.00 - 17/9-2018 - Maria Frederiksen
//From standard posting Credit Memo, transferred lines to SVA Occupant Trans
{
    fields
    {
        field(50001;"SVA CostType";Text[10])
        {
            Caption = 'Costtype';
            DataClassification = CustomerContent;
            AccessByPermission = TableData 50006 = rimd;
        }
    }
    trigger OnAfterInsert();
    var
        SalesCrHeader: Record "Sales Cr.Memo Header";
        OccupantTrans: Record "SVA Occupant Trans";
        CostTypeAccounts: Record "SVA Cost type";
        Occupant: Text[10];
        
    begin
        SalesCrHeader.Reset;
        SalesCrHeader.SetRange("No.", Rec."Document No.");
        if SalesCrHeader.findfirst then
            Occupant := SalesCrHeader."SVA Occupant";

        if Occupant <> '' then begin
            OccupantTrans.Occupant := Occupant;
            OccupantTrans.Date := Rec."Posting Date";
            OccupantTrans.Description := Rec.Description;
            OccupantTrans."Invoice No" := Rec."Document No." + '_' + Format(Rec."Line No.");
            OccupantTrans.Price := Rec."Unit Price";
            OccupantTrans.Qty := Rec.Quantity*-1;
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