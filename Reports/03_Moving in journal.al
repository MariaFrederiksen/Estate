report 50210 "SVA Moving in Journal"
{
    DefaultLayout = RDLC;
    RDLCLayout = './layouts/Moving in collections.rdlc';
    Caption='Moving In Collection Journal';

    dataset
    {
        dataitem(DataItem1000000000;"SVA Occupant")
        {
            column(Number_Occupant;Number)
            {
            }
            column(TenancyNo_Occupant;TenancyNo)
            {
            }
            column(CustomerNo_Occupant;"Customer No")
            {
            }
            column(Name1_Occupant;Name1)
            {
            }
            column(Name2_Occupant;Name2)
            {
            }
            column(StartDate_Occupant;StartDate)
            {
            }
            column(CAddress;CAddress)
            {
            }
            column(CPostcode;CPostCode)
            {
            }
            column(CCIty;CCity)
            {
            }
            column(TAddress;TAddress)
            {
            }
            column(TPostCode;TPostCode)
            {
            }
            column(TCity;TCity)
            {
            }
            dataitem(DataItem1000000004;"SVA LeaseContract_A9")
            {
                column(TypeA93ACHeat_LeaseContractA9;TypeA9_3_ACHeat)
                {
                }
                column(TypeA93ACWater_LeaseContractA9;TypeA9_3_ACWater)
                {
                }
                column(TypeA93ACElectricity_LeaseContractA9;TypeA9_3_ACElectricity)
                {
                }
                column(TypeA93ACCooling_LeaseContractA9;TypeA9_3_ACCooling)
                {
                }
                column(TypeA93Antenna_LeaseContractA9;TypeA9_3_Antenna)
                {
                }
                column(TypeA93Internet_LeaseContractA9;TypeA9_3_Internet)
                {
                }
                column(TypeA93TenantGroup_LeaseContractA9;TypeA9_3_TenantGroup)
                {
                }
                column(TypeA93OtherText1_LeaseContractA9;TypeA9_3_OtherText1)
                {
                }
                column(TypeA93OtherAmount1_LeaseContractA9;TypeA9_3_OtherAmount1)
                {
                }
                column(TypeA93OtherText2_LeaseContractA9;TypeA9_3_OtherText2)
                {
                }
                column(TypeA93OtherAmount2_LeaseContractA9;TypeA9_3_OtherAmount2)
                {
                }
                column(TypeA92Startdate_LeaseContractA9;TypeA9_2_Startdate)
                {
                }
                column(TypeA94DepAmount_LeaseContractA9;TypeA9_4_DepAmount)
                {
                }
                column(TypeA94DepMth_LeaseContractA9;TypeA9_4_DepMth)
                {
                }
                column(TypeA94PrepaidRentMth_LeaseContractA9;TypeA9_4_PrepaidRentMth)
                {
                }
                column(TypeA94DueDate_LeaseContractA9;TypeA9_4_DueDate)
                {
                }
                column(TypeA94DueAmount_LeaseContractA9;TypeA9_4_DueAmount)
                {
                }
                column(TypeA94PrepaidRent_LeaseContractA9;TypeA9_4_PrepaidRent)
                {
                }
                column(TypeA94RentFrom_LeaseContractA9;TypeA9_4_RentFrom)
                {
                }
                column(TypeA94RentTo_LeaseContractA9;TypeA9_4_RentTo)
                {
                }
                column(TypeA94Text1_LeaseContractA9;TypeA9_4_Text1)
                {
                }
                column(TypeA94Amount1_LeaseContractA9;TypeA9_4_Amount1)
                {
                }
                column(TypeA94Text2_LeaseContractA9;TypeA9_4_Text2)
                {
                }
                column(TypeA94Amount2_LeaseContractA9;TypeA9_4_Amount2)
                {
                }
                column(TypeA94Text3_LeaseContractA9;TypeA9_4_Text3)
                {
                }
                column(TypeA94Amount3_LeaseContractA9;TypeA9_4_Amount3)
                {
                }
                column(TypeA94TotalAmount_LeaseContractA9;TypeA9_4_TotalAmount)
                {
                }
            }

            trigger OnAfterGetRecord();
            begin
                Customer.RESET;
                Customer.SETRANGE("No.","Customer No");
                IF Customer.FINDFIRST() THEN  BEGIN
                  CAddress := Customer.Address;
                  CPostCode := Customer."Post Code";
                  CCity := Customer.City
                  END;

                Tenancy.RESET;
                Tenancy.SETRANGE(Number,TenancyNo);
                IF Tenancy.FINDFIRST() THEN BEGIN
                  TAddress := Tenancy.Address1;
                  TPostCode := Tenancy."Post Code";
                  TCity := Tenancy.City;
                  END;
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

    var
        CostTypeType : Record "SVA Cost type";
        Customer : Record "Customer";
        Tenancy : Record "SVA Tenancy";
        CAddress : Text[30];
        CPostCode : Text[10];
        CCity : Text[30];
        TAddress : Text[30];
        TPostCode : Text[10];
        TCity : Text[30];
}

