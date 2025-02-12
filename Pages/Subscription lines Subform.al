page 50019 "SVA Subscription lines subform"
//Tooltip created
{
    AutoSplitKey = true;
    Caption = 'Subscription lines';
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "SVA Subscription Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Cost Types"; Rec."Cost Types")
                {
                    NotBlank = true;
                    ToolTip = 'Costtype.';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Description of costtype. Will apear on invoices.';
                    ApplicationArea = All;
                }
                field("Date From"; Rec."Date From")
                {
                    NotBlank = true;
                    ToolTip = 'This line is applicable from';
                    ApplicationArea = All;
                }
                field("Date To"; Rec."Date To")
                {
                    ApplicationArea = All;
                    ToolTip = 'This line is applicable to. Best practise is to leave it blank.';
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

                field(ProductPostingGroup; Rec.ProductPostingGroup)
                {
                    NotBlank = true;
                    ToolTip = 'Prod.posting group for this line.';
                    ApplicationArea = All;
                }
                field(VatGroup; Rec.VatGroup)
                {
                    NotBlank = true;
                    ToolTip = 'Vatgroup to calculate VAT for this line.';
                    ApplicationArea = All;
                }
                field(PriceIndeks; Rec.PriceIndeks)
                {
                    ApplicationArea = All;
                    ToolTip = 'If set to true, this line can be adjusted automatically according to the setup on the contract';
                }
            }
        }
    }

}

