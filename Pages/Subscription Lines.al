page 60542 "Subscription Lines"
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

                    trigger OnValidate();
                    begin
                        Description := Costtype.Description
                    end;
                }
                field(Description;Description)
                {
                }
                field("Date From";"Date From")
                {
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

