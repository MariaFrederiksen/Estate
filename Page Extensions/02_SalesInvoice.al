pageextension 50001 "SVA Sales Invoice Ext." extends "Sales Invoice"
{
    layout
    {
        //addafter("Account Code")
        addlast(General)
        {
            field("SVA Occupant"; "SVA Occupant")
            {
                Caption = 'Occupant';
                ApplicationArea = all;
                ToolTip = 'Occupant no. Related to occupant entries.';
            }
        }
    }
    trigger OnAfterGetRecord();
    var
        SVAOccupant: Record "SVA Occupant";
    begin
        if "SVA Occupant" = '' then begin
            SVAOccupant.Reset();
            SVAOccupant.SetRange("Customer No", "Sell-to Customer No.");
            if SVAOccupant.FindSet() then
                repeat
                    "SVA Occupant" := SVAOccupant.Number;
                until SVAOccupant.NEXT() = 0;
        end;
    end;
}
