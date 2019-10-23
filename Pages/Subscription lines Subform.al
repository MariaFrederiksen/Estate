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
                field("Cost Types"; "Cost Types")
                {
                    NotBlank = true;
                    ToolTip = 'Costtype.';
                    ApplicationArea = All;
                }
                field(Description; Description)
                {                    
                    ToolTip = 'Description of costtype. Will apear on invoices.';
                    ApplicationArea = All;
                }
                field("Date From"; "Date From")
                {
                    NotBlank = true;
                    ToolTip = 'This line is applicable from';
                    ApplicationArea = All;
                }
                field("Date To"; "Date To")
                {                    
                    ApplicationArea = All;
                    ToolTip = 'This line is applicable to. Best practise is to leave it blank.';
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

                field(ProductPostingGroup; ProductPostingGroup)
                {
                    NotBlank = true;
                    ToolTip = 'Prod.posting group for this line.';
                    ApplicationArea = All;
                }
                field(VatGroup; VatGroup)
                {
                    NotBlank = true;
                    ToolTip = 'Vatgroup to calculate VAT for this line.';
                    ApplicationArea = All;
                }
                field(PriceIndeks; PriceIndeks)
                {                    
                    ApplicationArea = All;
                    ToolTip = 'This line is regulate by indeks.';
                }
            }
        }
    }
}

