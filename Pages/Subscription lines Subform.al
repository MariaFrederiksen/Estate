page 60560 "SVA Subscription lines subform"
//Tooltip created
{
    AutoSplitKey = true;
    Caption='Subscription lines';
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
                field("Cost Types";"Cost Types")
                {
                    NotBlank = true;
                    ToolTip='Costtype.';
                }
                field(Description;Description)
                {
                    ToolTip='Description of costtype. Will apear on invoices.';
                }
                field("Date From";"Date From")
                {
                    NotBlank = true;
                    ToolTip='This line is applicable from';
                }
                field("Date To";"Date To")
                {
                    ToolTip='This line is applicable to. Best practise is to leave it blank.';
                }
                field("Amount Year";"Amount Year")
                {
                    ToolTip='Amount per year';
                }
                field("Amount Period";"Amount Period")
                {
                    ToolTip='Amount per period (month, quater, halfyear or year';
                }
                field(VatGroup;VatGroup)
                {
                    NotBlank = true;
                    ToolTip='Vatgroup to calculate VAT for this line.';
                }
                field(PriceIndeks;PriceIndeks)
                {
                    ToolTip='This line is regulate by indeks.';
                }
            }
        }
    }

    actions
    {
    }

    var
        TenancyCard : Record "SVA Tenancy";
        CosttypeEstate : Record "SVA Cost type";
}

