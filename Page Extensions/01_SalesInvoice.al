pageextension 50001 "SVA Sales Invoice Ext." extends "Sales Invoice"
{
    layout
    {
        //addafter("Account Code")
        addlast(General)
        {
            field("SVA Occupant"; Rec."SVA Occupant")
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
        if Rec."SVA Occupant" = '' then begin
            SVAOccupant.Reset();
            SVAOccupant.SetRange("Customer No", Rec."Sell-to Customer No.");
            if SVAOccupant.FindSet() then
                repeat
                    Rec."SVA Occupant" := SVAOccupant.Number;
                    Rec."Dimension Set ID" := SVAOccupant."Dimension Set Id";
                until SVAOccupant.NEXT() = 0;
        end;
    end;
}
