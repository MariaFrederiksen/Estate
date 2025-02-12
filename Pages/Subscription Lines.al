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
                field(Tenancies; Rec.Tenancies)
                {
                    ApplicationArea = All;
                    ToolTip = 'Tenancy';
                }
                field("Cost Types"; Rec."Cost Types")
                {
                    ApplicationArea = All;
                    ToolTip = 'Costtype.';

                    trigger OnValidate();
                    begin
                        Rec.Description := SVACosttype.Description
                    end;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Description of SVACosttype.';
                }
                field("Date From"; Rec."Date From")
                {
                    ApplicationArea = All;
                    ToolTip = 'This line was applicable from';
                }
                field("Date To"; Rec."Date To")
                {
                    ApplicationArea = All;
                    ToolTip = 'This line was applicable to.';
                }
                field("Amount Year"; Rec."Amount Year")
                {
                    ApplicationArea = All;
                    ToolTip = 'Amount per year';
                }
                field("Amount Period"; Rec."Amount Period")
                {
                    ApplicationArea = All;
                    ToolTip = 'Amount per period (month, quater, halfyear or year';
                }
                field(VatGroup; Rec.VatGroup)
                {
                    ApplicationArea = All;
                    ToolTip = 'Vatgroup to calculate VAT for this line.';
                }
                field(ProductPostingGroup; Rec.ProductPostingGroup)
                {
                    ApplicationArea = All;
                    ToolTip = 'Gen. prod. group';
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = all;
                    ToolTip = 'Type of costtype. Is used for reports, moving in/moving out invoices, supscriptions and a conto.';
                }
                field(PriceIndeks; Rec.PriceIndeks)
                {
                    ApplicationArea = all;
                    ToolTip = 'Is the rent regulated by indeks?';
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

