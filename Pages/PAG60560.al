page 60560 "Subscription lines subform"
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
                }
                field(Description;Description)
                {
                }
                field("Date From";"Date From")
                {
                    NotBlank = true;
                }
                field("Date To";"Date To")
                {
                }
                field("Amount Year";"Amount Year")
                {
                }
                field("Amount Period";"Amount Period")
                {
                }
                field(VatGroup;VatGroup)
                {
                }
                field(PriceIndeks;PriceIndeks)
                {
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

