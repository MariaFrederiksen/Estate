pageextension 50010 "SVA General Journal" extends "General Journal"
{
    layout
    {
        addlast(Control1)
        {
            field("SVA Occupant"; "SVA Occupant")
            {
                ApplicationArea = all;
                ToolTip = 'Occupant no. Related to occupant entries.';
            }
        }
    }
}