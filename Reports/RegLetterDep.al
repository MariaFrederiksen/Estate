report 50028 "SVA Regulation Indeks Deposit"
{
    DefaultLayout = Word;
    WordLayout = './layouts/SVA Regulation IndeksDep.docx';
    Caption = 'Regulation letters';

    dataset
    {
        dataitem("SVA Regulations";"SVA Regulations")
        {
            column(Onumber;"SVA Regulations".Onumber)
            {
            }
            column(PropertyNo;"SVA Regulations".PropertyNo)
            {
            }
            column(OName1;"SVA Regulations".OName1)
            {
            }
            column(OName2;"SVA Regulations".OName2)
            {
            }
            column(OAddress;"SVA Regulations".OAddress)
            {
            }
            column(OAddress2;"SVA Regulations".OAddress2)
            {
            }
            column(OPostcode;"SVA Regulations".OPostcode)
            {
            }
            column(OCity;"SVA Regulations".OCity)
            {
            }
            column(OCountry;"SVA Regulations".OCountry)
            {
            }
            column(TenancyNo;"SVA Regulations".TenancyNo)
            {
            }
            column(TAddress1;"SVA Regulations".TAddress1)
            {
            }
            column(TAddress2;"SVA Regulations".TAddress2)
            {
            }
            column(TPostcode;"SVA Regulations".TPostcode)
            {
            }
            column(TCity;"SVA Regulations".TCity)
            {
            }
            column(Indeksdate;format("SVA Regulations".Indeksdate))
            {
            }
            column(Regulationdate;format("SVA Regulations".Regulationdate))
            {
            }
            column(IndeksOld;"SVA Regulations".Indeks_Old)
            {
            }
            column(IndeksNew;"SVA Regulations".Indeks_New)
            {
            }
            column(Increase;"SVA Regulations".Increase)
            {
            }
            column(Costtype;"SVA Regulations".Costtype)
            {
            }
            column(MaxRegulation;"SVA Regulations".MaxRegulation)
            {
            }
            column(MinRegulation;"SVA Regulations".MinRegulation)
            {
            }
            column(ActualRegulation;"SVA Regulations".ActualRegulation)
            {
            }
            column(RentYearNow;"SVA Regulations".RentYearNow)
            {
            }
            column(RentYearNew;"SVA Regulations".RentYearNew)
            {
            }
            column(RegulationYear;"SVA Regulations".RegulationYear)
            {
            }
            column(RentPerNow;"SVA Regulations".RentPerNow)
            {
            }
            column(RentPerNew;"SVA Regulations".RentPerNew)
            {
            }
            column(RegulationPer;"SVA Regulations".RegulationPer)
            {
            }
            column(DepositNow;"SVA Regulations".DepositNow)
            {
            }
            column(DepositNew;"SVA Regulations".DepositNew)
            {
            }
            column(RegulationDeposit;"SVA Regulations".RegulationDeposit)
            {
            }
            column(Closed;"SVA Regulations".Closed)
            {
            }
            column(PrepaidRentNow;"SVA Regulations".PrepaidRentNow)
            {
            }
            column(PrepaidRentNew;"SVA Regulations".PrepaidRentNew)
            {
            }
            column(RegulationPrepaidrent;"SVA Regulations".RegulationPrepaidrent)
            {
            }
        }
        dataitem("Company Information";"Company Information")
        {
            column(CName;"Company Information".Name)
            {
            }
            column(CAddress;"Company Information".Address)
            {
            }
            column(CPostCode;"Company Information"."Post Code")
            {
            }
            column(CCity;"Company Information".City)
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
        CompanyInfo.GET;
    end;

    var
        CompanyInfo: Record "Company Information";
}

