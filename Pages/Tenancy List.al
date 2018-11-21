page 60520 "SVA Tenancy List"
//Tooltip created.
{
    Caption = 'Tenancies';
    CardPageID = "SVA Tenancy Card";
    Editable = false;
    PageType = List;
    SourceTable = "SVA Tenancy";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(PropertyNo; PropertyNo)
                {
                    ToolTip='Attached to property number';
                }
                field(Number; Number)
                {
                    ToolTip='Tenancy number';
                }
                field(Address1; Address1)
                {
                    ToolTip='Tenancy address';
                }
                field(Address2; Address2)
                {
                    ToolTip='Tenancy address 2';

                }
                field(City; City)
                {
                    ToolTip='Tenancy city';
                }
                field(Type; Type)
                {
                    ToolTip='Tenancy type (Living,Commercial Leases,Partial,Owner,House,Other). ';
                }
                field(PeriodYear; PeriodYear)
                {
                    ToolTip='Periods for invoiced collection';
                }
                field(AreaTotal; AreaTotal)
                {
                    ToolTip='Total area of tenancy';
                }
                field(Rooms; Rooms)
                {
                    ToolTip='Quantity of rooms';
                }
                field(Vacant; Vacant)
                {
                    ToolTip='Is the tenancy vacant';
                }
                field(vacantDate; vacantDate)
                {
                    ToolTip='When is the tenancy vacant from.';
                }
            }
        }
        area(factboxes)
        {
            systempart(Notes; Notes)
            {
            }
            systempart(LinksSVAS; Links)
            {
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Naviger)
            {
                Caption = 'Navigation';
                action(Occupants)
                {
                    Caption = 'Occupants';
                    ToolTip='List of occupants in this tenancy.';
                    Image = Customer;
                    RunObject = Page "SVA Occupant List";
                    RunPageLink = TenancyNo = FIELD (Number);
                }
            }
        }
    }
}

