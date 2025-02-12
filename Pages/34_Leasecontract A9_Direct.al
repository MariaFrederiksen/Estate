page 50034 "SVA Leasecontract_A9 Direct"
//Tooltip created
{
    //Page er lavet, så man direkte uden om de øvrige tabeller, kan oprette en lejekontrakt.
    //Debitor oprettes herfra, det samme gælder beboeraftalen.
    // Tooltip created
    // Costtype er en option med 14 udfald
    //  0 : Andet (default)
    //  1 : Leje/husleje
    //  2 : AC varme
    //  3 : AC vand
    //  4 : AC el
    //  5 : AC køling
    //  6 : AC drift
    //  7 : Antenne
    //  8 : Internet
    //  9 : Beboerrep
    // 10 : Depositum
    // 11 : Forudbetalt leje
    // 12 : Afregning (årsafregnig af a conto beløb)
    // 13 : Flytteomkostninger

    Caption = 'Leasecontract A9';
    PageType = Card;
    SourceTable = "SVA LeaseContract_A9";

    layout
    {
        area(content)
        {
            Group(Customer)
            {
                Caption = 'Customer information';
                
                
                            }
            group("Paragraf 1")
            {
                Caption = 'Paragraph 1';
                field(Number; Rec.Number)
                {
                    ApplicationArea = all;
                    Tooltip = 'Nummer på beboeraftalen';
                }
                field(TypeA9_1_Apartment; Rec.TypeA9_1_Apartment)
                {
                    ApplicationArea = all;
                    Tooltip = 'Is the tenancy an apartment?';
                }
                field(TypeA9_1_Room; Rec.TypeA9_1_Room)
                {
                    ApplicationArea = all;
                    Tooltip = 'Is the tenancy a room?';
                }
                field(TypeA9_1_Condominium; Rec.TypeA9_1_Condominium)
                {
                    ApplicationArea = all;
                    Tooltip = 'Is the tenancy a Condominium?';
                }
                field(TypeA9_1_HousingCoop; Rec.TypeA9_1_HousingCoop)
                {
                    ApplicationArea = all;
                    Tooltip = 'Is the tenancy a housinggroup?';
                }
                field(TypeA9_1_OtherT; Rec.TypeA9_1_OtherT)
                {
                    ApplicationArea = all;
                    Tooltip = 'Is the tenancy none of the above?';
                }
                field(TypeA9_1_OtherTTxt; Rec.TypeA9_1_OtherTTxt)
                {
                    ApplicationArea = all;
                    Tooltip = 'What is the tenancy if not one of the above?';
                }
                field(TypeA9_1_Sublease; Rec.TypeA9_1_Sublease)
                {
                    ApplicationArea = all;
                    Tooltip = 'is it at sublease?';
                }
                field(TypeA9_1_Address; Rec.TypeA9_1_Address)
                {
                    ApplicationArea = all;
                    Tooltip = 'The address of the tenancy.';
                }
                field(TypeA9_1_City; Rec.TypeA9_1_City)
                {
                    ApplicationArea = all;
                    Tooltip = 'City for the tenancy';
                }
                field(TypeA9_1_Landlord; Rec.TypeA9_1_Landlord)
                {
                    ApplicationArea = all;
                    Tooltip = 'Landlord name';
                }
                field(TypeA9_1_LandlordCVR; Rec.TypeA9_1_LandlordCVR)
                {
                    ApplicationArea = all;
                    ToolTip = 'Landlord reg no.';
                }
                field(TypeA9_1_LandlordAddress; Rec.TypeA9_1_LandlordAddress)
                {
                    ApplicationArea = all;
                    ToolTip = 'Landlord address.';
                }
                field(TypeA9_1_TenentName; Rec.TypeA9_1_TenentName)
                {
                    ApplicationArea = all;
                    Tooltip = 'Tenant name';
                }
                field(TypeA9_1_TenentAddress; Rec.TypeA9_1_TenentAddress)
                {
                    ApplicationArea = all;
                    Tooltip = 'Tenants address';
                }
                field(TypeA9_1_TenantCPR; Rec.TypeA9_1_TenantCPR)
                {
                    ApplicationArea = all;
                    Tooltip = 'Tenant social securety number';
                }
                field(TypeA9_1_AreaTotal; Rec.TypeA9_1_AreaTotal)
                {
                    ApplicationArea = all;
                    Tooltip = 'Total area of the rented premissies';
                }
                field(TypeA9_1_Rooms; Rec.TypeA9_1_Rooms)
                {
                    ApplicationArea = all;
                    Tooltip = 'Qty of rooms';
                }
                field(TypeA9_1_AreaProf; Rec.TypeA9_1_AreaProf)
                {
                    ApplicationArea = all;
                    Tooltip = 'How much of the area is for prof. use?';
                }
                field(TypeA9_1_Laundy; Rec.TypeA9_1_Laundy)
                {
                    ApplicationArea = all;
                    Tooltip = 'Is there access to laundy?';
                }
                field(TypeA9_1_Courtyard; Rec.TypeA9_1_Courtyard)
                {
                    ApplicationArea = all;
                    Tooltip = 'Is there access to Courtyard?';
                }
                field(TypeA9_1_BicycleStorage; Rec.TypeA9_1_BicycleStorage)
                {
                    ApplicationArea = all;
                    Tooltip = 'Is there access to bicyclestorage?';
                }
                field(TypeA9_1_Garage; Rec.TypeA9_1_Garage)
                {
                    ApplicationArea = all;
                    Tooltip = 'Is there access to a garage?';
                }
                field(TypeA9_1_GarageNo; Rec.TypeA9_1_GarageNo)
                {
                    ApplicationArea = all;
                    Tooltip = 'If there is access to a garage, does it have a speciel mark (number or letter)?';
                }
                field(TypeA9_1_Attic; Rec.TypeA9_1_Attic)
                {
                    ApplicationArea = all;
                    Tooltip = 'Is there access to an attic?';
                }
                field(TypeA9_1_AtticNo; Rec.TypeA9_1_AtticNo)
                {
                    ApplicationArea = all;
                    Tooltip = 'If there is access to an attic, does it have a speciel mark (number or letter)?';
                }
                field(TypeA9_1_Other; Rec.TypeA9_1_Other)
                {
                    ApplicationArea = all;
                    Tooltip = 'Are there access to other?';
                }
                field(TypeA9_1_OtherTxt; Rec.TypeA9_1_OtherTxt)
                {
                    ApplicationArea = all;
                    Tooltip = 'If there is access to other, what is it?';
                }
                field(TypeA9_1_Use; Rec.TypeA9_1_Use)
                {
                    ApplicationArea = all;
                    Tooltip = 'What is the purpose for the use of the tenancy?';
                }
            }
            group("Paragraf 2")
            {
                Caption = 'Paragraph 2';
                field(TypeA9_2_Startdate; Rec.TypeA9_2_Startdate)
                {
                    ApplicationArea = all;
                    Tooltip = 'At which date start the agreement?';
                }
            }
            group("Paragraf 3")
            {
                Caption = 'Paragraph 3';
                field(TypeA9_3_DueDay; Rec.TypeA9_3_DueDay)
                {
                    ApplicationArea = all;
                    Tooltip = 'The rent is due at this day of the month';
                }
                field(TypeA9_3_Monthly; Rec.TypeA9_3_Monthly)
                {
                    ApplicationArea = all;
                    Tooltip = 'The rent is due every month/quarter';
                }
                field(TypeA9_3_Quater; Rec.TypeA9_3_Quater)
                {
                    ApplicationArea = all;
                    Tooltip = 'The rent is due every month/quarter';
                }
                field(TypeA9_3_RentPerPeriode; Rec.TypeA9_3_RentPerPeriode)
                {
                    ApplicationArea = all;
                    Tooltip = 'The amount of rent per period';
                }
                field(TypeA9_3_ACHeat; Rec.TypeA9_3_ACHeat)
                {
                    ApplicationArea = all;
                    Tooltip = 'The amount for a conto heat.';
                }
                field(TypeA9_3_ACWater; Rec.TypeA9_3_ACWater)
                {
                    ApplicationArea = all;
                    Tooltip = 'The amount for a conto water.';
                }
                field(TypeA9_3_ACElectricity; Rec.TypeA9_3_ACElectricity)
                {
                    ApplicationArea = all;
                    Tooltip = 'The amount for a conto electricity.';
                }
                field(TypeA9_3_ACCooling; Rec.TypeA9_3_ACCooling)
                {
                    ApplicationArea = all;
                    Tooltip = 'The amount for a conto cooling';
                }
                field(TypeA9_3_Antenna; Rec.TypeA9_3_Antenna)
                {
                    ApplicationArea = all;
                    Tooltip = 'The amount for antenna';
                }
                field(TypeA9_3_Internet; Rec.TypeA9_3_Internet)
                {
                    ApplicationArea = all;
                    Tooltip = 'The amount for internet';
                }
                field(TypeA9_3_TenantGroup; Rec.TypeA9_3_TenantGroup)
                {
                    ApplicationArea = all;
                    Tooltip = 'The amount for tenant group';
                }
                field(TypeA9_3_OtherText1; Rec.TypeA9_3_OtherText1)
                {
                    ApplicationArea = all;
                    Tooltip = 'Other payments';
                }
                field(TypeA9_3_OtherAmount1; Rec.TypeA9_3_OtherAmount1)
                {
                    ApplicationArea = all;
                    Tooltip = 'The amount for other payments';
                }
                field(TypeA9_3_OtherText2; Rec.TypeA9_3_OtherText2)
                {
                    ApplicationArea = all;
                    Tooltip = 'Other payments';
                }
                field(TypeA9_3_OtherAmount2; Rec.TypeA9_3_OtherAmount2)
                {
                    ApplicationArea = all;
                    Tooltip = 'The amount for other payments';
                }
                field(TypeA9_3_TotalperPeriod; Rec.TypeA9_3_TotalperPeriod)
                {
                    ApplicationArea = all;
                    Tooltip = 'Total amount each period.';
                }
                field(TypeA9_3_TaxesPer; Rec.TypeA9_3_TaxesPer)
                {
                    ApplicationArea = all;
                    Tooltip = 'The rent is based on taxes per date.';
                }
                field(TypeA9_3_BankRegNo; Rec.TypeA9_3_BankRegNo)
                {
                    ApplicationArea = all;
                    Tooltip = 'Bank reg. number. 4 digits';
                }
                field(TypeA9_3_BankAccount; Rec.TypeA9_3_BankAccount)
                {
                    ApplicationArea = all;
                    Tooltip = 'Bank account number.';
                }
                field(TypeA9_3_Bankname; Rec.TypeA9_3_Bankname)
                {
                    ApplicationArea = all;
                    Tooltip = 'Bank name';

                }
            }
            group("Paragraf 4")
            {
                Caption = 'Paragraph 4';
                field(TypeA9_4_DepMth; Rec.TypeA9_4_DepMth)
                {
                    ApplicationArea = all;
                    Tooltip = 'Month of deposit.';
                }
                field(TypeA9_4_DepAmount; Rec.TypeA9_4_DepAmount)
                {
                    ApplicationArea = all;
                    Tooltip = 'Deposit Amount.';
                }
                field(TypeA9_4_PrepaidRentMth; Rec.TypeA9_4_PrepaidRentMth)
                {
                    ApplicationArea = all;
                    Tooltip = 'Month of prepaid rent';
                }
                field(TypeA9_4_PrepaidRent; Rec.TypeA9_4_PrepaidRent)
                {
                    ApplicationArea = all;
                    Tooltip = 'Prepaid rent amount.';
                }
                field(TypeA9_4_Rentetc; Rec.TypeA9_4_Rentetc)
                {
                    ApplicationArea = all;
                    Tooltip = 'Rent etc. (Amount per period.)';
                }
                field(TypeA9_4_RentFrom; Rec.TypeA9_4_RentFrom)
                {
                    ApplicationArea = all;
                    Tooltip = 'First period of rent from';
                }
                field(TypeA9_4_RentTo; Rec.TypeA9_4_RentTo)
                {
                    ApplicationArea = all;
                    Tooltip = 'First period of rent to';
                }
                field(TypeA9_4_RentFirstTime; Rec.TypeA9_4_RentFirstTime)
                {
                    ApplicationArea = all;
                    Tooltip = 'First period of rent after moving in.';
                }
                field(TypeA9_4_Text1; Rec.TypeA9_4_Text1)
                {
                    ApplicationArea = all;
                    Tooltip = 'Description of other amount.';
                }
                field(TypeA9_4_Amount1; Rec.TypeA9_4_Amount1)
                {
                    ApplicationArea = all;
                    Tooltip = 'Amount';
                }
                field(TypeA9_4_Text2; Rec.TypeA9_4_Text2)
                {
                    ApplicationArea = all;
                    Tooltip = 'Description of other amount.';
                }
                field(TypeA9_4_Amount2; Rec.TypeA9_4_Amount2)
                {
                    ApplicationArea = all;
                    Tooltip = 'Amount';
                }
                field(TypeA9_4_Text3; Rec.TypeA9_4_Text3)
                {
                    ApplicationArea = all;
                    Tooltip = 'Description of other amount.';
                }
                field(TypeA9_4_Amount3; Rec.TypeA9_4_Amount3)
                {
                    ApplicationArea = all;
                    Tooltip = 'Amount';
                }
                field(TypeA9_4_TotalAmount; Rec.TypeA9_4_TotalAmount)
                {
                    ApplicationArea = all;
                    Tooltip = 'Total amount to be paid for this contract.';
                }
                field(TypeA9_4_DueDate; Rec.TypeA9_4_DueDate)
                {
                    ApplicationArea = all;
                    Tooltip = 'Duedate';
                }
            }
            group("Paragraf 5")
            {
                Caption = 'Paragraph 5';
                field(TypeA9_5_LandlordHeat; Rec.TypeA9_5_LandlordHeat)
                {
                    ApplicationArea = all;
                    Tooltip = 'Landlord provides heat.';
                }
                field(TypeA9_5_LandlorNatGas; Rec.TypeA9_5_LandlorNatGas)
                {
                    ApplicationArea = all;
                    Tooltip = 'The tenancy is heatet by natural gas/distant heat .';
                }
                field(TypeA9_5_LandlordOil; Rec.TypeA9_5_LandlordOil)
                {
                    ApplicationArea = all;
                    Tooltip = 'The tenancy is heatet by Oil.';
                }
                field(TypeA9_5_LandlordElHeating; Rec.TypeA9_5_LandlordElHeating)
                {
                    ApplicationArea = all;
                    Tooltip = 'The tenancy is heatet by electricity.';
                }
                field(TypeA9_5_LandlordOther; Rec.TypeA9_5_LandlordOther)
                {
                    ApplicationArea = all;
                    Tooltip = 'The tenancy is heatet by other.';
                }
                field(TypeA9_5_LandlordText; Rec.TypeA9_5_LandlordText)
                {
                    ApplicationArea = all;
                    Tooltip = 'Wich type of heat?';
                }
                field(TypeA9_5_HeatAccounting; Rec.TypeA9_5_HeatAccounting)
                {
                    ApplicationArea = all;
                    Tooltip = 'Heataccounting year starts';
                }
                field(TypeA9_5_TenantHeat; Rec.TypeA9_5_TenantHeat)
                {
                    ApplicationArea = all;
                    Tooltip = 'Tenant provides heat.';
                }
                field(TypeA9_5_TenantEl; Rec.TypeA9_5_TenantEl)
                {
                    ApplicationArea = all;
                    Tooltip = 'The tenancy is heatet by electricity.';
                }
                field(TypeA9_5_TenantGas; Rec.TypeA9_5_TenantGas)
                {
                    ApplicationArea = all;
                    Tooltip = 'The tenancy is heatet by gas.';
                }
                field(TypeA9_5_TenantOil; Rec.TypeA9_5_TenantOil)
                {
                    ApplicationArea = all;
                    Tooltip = 'The tenancy is heatet by oil.';
                }
                field(TypeA9_5_TenantNatGas; Rec.TypeA9_5_TenantNatGas)
                {
                    ApplicationArea = all;
                    Tooltip = 'The tenancy is heatet by natural gas.';
                }
                field(TypeA9_5_TenOtherHeat; Rec.TypeA9_5_TenOtherHeat)
                {
                    ApplicationArea = all;
                    Tooltip = 'The tenancy is heatet by other.';
                }
                field(TypeA9_5_TenOtherText; Rec.TypeA9_5_TenOtherText)
                {
                    ApplicationArea = all;
                    Tooltip = 'What is the tenancy heatet by.';
                }
                field(TypeA9_5_LandlordWater; Rec.TypeA9_5_LandlordWater)
                {
                    ApplicationArea = all;
                    Tooltip = 'Landlord provides water.';
                }
                field(TypeA9_5_WaterMeter; Rec.TypeA9_5_WaterMeter)
                {
                    ApplicationArea = all;
                    Tooltip = 'Tenancy has water meter';
                }
                field(TypeA9_5_WaterAccounting; Rec.TypeA9_5_WaterAccounting)
                {
                    ApplicationArea = all;
                    Tooltip = 'Wateraccounting year starts';
                }
                field(TypeA9_5_LandlordEl; Rec.TypeA9_5_LandlordEl)
                {
                    ApplicationArea = all;
                    Tooltip = 'Landlord provides electricity for other use than heat.';
                }
                field(TypeA9_5_ElAccounting; Rec.TypeA9_5_ElAccounting)
                {
                    ApplicationArea = all;
                    Tooltip = 'Elaccounting year starts';
                }
                field(TypeA9_5_LandlordCooling; Rec.TypeA9_5_LandlordCooling)
                {
                    ApplicationArea = all;
                    Tooltip = 'Landlord provides cooling.';
                }
                field(TypeA9_5_CoolingMeter; Rec.TypeA9_5_CoolingMeter)
                {
                    ApplicationArea = all;
                    Tooltip = 'Tenancy has cooling meter';
                }
                field(TypeA9_5_CooligAccounting; Rec.TypeA9_5_CooligAccounting)
                {
                    ApplicationArea = all;
                    Tooltip = 'Coolingaccounting year starts';
                }
            }
            group("Paragraf 6")
            {
                Caption = 'Paragraph 6';
                field(TypeA9_6_AntennaLandlord; Rec.TypeA9_6_AntennaLandlord)
                {
                    ApplicationArea = all;
                    Tooltip = 'Landlord deliver antenna where tenant pays contribution.';
                }
                field(TypeA9_6_AntennaTenancies; Rec.TypeA9_6_AntennaTenancies)
                {
                    ApplicationArea = all;
                    Tooltip = 'Tenant pays for common signal';
                }
                field(TypeA9_6_Internet; Rec.TypeA9_6_Internet)
                {
                    ApplicationArea = all;
                    Tooltip = 'Landlord provides for internet which tenants pays contribution';
                }
            }
            group("Paragraf 7")
            {
                Caption = 'Paragraph 7';
                field(TypeA9_7_InspecionIn; Rec.TypeA9_7_InspecionIn)
                {
                    ApplicationArea = all;
                    Tooltip = 'Inspection at moving in?';
                }
            }
            group("Paragraf 8")
            {
                Caption = 'Paragraph 8';
                field(TypeA9_8_MaintainceInsideTenan; Rec.TypeA9_8_MaintainceInsideTenan)
                {
                    ApplicationArea = all;
                    Tooltip = 'Inside maintenance by tenant';
                }
                field(TypeA9_8_MaintainceInsideLandl; Rec.TypeA9_8_MaintainceInsideLandl)
                {
                    ApplicationArea = all;
                    Tooltip = 'Inside maintenance by landlord';
                }
                field(TypeA9_8_Date; Rec.TypeA9_8_Date)
                {
                    ApplicationArea = all;
                    Tooltip = 'Amount maintenanceaccount per date.';
                }
                field(TypeA9_8_Amount; Rec.TypeA9_8_Amount)
                {
                    ApplicationArea = all;
                    Tooltip = 'Amount maintenanceaccount.';
                }
            }
            group("Paragraf 9")
            {
                Caption = 'Paragraph 9';
                field(TypeA9_9_Stove; Rec.TypeA9_9_Stove)
                {
                    ApplicationArea = all;
                    Tooltip = 'Indeholder køkkenet komtur';
                }
                field(TypeA9_9_Fridge; Rec.TypeA9_9_Fridge)
                {
                    ApplicationArea = all;
                    Tooltip = 'Indeholder lejemålet køleskab';
                }
                field(TypeA9_9_Freezer; Rec.TypeA9_9_Freezer)
                {
                    ApplicationArea = all;
                    Tooltip = 'Indeholder lejemålet fryser';
                }
                field(TypeA9_9_dishwasher; Rec.TypeA9_9_dishwasher)
                {
                    ApplicationArea = all;
                    Tooltip = 'Indeholder lejemålet opvaskemaskine';
                }
                field(TypeA9_9_Washer; Rec.TypeA9_9_Washer)
                {
                    ApplicationArea = all;
                    Tooltip = 'Indeholder lejemålet vaskemaskine';
                }
                field(TypeA9_9_Dryer; Rec.TypeA9_9_Dryer)
                {
                    ApplicationArea = all;
                    Tooltip = 'Indeholder lejemålet tørretumbler';
                }
                field(TypeA9_9_Hood; Rec.TypeA9_9_Hood)
                {
                    ApplicationArea = all;
                    Tooltip = 'Indeholder lejemålet emhætte';
                }
                field(TypeA9_9_ElectricPanels; Rec.TypeA9_9_ElectricPanels)
                {
                    ApplicationArea = all;
                    Tooltip = 'Indeholder lejemålet el-paneler';
                }
                field(TypeA9_9_ElectricPanels_qty; Rec.TypeA9_9_ElectricPanels_qty)
                {
                    ApplicationArea = all;
                    Tooltip = 'Hvis der er el-pananler, hvor mange er der?';
                }
                field(TypeA9_9_WaterHeater; Rec.TypeA9_9_WaterHeater)
                {
                    ApplicationArea = all;
                    Tooltip = 'Indeholder lejemålet vandvarme';
                }
                field(TypeA9_9_WaterHeater_qty; Rec.TypeA9_9_WaterHeater_qty)
                {
                    ApplicationArea = all;
                    Tooltip = 'Hvis der er vandvarme, hvor mange er der?';
                }
                field(TypeA9_9_Other1; Rec.TypeA9_9_Other1)
                {
                    ApplicationArea = all;
                    Tooltip = 'Indeholder lejemålet andre hvidevarer eller andet?';
                }
                field(TypeA9_9_Other1Text; Rec.TypeA9_9_Other1Text)
                {
                    ApplicationArea = all;
                    Tooltip = 'Beskrivelse';
                }
                field(TypeA9_9_Other2; Rec.TypeA9_9_Other2)
                {
                    ApplicationArea = all;
                    Tooltip = 'Beskrivelse';
                }
                field(TypeA9_9_Other2Text; Rec.TypeA9_9_Other2Text)
                {
                    ApplicationArea = all;
                    Tooltip = 'Beskrivelse';
                }
                field(TypeA9_9_Other3; Rec.TypeA9_9_Other3)
                {
                    ApplicationArea = all;
                    Tooltip = 'Beskrivelse';
                }
                field(TypeA9_9_Other3Text; Rec.TypeA9_9_Other3Text)
                {
                    ApplicationArea = all;
                    Tooltip = 'Beskrivelse';
                }
            }
            group("Paragraf 10")
            {
                Caption = 'Paragraph 10';
                field(TypeA9_10_TenRep; Rec.TypeA9_10_TenRep)
                {
                    ApplicationArea = all;
                    Tooltip = 'Er der ved kontraktens indgåelse etableret beboerrepræsentation i ejendommen?';
                }
                field(TypeA9_10_LiveStock; Rec.TypeA9_10_LiveStock)
                {
                    ApplicationArea = all;
                    Tooltip = 'Er det tilladt at holde husdyr i lejemålet?';
                }
                field(TypeA9_10_HouseRules; Rec.TypeA9_10_HouseRules)
                {
                    ApplicationArea = all;
                    Tooltip = 'Foreligger der ved lejeforholdets indgåelse en husorden for ejendommen?';
                }
            }
        }
        area(factboxes)
        {
            systempart(Links; Links)
            {
                ApplicationArea = All;
            }
            systempart(Notes; Notes)
            {
                ApplicationArea = All;
            }

        }
    }

    actions
    {
        area(Processing)
        {
            action(LeaseContract)
            {
                ApplicationArea = all;
                Caption = 'Print leasecontract';
                ToolTip = 'Print out leasecontract type A, 9. edition';
                Image = "Report";

                trigger OnAction();
                begin
                    CLEAR(SVALeaseContractA9);
                    SVALeaseContractA9.SETRANGE(Number, Rec.Number);
                    IF SVALeaseContractA9.FindFirst() THEN begin
                        CLEAR(RepSVAContractTypeA9);
                        RepSVAContractTypeA9.SETTABLEVIEW(SVALeaseContractA9);
                        RepSVAContractTypeA9.RunModal();
                    END;
                end;
            }
            action(MovingInJournal)
            {
                ApplicationArea = all;
                Caption = 'Move in journal';
                ToolTip = 'Making a journal for moving in costs';
                Image = Report;

                trigger Onaction();
                begin
                    CLEAR(SVALeaseContractA9);
                    SVALeaseContractA9.SETRANGE(Number, Rec.Number);
                    IF SVALeaseContractA9.FindFirst() THEN begin
                        CLEAR(SVAMovingInJournal);
                        SVAMovingInJournal.SETTABLEVIEW(SVALeaseContractA9);
                        SVAMovingInJournal.RunModal();
                    END;
                end;
            }

            action(MoveInInvoice)
            {
                ApplicationArea = all;
                Caption = 'Make Invoice moving in';
                ToolTip = 'Make invoice to customer for moving in costs';
                Image = Report;

                trigger OnAction();
                begin
                    CLEAR(SVALeaseContractA9);
                    SVALeaseContractA9.SETRANGE(Number, Rec.Number);
                    IF SVALeaseContractA9.FindFirst() then
                        Codeunit.run(Codeunit::"SVA Move In Invoice", SVALeaseContractA9);
                end;

            }
        }
    }

    var
        SVALeaseContractA9: Record "SVA LeaseContract_A9";
        RepSVAContractTypeA9: Report "SVA ContractTypeA9";
        SVAMovinginJournal: Report "SVA Moving in Journal";
}

