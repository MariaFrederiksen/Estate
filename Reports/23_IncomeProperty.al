report 50023 "SVA Income Property"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/IncomeProperty.rdlc';
    Caption='Income property';
    UsageCategory=ReportsAndAnalysis; 

    dataset
    {
        dataitem(Tenancy;"SVA Tenancy")
        {
            column(CompanyName;COMPANYPROPERTY.DISPLAYNAME)
            {
            }
            column(Number_Tenancy;Number)
            {
            }
            column(PropertyNo_Tenancy;PropertyNo)
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
            column(Type_Tenancy;Type)
            {
            }
            column(AreaLiv_Tenancy;AreaLiv)
            {
            }
            column(Rooms_Tenancy;Rooms)
            {
            }
            dataitem("SVA Subscription Lines";"SVA Subscription Lines")
            {
                DataItemLink = Tenancies = FIELD (Number);
                DataItemTableView = SORTING (Tenancies, Order, "Cost Types", "Date From", "Date To", KeyNumber)
                                    ORDER(Ascending)
                                    WHERE (Type = const (Rent));
                column(Amount_Period;"Amount Period")
                {
                }
                trigger OnAfterGetRecord();
                begin
                    if ("Date To" < Today) and ("Date To" <> 0D) then   
                        CurrReport.Skip;
                    if Type = 1 then
                        AmountRent := "Amount Year";    
                end;
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

    labels
    {
    }
    var
    AmountRent : Decimal;
}

