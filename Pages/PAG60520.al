page 60520 "SVA Tenancy List"
{
    Caption = 'Tenancies';
    CardPageID = "SVA Tenancy Card";
    Editable = false;
    PageType = List;
    SourceTable = "SVA Tenancy";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(PropertyNo;PropertyNo)
                {
                }
                field(Number;Number)
                {
                }
                field(Address1;Address1)
                {
                }
                field(Address2;Address2)
                {
                    Caption = 'Adresse 2';
                }
                field(City;City)
                {
                }
                field(Type;Type)
                {
                    Caption = 'Type';
                }
                field(PeriodYear;PeriodYear)
                {
                    OptionCaption='Mth,Qtr,Half year,Year';
                }
                field(AreaTotal;AreaTotal)
                {
                }
                field(Rooms;Rooms)
                {
                }
                field(Vacant;Vacant)
                {
                }
                field(vacantDate;vacantDate)
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Notes;Notes)
            {
            }
            systempart(LinksSVAS;Links)
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
                Caption='Navigation';
                action(Occupants)
                {
                    Caption = 'Occupants';
                    Image = Customer;
                    RunObject = Page "SVA Occupant List";
                    RunPageLink = TenancyNo=FIELD(Number);
                }
            }
        }
    }
}

