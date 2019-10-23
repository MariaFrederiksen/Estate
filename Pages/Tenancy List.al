page 50024 "SVA Tenancy List"
//Tooltip created.
{
    Caption = 'List of Tenancies';
    CardPageID = "SVA Tenancy Card";
    Editable = false;
    PageType = List;
    SourceTable = "SVA Tenancy";
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(PropertyNo; PropertyNo)
                {                    
                    ApplicationArea = All;
                    ToolTip = 'Attached to property number';
                }
                field(Number; Number)
                {                    
                    ApplicationArea = All;
                    ToolTip = 'Tenancy number';
                }
                field(Address1; Address1)
                {                    
                    ApplicationArea = All;
                    ToolTip = 'Tenancy address';
                }
                field(Address2; Address2)
                {                    
                    ApplicationArea = All;
                    ToolTip = 'Tenancy address 2';

                }
                field(City; City)
                {                    
                    ApplicationArea = All;
                    ToolTip = 'Tenancy city';
                }
                field(Type; Type)
                {                    
                    ApplicationArea = All;
                    ToolTip = 'Tenancy type (Living,Commercial Leases,Partial,Owner,House,Other). ';
                }
                field(PeriodYear; PeriodYear)
                {                    
                    ApplicationArea = All;
                    ToolTip = 'Periods for invoiced collection';
                }
                field(AreaTotal; AreaTotal)
                {                    
                    ApplicationArea = All;
                    ToolTip = 'Total area of tenancy';
                }
                field(Rooms; Rooms)
                {                    
                    ApplicationArea = All;
                    ToolTip = 'Quantity of rooms';
                }
                field(Vacant; Vacant)
                {                    
                    ApplicationArea = All;
                    ToolTip = 'Is the tenancy vacant';
                }
                field(vacantDate; vacantDate)
                {                    
                    ApplicationArea = All;
                    ToolTip = 'When is the tenancy vacant from.';
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
            action(Occupants)
            {
                ApplicationArea = All;
                Caption = 'Occupants';
                ToolTip = 'List of occupants in this tenancy.';
                Image = Customer;
                RunObject = Page "SVA Occupant List";
                RunPageLink = TenancyNo = FIELD (Number);
            }
        }
    }
}

