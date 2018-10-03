report 50310 "SVA Occupant Report (out)"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Occupant Report (out).rdlc';
    Caption='Occupant moveout report';

    dataset
    {
        dataitem(Occupant;"SVA Occupant")
        {
            column(OTenancy;TenancyNo)
            {
            }
            column(OCustomer;"Customer No")
            {
            }
            column(OName;Name1)
            {
            }
            column(OStartdate;StartDate)
            {
            }
            dataitem(Tenancy;"SVA Tenancy")
            {
                DataItemLink = PropertyNo=FIELD(PropertyNo),
                               Number=FIELD(TenancyNo);
                DataItemTableView = SORTING(PropertyNo,Number)
                                    ORDER(Ascending);
                column(TAddress1;Address1)
                {
                }
                column(TAddress2;Address2)
                {
                }
                column(TPostCode;"Post Code")
                {
                }
                column(TCity;City)
                {
                }
                column(CName;CompanyInfo.Name)
                {
                }
                column(CAddress;CompanyInfo.Address)
                {
                }
                column(CPostCode;CompanyInfo."Post Code")
                {
                }
                column(CCity;CompanyInfo.City)
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

    trigger OnInitReport();
    begin
        CompanyInfo.GET;
    end;

    var
        CompanyInfo : Record"Company Information";
}

