pageextension 50010 "SVA General Journal" extends "General Journal"
{
    layout
    {
        addlast(Control1)
        {
            field(Costtype; "SVA Occupant")
            {
                ApplicationArea = all;
            }
        }
    }
}