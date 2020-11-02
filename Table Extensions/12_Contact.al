tableextension 50042 "SVA Contact" extends "Contact"

{
    fields
    {
        field(50001; "SVA Occupant"; Text[20])
        {
            Caption = 'Occupant';
            TableRelation = "SVA Occupant".Number;
            DataClassification = CustomerContent;
            Editable = true;
        }
    }

}