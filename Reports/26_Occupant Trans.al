report 50026 "SVA Occupant Trans"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Occupant Trans.rdlc';
    Caption = 'Occupant Trans report';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("SVA Property"; "SVA Property")

        {
            //DataItemTableView = SORTING(Property);
            column(Property; Property)
            {

            }
            dataitem("SVA Tenancy"; "SVA Tenancy")
            {
                DataItemLink = PropertyNo = field(Property);
                DataItemTableView = SORTING(Number);
                column(Number; Number)
                {

                }

                dataitem(Occupant; "SVA Occupant")
                {
                    DataItemLink = TenancyNo = field(Number);
                    DataItemTableView = sorting(Number);
                    column(CompanyName; COMPANYPROPERTY.DISPLAYNAME)
                    {
                    }
                    column(OProperty; PropertyNo)
                    {
                    }
                    column(ONo; Number)
                    {
                    }
                    column(OTenancy; TenancyNo)
                    {
                    }
                    column(OCustomer; "Customer No")
                    {
                    }
                    column(OName; Name1)
                    {
                    }
                    column(OEndDate; EndDate)
                    {
                    }
                    column(OStartDate; StartDate)
                    {
                    }
                    dataitem("Occupant Trans"; "SVA Occupant Trans")
                    {
                        DataItemLink = Occupant = FIELD(Number);

                        column(OTransNo; Occupant)
                        {
                        }
                        column(Costtype; "Cost type Estate")
                        {
                        }
                        column(Date; Date)
                        {
                        }
                        column(Amount; Amount)
                        {
                        }
                    }
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

    labels
    {
    }
}

