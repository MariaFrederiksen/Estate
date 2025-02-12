pageextension 50004 "SVA CrMemo Line Ext." extends "Sales Cr. Memo Subform"
{
    layout
    {
        addlast(Control1)
        {
            field(Costtype; Rec."SVA CostType")
            {
                Caption = 'Costtype';
                ApplicationArea = all;
                ToolTip = 'Costtype. Related to G/L Account';
            }
        }
    }
}
