tableextension 50041 "SVA Gen. Journal Line" extends "Gen. Journal Line"
// SVA Maria Frederiksen
{
    fields
    {
        field(50001; "SVA Occupant"; Text[10])
        {
            Caption = 'Occupant';
            TableRelation = "SVA Occupant".Number;
            DataClassification = CustomerContent;
            Editable = true;
        }
    }

}