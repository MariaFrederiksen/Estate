pageextension 50002 "SVA Sales Invoice Line Ext." extends "Sales Invoice Subform"
{
    layout
    {
        addfirst(Control1)

        {
            field(Costtype; "SVA CostType")
            {
                Caption = 'Costtype';
                ApplicationArea = all;
                ToolTip = 'Costtype on this line.';

            }
        }
    }
}
