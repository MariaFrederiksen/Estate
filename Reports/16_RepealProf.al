report 50640 "SVA Repeal Prof"
{
    WordLayout = './Layouts/RepealProf.docx';
    DefaultLayout = Word;
    Caption='Repeal professional';

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
                column(CName;Name)
                {
                }
                column(CAddress;Address1)
                {
                }
                column(CPostCode;"Post Code")
                {
                }
                column(CCity;City)
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
        CompanyInfo : Record "Company Information";
}

