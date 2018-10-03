report 50510 "SVA Contract Garage"
{
    // Garagekontrakten er baseret på samme kartotek som lejekontrakt TypeA 9. udgave. Der kan kun være en lejekontrakt pr. beboeraftale.
    RDLCLayout = './Layouts/Contract Garage.rdlc';
    WordLayout = './Layouts/Contract Garage.docx';

    Caption='Leasecontract for garage';
    DefaultLayout = Word;

    dataset
    {
        dataitem("Garage";"SVA LeaseContract_A9")
        {
            column(Number;Number)
            {
            }
            column(TAddress;TypeA9_1_Address)
            {
            }
            column(TCity;TypeA9_1_City)
            {
            }
            column(Landlord;TypeA9_1_Landlord)
            {
            }
            column(LandlordCVR;TypeA9_1_LandlordCVR)
            {
            }
            column(LandlordAddress;TypeA9_1_LandlordAddress)
            {
            }
            column(OName;TypeA9_1_TenentName)
            {
            }
            column(OAddress;TypeA9_1_TenentAddress)
            {
            }
            column(Ocpr;TypeA9_1_TenantCPR)
            {
            }
            column("Area";TypeA9_1_AreaTotal)
            {
            }
            column(GarageNo;TypeA9_1_GarageNo)
            {
            }
            column(StartDate;TextT9_2_Date)
            {
            }
            column(RentPrYr;TypeA9_3_RentPerYear)
            {
            }
            column(RentPPeriod;TypeA9_3_RentPerPeriode)
            {
            }
            column(TotalPerPeriod;TypeA9_3_TotalperPeriod)
            {
            }
            column(BankRegNo;TypeA9_3_BankRegNo)
            {
            }
            column(BankAccount;TypeA9_3_BankAccount)
            {
            }
            column(Bankname;TypeA9_3_Bankname)
            {
            }
            column(DepAmount;TypeA9_4_DepAmount)
            {
            }
            column(DepMth;TypeA9_4_DepMth)
            {
            }
            column(DueDate;TypeA9_4_DueDate)
            {
            }
            column(PrepaidRent;TypeA9_4_PrepaidRent)
            {
            }
            column(Rent;TypeA9_4_Rentetc)
            {
            }
            column(RentFrom;TextT9_4_RentFrom)
            {
            }
            column(RentTo;TextT9_4_RentTo)
            {
            }
            column(Deposit;TypeA9_4_Depositum)
            {
            }
            column(TotalAmount;TypeA9_4_TotalAmount)
            {
            }
            column(RentFirstTime;TextT9_4_RentFirstTime)
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

    var
        TemplateName : Text[150];
        Txt001 : Label '" "';
        Txt002 : Label 'X';
}

