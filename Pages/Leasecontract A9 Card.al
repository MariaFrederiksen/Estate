page 50004 "SVA Leasecontract_A9"
//Tooltip created
{
    // Page er oprettet for at kunne udfylde Lejekontrakt Type A, 9. udgave korrekt. En del informationer findes i andre tabeller, og
    // udfyldes når man går ind på kontrakten første gang. Senere ændringer overskrives ikke.
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
            group("Paragraf 1")
            {
                Caption = 'Paragraph 1';
                field(Number; Number)
                {
                    ApplicationArea = all;
                    Tooltip = 'Nummer på beboeraftalen';
                }
                field(TypeA9_1_Apartment; TypeA9_1_Apartment)
                {
                    ApplicationArea = all;
                    Tooltip = 'Is the tenancy an apartment?';
                }
                field(TypeA9_1_Room; TypeA9_1_Room)
                {
                    ApplicationArea = all;
                    Tooltip = 'Is the tenancy a room?';
                }
                field(TypeA9_1_Condominium; TypeA9_1_Condominium)
                {
                    ApplicationArea = all;
                    Tooltip = 'Is the tenancy a Condominium?';
                }
                field(TypeA9_1_HousingCoop; TypeA9_1_HousingCoop)
                {
                    ApplicationArea = all;
                    Tooltip = 'Is the tenancy a housinggroup?';
                }
                field(TypeA9_1_OtherT; TypeA9_1_OtherT)
                {
                    ApplicationArea = all;
                    Tooltip = 'Is the tenancy none of the above?';
                }
                field(TypeA9_1_OtherTTxt; TypeA9_1_OtherTTxt)
                {
                    ApplicationArea = all;
                    Tooltip = 'What is the tenancy if not one of the above?';
                }
                field(TypeA9_1_Sublease; TypeA9_1_Sublease)
                {
                    ApplicationArea = all;
                    Tooltip = 'is it at sublease?';
                }
                field(TypeA9_1_Address; TypeA9_1_Address)
                {
                    ApplicationArea = all;
                    Tooltip = 'The address of the tenancy.';
                }
                field(TypeA9_1_City; TypeA9_1_City)
                {
                    ApplicationArea = all;
                    Tooltip = 'City for the tenancy';
                }
                field(TypeA9_1_Landlord; TypeA9_1_Landlord)
                {
                    ApplicationArea = all;
                    Tooltip = 'Landlord name';
                }
                field(TypeA9_1_LandlordCVR; TypeA9_1_LandlordCVR)
                {
                    ApplicationArea = all;
                    ToolTip = 'Landlord reg no.';
                }
                field(TypeA9_1_LandlordAddress; TypeA9_1_LandlordAddress)
                {
                    ApplicationArea = all;
                    ToolTip = 'Landlord address.';
                }
                field(TypeA9_1_TenentName; TypeA9_1_TenentName)
                {
                    ApplicationArea = all;
                    Tooltip = 'Tenant name';
                }
                field(TypeA9_1_TenentAddress; TypeA9_1_TenentAddress)
                {
                    ApplicationArea = all;
                    Tooltip = 'Tenants address';
                }
                field(TypeA9_1_TenantCPR; TypeA9_1_TenantCPR)
                {
                    ApplicationArea = all;
                    Tooltip = 'Tenant social securety number';
                }
                field(TypeA9_1_AreaTotal; TypeA9_1_AreaTotal)
                {
                    ApplicationArea = all;
                    Tooltip = 'Total area of the rented premissies';
                }
                field(TypeA9_1_Rooms; TypeA9_1_Rooms)
                {
                    ApplicationArea = all;
                    Tooltip = 'Qty of rooms';
                }
                field(TypeA9_1_AreaProf; TypeA9_1_AreaProf)
                {
                    ApplicationArea = all;
                    Tooltip = 'How much of the area is for prof. use?';
                }
                field(TypeA9_1_Laundy; TypeA9_1_Laundy)
                {
                    ApplicationArea = all;
                    Tooltip = 'Is there access to laundy?';
                }
                field(TypeA9_1_Courtyard; TypeA9_1_Courtyard)
                {
                    ApplicationArea = all;
                    Tooltip = 'Is there access to Courtyard?';
                }
                field(TypeA9_1_BicycleStorage; TypeA9_1_BicycleStorage)
                {
                    ApplicationArea = all;
                    Tooltip = 'Is there access to bicyclestorage?';
                }
                field(TypeA9_1_Garage; TypeA9_1_Garage)
                {
                    ApplicationArea = all;
                    Tooltip = 'Is there access to a garage?';
                }
                field(TypeA9_1_GarageNo; TypeA9_1_GarageNo)
                {
                    ApplicationArea = all;
                    Tooltip = 'If there is access to a garage, does it have a speciel mark (number or letter)?';
                }
                field(TypeA9_1_Attic; TypeA9_1_Attic)
                {
                    ApplicationArea = all;
                    Tooltip = 'Is there access to an attic?';
                }
                field(TypeA9_1_AtticNo; TypeA9_1_AtticNo)
                {
                    ApplicationArea = all;
                    Tooltip = 'If there is access to an attic, does it have a speciel mark (number or letter)?';
                }
                field(TypeA9_1_Other; TypeA9_1_Other)
                {
                    ApplicationArea = all;
                    Tooltip = 'Are there access to other?';
                }
                field(TypeA9_1_OtherTxt; TypeA9_1_OtherTxt)
                {
                    ApplicationArea = all;
                    Tooltip = 'If there is access to other, what is it?';
                }
                field(TypeA9_1_Use; TypeA9_1_Use)
                {
                    ApplicationArea = all;
                    Tooltip = 'What is the purpose for the use of the tenancy?';
                }
            }
            group("Paragraf 2")
            {
                Caption = 'Paragraph 2';
                field(TypeA9_2_Startdate; TypeA9_2_Startdate)
                {
                    ApplicationArea = all;
                    Tooltip = 'At which date start the agreement?';
                }
            }
            group("Paragraf 3")
            {
                Caption = 'Paragraph 3';
                field(TypeA9_3_DueDay; TypeA9_3_DueDay)
                {
                    ApplicationArea = all;
                    Tooltip = 'The rent is due at this day of the month';
                }
                field(TypeA9_3_Monthly; TypeA9_3_Monthly)
                {
                    ApplicationArea = all;
                    Tooltip = 'The rent is due every month/quarter';
                }
                field(TypeA9_3_Quater; TypeA9_3_Quater)
                {
                    ApplicationArea = all;
                    Tooltip = 'The rent is due every month/quarter';
                }
                field(TypeA9_3_RentPerPeriode; TypeA9_3_RentPerPeriode)
                {
                    ApplicationArea = all;
                    Tooltip = 'The amount of rent per period';
                }
                field(TypeA9_3_ACHeat; TypeA9_3_ACHeat)
                {
                    ApplicationArea = all;
                    Tooltip = 'The amount for a conto heat.';
                }
                field(TypeA9_3_ACWater; TypeA9_3_ACWater)
                {
                    ApplicationArea = all;
                    Tooltip = 'The amount for a conto water.';
                }
                field(TypeA9_3_ACElectricity; TypeA9_3_ACElectricity)
                {
                    ApplicationArea = all;
                    Tooltip = 'The amount for a conto electricity.';
                }
                field(TypeA9_3_ACCooling; TypeA9_3_ACCooling)
                {
                    ApplicationArea = all;
                    Tooltip = 'The amount for a conto cooling';
                }
                field(TypeA9_3_Antenna; TypeA9_3_Antenna)
                {
                    ApplicationArea = all;
                    Tooltip = 'The amount for antenna';
                }
                field(TypeA9_3_Internet; TypeA9_3_Internet)
                {
                    ApplicationArea = all;
                    Tooltip = 'The amount for internet';
                }
                field(TypeA9_3_TenantGroup; TypeA9_3_TenantGroup)
                {
                    ApplicationArea = all;
                    Tooltip = 'The amount for tenant group';
                }
                field(TypeA9_3_OtherText1; TypeA9_3_OtherText1)
                {
                    ApplicationArea = all;
                    Tooltip = 'Other payments';
                }
                field(TypeA9_3_OtherAmount1; TypeA9_3_OtherAmount1)
                {
                    ApplicationArea = all;
                    Tooltip = 'The amount for other payments';
                }
                field(TypeA9_3_OtherText2; TypeA9_3_OtherText2)
                {
                    ApplicationArea = all;
                    Tooltip = 'Other payments';
                }
                field(TypeA9_3_OtherAmount2; TypeA9_3_OtherAmount2)
                {
                    ApplicationArea = all;
                    Tooltip = 'The amount for other payments';
                }
                field(TypeA9_3_TotalperPeriod; TypeA9_3_TotalperPeriod)
                {
                    ApplicationArea = all;
                    Tooltip = 'Total amount each period.';
                }
                field(TypeA9_3_TaxesPer; TypeA9_3_TaxesPer)
                {
                    ApplicationArea = all;
                    Tooltip = 'The rent is based on taxes per date.';
                }
                field(TypeA9_3_BankRegNo; TypeA9_3_BankRegNo)
                {
                    ApplicationArea = all;
                    Tooltip = 'Bank reg. number. 4 digits';
                }
                field(TypeA9_3_BankAccount; TypeA9_3_BankAccount)
                {
                    ApplicationArea = all;
                    Tooltip = 'Bank account number.';
                }
                field(TypeA9_3_Bankname; TypeA9_3_Bankname)
                {
                    ApplicationArea = all;
                    Tooltip = 'Bank name';

                }
            }
            group("Paragraf 4")
            {
                Caption = 'Paragraph 4';
                field(TypeA9_4_DepMth; TypeA9_4_DepMth)
                {
                    ApplicationArea = all;
                    Tooltip = 'Month of deposit.';
                }
                field(TypeA9_4_DepAmount; TypeA9_4_DepAmount)
                {
                    ApplicationArea = all;
                    Tooltip = 'Deposit Amount.';
                }
                field(TypeA9_4_PrepaidRentMth; TypeA9_4_PrepaidRentMth)
                {
                    ApplicationArea = all;
                    Tooltip = 'Month of prepaid rent';
                }
                field(TypeA9_4_PrepaidRent; TypeA9_4_PrepaidRent)
                {
                    ApplicationArea = all;
                    Tooltip = 'Prepaid rent amount.';
                }
                field(TypeA9_4_Rentetc; TypeA9_4_Rentetc)
                {
                    ApplicationArea = all;
                    Tooltip = 'Rent etc. (Amount per period.)';
                }
                field(TypeA9_4_RentFrom; TypeA9_4_RentFrom)
                {
                    ApplicationArea = all;
                    Tooltip = 'First period of rent from';
                }
                field(TypeA9_4_RentTo; TypeA9_4_RentTo)
                {
                    ApplicationArea = all;
                    Tooltip = 'First period of rent to';
                }
                field(TypeA9_4_RentFirstTime; TypeA9_4_RentFirstTime)
                {
                    ApplicationArea = all;
                    Tooltip = 'First period of rent after moving in.';
                }
                field(TypeA9_4_Text1; TypeA9_4_Text1)
                {
                    ApplicationArea = all;
                    Tooltip = 'Description of other amount.';
                }
                field(TypeA9_4_Amount1; TypeA9_4_Amount1)
                {
                    ApplicationArea = all;
                    Tooltip = 'Amount';
                }
                field(TypeA9_4_Text2; TypeA9_4_Text2)
                {
                    ApplicationArea = all;
                    Tooltip = 'Description of other amount.';
                }
                field(TypeA9_4_Amount2; TypeA9_4_Amount2)
                {
                    ApplicationArea = all;
                    Tooltip = 'Amount';
                }
                field(TypeA9_4_Text3; TypeA9_4_Text3)
                {
                    ApplicationArea = all;
                    Tooltip = 'Description of other amount.';
                }
                field(TypeA9_4_Amount3; TypeA9_4_Amount3)
                {
                    ApplicationArea = all;
                    Tooltip = 'Amount';
                }
                field(TypeA9_4_TotalAmount; TypeA9_4_TotalAmount)
                {
                    ApplicationArea = all;
                    Tooltip = 'Total amount to be paid for this contract.';
                }
                field(TypeA9_4_DueDate; TypeA9_4_DueDate)
                {
                    ApplicationArea = all;
                    Tooltip = 'Duedate';
                }
            }
            group("Paragraf 5")
            {
                Caption = 'Paragraph 5';
                field(TypeA9_5_LandlordHeat; TypeA9_5_LandlordHeat)
                {
                    ApplicationArea = all;
                    Tooltip = 'Landlord provides heat.';
                }
                field(TypeA9_5_LandlorNatGas; TypeA9_5_LandlorNatGas)
                {
                    ApplicationArea = all;
                    Tooltip = 'The tenancy is heatet by natural gas/distant heat .';
                }
                field(TypeA9_5_LandlordOil; TypeA9_5_LandlordOil)
                {
                    ApplicationArea = all;
                    Tooltip = 'The tenancy is heatet by Oil.';
                }
                field(TypeA9_5_LandlordElHeating; TypeA9_5_LandlordElHeating)
                {
                    ApplicationArea = all;
                    Tooltip = 'The tenancy is heatet by electricity.';
                }
                field(TypeA9_5_LandlordOther; TypeA9_5_LandlordOther)
                {
                    ApplicationArea = all;
                    Tooltip = 'The tenancy is heatet by other.';
                }
                field(TypeA9_5_LandlordText; TypeA9_5_LandlordText)
                {
                    ApplicationArea = all;
                    Tooltip = 'Wich type of heat?';
                }
                field(TypeA9_5_HeatAccounting; TypeA9_5_HeatAccounting)
                {
                    ApplicationArea = all;
                    Tooltip = 'Heataccounting year starts';
                }
                field(TypeA9_5_TenantHeat; TypeA9_5_TenantHeat)
                {
                    ApplicationArea = all;
                    Tooltip = 'Tenant provides heat.';
                }
                field(TypeA9_5_TenantEl; TypeA9_5_TenantEl)
                {
                    ApplicationArea = all;
                    Tooltip = 'The tenancy is heatet by electricity.';
                }
                field(TypeA9_5_TenantGas; TypeA9_5_TenantGas)
                {
                    ApplicationArea = all;
                    Tooltip = 'The tenancy is heatet by gas.';
                }
                field(TypeA9_5_TenantOil; TypeA9_5_TenantOil)
                {
                    ApplicationArea = all;
                    Tooltip = 'The tenancy is heatet by oil.';
                }
                field(TypeA9_5_TenantNatGas; TypeA9_5_TenantNatGas)
                {
                    ApplicationArea = all;
                    Tooltip = 'The tenancy is heatet by natural gas.';
                }
                field(TypeA9_5_TenOtherHeat; TypeA9_5_TenOtherHeat)
                {
                    ApplicationArea = all;
                    Tooltip = 'The tenancy is heatet by other.';
                }
                field(TypeA9_5_TenOtherText; TypeA9_5_TenOtherText)
                {
                    ApplicationArea = all;
                    Tooltip = 'What is the tenancy heatet by.';
                }
                field(TypeA9_5_LandlordWater; TypeA9_5_LandlordWater)
                {
                    ApplicationArea = all;
                    Tooltip = 'Landlord provides water.';
                }
                field(TypeA9_5_WaterMeter; TypeA9_5_WaterMeter)
                {
                    ApplicationArea = all;
                    Tooltip = 'Tenancy has water meter';
                }
                field(TypeA9_5_WaterAccounting; TypeA9_5_WaterAccounting)
                {
                    ApplicationArea = all;
                    Tooltip = 'Wateraccounting year starts';
                }
                field(TypeA9_5_LandlordEl; TypeA9_5_LandlordEl)
                {
                    ApplicationArea = all;
                    Tooltip = 'Landlord provides electricity for other use than heat.';
                }
                field(TypeA9_5_ElAccounting; TypeA9_5_ElAccounting)
                {
                    ApplicationArea = all;
                    Tooltip = 'Elaccounting year starts';
                }
                field(TypeA9_5_LandlordCooling; TypeA9_5_LandlordCooling)
                {
                    ApplicationArea = all;
                    Tooltip = 'Landlord provides cooling.';
                }
                field(TypeA9_5_CoolingMeter; TypeA9_5_CoolingMeter)
                {
                    ApplicationArea = all;
                    Tooltip = 'Tenancy has cooling meter';
                }
                field(TypeA9_5_CooligAccounting; TypeA9_5_CooligAccounting)
                {
                    ApplicationArea = all;
                    Tooltip = 'Coolingaccounting year starts';
                }
            }
            group("Paragraf 6")
            {
                Caption = 'Paragraph 6';
                field(TypeA9_6_AntennaLandlord; TypeA9_6_AntennaLandlord)
                {
                    ApplicationArea = all;
                    Tooltip = 'Landlord deliver antenna where tenant pays contribution.';
                }
                field(TypeA9_6_AntennaTenancies; TypeA9_6_AntennaTenancies)
                {
                    ApplicationArea = all;
                    Tooltip = 'Tenant pays for common signal';
                }
                field(TypeA9_6_Internet; TypeA9_6_Internet)
                {
                    ApplicationArea = all;
                    Tooltip = 'Landlord provides for internet which tenants pays contribution';
                }
            }
            group("Paragraf 7")
            {
                Caption = 'Paragraph 7';
                field(TypeA9_7_InspecionIn; TypeA9_7_InspecionIn)
                {
                    ApplicationArea = all;
                    Tooltip = 'Inspection at moving in?';
                }
            }
            group("Paragraf 8")
            {
                Caption = 'Paragraph 8';
                field(TypeA9_8_MaintainceInsideTenan; TypeA9_8_MaintainceInsideTenan)
                {
                    ApplicationArea = all;
                    Tooltip = 'Inside maintenance by tenant';
                }
                field(TypeA9_8_MaintainceInsideLandl; TypeA9_8_MaintainceInsideLandl)
                {
                    ApplicationArea = all;
                    Tooltip = 'Inside maintenance by landlord';
                }
                field(TypeA9_8_Date; TypeA9_8_Date)
                {
                    ApplicationArea = all;
                    Tooltip = 'Amount maintenanceaccount per date.';
                }
                field(TypeA9_8_Amount; TypeA9_8_Amount)
                {
                    ApplicationArea = all;
                    Tooltip = 'Amount maintenanceaccount.';
                }
            }
            group("Paragraf 9")
            {
                Caption = 'Paragraph 9';
                field(TypeA9_9_Stove; TypeA9_9_Stove)
                {
                    ApplicationArea = all;
                    Tooltip = 'Indeholder køkkenet komtur';
                }
                field(TypeA9_9_Fridge; TypeA9_9_Fridge)
                {
                    ApplicationArea = all;
                    Tooltip = 'Indeholder lejemålet køleskab';
                }
                field(TypeA9_9_Freezer; TypeA9_9_Freezer)
                {
                    ApplicationArea = all;
                    Tooltip = 'Indeholder lejemålet fryser';
                }
                field(TypeA9_9_dishwasher; TypeA9_9_dishwasher)
                {
                    ApplicationArea = all;
                    Tooltip = 'Indeholder lejemålet opvaskemaskine';
                }
                field(TypeA9_9_Washer; TypeA9_9_Washer)
                {
                    ApplicationArea = all;
                    Tooltip = 'Indeholder lejemålet vaskemaskine';
                }
                field(TypeA9_9_Dryer; TypeA9_9_Dryer)
                {
                    ApplicationArea = all;
                    Tooltip = 'Indeholder lejemålet tørretumbler';
                }
                field(TypeA9_9_Hood; TypeA9_9_Hood)
                {
                    ApplicationArea = all;
                    Tooltip = 'Indeholder lejemålet emhætte';
                }
                field(TypeA9_9_ElectricPanels; TypeA9_9_ElectricPanels)
                {
                    ApplicationArea = all;
                    Tooltip = 'Indeholder lejemålet el-paneler';
                }
                field(TypeA9_9_ElectricPanels_qty; TypeA9_9_ElectricPanels_qty)
                {
                    ApplicationArea = all;
                    Tooltip = 'Hvis der er el-pananler, hvor mange er der?';
                }
                field(TypeA9_9_WaterHeater; TypeA9_9_WaterHeater)
                {
                    ApplicationArea = all;
                    Tooltip = 'Indeholder lejemålet vandvarme';
                }
                field(TypeA9_9_WaterHeater_qty; TypeA9_9_WaterHeater_qty)
                {
                    ApplicationArea = all;
                    Tooltip = 'Hvis der er vandvarme, hvor mange er der?';
                }
                field(TypeA9_9_Other1; TypeA9_9_Other1)
                {
                    ApplicationArea = all;
                    Tooltip = 'Indeholder lejemålet andre hvidevarer eller andet?';
                }
                field(TypeA9_9_Other1Text; TypeA9_9_Other1Text)
                {
                    ApplicationArea = all;
                    Tooltip = 'Beskrivelse af hvidevarer eller andet.';
                }
                field(TypeA9_9_Other2; TypeA9_9_Other2)
                {
                    ApplicationArea = all;
                    Tooltip = 'Beskrivelse af hvidevarer eller andet.';
                }
                field(TypeA9_9_Other2Text; TypeA9_9_Other2Text)
                {
                    ApplicationArea = all;
                    Tooltip = 'Beskrivelse af hvidevarer eller andet.';
                }
                field(TypeA9_9_Other3; TypeA9_9_Other3)
                {
                    ApplicationArea = all;
                    Tooltip = 'Beskrivelse af hvidevarer eller andet.';
                }
                field(TypeA9_9_Other3Text; TypeA9_9_Other3Text)
                {
                    ApplicationArea = all;
                    Tooltip = 'Beskrivelse af hvidevarer eller andet.';
                }
            }
            group("Paragraf 10")
            {
                Caption = 'Paragraph 10';
                field(TypeA9_10_TenRep; TypeA9_10_TenRep)
                {
                    ApplicationArea = all;
                    Tooltip = 'Er der ved kontraktens indgåelse etableret beboerrepræsentation i ejendommen?';
                }
                field(TypeA9_10_LiveStock; TypeA9_10_LiveStock)
                {
                    ApplicationArea = all;
                    Tooltip = 'Er det tilladt at holde husdyr i lejemålet?';
                }
                field(TypeA9_10_HouseRules; TypeA9_10_HouseRules)
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

        area(processing)
        {
            action(LeaseContract)
            {
                ApplicationArea = all;
                Caption = 'Print leasecontract';
                ToolTip = 'Print out leasecontract type A, 9. edition';
                Image = "Report";

                trigger OnAction();
                begin
                    CLEAR(Contract);
                    Contract.SETRANGE(Number, Rec.Number);
                    IF Contract.FindFirst() THEN begin
                        CLEAR(TypeA9);
                        TypeA9.SETTABLEVIEW(Contract);
                        TypeA9.RunModal;
                    END;
                end;
            }
            action(MoveInJournal)
            {
                ApplicationArea = all;
                Caption = 'Move in journal';
                ToolTip = 'Making a journal for moving in costs';
                Image = Report;

                trigger Onaction();
                begin
                    CLEAR(MoveInContract);
                    MoveInContract.SETRANGE(Number, Rec.Number);
                    IF MoveInContract.FindFirst() THEN begin
                        CLEAR(MoveInJournal);
                        MoveInJournal.SETTABLEVIEW(MoveInContract);
                        MoveInJournal.RunModal;
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
                    CLEAR(Contract);
                    Contract.SETRANGE(Number, Rec.Number);
                    IF Contract.FindFirst() then
                        Codeunit.run(Codeunit::"SVA Move In Invoice", Contract);
                end;

            }
        }
    }

    trigger OnAfterGetCurrRecord();
    begin
        CurrPage.UPDATE;
    end;

    trigger OnAfterGetRecord()
    begin
        Validate(Number);
    end;

    var
        Contract: Record "SVA LeaseContract_A9";
        MoveInContract: Record "SVA LeaseContract_A9";
        TypeA9: Report "SVA ContractTypeA9";
        MoveInJournal: Report "SVA Moving in Journal";
}

