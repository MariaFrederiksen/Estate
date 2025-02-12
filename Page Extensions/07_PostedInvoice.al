pageextension 50007 "SVA Posted Invoice Ext." extends "Posted Sales Invoice"
{
    layout
    {
        //addafter("Account Code")
        addlast(General)
        {
            field(Occupant; Rec."SVA Occupant")
            {
                Caption = 'Occupant';
                ApplicationArea = All;
                ToolTip = 'Occupant no. Related to occupant entries.';
            }
        }
    }
}
