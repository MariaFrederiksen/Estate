pageextension 50015 "SVA Customer Card" extends "Customer Card"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {

        addafter(Documents)
        {
            action(FindOccupant)
            {
                Caption = 'Occupant';
                ToolTip = 'Finds occupant(s) with this customer as tenant.';
                ApplicationArea = all;
                RunObject = Page "SVA Occupant List";
                RunPageLink = "Customer No" = FIELD("No.");
            }
        }
    }
}