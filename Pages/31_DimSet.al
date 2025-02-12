page 50031 "SVA DimSet"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Dimension Set Entry";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Dimension Set ID"; Rec."Dimension Set ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tooltip';
                }
                field("Dimension Code"; Rec."Dimension Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tooltip';
                }
                field("Dimension Name"; Rec."Dimension Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tooltip';
                }
                Field("Dimension Value Code"; Rec."Dimension Value Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tooltip';
                }
                field("Dimension Value ID"; Rec."Dimension Value ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tooltip';
                }
                field("Dimension Value Name"; Rec."Dimension Value Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Tooltip';
                }
            }
        }
        area(Factboxes)
        {

        }
    }


}