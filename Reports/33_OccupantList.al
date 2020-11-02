report 50033 "SVA Occupant List"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Occupants List.rdlc';
    Caption = 'List of occupants';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("SVA Property"; "SVA Property")
        {
            dataitem(Tenancy; "SVA Tenancy")
            {
                DataItemLink = PropertyNo = field(Property);

                column(CompanyName; COMPANYPROPERTY.DISPLAYNAME())
                {
                }
                column(Number_Tenancy; Number)
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
                dataitem("SVA Occupant"; "SVA Occupant")
                {
                    DataItemLink = TenancyNo = FIELD(Number);
                    column(Name1; Name1)
                    {
                    }
                    column(Name2; Name2)
                    {

                    }

                    column(Address; Address)
                    {

                    }
                    column(Post_Code; "Post Code")
                    {

                    }
                    column(City; City)
                    {

                    }
                    column(Phone; Phone)
                    {

                    }
                    column(CellPhone1; CellPhone1)
                    {

                    }
                    column(CellPhone2; CellPhone2)
                    {

                    }
                    column(Email1; Email1)
                    {

                    }
                    column(Email2; Email2)
                    {

                    }
                    trigger OnAfterGetRecord();
                    begin
                        if (EndDate < Today) and (EndDate <> 0D) then
                            CurrReport.Skip();

                    end;
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
    trigger OnPreReport();
    begin
        CompanyInformation.GET();
    end;

    var
        CompanyInformation: Record "Company Information";
}

