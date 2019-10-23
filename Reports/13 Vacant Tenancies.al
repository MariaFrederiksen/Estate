report 50013 "SVA Vacant Tenancies"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Vacant Tenancies.rdlc';
    Caption='Vacant tenancies';
    UsageCategory=ReportsAndAnalysis; 

    dataset
    {
        dataitem(Tenancy;"SVA Tenancy")
        {
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
            column(vacantDate_Tenancy;vacantDate)
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
                end;
            }

            trigger OnAfterGetRecord();
            begin

                IF vacantDate = 0D THEN
                  CurrReport.SKIP
            end;
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
}

