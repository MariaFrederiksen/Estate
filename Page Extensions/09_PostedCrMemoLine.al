pageextension 50006 "SVA Posted CrMemo Line Ext." extends "Posted Sales Cr. Memo Subform"
{
    layout
    {
        addlast(Control1)
        {
            field(Costtype; "SVA CostType")
            {
                Caption = 'Costtype';
                ApplicationArea = all;
            }
        }
    }
}
