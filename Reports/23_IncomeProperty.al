report 50023 "SVA Income Property"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/IncomeProperty.rdlc';
    Caption = 'Income property';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Tenancy; "SVA Tenancy")
        {
            column(CompanyName; COMPANYPROPERTY.DISPLAYNAME())
            {
            }
            column(Number_Tenancy; Number)
            {
            }
            column(PropertyNo_Tenancy; PropertyNo)
            {
            }
            column(OccupantName; OccupantName)
            {

            }
            column(Address1_Tenancy; Address1)
            {
            }
            column(PostCode_Tenancy; "Post Code")
            {
            }
            column(City_Tenancy; City)
            {
            }
            column(Type_Tenancy; Type)
            {
            }
            column(AreaLiv_Tenancy; AreaLiv)
            {
            }
            column(Rooms_Tenancy; Rooms)
            {
            }

            dataitem("SVA Subscription Lines"; "SVA Subscription Lines")
            {
                DataItemLink = Tenancies = FIELD(Number);
                DataItemTableView = SORTING(Tenancies, Order, "Cost Types")
                                    ORDER(Ascending)
                                    WHERE(Type = const(Rent));
                column(Amount_Period; "Amount Period")
                {
                }
                trigger OnAfterGetRecord();
                begin
                    if ("Date To" < Today) and ("Date To" <> 0D) then
                        CurrReport.Skip();

                end;
            }
            trigger OnAfterGetRecord()
            var
                SVAOccupant: Record "SVA Occupant";
            begin
                SVAOccupant.Reset();
                SVAOccupant.SetRange(TenancyNo, Number);
                if SVAOccupant.FindLast() then
                    OccupantName := SVAOccupant.Name1;
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
    var
        OccupantName: Text[50];
}

