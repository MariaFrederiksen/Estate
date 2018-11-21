page 60542 "SVA Subscription Lines"
{
    Caption='Subscription Lines';
    InsertAllowed = true;
    PageType = List;
    SourceTable = "SVA Subscription Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Tenancies;Tenancies)
                {
                }
                field("Cost Types";"Cost Types")
                {
                    ToolTip='Costtype.';

                    trigger OnValidate();
                    begin
                        Description := Costtype.Description
                    end;
                }
                field(Description;Description)
                {
                    ToolTip='Description of costtype.';
                }
                field("Date From";"Date From")
                {
                    ToolTip='This line was applicable from';
                }
                field("Date To";"Date To")
                {
                    ToolTip='This line was applicable to.';
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
                    ToolTip='Vatgroup to calculate VAT for this line.';
                }
            }
        }
        area(factboxes)
        {
            systempart(Links;Links)
            {
            }
            systempart(Notes;Notes)
            {
            }
        }
    }

    actions
    {
    }

    var
        Costtype : Record "SVA Cost Type";
}

