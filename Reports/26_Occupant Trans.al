report 50026 "SVA Occupant Trans"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Occupant Trans.rdlc';
    Caption = 'Occupant Trans report';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {

        dataitem(Occupant; "SVA Occupant")
        {
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

