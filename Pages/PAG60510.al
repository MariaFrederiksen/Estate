page 60510 "SVA Property List"
{
    Caption='Properties';
    CardPageID = "Property Card";
    PageType = List;
    SourceTable = "SVA Property";
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Property;Property)
                {
                }
                field(Name;Name)
                {
                }
                field(Address1;Address1)
                {
                }
                field("Post Code";"Post Code")
                {
                }
                field(City;City)
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(NOTES;Notes)
            {
            }
            systempart(links;Links)
            {
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Oversigter)
            {
                Caption='Overview';
                action(Tenancies)
                {
                    Caption='Tenancies';
                    Image = StepInto;
                    RunObject = Page "SVA Tenancy List";
                    RunPageLink = PropertyNo=FIELD(Property);
                    
                }
                action(Residens)
                {
                    Caption='Occupants';
                    Image = customer;
                    RunObject = Page "SVA Occupant List";
                    RunPageLink = PropertyNo=FIELD(Property);
                    
                }
            }
        }
        area(reporting)
        {
            group(Rapporter)
            {
                Caption='Reports';
                action("Vacant tenancies")
                {
                    Caption='Vacant tenancies';
                    Image = Report2;
                    RunObject = Report 50610;
                }
                action("Basic data report")
                {
                    Caption='Data sheet report';
                    Image = "report";
                    RunObject = Report 50100;
                }
            }
        }
        area(processing)
        {
            group(Periodisk)
            {
                Caption='Periodic';
                action(Journal)
                {
                    Caption='Collection journal';
                    Image = Report2;
                    RunObject = Report "SVA Collection Journal";
                }
                action(Invoicing)
                {
                    Caption='Subscription invoicing';
                    Image = Invoice;
                    RunObject = Codeunit 60500;
                }
                action(Nets)
                {
                    Caption='File for NETS type 0601';
                    Image = SalesInvoice;
                    RunObject = Page 60630;
                }
            }
        }
    }
}

