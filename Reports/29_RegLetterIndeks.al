report 50029 "SVA Regulation Indeks"
{
    DefaultLayout = Word;
    WordLayout = './layouts/SVA Regulation Indeks.docx';
    Caption = 'Regulation letters, indeks';


    dataset
    {
        dataitem("SVA Regulations"; "SVA Regulations")
        {
            column(Onumber; "SVA Regulations".Onumber)
            {
            }
            column(PropertyNo; "SVA Regulations".PropertyNo)
            {
            }
            column(OName1; "SVA Regulations".OName1)
            {
            }
            column(OName2; "SVA Regulations".OName2)
            {
            }
            column(OAddress; "SVA Regulations".OAddress)
            {
            }
            column(OAddress2; "SVA Regulations".OAddress2)
            {
            }
            column(OPostcode; "SVA Regulations".OPostcode)
            {
            }
            column(OCity; "SVA Regulations".OCity)
            {
            }
            column(OCountry; "SVA Regulations".OCountry)
            {
            }
            column(TenancyNo; "SVA Regulations".TenancyNo)
            {
            }
            column(TAddress1; "SVA Regulations".TAddress1)
            {
            }
            column(TAddress2; "SVA Regulations".TAddress2)
            {
            }
            column(TPostcode; "SVA Regulations".TPostcode)
            {
            }
            column(TCity; "SVA Regulations".TCity)
            {
            }
            column(Indeksdate; format("SVA Regulations".Indeksdate))
            {
            }
            column(Regulationdate; format("SVA Regulations".Regulationdate))
            {
            }
            column(OldIndeksDate; format("SVA Regulations".OldIndeksDate))
            {

            }
            column(IndeksOld; "SVA Regulations".Indeks_Old)
            {
            }
            column(IndeksNew; "SVA Regulations".Indeks_New)
            {
            }
            column(Increase; "SVA Regulations".Increase)
            {
            }
            column(Costtype; "SVA Regulations".Costtype)
            {
            }
            column(MaxRegulation; "SVA Regulations".MaxRegulation)
            {
            }
            column(MinRegulation; "SVA Regulations".MinRegulation)
            {
            }
            column(ActualRegulation; "SVA Regulations".ActualRegulation)
            {
            }
            column(RentYearNow; "SVA Regulations".RentYearNow)
            {
            }
            column(RentYearNew; "SVA Regulations".RentYearNew)
            {
            }
            column(RegulationYear; "SVA Regulations".RegulationYear)
            {
            }
            column(RentPerNow; "SVA Regulations".RentPerNow)
            {
            }
            column(RentPerNew; "SVA Regulations".RentPerNew)
            {
            }
            column(RegulationPer; "SVA Regulations".RegulationPer)
            {
            }
            column(DepositNow; "SVA Regulations".DepositNow)
            {
            }
            column(DepositNew; "SVA Regulations".DepositNew)
            {
            }
            column(RegulationDeposit; "SVA Regulations".RegulationDeposit)
            {
            }
            column(Closed; "SVA Regulations".Closed)
            {
            }
            column(PrepaidRentNow; "SVA Regulations".PrepaidRentNow)
            {
            }
            column(PrepaidRentNew; "SVA Regulations".PrepaidRentNew)
            {
            }
            column(RegulationPrepaidrent; "SVA Regulations".RegulationPrepaidrent)
            {
            }
        }
        dataitem("Company Information"; "Company Information")
        {
            column(CompanyAddress1; "Company Information".Name)
            {
            }
            column(CompanyAddress2; "Company Information".Address)
            {
            }
            column(CompanyAddress3; "Company Information"."Post Code" + ' ' + "Company Information".City)
            {
            }
            column(CompanyPhoneNo; "Company Information"."Phone No.")
            {
            }
            column(CompanyHomePage; "Company Information"."Home Page")
            {
            }
            column(CompanyVatRegNo; "Company Information"."VAT Registration No.")
            {
            }
            column(CompanyPicture; "Company Information".Picture)
            {
            }
            column(UserName; UserName)
            {
            }
            column(UserEmail; UserEmail)
            {

            }
            column(UserText; UserText)
            {

            }
            column(UserPhone; UserPhone)
            {

            }
            column(VatText; VatText)
            {

            }
            trigger OnAfterGetrecord()
            var
                User: record User;
            begin
                User.Reset();
                User.SetRange("User Security ID", UserSecurityId());
                if User.FindFirst() then begin
                    UserName := User."Full Name";
                    UserEmail := User."Contact Email";
                    UserText := 'Ejendomsadministrator';
                    UserPhone := '8722 4543';
                end;
                VatText := '';
                if "SVA Regulations"."Vat Charge" = true then
                    VatText := VatTextLbl;

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
    trigger OnPreReport();
    begin
        CompanyInformation.GET();
    end;

    var
        CompanyInformation: Record "Company Information";
        UserName: Text;
        UserEmail: Text;
        UserText: Text;
        UserPhone: Text;
        VatTextLbl: Label 'The above amount is subject to VAT';
        VatText: Text;

}

