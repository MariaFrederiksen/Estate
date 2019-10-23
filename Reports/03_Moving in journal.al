report 50004 "SVA Moving in Journal"
{
    DefaultLayout = RDLC;
    RDLCLayout = './layouts/Moving in collections.rdlc';
    Caption = 'Moving In Collection Journal';

    dataset
    {
        dataitem("SVA LeaseContract_A9"; "SVA LeaseContract_A9")
        {
            column(TypeA93RentPrperiod_LeaseContractA9;TypeA9_3_RentPerPeriode)
            {
            }
            column(TypeA93ACHeat_LeaseContractA9; TypeA9_3_ACHeat)
            {
            }
            column(TypeA93ACWater_LeaseContractA9; TypeA9_3_ACWater)
            {
            }
            column(TypeA93ACElectricity_LeaseContractA9; TypeA9_3_ACElectricity)
            {
            }
            column(TypeA93ACCooling_LeaseContractA9; TypeA9_3_ACCooling)
            {
            }
            column(TypeA93Antenna_LeaseContractA9; TypeA9_3_Antenna)
            {
            }
            column(TypeA93Internet_LeaseContractA9; TypeA9_3_Internet)
            {
            }
            column(TypeA93TenantGroup_LeaseContractA9; TypeA9_3_TenantGroup)
            {
            }
            column(TypeA93OtherText1_LeaseContractA9; TypeA9_3_OtherText1)
            {
            }
            column(TypeA93OtherAmount1_LeaseContractA9; TypeA9_3_OtherAmount1)
            {
            }
            column(TypeA93OtherText2_LeaseContractA9; TypeA9_3_OtherText2)
            {
            }
            column(TypeA93OtherAmount2_LeaseContractA9; TypeA9_3_OtherAmount2)
            {
            }
            column(TypeA92Startdate_LeaseContractA9; TypeA9_2_Startdate)
            {
            }
            column(TypeA94DepAmount_LeaseContractA9; TypeA9_4_DepAmount)
            {
            }
            column(TypeA94DepMth_LeaseContractA9; TypeA9_4_DepMth)
            {
            }
            column(TypeA94PrepaidRentMth_LeaseContractA9; TypeA9_4_PrepaidRentMth)
            {
            }
            column(TypeA94DueDate_LeaseContractA9; TypeA9_4_DueDate)
            {
            }
            column(TypeA94DueAmount_LeaseContractA9; TypeA9_4_DueAmount)
            {
            }
            column(TypeA94PrepaidRent_LeaseContractA9; TypeA9_4_PrepaidRent)
            {
            }
            column(TypeA94RentFrom_LeaseContractA9; TypeA9_4_RentFrom)
            {
            }
            column(TypeA94RentTo_LeaseContractA9; TypeA9_4_RentTo)
            {
            }
            column(TypeA94Text1_LeaseContractA9; TypeA9_4_Text1)
            {
            }
            column(TypeA94Amount1_LeaseContractA9; TypeA9_4_Amount1)
            {
            }
            column(TypeA94Text2_LeaseContractA9; TypeA9_4_Text2)
            {
            }
            column(TypeA94Amount2_LeaseContractA9; TypeA9_4_Amount2)
            {
            }
            column(TypeA94Text3_LeaseContractA9; TypeA9_4_Text3)
            {
            }
            column(TypeA94Amount3_LeaseContractA9; TypeA9_4_Amount3)
            {
            }
            column(TypeA94TotalAmount_LeaseContractA9; TypeA9_4_TotalAmount)
            {
            }
            column(Vatcode;Vatcode)
            {
            }
                       
            dataitem("SVA Occupant"; "SVA Occupant")
            {
                DataItemLink = number = field (Number);
                DataItemLinkReference = "SVA LeaseContract_A9";

                column(Number_Occupant; Number)
                {
                }
                column(TenancyNo_Occupant; TenancyNo)
                {
                }
                column(CustomerNo_Occupant; "Customer No")
                {
                }
                column(Name1_Occupant; Name1)
                {
                }
                column(Name2_Occupant; Name2)
                {
                }
                column(StartDate_Occupant; StartDate)
                {
                }
                column(CAddress;Address)
                {
                }
                column(CPostcode;"Post code")
                {
                }
                column(CCIty;City)
                {
                }
                
                dataitem("SVA Tenancy";"SVA Tenancy")
                {
                    DataItemLink = Number = field (TenancyNo);
                    DataItemLinkReference = "Sva Occupant";
                                                               
                    column(TAddress;Address1)
                    {
                    }
                    column(TPostCode;"SVA Tenancy"."Post Code")
                    {
                    }
                    column(TCity;"SVA Tenancy".City)
                    {
                    }
                }
            }
            trigger OnAfterGetRecord();
            begin
                if (DATE2DMY("SVA LeaseContract_A9".TypeA9_2_Startdate,1) > 13) AND (DATE2DMY("SVA LeaseContract_A9".TypeA9_2_Startdate,1) < 17)  then begin
                "SVA LeaseContract_A9".TypeA9_3_RentPerPeriode := "SVA LeaseContract_A9".TypeA9_3_RentPerPeriode/2;
                "SVA LeaseContract_A9".TypeA9_3_ACHeat := "SVA LeaseContract_A9".TypeA9_3_ACHeat/2;
                "SVA LeaseContract_A9".TypeA9_3_ACWater := "SVA LeaseContract_A9".TypeA9_3_ACWater/2;
                "SVA LeaseContract_A9".TypeA9_3_ACElectricity := "SVA LeaseContract_A9".TypeA9_3_ACElectricity/2;
                "SVA LeaseContract_A9".TypeA9_3_ACCooling := "SVA LeaseContract_A9".TypeA9_3_ACCooling/2;
                "SVA LeaseContract_A9".TypeA9_3_Antenna := "SVA LeaseContract_A9".TypeA9_3_Antenna/2;
                "SVA LeaseContract_A9".TypeA9_3_Internet := "SVA LeaseContract_A9".TypeA9_3_Internet/2;
                "SVA LeaseContract_A9".TypeA9_3_TenantGroup := "SVA LeaseContract_A9".TypeA9_3_TenantGroup/2;
                "SVA LeaseContract_A9".TypeA9_3_OtherAmount1 := "SVA LeaseContract_A9".TypeA9_3_OtherAmount1/2;
                "SVA LeaseContract_A9".TypeA9_3_OtherAmount2 := "SVA LeaseContract_A9".TypeA9_3_OtherAmount2/2;
                end;

                TypeA9.Reset;
                TypeA9.SetRange(Number,"SVA LeaseContract_A9".Number);
                if TypeA9.FindFirst then begin
                    Occupant.RESET;
                    Occupant.SETRANGE(Occupant.Number,TypeA9.Number);
                    if Occupant.FindFirst() then begin
                        Customer.Reset;
                        Customer.SetRange("No.", Occupant."Customer No");
                        if Customer.FindFirst then begin
                            Vatpostinggroup.Reset;
                            Vatpostinggroup.SetRange("Vat Prod. Posting Group", Vatcode);
                            Vatpostinggroup.SetRange("VAT Bus. Posting Group", Customer."VAT Bus. Posting Group");
                            IF Vatpostinggroup.FindFirst() then
                                Vatrate := 1 + (Vatpostinggroup."VAT %" / 100);
                            IF Vatrate = 0 then
                                Vatrate := 1;
                            AmountInclVat := "SVA LeaseContract_A9".TypeA9_4_TotalAmount;
                        end;
                    end;
                end;        
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
    TypeA9 : Record "SVA LeaseContract_A9";
    Customer : Record Customer;
    Vatpostinggroup : Record "VAT Posting Setup";
    Occupant : Record "SVA Occupant";
    Vatrate : Decimal;
    AmountInclVat : Decimal;

}

