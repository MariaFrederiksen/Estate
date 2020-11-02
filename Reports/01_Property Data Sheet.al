report 50001 "SVA Property Data sheet"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Property Data sheet.rdlc';
    Caption = 'Property datasheet';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(Property; "SVA Property")
        {
            column(Headline; Headline)
            {

            }
            column(CompanyName; COMPANYPROPERTY.DISPLAYNAME())
            {
            }
            column(Number; Property)
            {
            }
            column(Name; Name)
            {
            }
            column(Address1; Address1)
            {
            }
            column(Address2; Address2)
            {
            }
            column(PostCode; "Post Code")
            {
            }
            column(City; City)
            {
            }
            column(Country; "Country/Region Code")
            {
            }
            column(RegNo; CompanyRegNo)
            {
            }
            column(CadastralNo; CadastralNo)
            {
            }
            column(OwnerName; Owner)
            {
            }
            column(OwnerAdress; OwnerAddress1)
            {
            }
            column(OwnerAddress2; OwnerAddress2)
            {
            }
            column(OwnerPostCode; OwnerPostCode)
            {
            }
            column(OwnerCity; OwnerCity)
            {
            }
            column(OwnerCountry; OwnerCountry)
            {
            }
            column(OwnerPhone; OwnerPhone)
            {
            }
            column(OwnerCell; OwnerCell)
            {
            }
            column(OwnerEmail; OwnerEmail)
            {
            }
            column(Bankname; Bankname)
            {
            }
            column(BankRegNo; BankRegNo)
            {
            }
            column(BankAccount; Bankaccount)
            {
            }
            column(CPGNumber; CGPNumber)
            {
            }
            column(Startdate; Startdate)
            {
            }
            column(ArchiveDate; ArchiveDate)
            {
            }
            column(FinYearFrom; FinancialYearFrom)
            {
            }
            column(FinYearTo; FinancialYearTo)
            {
            }
            column(HeatingFrom; HeatingYearFrom)
            {
            }
            column(HeatingTo; HeatingYearTo)
            {
            }
            column(WaterFrom; WaterYearFrom)
            {
            }
            column(WaterTo; WaterYearTo)
            {
            }
            column(ElFrom; ElectricYearFrom)
            {
            }
            column(ElTo; ElectricYearTo)
            {
            }
            column(ManFrom; ManYearFrom)
            {
            }
            column(ManTo; ManYearTo)
            {
            }
            column(FinCompany; FinCompany)
            {
            }
            column(FinNo; FinCompanyNo)
            {
            }
            column(FinEmail; FinEmail)
            {
            }
            column(FinLatest; FinLatest)
            {
            }
            column(HeatCompany; HeatCompany)
            {
            }
            column(HeatCompNo; HeatCompanyNo)
            {
            }
            column(HeatEmail; HeatEmail)
            {
            }
            column(HeatLatest; HeatLatest)
            {
            }
            column(WaterCompany; WaterCompany)
            {
            }
            column(WaterCompNo; WaterCompanyNo)
            {
            }
            column(WaterEmail; WaterEmail)
            {
            }
            column(WaterLatest; WaterLatest)
            {
            }
            column(ElCompany; ElCompany)
            {
            }
            column(ElCompanyNo; ELCompanyNo)
            {
            }
            column(ElEmail; ElEmail)
            {
            }
            column(ElLatest; ElLatest)
            {
            }
            column(ManLatest; ManLatest)
            {
            }

            trigger OnAfterGetRecord();
            begin
                Headline := HeadlineLbl;
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

    Var
        Headline: Text[50];
        HeadlineLbl: Label 'Property Data Sheet';

}

