page 60580 "SVA Leasecontract_A9"
//Tooltip created
{
    // Page er oprettet for at kunne udfylde Lejekontrakt Type A, 9. udgave korrekt. En del informationer findes i andre tabeller, og
    // udfyldes når man går ind på kontrakten første gang. Senere ændringer overskrives ikke.
    //Tooltip created

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
                    ToolTip = 'Nummer på beboeraftalen';
                }
                field(TypeA9_1_Apartment; TypeA9_1_Apartment)
                {
                    ToolTip = 'Is the tenancy an apartment?';
                }
                field(TypeA9_1_Room; TypeA9_1_Room)
                {
                    ToolTip = 'Is the tenancy a room?';
                }
                field(TypeA9_1_Condominium; TypeA9_1_Condominium)
                {
                    ToolTip = 'Is the tenancy a Condominium?';
                }
                field(TypeA9_1_HousingCoop; TypeA9_1_HousingCoop)
                {
                    ToolTip = 'Is the tenancy a housinggroup?';
                }
                field(TypeA9_1_OtherT; TypeA9_1_OtherT)
                {
                    ToolTip = 'Is the tenancy none of the above?';
                }
                field(TypeA9_1_OtherTTxt; TypeA9_1_OtherTTxt)
                {
                    ToolTip = 'What is the tenancy if not one of the above?';
                }
                field(TypeA9_1_Sublease; TypeA9_1_Sublease)
                {
                    ToolTip = 'is it at sublease?';
                }
                field(TypeA9_1_Address; TypeA9_1_Address)
                {
                    ToolTip = 'The address of the tenancy.';
                }
                field(TypeA9_1_City; TypeA9_1_City)
                {
                    ToolTip = 'City for the tenancy';
                }
                field(TypeA9_1_Landlord; TypeA9_1_Landlord)
                {
                    ToolTip = 'Landlord name';
                }
                field(TypeA9_1_LandlordCVR; TypeA9_1_LandlordCVR)
                {
                    ToolTip = 'Landlord reg no.';
                }
                field(TypeA9_1_LandlordAddress; TypeA9_1_LandlordAddress)
                {
                    ToolTip = 'Landlord address.';
                }
                field(TypeA9_1_TenentName; TypeA9_1_TenentName)
                {
                    ToolTip = 'Tenant name';
                }
                field(TypeA9_1_TenentAddress; TypeA9_1_TenentAddress)
                {
                    ToolTip = 'Tenants address';
                }
                field(TypeA9_1_TenantCPR; TypeA9_1_TenantCPR)
                {
                    ToolTip = 'Tenant social securety number';
                }
                field(TypeA9_1_AreaTotal; TypeA9_1_AreaTotal)
                {
                    ToolTip = 'Total area of the rented premissies';
                }
                field(TypeA9_1_Rooms; TypeA9_1_Rooms)
                {
                    ToolTip = 'Qty of rooms';
                }
                field(TypeA9_1_AreaProf; TypeA9_1_AreaProf)
                {
                    ToolTip = 'How much of the area is for prof. use?';
                }
                field(TypeA9_1_Laundy; TypeA9_1_Laundy)
                {
                    ToolTip = 'Is there access to laundy?';
                }
                field(TypeA9_1_Courtyard; TypeA9_1_Courtyard)
                {
                    ToolTip = 'Is there access to Courtyard?';
                }
                field(TypeA9_1_BicycleStorage; TypeA9_1_BicycleStorage)
                {
                    ToolTip = 'Is there access to bicyclestorage?';
                }
                field(TypeA9_1_Garage; TypeA9_1_Garage)
                {
                    ToolTip = 'Is there access to a garage?';
                }
                field(TypeA9_1_GarageNo; TypeA9_1_GarageNo)
                {
                    ToolTip = 'If there is access to a garage, does it have a speciel mark (number or letter)?';
                }
                field(TypeA9_1_Attic; TypeA9_1_Attic)
                {
                    ToolTip = 'Is there access to an attic?';
                }
                field(TypeA9_1_AtticNo; TypeA9_1_AtticNo)
                {
                    ToolTip = 'If there is access to an attic, does it have a speciel mark (number or letter)?';
                }
                field(TypeA9_1_Other; TypeA9_1_Other)
                {
                    ToolTip = 'Are there access to other?';
                }
                field(TypeA9_1_OtherTxt; TypeA9_1_OtherTxt)
                {
                    ToolTip = 'If there is access to other, what is it?';
                }
                field(TypeA9_1_Use; TypeA9_1_Use)
                {
                    ToolTip = 'What is the purpose for the use of the tenancy?';
                }
            }
            group("Paragraf 2")
            {
                Caption = 'Paragraph 2';
                field(TypeA9_2_Startdate; TypeA9_2_Startdate)
                {
                    ToolTip = 'At which date start the agreement?';
                }
            }
            group("Paragraf 3")
            {
                Caption = 'Paragraph 3';
                field(TypeA9_3_DueDay; TypeA9_3_DueDay)
                {
                    ToolTip = 'The rent is due at this day of the month';
                }
                field(TypeA9_3_Monthly; TypeA9_3_Monthly)
                {
                    ToolTip = 'The rent is due every month/quarter';
                }
                field(TypeA9_3_Quater; TypeA9_3_Quater)
                {
                    ToolTip = 'The rent is due every month/quarter';
                }
                field(TypeA9_3_RentPerPeriode; TypeA9_3_RentPerPeriode)
                {
                    ToolTip = 'The amount of rent per period';
                }
                field(TypeA9_3_ACHeat; TypeA9_3_ACHeat)
                {
                    ToolTip = 'The amount for a conto heat.';
                }
                field(TypeA9_3_ACWater; TypeA9_3_ACWater)
                {
                    ToolTip = 'The amount for a conto water.';
                }
                field(TypeA9_3_ACElectricity; TypeA9_3_ACElectricity)
                {
                    ToolTip = 'The amount for a conto electricity.';
                }
                field(TypeA9_3_ACCooling; TypeA9_3_ACCooling)
                {
                    ToolTip = 'The amount for a conto cooling';
                }
                field(TypeA9_3_Antenna; TypeA9_3_Antenna)
                {
                    ToolTip = 'The amount for antenna';
                }
                field(TypeA9_3_Internet; TypeA9_3_Internet)
                {
                    ToolTip = 'The amount for internet';
                }
                field(TypeA9_3_TenantGroup; TypeA9_3_TenantGroup)
                {
                    ToolTip = 'The amount for tenant group';
                }
                field(TypeA9_3_OtherText1; TypeA9_3_OtherText1)
                {
                    ToolTip = 'Other payments';
                }
                field(TypeA9_3_OtherAmount1; TypeA9_3_OtherAmount1)
                {
                    ToolTip = 'The amount for other payments';
                }
                field(TypeA9_3_OtherText2; TypeA9_3_OtherText2)
                {
                    ToolTip = 'Other payments';
                }
                field(TypeA9_3_OtherAmount2; TypeA9_3_OtherAmount2)
                {
                    ToolTip = 'The amount for other payments';
                }
                field(TypeA9_3_TotalperPeriod; TypeA9_3_TotalperPeriod)
                {
                    ToolTip = 'Total amount each period.';
                }
                field(TypeA9_3_TaxesPer; TypeA9_3_TaxesPer)
                {
                    ToolTip = 'The rent is based on taxes per date.';
                }
                field(TypeA9_3_BankRegNo; TypeA9_3_BankRegNo)
                {
                    Tooltip = 'Bank reg. number. 4 digits';
                }
                field(TypeA9_3_BankAccount; TypeA9_3_BankAccount)
                {
                    Tooltip = 'Bank account number.';
                }
                field(TypeA9_3_Bankname; TypeA9_3_Bankname)
                {
                    Tooltip = 'Bank name';

                }
            }
            group("Paragraf 4")
            {
                Caption = 'Paragraph 4';
                field(TypeA9_4_DepMth; TypeA9_4_DepMth)
                {
                    ToolTip = 'Month of deposit.';
                }
                field(TypeA9_4_DepAmount; TypeA9_4_DepAmount)
                {
                    Tooltip = 'Deposit Amount.';
                }
                field(TypeA9_4_PrepaidRentMth; TypeA9_4_PrepaidRentMth)
                {
                    Tooltip = 'Month of prepaid rent';
                }
                field(TypeA9_4_PrepaidRent; TypeA9_4_PrepaidRent)
                {
                    Tooltip = 'Prepaid rent amount.';
                }
                field(TypeA9_4_Rentetc; TypeA9_4_Rentetc)
                {
                    Tooltip = 'Rent etc. (Amount per period.)';
                }
                field(TypeA9_4_RentFrom; TypeA9_4_RentFrom)
                {
                    Tooltip = 'First period of rent from';
                }
                field(TypeA9_4_RentTo; TypeA9_4_RentTo)
                {
                    Tooltip = 'First period of rent to';
                }
                field(TypeA9_4_RentFirstTime; TypeA9_4_RentFirstTime)
                {
                    Tooltip = 'First period of rent after moving in.';
                }
                field(TypeA9_4_Text1; TypeA9_4_Text1)
                {
                    ToolTip = 'Description of other amount.';
                }
                field(TypeA9_4_Amount1; TypeA9_4_Amount1)
                {
                    ToolTip = 'Amount';
                }
                field(TypeA9_4_Text2; TypeA9_4_Text2)
                {
                    ToolTip = 'Description of other amount.';
                }
                field(TypeA9_4_Amount2; TypeA9_4_Amount2)
                {
                    ToolTip = 'Amount';
                }
                field(TypeA9_4_Text3; TypeA9_4_Text3)
                {
                    ToolTip = 'Description of other amount.';
                }
                field(TypeA9_4_Amount3; TypeA9_4_Amount3)
                {
                    ToolTip = 'Amount';
                }
                field(TypeA9_4_TotalAmount; TypeA9_4_TotalAmount)
                {
                    Tooltip = 'Total amount to be paid for this contract.';
                }
                field(TypeA9_4_DueDate; TypeA9_4_DueDate)
                {
                    Tooltip = 'Duedate';
                }
            }
            group("Paragraf 5")
            {
                Caption = 'Paragraph 5';
                field(TypeA9_5_LandlordHeat; TypeA9_5_LandlordHeat)
                {
                    Tooltip = 'Landlord provides heat.';
                }
                field(TypeA9_5_LandlorNatGas; TypeA9_5_LandlorNatGas)
                {
                    Tooltip = 'The tenancy is heatet by natural gas/distant heat .';
                }
                field(TypeA9_5_LandlordOil; TypeA9_5_LandlordOil)
                {
                    Tooltip = 'The tenancy is heatet by Oil.';
                }
                field(TypeA9_5_LandlordElHeating; TypeA9_5_LandlordElHeating)
                {
                    Tooltip = 'The tenancy is heatet by electricity.';
                }
                field(TypeA9_5_LandlordOther; TypeA9_5_LandlordOther)
                {
                    Tooltip = 'The tenancy is heatet by other.';
                }
                field(TypeA9_5_LandlordText; TypeA9_5_LandlordText)
                {
                    Tooltip = 'Wich type of heat?';
                }
                field(TypeA9_5_HeatAccounting; TypeA9_5_HeatAccounting)
                {
                    Tooltip = 'Heataccounting year starts';
                }
                field(TypeA9_5_TenantHeat; TypeA9_5_TenantHeat)
                {
                    Tooltip = 'Tenant provides heat.';
                }
                field(TypeA9_5_TenantEl; TypeA9_5_TenantEl)
                {
                    Tooltip = 'The tenancy is heatet by electricity.';
                }
                field(TypeA9_5_TenantGas; TypeA9_5_TenantGas)
                {
                    Tooltip = 'The tenancy is heatet by gas.';
                }
                field(TypeA9_5_TenantOil; TypeA9_5_TenantOil)
                {
                    Tooltip = 'The tenancy is heatet by oil.';
                }
                field(TypeA9_5_TenantNatGas; TypeA9_5_TenantNatGas)
                {
                    Tooltip = 'The tenancy is heatet by natural gas.';
                }
                field(TypeA9_5_TenOtherHeat; TypeA9_5_TenOtherHeat)
                {
                    Tooltip = 'The tenancy is heatet by other.';
                }
                field(TypeA9_5_TenOtherText; TypeA9_5_TenOtherText)
                {
                    Tooltip = 'What is the tenancy heatet by.';
                }
                field(TypeA9_5_LandlordWater; TypeA9_5_LandlordWater)
                {
                    Tooltip = 'Landlord provides water.';
                }
                field(TypeA9_5_WaterMeter; TypeA9_5_WaterMeter)
                {
                    Tooltip = 'Tenancy has water meter';
                }
                field(TypeA9_5_WaterAccounting; TypeA9_5_WaterAccounting)
                {
                    Tooltip = 'Wateraccounting year starts';
                }
                field(TypeA9_5_LandlordEl; TypeA9_5_LandlordEl)
                {
                    Tooltip = 'Landlord provides electricity for other use than heat.';
                }
                field(TypeA9_5_ElAccounting; TypeA9_5_ElAccounting)
                {
                    Tooltip = 'Elaccounting year starts';
                }
                field(TypeA9_5_LandlordCooling; TypeA9_5_LandlordCooling)
                {
                    Tooltip = 'Landlord provides cooling.';
                }
                field(TypeA9_5_CoolingMeter; TypeA9_5_CoolingMeter)
                {
                    Tooltip = 'Tenancy has cooling meter';
                }
                field(TypeA9_5_CooligAccounting; TypeA9_5_CooligAccounting)
                {
                    Tooltip = 'Coolingaccounting year starts';
                }
            }
            group("Paragraf 6")
            {
                Caption = 'Paragraph 6';
                field(TypeA9_6_AntennaLandlord; TypeA9_6_AntennaLandlord)
                {
                    Tooltip = 'Landlord deliver antenna where tenant pays contribution.';
                }
                field(TypeA9_6_AntennaTenancies; TypeA9_6_AntennaTenancies)
                {
                    Tooltip = 'Tenant pays for common signal';
                }
                field(TypeA9_6_Internet; TypeA9_6_Internet)
                {
                    Tooltip = 'Landlord provides for internet which tenants pays contribution';
                }
            }
            group("Paragraf 7")
            {
                Caption = 'Paragraph 7';
                field(TypeA9_7_InspecionIn; TypeA9_7_InspecionIn)
                {
                    Tooltip = 'Inspection at moving in?';
                }
            }
            group("Paragraf 8")
            {
                Caption = 'Paragraph 8';
                field(TypeA9_8_MaintainceInsideTenan; TypeA9_8_MaintainceInsideTenan)
                {
                    Tooltip = 'Inside maintenance by tenant';
                }
                field(TypeA9_8_MaintainceInsideLandl; TypeA9_8_MaintainceInsideLandl)
                {
                    Tooltip = 'Inside maintenance by landlord';
                }
                field(TypeA9_8_Date; TypeA9_8_Date)
                {
                    Tooltip = 'Amount maintenanceaccount per date.';
                }
                field(TypeA9_8_Amount; TypeA9_8_Amount)
                {
                    Tooltip = 'Amount maintenanceaccount.';
                }
            }
            group("Paragraf 9")
            {
                Caption = 'Paragraph 9';
                field(TypeA9_9_Stove; TypeA9_9_Stove)
                {
                    Tooltip = 'Indeholder køkkenet komtur';
                }
                field(TypeA9_9_Fridge; TypeA9_9_Fridge)
                {
                    Tooltip = 'Indeholder lejemålet køleskab';
                }
                field(TypeA9_9_Freezer; TypeA9_9_Freezer)
                {
                    Tooltip = 'Indeholder lejemålet fryser';
                }
                field(TypeA9_9_dishwasher; TypeA9_9_dishwasher)
                {
                    Tooltip = 'Indeholder lejemålet opvaskemaskine';
                }
                field(TypeA9_9_Washer; TypeA9_9_Washer)
                {
                    Tooltip = 'Indeholder lejemålet vaskemaskine';
                }
                field(TypeA9_9_Dryer; TypeA9_9_Dryer)
                {
                    Tooltip = 'Indeholder lejemålet tørretumbler';
                }
                field(TypeA9_9_Hood; TypeA9_9_Hood)
                {
                    Tooltip = 'Indeholder lejemålet emhætte';
                }
                field(TypeA9_9_ElectricPanels; TypeA9_9_ElectricPanels)
                {
                    Tooltip = 'Indeholder lejemålet el-paneler';
                }
                field(TypeA9_9_ElectricPanels_qty; TypeA9_9_ElectricPanels_qty)
                {
                    Tooltip = 'Hvis der er el-pananler, hvor mange er der?';
                }
                field(TypeA9_9_WaterHeater; TypeA9_9_WaterHeater)
                {
                    Tooltip = 'Indeholder lejemålet vandvarme';
                }
                field(TypeA9_9_WaterHeater_qty; TypeA9_9_WaterHeater_qty)
                {
                    Tooltip = 'Hvis der er vandvarme, hvor mange er der?';
                }
                field(TypeA9_9_Other1; TypeA9_9_Other1)
                {
                    Tooltip = 'Indeholder lejemålet andre hvidevarer eller andet?';
                }
                field(TypeA9_9_Other1Text; TypeA9_9_Other1Text)
                {
                    Tooltip = 'Beskrivelse af hvidevarer eller andet.';
                }
                field(TypeA9_9_Other2; TypeA9_9_Other2)
                {
                    Tooltip = 'Beskrivelse af hvidevarer eller andet.';
                }
                field(TypeA9_9_Other2Text; TypeA9_9_Other2Text)
                {
                    Tooltip = 'Beskrivelse af hvidevarer eller andet.';
                }
                field(TypeA9_9_Other3; TypeA9_9_Other3)
                {
                    Tooltip = 'Beskrivelse af hvidevarer eller andet.';
                }
                field(TypeA9_9_Other3Text; TypeA9_9_Other3Text)
                {
                    Tooltip = 'Beskrivelse af hvidevarer eller andet.';
                }
            }
            group("Paragraf 10")
            {
                Caption = 'Paragraph 10';
                field(TypeA9_10_TenRep; TypeA9_10_TenRep)
                {
                    Tooltip = 'Er der ved kontraktens indgåelse etableret beboerrepræsentation i ejendommen?';
                }
                field(TypeA9_10_LiveStock; TypeA9_10_LiveStock)
                {
                    Tooltip = 'Er det tilladt at holde husdyr i lejemålet?';
                }
                field(TypeA9_10_HouseRules; TypeA9_10_HouseRules)
                {
                    Tooltip = 'Foreligger der ved lejeforholdets indgåelse en husorden for ejendommen?';
                }
            }
        }
        area(factboxes)
        {
            systempart(Notes; Notes)
            {
            }
            systempart(Links; Links)
            {
            }
        }
    }

    actions
    {
        area(creation)
        {
            group(Handlinger)
            {
                Caption = 'Actions';
            }
            action(LeaseContract)
            {
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
                Caption = 'Move in journal';
                ToolTip = 'Making a journal for moving in costs';
                Image = Report;
                trigger Onaction();
                begin
                    CLEAR(Contract);
                    Contract.SETRANGE(Number, Rec.Number);
                    IF Contract.FindFirst() THEN begin
                        CLEAR(MoveInJournal);
                        MoveInJournal.SETTABLEVIEW(Contract);
                        MoveInJournal.RunModal;
                    END;
                end;
            }
            action(OccupantInvoiceIn)
            {
                Caption = 'Make Invoice moving in';
                ToolTip = 'Make invoice to customer for moving in costs';
                Image = report;

                trigger OnAction();
                begin
                    CLEAR(Occupant);
                    Occupant.SETRANGE(Number, Rec.Number);

                    IF Occupant.FINDFIRST() THEN BEGIN
                        //Dan ordrehoved

                        Salesheader.INIT;
                        Salesheader.VALIDATE("Document Type", Salesheader."Document Type"::Invoice);
                        Salesheader."No." := '';
                        Salesheader."Bill-to Customer No." := Occupant."Customer No";
                        Salesheader."Bill-to Name" := Occupant.Name1;
                        Salesheader."Bill-to Address" := Occupant.Address;
                        Salesheader."Bill-to Address 2" := Occupant.Address2;
                        Salesheader."Bill-to Post Code" := Occupant."Post Code";
                        Salesheader."Bill-to City" := Occupant.City;
                        Salesheader."Bill-to Country/Region Code" := Occupant."Country/Region Code";
                        Salesheader."Sell-to Customer No." := Occupant."Customer No";
                        Salesheader."Sell-to Customer Name" := Occupant.Name1;
                        Salesheader."Sell-to Address" := Occupant.Address;
                        Salesheader."Sell-to Address 2" := Occupant.Address2;
                        Salesheader."Sell-to Post Code" := Occupant."Post Code";
                        Salesheader."Sell-to City" := Occupant.City;
                        Salesheader."Sell-to Country/Region Code" := Occupant."Country/Region Code";
                        Salesheader."Posting Date" := TODAY;
                        Salesheader."SVA Included" := false;
                        Salesheader."SVA Occupant" := Occupant.Number;

                        CLEAR(Contract);
                        Contract.SETRANGE(Number, Occupant.Number);
                        IF Contract.FINDFIRST() THEN BEGIN
                            Salesheader."Due Date" := TypeA9_4_DueDate;
                        END;

                        cust.RESET;
                        cust.SETRANGE("Bill-to Customer No.", Occupant."Customer No");
                        IF cust.FINDFIRST() THEN BEGIN
                            Salesheader."Payment Terms Code" := cust."Payment Terms Code";
                            Salesheader."Currency Code" := cust."Currency Code";
                            Salesheader."Customer Posting Group" := cust."Customer Posting Group";
                        END;
                        Salesheader.INSERT(TRUE);
                    END;

                    //Med eller uden moms
                    CLEAR(Contract);
                    Contract.SETRANGE(Number, Occupant.Number);
                    IF Contract.FINDFIRST() THEN BEGIN
                        CostTypeEstate.RESET;
                        CostTypeEstate.SETRANGE(Type, 1);
                        IF CostTypeEstate.FINDFIRST() THEN BEGIN
                            Subscription.RESET;
                            Subscription.SETRANGE(Subscription."Cost Types", CostTypeEstate.Costtype);
                            IF CostTypeEstate.FINDFIRST() THEN
                                VatType := CostTypeEstate.VatGroup;
                        END;
                    END;

                    //Dan ordrelinjer
                    LineNo := 0;
                    CLEAR(Contract);
                    Contract.SETRANGE(Number, Occupant.Number);

                    IF Contract.FINDFIRST() THEN BEGIN
                        //Depositum
                        IF Contract.TypeA9_4_DepMth > 0 THEN BEGIN
                            SalesLine.INIT;
                            SalesLine.VALIDATE(SalesLine."Document Type", Salesheader."Document Type"::Invoice);
                            SalesLine."Line No." := LineNo + 1;
                            LineNo := LineNo + 1;
                            SalesLine.Type := 1;
                            SalesLine."Document No." := Salesheader."No.";
                            SalesLine.Quantity := Contract.TypeA9_4_DepMth;
                            SalesLine."Qty. to Ship" := SalesLine.Quantity;
                            SalesLine."Qty. to Invoice" := SalesLine.Quantity;
                            SalesLine."Unit Price" := Contract.TypeA9_4_DepAmount / Contract.TypeA9_4_DepMth;
                            SalesLine.Amount := Contract.TypeA9_4_DepAmount;
                            SalesLine."Line Amount" := Contract.TypeA9_4_DepAmount;
                            CostTypeEstate.RESET;
                            CostTypeEstate.SETRANGE(Type, 9);
                            CostTypeEstate.SETRANGE(VatGroup, VatType);
                            IF CostTypeEstate.FINDFIRST() THEN BEGIN
                                SalesLine."No." := CostTypeEstate.Account;
                                SalesLine.Description := CostTypeEstate.Description;
                                SalesLine."VAT Prod. Posting Group" := CostTypeEstate.VatGroup;
                                SalesLine."SVA Costtype" := CostTypeEstate.Costtype;
                            END;
                            LedAccount.RESET;
                            LedAccount.SETRANGE(LedAccount."No.", CostTypeEstate.Account);
                            IF LedAccount.FINDFIRST THEN BEGIN
                                SalesLine."Gen. Bus. Posting Group" := LedAccount."Gen. Bus. Posting Group";
                                SalesLine."Gen. Prod. Posting Group" := LedAccount."Gen. Prod. Posting Group";
                            END;

                            SalesLine.INSERT(TRUE);
                        END;
                        //Forudbetalt leje
                        IF Contract.TypeA9_4_PrepaidRentMth > 0 THEN BEGIN
                            SalesLine.INIT;
                            SalesLine.VALIDATE(SalesLine."Document Type", Salesheader."Document Type"::Invoice);
                            SalesLine."Line No." := LineNo + 1;
                            LineNo := LineNo + 1;
                            SalesLine.Type := 1;
                            SalesLine."Document No." := Salesheader."No.";
                            SalesLine.Quantity := Contract.TypeA9_4_PrepaidRentMth;
                            SalesLine."Qty. to Ship" := SalesLine.Quantity;
                            SalesLine."Qty. to Invoice" := SalesLine.Quantity;
                            SalesLine."Unit Price" := Contract.TypeA9_4_PrepaidRent / Contract.TypeA9_4_PrepaidRentMth;
                            SalesLine.Amount := Contract.TypeA9_4_PrepaidRent;
                            SalesLine."Line Amount" := Contract.TypeA9_4_PrepaidRent;
                            CostTypeEstate.RESET;
                            CostTypeEstate.SETRANGE(Type, 10);
                            CostTypeEstate.SETRANGE(VatGroup, VatType);
                            IF CostTypeEstate.FINDFIRST() THEN BEGIN
                                SalesLine."No." := CostTypeEstate.Account;
                                SalesLine.Description := CostTypeEstate.Description;
                                SalesLine."VAT Prod. Posting Group" := CostTypeEstate.VatGroup;
                                SalesLine."SVA Costtype" := CostTypeEstate.Costtype;
                            END;
                            LedAccount.RESET;
                            LedAccount.SETRANGE(LedAccount."No.", CostTypeEstate.Account);
                            IF LedAccount.FINDFIRST THEN BEGIN
                                SalesLine."Gen. Bus. Posting Group" := LedAccount."Gen. Bus. Posting Group";
                                SalesLine."Gen. Prod. Posting Group" := LedAccount."Gen. Prod. Posting Group";
                            END;

                            SalesLine.INSERT(TRUE);
                        END;
                        //Første måneds leje
                        IF Contract.TypeA9_3_RentPerPeriode > 0 THEN BEGIN
                            SalesLine.INIT;
                            SalesLine.VALIDATE(SalesLine."Document Type", Salesheader."Document Type"::Invoice);
                            SalesLine."Line No." := LineNo + 1;
                            LineNo := LineNo + 1;
                            SalesLine.Type := 1;
                            SalesLine."Document No." := Salesheader."No.";
                            SalesLine.Quantity := 1;
                            SalesLine."Qty. to Ship" := SalesLine.Quantity;
                            SalesLine."Qty. to Invoice" := SalesLine.Quantity;
                            SalesLine."Unit Price" := Contract.TypeA9_3_RentPerPeriode;
                            SalesLine.Amount := Contract.TypeA9_3_RentPerPeriode;
                            SalesLine."Line Amount" := Contract.TypeA9_3_RentPerPeriode;
                            Subscription.Reset;
                            Subscription.SetRange(Tenancies, Occupant.TenancyNo);
                            Subscription.SetRange(Type, 1); //husleje
                            IF Subscription.FindFirst() THEN begin
                                CostTypeEstate.RESET;
                                CostTypeEstate.SETRANGE(Costtype, Subscription."Cost Types");
                                IF CostTypeEstate.FINDFIRST() THEN BEGIN
                                    SalesLine."No." := CostTypeEstate.Account;
                                    SalesLine.Description := 'Leje ' + FORMAT(TypeA9_4_RentFrom) + ' til ' + FORMAT(TypeA9_4_RentTo);
                                    SalesLine."VAT Prod. Posting Group" := CostTypeEstate.VatGroup;
                                    SalesLine."SVA Costtype" := CostTypeEstate.Costtype;
                                END;
                            END;
                            LedAccount.RESET;
                            LedAccount.SETRANGE(LedAccount."No.", CostTypeEstate.Account);
                            IF LedAccount.FINDFIRST THEN BEGIN
                                SalesLine."Gen. Bus. Posting Group" := LedAccount."Gen. Bus. Posting Group";
                                SalesLine."Gen. Prod. Posting Group" := LedAccount."Gen. Prod. Posting Group";
                            END;

                            SalesLine.INSERT(TRUE);
                        END;
                        //ACVarme
                        IF Contract.TypeA9_3_ACHeat > 0 THEN BEGIN
                            SalesLine.INIT;
                            SalesLine.VALIDATE(SalesLine."Document Type", Salesheader."Document Type"::Invoice);
                            SalesLine."Line No." := LineNo + 1;
                            LineNo := LineNo + 1;
                            SalesLine.Type := 1;
                            SalesLine."Document No." := Salesheader."No.";
                            SalesLine.Quantity := 1;
                            SalesLine."Qty. to Ship" := SalesLine.Quantity;
                            SalesLine."Qty. to Invoice" := SalesLine.Quantity;
                            SalesLine."Unit Price" := Contract.TypeA9_3_ACHeat;
                            SalesLine.Amount := Contract.TypeA9_3_ACHeat;
                            SalesLine."Line Amount" := Contract.TypeA9_3_ACHeat;
                            CostTypeEstate.RESET;
                            CostTypeEstate.SETRANGE(Type, 2);
                            CostTypeEstate.SETRANGE(VatGroup, VatType);
                            IF CostTypeEstate.FINDFIRST() THEN BEGIN
                                SalesLine."No." := CostTypeEstate.Account;
                                SalesLine.Description := CostTypeEstate.Description;
                                SalesLine."VAT Prod. Posting Group" := CostTypeEstate.VatGroup;
                                SalesLine."SVA Costtype" := CostTypeEstate.Costtype;
                            END;
                            LedAccount.RESET;
                            LedAccount.SETRANGE(LedAccount."No.", CostTypeEstate.Account);
                            IF LedAccount.FINDFIRST THEN BEGIN
                                SalesLine."Gen. Bus. Posting Group" := LedAccount."Gen. Bus. Posting Group";
                                SalesLine."Gen. Prod. Posting Group" := LedAccount."Gen. Prod. Posting Group";
                            END;
                            SalesLine.INSERT(TRUE);
                        END;
                        //ACVand
                        IF Contract.TypeA9_3_ACWater > 0 THEN BEGIN
                            SalesLine.INIT;
                            SalesLine.VALIDATE(SalesLine."Document Type", Salesheader."Document Type"::Invoice);
                            SalesLine."Line No." := LineNo + 1;
                            LineNo := LineNo + 1;
                            SalesLine.Type := 1;
                            SalesLine."Document No." := Salesheader."No.";
                            SalesLine.Quantity := 1;
                            SalesLine."Qty. to Ship" := SalesLine.Quantity;
                            SalesLine."Qty. to Invoice" := SalesLine.Quantity;
                            SalesLine."Unit Price" := Contract.TypeA9_3_ACWater;
                            SalesLine.Amount := Contract.TypeA9_3_ACWater;
                            SalesLine."Line Amount" := Contract.TypeA9_3_ACWater;
                            CostTypeEstate.RESET;
                            CostTypeEstate.SETRANGE(Type, 3);
                            CostTypeEstate.SETRANGE(VatGroup, VatType);
                            IF CostTypeEstate.FINDFIRST() THEN BEGIN
                                SalesLine."No." := CostTypeEstate.Account;
                                SalesLine.Description := CostTypeEstate.Description;
                                SalesLine."VAT Prod. Posting Group" := CostTypeEstate.VatGroup;
                                SalesLine."SVA Costtype" := CostTypeEstate.Costtype;
                            END;
                            LedAccount.RESET;
                            LedAccount.SETRANGE(LedAccount."No.", CostTypeEstate.Account);
                            IF LedAccount.FINDFIRST THEN BEGIN
                                SalesLine."Gen. Bus. Posting Group" := LedAccount."Gen. Bus. Posting Group";
                                SalesLine."Gen. Prod. Posting Group" := LedAccount."Gen. Prod. Posting Group";
                            END;
                            SalesLine.INSERT(TRUE);
                        END;
                        //ACEl
                        IF Contract.TypeA9_3_ACElectricity > 0 THEN BEGIN
                            SalesLine.INIT;
                            SalesLine.VALIDATE(SalesLine."Document Type", Salesheader."Document Type"::Invoice);
                            SalesLine."Line No." := LineNo + 1;
                            LineNo := LineNo + 1;
                            SalesLine.Type := 1;
                            SalesLine."Document No." := Salesheader."No.";
                            SalesLine.Quantity := 1;
                            SalesLine."Qty. to Ship" := SalesLine.Quantity;
                            SalesLine."Qty. to Invoice" := SalesLine.Quantity;
                            SalesLine."Unit Price" := Contract.TypeA9_3_ACElectricity;
                            SalesLine.Amount := Contract.TypeA9_3_ACElectricity;
                            SalesLine."Line Amount" := Contract.TypeA9_3_ACElectricity;
                            CostTypeEstate.RESET;
                            CostTypeEstate.SETRANGE(Type, 4);
                            CostTypeEstate.SETRANGE(VatGroup, VatType);
                            IF CostTypeEstate.FINDFIRST() THEN BEGIN
                                SalesLine."No." := CostTypeEstate.Account;
                                SalesLine.Description := CostTypeEstate.Description;
                                SalesLine."VAT Prod. Posting Group" := CostTypeEstate.VatGroup;
                                SalesLine."SVA Costtype" := CostTypeEstate.Costtype;
                            END;
                            LedAccount.RESET;
                            LedAccount.SETRANGE(LedAccount."No.", CostTypeEstate.Account);
                            IF LedAccount.FINDFIRST THEN BEGIN
                                SalesLine."Gen. Bus. Posting Group" := LedAccount."Gen. Bus. Posting Group";
                                SalesLine."Gen. Prod. Posting Group" := LedAccount."Gen. Prod. Posting Group";
                            END;
                            SalesLine.INSERT(TRUE);
                        END;
                        //ACkøling
                        IF Contract.TypeA9_3_ACCooling > 0 THEN BEGIN
                            SalesLine.INIT;
                            SalesLine.VALIDATE(SalesLine."Document Type", Salesheader."Document Type"::Invoice);
                            SalesLine."Line No." := LineNo + 1;
                            LineNo := LineNo + 1;
                            SalesLine.Type := 1;
                            SalesLine."Document No." := Salesheader."No.";
                            SalesLine.Quantity := 1;
                            SalesLine."Qty. to Ship" := SalesLine.Quantity;
                            SalesLine."Qty. to Invoice" := SalesLine.Quantity;
                            SalesLine."Unit Price" := Contract.TypeA9_3_ACCooling;
                            SalesLine.Amount := Contract.TypeA9_3_ACCooling;
                            SalesLine."Line Amount" := Contract.TypeA9_3_ACCooling;
                            CostTypeEstate.RESET;
                            CostTypeEstate.SETRANGE(Type, 5);
                            CostTypeEstate.SETRANGE(VatGroup, VatType);
                            IF CostTypeEstate.FINDFIRST() THEN BEGIN
                                SalesLine."No." := CostTypeEstate.Account;
                                SalesLine.Description := CostTypeEstate.Description;
                                SalesLine."VAT Prod. Posting Group" := CostTypeEstate.VatGroup;
                                SalesLine."SVA Costtype" := CostTypeEstate.Costtype;
                            END;
                            LedAccount.RESET;
                            LedAccount.SETRANGE(LedAccount."No.", CostTypeEstate.Account);
                            IF LedAccount.FINDFIRST THEN BEGIN
                                SalesLine."Gen. Bus. Posting Group" := LedAccount."Gen. Bus. Posting Group";
                                SalesLine."Gen. Prod. Posting Group" := LedAccount."Gen. Prod. Posting Group";
                            END;
                            SalesLine.INSERT(TRUE);
                        END;
                        //Antenne
                        IF Contract.TypeA9_3_Antenna > 0 THEN BEGIN
                            SalesLine.INIT;
                            SalesLine.VALIDATE(SalesLine."Document Type", Salesheader."Document Type"::Invoice);
                            SalesLine."Line No." := LineNo + 1;
                            LineNo := LineNo + 1;
                            SalesLine.Type := 1;
                            SalesLine."Document No." := Salesheader."No.";
                            SalesLine.Quantity := 1;
                            SalesLine."Qty. to Ship" := SalesLine.Quantity;
                            SalesLine."Qty. to Invoice" := SalesLine.Quantity;
                            SalesLine."Unit Price" := Contract.TypeA9_3_Antenna;
                            SalesLine.Amount := Contract.TypeA9_3_Antenna;
                            SalesLine."Line Amount" := Contract.TypeA9_3_Antenna;
                            CostTypeEstate.RESET;
                            CostTypeEstate.SETRANGE(Type, 6);
                            CostTypeEstate.SETRANGE(VatGroup, VatType);
                            IF CostTypeEstate.FINDFIRST() THEN BEGIN
                                SalesLine."No." := CostTypeEstate.Account;
                                SalesLine.Description := CostTypeEstate.Description;
                                SalesLine."VAT Prod. Posting Group" := CostTypeEstate.VatGroup;
                                SalesLine."SVA Costtype" := CostTypeEstate.Costtype;
                            END;
                            LedAccount.RESET;
                            LedAccount.SETRANGE(LedAccount."No.", CostTypeEstate.Account);
                            IF LedAccount.FINDFIRST THEN BEGIN
                                SalesLine."Gen. Bus. Posting Group" := LedAccount."Gen. Bus. Posting Group";
                                SalesLine."Gen. Prod. Posting Group" := LedAccount."Gen. Prod. Posting Group";
                            END;
                            SalesLine.INSERT(TRUE);
                        END;
                        //Internet
                        IF Contract.TypeA9_3_Internet > 0 THEN BEGIN
                            SalesLine.INIT;
                            SalesLine.VALIDATE(SalesLine."Document Type", Salesheader."Document Type"::Invoice);
                            SalesLine."Line No." := LineNo + 1;
                            LineNo := LineNo + 1;
                            SalesLine.Type := 1;
                            SalesLine."Document No." := Salesheader."No.";
                            SalesLine.Quantity := 1;
                            SalesLine."Qty. to Ship" := SalesLine.Quantity;
                            SalesLine."Qty. to Invoice" := SalesLine.Quantity;
                            SalesLine."Unit Price" := Contract.TypeA9_3_Internet;
                            SalesLine.Amount := Contract.TypeA9_3_Internet;
                            SalesLine."Line Amount" := Contract.TypeA9_3_Internet;
                            CostTypeEstate.RESET;
                            CostTypeEstate.SETRANGE(Type, 7);
                            CostTypeEstate.SETRANGE(VatGroup, VatType);
                            IF CostTypeEstate.FINDFIRST() THEN BEGIN
                                SalesLine."No." := CostTypeEstate.Account;
                                SalesLine.Description := CostTypeEstate.Description;
                                SalesLine."VAT Prod. Posting Group" := CostTypeEstate.VatGroup;
                                SalesLine."SVA Costtype" := CostTypeEstate.Costtype;
                            END;
                            LedAccount.RESET;
                            LedAccount.SETRANGE(LedAccount."No.", CostTypeEstate.Account);
                            IF LedAccount.FINDFIRST THEN BEGIN
                                SalesLine."Gen. Bus. Posting Group" := LedAccount."Gen. Bus. Posting Group";
                                SalesLine."Gen. Prod. Posting Group" := LedAccount."Gen. Prod. Posting Group";
                            END;
                            SalesLine.INSERT(TRUE);
                        END;
                        //Beboerrepræsentation
                        IF Contract.TypeA9_3_TenantGroup > 0 THEN BEGIN
                            SalesLine.INIT;
                            SalesLine.VALIDATE(SalesLine."Document Type", Salesheader."Document Type"::Invoice);
                            SalesLine."Line No." := LineNo + 1;
                            LineNo := LineNo + 1;
                            SalesLine.Type := 1;
                            SalesLine."Document No." := Salesheader."No.";
                            SalesLine.Quantity := 1;
                            SalesLine."Qty. to Ship" := SalesLine.Quantity;
                            SalesLine."Qty. to Invoice" := SalesLine.Quantity;
                            SalesLine."Unit Price" := Contract.TypeA9_3_TenantGroup;
                            SalesLine.Amount := Contract.TypeA9_3_TenantGroup;
                            SalesLine."Line Amount" := Contract.TypeA9_3_TenantGroup;
                            CostTypeEstate.RESET;
                            CostTypeEstate.SETRANGE(Type, 8);
                            CostTypeEstate.SETRANGE(VatGroup, VatType);
                            IF CostTypeEstate.FINDFIRST() THEN BEGIN
                                SalesLine."No." := CostTypeEstate.Account;
                                SalesLine.Description := CostTypeEstate.Description;
                                SalesLine."VAT Prod. Posting Group" := CostTypeEstate.VatGroup;
                                SalesLine."SVA Costtype" := CostTypeEstate.Costtype;
                            END;
                            LedAccount.RESET;
                            LedAccount.SETRANGE(LedAccount."No.", CostTypeEstate.Account);
                            IF LedAccount.FINDFIRST THEN BEGIN
                                SalesLine."Gen. Bus. Posting Group" := LedAccount."Gen. Bus. Posting Group";
                                SalesLine."Gen. Prod. Posting Group" := LedAccount."Gen. Prod. Posting Group";
                            END;
                            SalesLine.INSERT(TRUE);
                        END;
                        //Andet 1
                        IF Contract.TypeA9_3_OtherAmount1 > 0 THEN BEGIN
                            SalesLine.INIT;
                            SalesLine.VALIDATE(SalesLine."Document Type", Salesheader."Document Type"::Invoice);
                            SalesLine."Line No." := LineNo + 1;
                            LineNo := LineNo + 1;
                            SalesLine.Type := 1;
                            SalesLine."Document No." := Salesheader."No.";
                            SalesLine.Quantity := 1;
                            SalesLine."Qty. to Ship" := SalesLine.Quantity;
                            SalesLine."Qty. to Invoice" := SalesLine.Quantity;
                            SalesLine."Unit Price" := Contract.TypeA9_3_OtherAmount1;
                            SalesLine.Amount := Contract.TypeA9_3_OtherAmount1;
                            SalesLine."Line Amount" := Contract.TypeA9_3_OtherAmount1;
                            CostTypeEstate.RESET;
                            CostTypeEstate.SETRANGE(Type, 1);
                            CostTypeEstate.SETRANGE(VatGroup, VatType);
                            IF CostTypeEstate.FINDFIRST() THEN BEGIN
                                SalesLine."No." := CostTypeEstate.Account;
                                SalesLine.Description := Contract.TypeA9_3_OtherText1;
                                SalesLine."VAT Prod. Posting Group" := CostTypeEstate.VatGroup;
                                SalesLine."SVA Costtype" := CostTypeEstate.Costtype;
                            END;
                            LedAccount.RESET;
                            LedAccount.SETRANGE(LedAccount."No.", CostTypeEstate.Account);
                            IF LedAccount.FINDFIRST THEN BEGIN
                                SalesLine."Gen. Bus. Posting Group" := LedAccount."Gen. Bus. Posting Group";
                                SalesLine."Gen. Prod. Posting Group" := LedAccount."Gen. Prod. Posting Group";
                            END;
                            SalesLine.INSERT(TRUE);
                        END;
                        //Andet 2
                        IF Contract.TypeA9_3_OtherAmount2 > 0 THEN BEGIN
                            SalesLine.INIT;
                            SalesLine.VALIDATE(SalesLine."Document Type", Salesheader."Document Type"::Invoice);
                            SalesLine."Line No." := LineNo + 1;
                            LineNo := LineNo + 1;
                            SalesLine.Type := 1;
                            SalesLine."Document No." := Salesheader."No.";
                            SalesLine.Quantity := 1;
                            SalesLine."Qty. to Ship" := SalesLine.Quantity;
                            SalesLine."Qty. to Invoice" := SalesLine.Quantity;
                            SalesLine."Unit Price" := Contract.TypeA9_3_OtherAmount2;
                            SalesLine.Amount := Contract.TypeA9_3_OtherAmount2;
                            SalesLine."Line Amount" := Contract.TypeA9_3_OtherAmount2;
                            CostTypeEstate.RESET;
                            CostTypeEstate.SETRANGE(Type, 1);
                            CostTypeEstate.SETRANGE(VatGroup, VatType);
                            IF CostTypeEstate.FINDFIRST() THEN BEGIN
                                SalesLine."No." := CostTypeEstate.Account;
                                SalesLine.Description := Contract.TypeA9_3_OtherText1;
                                SalesLine."VAT Prod. Posting Group" := CostTypeEstate.VatGroup;
                                SalesLine."SVA Costtype" := CostTypeEstate.Costtype;
                            END;
                            LedAccount.RESET;
                            LedAccount.SETRANGE(LedAccount."No.", CostTypeEstate.Account);
                            IF LedAccount.FINDFIRST THEN BEGIN
                                SalesLine."Gen. Bus. Posting Group" := LedAccount."Gen. Bus. Posting Group";
                                SalesLine."Gen. Prod. Posting Group" := LedAccount."Gen. Prod. Posting Group";
                            END;
                            SalesLine.INSERT(TRUE);
                        END;
                    END;

                    //Posting
                    CODEUNIT.RUN(CODEUNIT::"Sales-Post", Salesheader);

                    // Opret linjerne på beboer posteringer
                    Invoice.RESET;
                    Invoice.SETRANGE(Invoice."Posting Date", TODAY);
                    Invoice.SETRANGE(Invoice."Pre-Assigned No.", Salesheader."No.");
                    Invoice.SETRANGE(Invoice."SVA Occupant", Salesheader."SVA Occupant");
                    IF Invoice.FINDFIRST THEN
                        InvoiceLine.RESET;
                    InvoiceLine.SETRANGE(InvoiceLine."Document No.", Invoice."No.");
                    IF InvoiceLine.FIND('-') THEN
                        REPEAT
                              OcTrans.Occupant := Invoice."SVA Occupant";
                        OcTrans.Date := Invoice."Posting Date";
                        OcTrans."Cost type Estate" := InvoiceLine."SVA Costtype";
                        OcTrans."Invoice No" := InvoiceLine."Document No.";
                        OcTrans.Description := InvoiceLine.Description;
                        OcTrans.Qty := InvoiceLine.Quantity;
                        OcTrans.Price := InvoiceLine."Unit Price";
                        OcTrans.Amount := InvoiceLine.Amount;

                        CostTypeEstate.RESET;
                        CostTypeEstate.SETRANGE(Costtype, InvoiceLine."SVA Costtype");
                        IF CostTypeEstate.FINDFIRST() THEN BEGIN
                            OcTrans.Type := CostTypeEstate.Type;
                        END;
                        OcTrans.INSERT();
                        UNTIL InvoiceLine.NEXT = 0;

                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord();
    begin
        CurrPage.UPDATE;
    end;

    var
        Occupant: Record "SVA Occupant";
        Tenancy: Record "SVA Tenancy";
        Property: Record "SVA Property";
        Subscription: Record "SVA Subscription Lines";
        CompanyInfo: Record "Company Information";
        Customer: Record Customer;
        Contract: Record "SVA LeaseContract_A9";
        TypeA9: Report "SVA ContractTypeA9";
        MoveInJournal: Report "SVA Moving in Journal";
        Salesheader: Record "Sales header";
        LineNo: Integer;
        cust: Record Customer;
        SalesLine: Record "Sales Line";
        LedAccount: Record "G/L Account";
        CostTypeEstate: Record "SVA Cost type";
        Invoice: Record "Sales Invoice Header";
        InvoiceLine: Record "Sales Invoice Line";
        OcTrans: Record "SVA Occupant Trans";
        VatType: Code[10];
}

