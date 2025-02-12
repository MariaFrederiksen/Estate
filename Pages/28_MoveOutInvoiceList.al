page 50028 "SVA Move Out Invoice List"
{
    Caption = 'Move Out Invoice List';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "SVA MoveOut Invoice Header";
    CardPageID = "SVA Move Out Invoice";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(Number; Rec.Number)
                {
                    ApplicationArea = All;
                    Tooltip = 'Agreement number';
                }
                field("Customer No"; Rec."Customer No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Costumer no. from customer table.';
                }
                field(Name1; Rec.Name1)
                {
                    ApplicationArea = All;
                    ToolTip = 'Tenants full name';
                }
                field(Name2; Rec.Name2)
                {
                    ApplicationArea = All;
                    ToolTip = 'Second tenants name';
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                    ToolTip = 'Invoice address';
                }
                field(Address2; Rec.Address2)
                {
                    ApplicationArea = All;
                    ToolTip = 'Invoice address 2';
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Invoice post code';
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                    ToolTip = 'Invoice city';
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Invoice Country code';
                }
                field(startdate; Rec.StartDate)
                {
                    ApplicationArea = All;
                    ToolTip = 'Startdate of the contract.';
                }
                field(EndDate; Rec.EndDate)
                {
                    ApplicationArea = All;
                    ToolTip = 'The date this contract expire';
                }
            }
        }
    }
}