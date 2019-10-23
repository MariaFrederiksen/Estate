pageextension 50003 "SVA Credit memo Ext." extends "Sales Credit Memo"
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
