page 50020 "SVA Subscription Lines"
{
    Caption = 'Subscription Lines';
    PageType = List;
    SourceTable = "SVA Subscription Lines";
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Tenancies; Tenancies)
                {
                    ApplicationArea = All;
                    ToolTip = 'Tenancy';
                }
                field("Cost Types"; "Cost Types")
                {
                    ApplicationArea = All;
                    ToolTip = 'SVACosttype.';

                    trigger OnValidate();
                    begin
                        Description := SVACosttype.Description
                    end;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Description of SVACosttype.';
                }
                field("Date From"; "Date From")
                {
                    ApplicationArea = All;
                    ToolTip = 'This line was applicable from';
                }
                field("Date To"; "Date To")
                {
                    ApplicationArea = All;
                    ToolTip = 'This line was applicable to.';
                }
                field("Amount Year"; "Amount Year")
                {
                    ApplicationArea = All;
                    ToolTip = 'Amount per year';
                }
                field("Amount Period"; "Amount Period")
                {
                    ApplicationArea = All;
                    ToolTip = 'Amount per period (month, quater, halfyear or year';
                }
                field(VatGroup; VatGroup)
                {
                    ApplicationArea = All;
                    ToolTip = 'Vatgroup to calculate VAT for this line.';
                }
                field(ProductPostingGroup; ProductPostingGroup)
                {
                    ApplicationArea = All;
                    ToolTip = 'Gen. prod. group';
                }
                field(Type; Type)
                {
                    ApplicationArea = all;
                }
            }
        }
        area(factboxes)
        {
            systempart(Links; Links)
            {
                ApplicationArea = All;
            }
            systempart(Notes; Notes)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
    }

    var
        SVACosttype: Record "SVA Cost Type";
}

