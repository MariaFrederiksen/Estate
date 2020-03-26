tableextension 50033 "SVA SalesInvHeaderExt" extends "Sales Invoice Header"
// SVA 1.00 - 17/9-2018 - Maria Frederiksen

{
    fields
    {

        field(50041; "SVA Included"; Boolean)
        {
            Caption = 'Included';
            DataClassification = CustomerContent;
            Editable = true;
           
        }
        field(50042; "SVA Send"; Boolean)
        {
            Caption = 'Send';
            DataClassification = CustomerContent;
            Editable = true;
            
        }
        field(50043; "SVA Send Date"; Date)
        {
            Caption = 'Send date';
            DataClassification = CustomerContent;
            Editable = true;
           
        }
        field(50044; "SVA Occupant"; Code[10])
        {
            Caption = 'Occupant';
            TableRelation = "SVA Occupant".Number;
            DataClassification = CustomerContent;
           
        }
    }
    trigger OnBeforeInsert();
    var
        OccupantRec: Record "SVA Occupant";
    begin
        if "SVA Occupant" = '' then begin
            OccupantRec.Reset;
            OccupantRec.SetRange("Customer No", "Sell-to Customer No.");
            if OccupantRec.FindSet then
                repeat
                    "SVA Occupant" := OccupantRec.Number;
                until OccupantRec.Next = 0;
        end;
    end;
}
