report 50024 "SVA MoveInOutList"
{
    WordLayout = './layouts/MoveInOutList.docx';
    DefaultLayout = Word;
    Caption = 'Ind- og fraflytninger';

    dataset
    {
        dataitem(Occupant;"SVA Occupant")
        {
            column(CompanyName;COMPANYPROPERTY.DISPLAYNAME)
            {
            }
            column(PropertyNo_Occupant;PropertyNo)
            {
            }
            column(TenancyNo_Occupant;TenancyNo)
            {
            }
            column(Name1_Occupant;Name1)
            {
            }
            column(Name2_Occupant;Name2)
            {
            }
            column(CellPhone1_Occupant;CellPhone1)
            {
            }
            column(CellPhone2_Occupant;CellPhone2)
            {
            }
            column(StartDate_Occupant;StartDate)
            {
            }
            column(EndDate_Occupant;EndDate)
            {
            }
            dataitem(Tenancy;"SVA Tenancy")
            {
                DataItemLink = Number=FIELD(TenancyNo);
                column(Number_Tenancy;Number)
                {
                }
                column(Address1_Tenancy;Address1)
                {
                }
                column(PostCode_Tenancy;"Post Code")
                {
                }
                column(City_Tenancy;City)
                {
                }
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
            }
                
            
        }

    }

