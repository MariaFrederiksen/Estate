page 60530 "SVA Occupant List"
{
    Caption='Occupants';
    CardPageID = "Occupant Card";
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
                }
                field(TenancyNo;TenancyNo)
                {
                }
                field(Name1;Name1)
                {
                }
                field(Name2;Name2)
                {
                }
                field(Address;Address)
                {
                }
                field(City;City)
                {
                }
                field(Phone;Phone)
                {
                }
                field(Email1;Email1)
                {
                    ExtendedDatatype = EMail;
                }
                field(StartDate;StartDate)
                {
                }
                field(EndDate;EndDate)
                {
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

