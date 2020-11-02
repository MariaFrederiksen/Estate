report 50004 "SVA Moving in Journal"
{
    DefaultLayout = RDLC;
    RDLCLayout = './layouts/Moving in collections.rdlc';
    Caption = 'Moving In Collection Journal';

    dataset
    {
        dataitem("SVA LeaseContract_A9"; "SVA LeaseContract_A9")
        {
            column(CompanyName; COMPANYPROPERTY.DISPLAYNAME())
            {
            }
            column(TypeA93RentPrperiod_LeaseContractA9; TypeA9_3_RentPerPeriode)
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
            column(Vatcode; Vatcode)
            {
            }

            dataitem("SVA Occupant"; "SVA Occupant")
            {
                DataItemLink = number = field(Number);
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
                column(CAddress; Address)
                {
                }
                column(CPostcode; "Post code")
                {
                }
                column(CCIty; City)
                {
                }

                dataitem("SVA Tenancy"; "SVA Tenancy")
                {
                    DataItemLink = Number = field(TenancyNo);
                    DataItemLinkReference = "Sva Occupant";

                    column(TAddress; Address1)
                    {
                    }
                    column(TPostCode; "SVA Tenancy"."Post Code")
                    {
                    }
                    column(TCity; "SVA Tenancy".City)
                    {
                    }
                }
            }
            trigger OnAfterGetRecord();
            begin
                if DATE2DMY(TypeA9_2_Startdate, 1) = 1 then
                    factor := 1;
                if (DATE2DMY(TypeA9_2_Startdate, 1) > 1) AND (DATE2DMY(TypeA9_2_Startdate, 1) < 32) then begin
                    SVAParameters.Reset();
                    if SVAParameters.FindFirst() then begin
                        if SVAParameters.Splitcalc = false then
                            Factor := 0.5; //Split in half
                        if SVAParameters.Splitcalc = true then begin
                            Days := CalcDate('<1M-1D>', TypeA9_2_Startdate) - TypeA9_2_Startdate + 1;//qty of days in monht TypeA9_3_Startdate
                            Factor := ((Days - Date2DMY(TypeA9_2_Startdate, 1) + 1) / Days);
                        end;
                    end;
                end;

                "SVA LeaseContract_A9".TypeA9_3_RentPerPeriode := "SVA LeaseContract_A9".TypeA9_3_RentPerPeriode * Factor;
                "SVA LeaseContract_A9".TypeA9_3_ACHeat := "SVA LeaseContract_A9".TypeA9_3_ACHeat * Factor;
                "SVA LeaseContract_A9".TypeA9_3_ACWater := "SVA LeaseContract_A9".TypeA9_3_ACWater * Factor;
                "SVA LeaseContract_A9".TypeA9_3_ACElectricity := "SVA LeaseContract_A9".TypeA9_3_ACElectricity * Factor;
                "SVA LeaseContract_A9".TypeA9_3_ACCooling := "SVA LeaseContract_A9".TypeA9_3_ACCooling * Factor;
                "SVA LeaseContract_A9".TypeA9_3_Antenna := "SVA LeaseContract_A9".TypeA9_3_Antenna * Factor;
                "SVA LeaseContract_A9".TypeA9_3_Internet := "SVA LeaseContract_A9".TypeA9_3_Internet * Factor;
                "SVA LeaseContract_A9".TypeA9_3_TenantGroup := "SVA LeaseContract_A9".TypeA9_3_TenantGroup * Factor;
                "SVA LeaseContract_A9".TypeA9_3_OtherAmount1 := "SVA LeaseContract_A9".TypeA9_3_OtherAmount1 * Factor;
                "SVA LeaseContract_A9".TypeA9_3_OtherAmount2 := "SVA LeaseContract_A9".TypeA9_3_OtherAmount2 * Factor;


                SVALeaseContractA9.Reset();
                SVALeaseContractA9.SetRange(Number, "SVA LeaseContract_A9".Number);
                if SVALeaseContractA9.FindFirst() then begin
                    SVAOccupant.Reset();
                    SVAOccupant.SETRANGE(SVAOccupant.Number, SVALeaseContractA9.Number);
                    if SVAOccupant.FindFirst() then begin
                        Customer.Reset();
                        Customer.SetRange("No.", SVAOccupant."Customer No");
                        if Customer.FindFirst() then begin
                            VATPostingSetup.Reset();
                            VATPostingSetup.SetRange("Vat Prod. Posting Group", Vatcode);
                            VATPostingSetup.SetRange("VAT Bus. Posting Group", Customer."VAT Bus. Posting Group");
                            IF VATPostingSetup.FindFirst() then
                                Vatrate := 1 + (VATPostingSetup."VAT %" / 100);
                            IF Vatrate = 0 then
                                Vatrate := 1;
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
        SVALeaseContractA9: Record "SVA LeaseContract_A9";
        Customer: Record Customer;
        VATPostingSetup: Record "VAT Posting Setup";
        SVAOccupant: Record "SVA Occupant";
        SVAParameters: Record "SVA Parameters";
        Vatrate: Decimal;
        Days: Integer;
        Factor: Decimal;

}

