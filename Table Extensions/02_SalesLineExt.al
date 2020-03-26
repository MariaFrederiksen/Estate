tableextension 50032 "SVA Sales Line" extends "Sales Line"
// SVA 1.00 - 17/9-2018 - Maria Frederiksen
{
    fields
    {
        field(50041;"SVA CostType";Text[10])
        {
            Caption = 'Costtype';
            TableRelation = "SVA Cost type".Costtype;
            DataClassification = CustomerContent;
            Editable = true;
        }
    }
        
}