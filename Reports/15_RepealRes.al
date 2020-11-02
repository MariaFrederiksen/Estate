report 50015 "SVA Repeal Res"
{

    WordLayout = './Layouts/RepealRes.docx';
    DefaultLayout = Word;
    Caption = 'Repeal Residense';

    dataset
    {
        dataitem(Occupant; "SVA Occupant")
        {
            column(OTenancy; TenancyNo)
            {
            }
            column(OCustomer; "Customer No")
            {
            }
            column(OName; Name1)
            {
            }
            column(Oaddress; Address)
            {
            }
            column(OAddress2; Address2)
            {
            }
            column(OPost_code; "Post Code")
            {
            }
            column(OCity; City)
            {
            }
            column(OStartdate; StartDate)
            {
            }
            dataitem(Tenancy; "SVA Tenancy")
            {
                DataItemLink = PropertyNo = FIELD(PropertyNo),
                               Number = FIELD(TenancyNo);
                DataItemTableView = SORTING(PropertyNo, Number)
                                    ORDER(Ascending);
                column(TAddress1; Address1)
                {
                }
                column(TAddress2; Address2)
                {
                }
                column(TPostCode; "Post Code")
                {
                }
                column(TCity; City)
                {
                }
            }
        }
        dataitem("Company Information"; "Company Information")
        {
            column(CName; Name)
            {
            }
            column(CAddress; Address)
            {
            }
            column(CPostCode; "Post Code")
            {
            }
            column(CCity; City)
            {
            }
            column(CompanyVAT_Registration_No_; "VAT Registration No.")
            {
            }
            column(CompanyGetVATRegistrationNumberLbl; GetVATRegistrationNumberLbl())
            {
            }
            column(CompanyPhone_No_; "Phone No.")
            {
            }
            column(COmpanyPicture; Picture)
            {
            }
            column(CompanyBankBranchNo; CompanyInformation."Bank Branch No.")
            {
            }
            column(CompanyBanAccountNo; CompanyInformation."Bank Branch No.")
            {
            }
            column(CompanyBankName; CompanyInformation."Bank Name")
            {
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

    trigger OnPreReport();
    begin
        CompanyInformation.GET();
    end;

    var
    CompanyInformation: Record "Company Information";
}

