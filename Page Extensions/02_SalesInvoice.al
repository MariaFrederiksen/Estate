pageextension 50001 "SVA Sales Invoice Ext." extends "Sales Invoice"
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
            }
        }
    }
    trigger OnAfterGetRecord();
    var
        OccupantCard: Record "SVA Occupant";
        begin
            if "SVA Occupant" = '' then begin
                OccupantCard.Reset;
                OccupantCard.SetRange("Customer No", "Sell-to Customer No.");
                if OccupantCard.FindSet then
                    repeat
                        "SVA Occupant" := OccupantCard.Number;
                    until OccupantCard.Next = 0;
            end;
        end;
}
