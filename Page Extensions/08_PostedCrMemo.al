pageextension 50005 "SVA Posted Cr.Memo Ext." extends "Posted Sales Credit Memo"
{
    layout
    {
        //addafter("Account Code")
        addlast(General)
        {
            field(Occupant; "SVA Occupant")
            {
                Caption = 'Occupant';
                ApplicationArea = all;
                ToolTip = 'Occupant no. Related to occupant entries.';
            }
        }
    }
}
