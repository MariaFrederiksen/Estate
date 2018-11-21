page 60530 "SVA Occupant List"
//Tooltips created
{
    Caption='Occupants';
    CardPageID = "SVA Occupant Card";
    PageType = List;
    SourceTable = "SVA Occupant";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Number;Number)
                {
                    Tooltip='Agreement number';
                }
                field(TenancyNo;TenancyNo)
                {
                    Tooltip='Tenancy number';
                }
                field(Name1;Name1)
                {
                    Tooltip='Tenant name';
                }
                field(Name2;Name2)
                {
                    Tooltip='Second tenant name';
                }
                field(Address;Address)
                {
                    Tooltip='Invoice address';
                }
                field(City;City)
                {
                    Tooltip='Invoice city';
                }
                field(Phone;Phone)
                {
                    Tooltip='Tenants primary phone number';
                }
                field(Email1;Email1)
                {
                    Tooltip='Tenants primary email';
                    ExtendedDatatype = EMail;
                }
                field(StartDate;StartDate)
                {
                    ToolTip='Contract startdate';
                }
                field(EndDate;EndDate)
                {
                    ToolTip='Contract end date.';
                }
            }
        }
        area(factboxes)
        {
            systempart(Notat;Notes)
            {
            }
            systempart(Links;Links)
            {
            }
        }
    }

    actions
    {
    }
}

