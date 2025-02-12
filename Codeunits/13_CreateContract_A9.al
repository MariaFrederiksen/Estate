codeunit 50013 "SVA Create Contract A9"
{
    TableNo = "SVA Occupant";

    trigger OnRun()
    begin
        SVAOccupant.Copy(Rec);
        Rec := SVAOccupant;

        if SVAOccupant.StartDate = 0D then
            Error('Der skal indtastes startdato.');

        SVALeaseContractA9.Reset();
        SVALeaseContractA9.SetRange(Number, SVAOccupant.Number);
        if SVALeaseContractA9.Findfirst() then
            ;

        if not SVALeaseContractA9.Findfirst() then begin

            SVALeaseContractA9.Init();
            CompanyInformation.GET();
            SVALeaseContractA9.Number := SVAOccupant.Number;
            SVALeaseContractA9.TypeA9_1_Landlord := CompanyInformation.Name;
            SVALeaseContractA9.TypeA9_1_LandlordCVR := CompanyInformation."VAT Registration No.";
            IF CompanyInformation.Address <> '' then
                SVALeaseContractA9.TypeA9_1_LandlordAddress := CompanyInformation.Address + ', ' + CompanyInformation."Post Code" + ' ' + CompanyInformation.City;


            SVALeaseContractA9.TypeA9_1_TenentName := SVAOccupant.Name1 + ' ' + SVAOccupant.Name2;
            SVALeaseContractA9.TypeA9_1_TenantCPR := SVAOccupant.CPRno1 + ' ' + SVAOccupant.CPRno2;
            SVALeaseContractA9.TypeA9_1_Phone := SVAOccupant.CellPhone1 + ' ' + SVAOccupant.CellPhone2;
            SVALeaseContractA9.TypeA9_1_Mail := SVAOccupant.Email1 + ' ' + SVAOccupant.Email2;
            SVALeaseContractA9.TypeA9_2_Startdate := SVAOccupant.StartDate;
            SVALeaseContractA9.TypeA9_4_RentFirstTime := CALCDATE('<+1M>', SVAOccupant.StartDate);
            if (DATE2DMY(SVALeaseContractA9.TypeA9_2_Startdate, 1) > 13) AND (DATE2DMY(SVALeaseContractA9.TypeA9_2_Startdate, 1) < 17) then begin
                SVALeaseContractA9.TypeA9_4_RentFirstTime := CALCDATE('<+1M>', SVAOccupant.StartDate);
                Mnth := Date2DMY(SVALeaseContractA9.TypeA9_4_RentFirstTime, 2);
                Yr := Date2DMY(SVALeaseContractA9.TypeA9_4_RentFirstTime, 3);
                SVALeaseContractA9.TypeA9_4_RentFirstTime := DMY2Date((Date2DMY(SVALeaseContractA9.TypeA9_4_RentFirstTime, 1) - Date2DMY(SVALeaseContractA9.TypeA9_4_RentFirstTime, 1) + 1), Mnth, Yr);
            end;
            SetAmounts(SVAOccupant.Number);


            SVAProperty.Reset();
            SVAProperty.SETRANGE(Property, SVAOccupant.PropertyNo);
            IF SVAProperty.FINDFIRST() then begin
                SVALeaseContractA9.TypeA9_3_BankRegNo := SVAProperty.BankRegNo;
                SVALeaseContractA9.TypeA9_3_BankAccount := SVAProperty.Bankaccount;
                SVALeaseContractA9.TypeA9_3_Bankname := SVAProperty.Bankname;
                SVALeaseContractA9.TypeA9_3_TaxesPer := SVAProperty.TypeA9_3_Taxes;
                SVALeaseContractA9.TypeA9_5_WaterAccounting := FORMAT(SVAProperty.WaterYearFrom);
                SVALeaseContractA9.TypeA9_5_HeatAccounting := FORMAT(SVAProperty.HeatingYearFrom);
                SVALeaseContractA9.TypeA9_5_ElAccounting := FORMAT(SVAProperty.ElectricYearFrom);
            END;


            Customer.Reset();
            Customer.SETRANGE(Customer."No.", SVAOccupant."Customer No");
            IF Customer.FINDFIRST() THEN
                SVALeaseContractA9.TypeA9_1_TenentAddress := Customer.Address + ', ' + Customer."Post Code" + ' ' + Customer.City;

            IF SVALeaseContractA9.TypeA9_1_TenentAddress = '' then
                SVALeaseContractA9.TypeA9_1_TenentAddress := SVAOccupant.Address + ', ' + SVAOccupant."Post Code" + ' ' + SVAOccupant.City;

            IF SVALeaseContractA9.TypeA9_4_DueDate = 0D THEN
                SVALeaseContractA9.TypeA9_4_DueDate := TODAY + 8;

            SVATenancy.Reset();
            SVATenancy.SETRANGE(Number, SVAOccupant.TenancyNo);
            IF SVATenancy.FindSet() then begin
                SVALeaseContractA9.TypeA9_1_TenancyNo := SVATenancy.Number;
                SVALeaseContractA9.TypeA9_1_Address := SVATenancy.Address1;
                SVALeaseContractA9.TypeA9_1_City := SVATenancy."Post Code" + ' ' + SVATenancy.City;
                SVALeaseContractA9.TypeA9_3_DueDay := '1.';
                IF SVATenancy.Type = 0 then begin
                    //Boliglejemål
                    //§1                             
                    SVALeaseContractA9.TypeA9_1_Apartment := SVATenancy.TypeA9_1_Apartment;
                    SVALeaseContractA9.TypeA9_1_Room := SVATenancy.TypeA9_1_Room;
                    SVALeaseContractA9.TypeA9_1_Condominium := SVATenancy.TypeA9_1_Condominium;
                    SVALeaseContractA9.TypeA9_1_HousingCoop := SVATenancy.TypeA9_1_HousingCoop;
                    SVALeaseContractA9.TypeA9_1_Other := SVATenancy.TypeA9_1_Other;
                    SVALeaseContractA9.TypeA9_1_OtherTxt := SVATenancy.TypeA9_1_OtherTxt;
                    SVALeaseContractA9.TypeA9_1_AreaTotal := SVATenancy.AreaTotal;
                    SVALeaseContractA9.TypeA9_1_AreaProf := SVATenancy.AreaPro;
                    SVALeaseContractA9.TypeA9_1_Rooms := SVATenancy.Rooms;
                    SVALeaseContractA9.TypeA9_1_Laundy := SVATenancy.TypeA9_1_Laundy;
                    SVALeaseContractA9.TypeA9_1_BicycleStorage := SVATenancy.TypeA9_1_BicycleStorage;
                    SVALeaseContractA9.TypeA9_1_Courtyard := SVATenancy.TypeA9_1_Courtyard;
                    SVALeaseContractA9.TypeA9_1_Garage := SVATenancy.TypeA9_1_Garage;
                    SVALeaseContractA9.TypeA9_1_GarageNo := SVATenancy.TypeA9_1_GarageNo;
                    SVALeaseContractA9.TypeA9_1_Attic := SVATenancy.TypeA9_1_Attic;
                    SVALeaseContractA9.TypeA9_1_AtticNo := SVATenancy.TypeA9_1_AtticNo;
                    SVALeaseContractA9.TypeA9_1_OtherT := SVATenancy.TypeA9_1_OtherT;
                    SVALeaseContractA9.TypeA9_1_OtherTTxt := SVATenancy.TypeA9_1_OtherTTxt;
                    SVALeaseContractA9.TypeA9_1_Use := SVATenancy.TypeA9_1_Use;
                    IF SVATenancy.TypeA9_1_Use = '' THEN
                        SVALeaseContractA9.TypeA9_1_Use := 'Beboelse';


                    //§3
                    IF SVATenancy.PeriodYear = 0 then begin
                        SVALeaseContractA9.TypeA9_3_Monthly := TRUE;
                        SVALeaseContractA9.TypeA9_3_Quater := FALSE;
                    END;
                    IF SVATenancy.PeriodYear <> 0 then begin
                        SVALeaseContractA9.TypeA9_3_Monthly := FALSE;
                        SVALeaseContractA9.TypeA9_3_Quater := TRUE;
                    END;

                    //§4
                    SVALeaseContractA9.TypeA9_4_DepMth := SVATenancy.Deposit;
                    SVALeaseContractA9.TypeA9_4_PrepaidRentMth := SVATenancy.PrepaidRent;
                    SVALeaseContractA9.TypeA9_4_DepAmount := SVALeaseContractA9.TypeA9_3_RentPerYear / 12 * SVALeaseContractA9.TypeA9_4_DepMth;
                    SVALeaseContractA9.TypeA9_4_PrepaidRent := SVALeaseContractA9.TypeA9_3_RentPerYear / 12 * SVALeaseContractA9.TypeA9_4_PrepaidRentMth;
                    SVALeaseContractA9.TypeA9_4_RentFrom := SVAOccupant.StartDate;
                    SVALeaseContractA9.TypeA9_4_RentTo := CalcDate('<-1D>', SVALeaseContractA9.TypeA9_4_RentFirstTime);
                    IF SVALeaseContractA9.TypeA9_4_DueDate = 0D THEN
                        SVALeaseContractA9.TypeA9_4_DueDate := TODAY + 8;
                    //§5 - Varme
                    SVALeaseContractA9.TypeA9_5_LandlordHeat := SVATenancy.TypeA9_5_LandlordHeat;
                    SVALeaseContractA9.TypeA9_5_LandlorNatGas := SVATenancy.TypeA9_5_LNatgas;
                    SVALeaseContractA9.TypeA9_5_LandlordOil := SVATenancy.TypeA9_5_lOil;
                    SVALeaseContractA9.TypeA9_5_LandlordElHeating := SVATenancy.TypeA9_5_LElHeat;
                    SVALeaseContractA9.TypeA9_5_LandlordOther := SVATenancy.TypeA9_5_LOther;
                    SVALeaseContractA9.TypeA9_5_LandlordText := SVATenancy.TypeA9_5_LOtherText;

                    SVALeaseContractA9.TypeA9_5_TenantHeat := SVATenancy.TypeA9_5_TenantHeat;
                    SVALeaseContractA9.TypeA9_5_TenantEl := SVATenancy.TypeA9_5_TEl;
                    SVALeaseContractA9.TypeA9_5_TenantGas := SVATenancy.TypeA9_5_Tgas;
                    SVALeaseContractA9.TypeA9_5_TenantOil := SVATenancy.TypeA9_5_TOil;
                    SVALeaseContractA9.TypeA9_5_TenantNatGas := SVATenancy.TypeA9_5_TNatgas;
                    SVALeaseContractA9.TypeA9_5_TenOtherHeat := SVATenancy.TypeA9_5_TOTher;
                    SVALeaseContractA9.TypeA9_5_TenOtherText := SVATenancy.TypeA9_5_TOtherText;

                    //Vand
                    SVALeaseContractA9.TypeA9_5_LandlordWater := SVATenancy.TypeA9_5_LandlordWater;
                    SVALeaseContractA9.TypeA9_5_WaterMeter := SVATenancy.TypeA9_5_WaterMeter;
                    //El
                    SVALeaseContractA9.TypeA9_5_LandlordEl := SVATenancy.TypeA9_5_LandlordEl;
                    SVALeaseContractA9.TypeA9_5_TenantEl := SVATenancy.TypeA9_5_TEl;
                    //Køling
                    SVALeaseContractA9.TypeA9_5_LandlordCooling := SVATenancy.TypeA9_5_LandlordCooling;
                    SVALeaseContractA9.TypeA9_5_CoolingMeter := SVATenancy.TypeA9_5_CoolingMeter;
                    //§6
                    SVALeaseContractA9.TypeA9_6_AntennaLandlord := SVATenancy.TypeA9_6_AntennaLandlord;
                    SVALeaseContractA9.TypeA9_6_AntennaTenancies := SVATenancy.TypeA9_6_AntennaTenancies;
                    SVALeaseContractA9.TypeA9_6_Internet := SVATenancy.TypeA9_6_Internet;
                    //§7
                    SVALeaseContractA9.TypeA9_7_InspecionIn := SVATenancy.TypeA9_7_InspecionIn;
                    //§8
                    SVALeaseContractA9.TypeA9_8_MaintainceInsideLandl := SVATenancy.TypeA9_8_MaintainceInsideLandl;
                    SVALeaseContractA9.TypeA9_8_MaintainceInsideTenan := SVATenancy.TypeA9_8_MaintainceInsideTenan;
                    IF SVALeaseContractA9.TypeA9_8_MaintainceInsideLandl = TRUE then begin
                        SVALeaseContractA9.TypeA9_8_Date := SVATenancy.TypeA9_8_Date;
                        SVALeaseContractA9.TypeA9_8_Amount := SVATenancy.TypeA9_8_Amount;
                    END;
                    IF (SVALeaseContractA9.TypeA9_8_MaintainceInsideLandl = FALSE) AND (SVALeaseContractA9.TypeA9_8_MaintainceInsideTenan = FALSE) THEN
                        SVALeaseContractA9.TypeA9_8_MaintainceInsideTenan := TRUE;

                    //§9
                    SVALeaseContractA9.TypeA9_9_Stove := SVATenancy.TypeA9_9_Stove;
                    SVALeaseContractA9.TypeA9_9_Fridge := SVATenancy.TypeA9_9_Fridge;
                    SVALeaseContractA9.TypeA9_9_Freezer := SVATenancy.TypeA9_9_Freezer;
                    SVALeaseContractA9.TypeA9_9_dishwasher := SVATenancy.TypeA9_9_dishwasher;
                    SVALeaseContractA9.TypeA9_9_Washer := SVATenancy.TypeA9_9_Washer;
                    SVALeaseContractA9.TypeA9_9_Dryer := SVATenancy.TypeA9_9_Dryer;
                    SVALeaseContractA9.TypeA9_9_Hood := SVATenancy.TypeA9_9_Hood;
                    SVALeaseContractA9.TypeA9_9_ElectricPanels := SVATenancy.TypeA9_9_ElectricPanels;
                    SVALeaseContractA9.TypeA9_9_ElectricPanels_qty := SVATenancy.TypeA9_9_El_qty;
                    SVALeaseContractA9.TypeA9_9_WaterHeater := SVATenancy.TypeA9_9_WaterHeater;
                    SVALeaseContractA9.TypeA9_9_WaterHeater_qty := SVATenancy.TypeA9_9_WaterHeater_qty;
                    SVALeaseContractA9.TypeA9_9_Other1 := SVATenancy.TypeA9_9_Other1;
                    SVALeaseContractA9.TypeA9_9_Other2 := SVATenancy.TypeA9_9_Other2;
                    SVALeaseContractA9.TypeA9_9_Other3 := SVATenancy.TypeA9_9_Other3;
                    SVALeaseContractA9.TypeA9_9_Other1Text := SVATenancy.TypeA9_9_Other1Text;
                    SVALeaseContractA9.TypeA9_9_Other2Text := SVATenancy.TypeA9_9_Other2Text;
                    SVALeaseContractA9.TypeA9_9_Other3Text := SVATenancy.TypeA9_9_Other3Text;
                    //§0
                    SVALeaseContractA9.TypeA9_10_TenRep := SVATenancy.TypeA9_10_TenRep;
                    SVALeaseContractA9.TypeA9_10_LiveStock := SVATenancy.TypeA9_10_LiveStock;
                    SVALeaseContractA9.TypeA9_10_HouseRules := SVATenancy.TypeA9_10_HouseRules;
                END; //boliglejemål.

                IF SVATenancy.Type = 1 then begin //Erhvervslejemål - i praksis garager.
                                                  //§
                    SVALeaseContractA9.TypeA9_1_GarageNo := SVATenancy.TypeA9_1_GarageNo;
                    //§3
                    IF SVATenancy.PeriodYear = 0 then begin
                        SVALeaseContractA9.TypeA9_3_Monthly := TRUE;
                        SVALeaseContractA9.TypeA9_3_Quater := FALSE;
                    END;
                    IF SVATenancy.PeriodYear = 1 then begin
                        SVALeaseContractA9.TypeA9_3_Monthly := FALSE;
                        SVALeaseContractA9.TypeA9_3_Quater := TRUE;
                    END;
                    //§4
                    SVALeaseContractA9.TypeA9_4_DepMth := SVATenancy.Deposit;
                    SVALeaseContractA9.TypeA9_4_PrepaidRentMth := SVATenancy.PrepaidRent;
                    SVALeaseContractA9.TypeA9_4_DepAmount := SVALeaseContractA9.TypeA9_3_RentPerYear / 12 * SVALeaseContractA9.TypeA9_4_DepMth;
                    SVALeaseContractA9.TypeA9_4_PrepaidRent := SVALeaseContractA9.TypeA9_3_RentPerYear / 12 * SVALeaseContractA9.TypeA9_4_PrepaidRentMth;
                    SVALeaseContractA9.TypeA9_4_RentFrom := SVAOccupant.StartDate;
                    SVALeaseContractA9.TypeA9_4_RentTo := CalcDate('<-1D>', SVALeaseContractA9.TypeA9_4_RentFirstTime);
                    IF SVALeaseContractA9.TypeA9_4_DueDate = 0D THEN
                        SVALeaseContractA9.TypeA9_4_DueDate := TODAY + 8;
                END; //erhvervslejemål - i praksis garager
                SetBoolean();
                MoveInAmount();
                PeriodAmount();
                SetDate();
                SetHeat();
            END; //Lejemål
            if not SVALeaseContractA9.Insert() then
                SVALeaseContractA9.Modify();
        end;
    end;


    var
        SVALeaseContractA9: Record "SVA LeaseContract_A9";
        SVAOccupant: Record "SVA Occupant";
        SVATenancy: Record "SVA Tenancy";
        Customer: Record "Customer";
        CompanyInformation: Record "Company Information";
        SVAProperty: Record "SVA Property";
        SVASubscriptionLines: Record "SVA Subscription Lines";
        SVAParameters: Record "SVA Parameters";
        SVACosttype: Record "SVA Cost type";
        Mnth: Integer;
        Yr: Integer;
        Days: Integer;



    local procedure SetBoolean();
    begin
        IF SVALeaseContractA9.TypeA9_1_Apartment = TRUE THEN
            SVALeaseContractA9.TextT9_1_Apartment := 'X'
        ELSE
            SVALeaseContractA9.TextT9_1_Apartment := ' ';

        IF SVALeaseContractA9.TypeA9_1_Room = TRUE THEN
            SVALeaseContractA9.TextT9_1_Room := 'X'
        ELSE
            SVALeaseContractA9.TextT9_1_Room := ' ';

        IF SVALeaseContractA9.TypeA9_1_Condominium = TRUE THEN
            SVALeaseContractA9.TextT9_1_Condominium := 'X'
        ELSE
            SVALeaseContractA9.TextT9_1_Condominium := ' ';

        IF SVALeaseContractA9.TypeA9_1_HousingCoop = TRUE THEN
            SVALeaseContractA9.TextT9_1_HousingCoop := 'X'
        ELSE
            SVALeaseContractA9.TextT9_1_HousingCoop := ' ';

        IF SVALeaseContractA9.TypeA9_1_OtherT = TRUE THEN
            SVALeaseContractA9.TextT9_1_OtherT := 'X'
        ELSE
            SVALeaseContractA9.TextT9_1_OtherT := ' ';

        IF SVALeaseContractA9.TypeA9_1_Sublease = TRUE THEN
            SVALeaseContractA9.TextT9_1_Sublease := 'X'
        ELSE
            SVALeaseContractA9.TextT9_1_Sublease := ' ';

        IF SVALeaseContractA9.TypeA9_1_Laundy = TRUE THEN
            SVALeaseContractA9.TextT9_1_Laundy := 'X'
        ELSE
            SVALeaseContractA9.TextT9_1_Laundy := ' ';

        IF SVALeaseContractA9.TypeA9_1_Courtyard = TRUE THEN
            SVALeaseContractA9.TextT9_1_Courtyard := 'X'
        ELSE
            SVALeaseContractA9.TextT9_1_Courtyard := ' ';

        IF SVALeaseContractA9.TypeA9_1_BicycleStorage = TRUE THEN
            SVALeaseContractA9.TextT9_1_BicycleStorage := 'X'
        ELSE
            SVALeaseContractA9.TextT9_1_BicycleStorage := ' ';

        IF SVALeaseContractA9.TypeA9_1_Garage = TRUE THEN
            SVALeaseContractA9.TextT9_1_Garage := 'X'
        ELSE
            SVALeaseContractA9.TextT9_1_Garage := ' ';

        IF SVALeaseContractA9.TypeA9_1_Attic = TRUE THEN
            SVALeaseContractA9.TextT9_1_Attic := 'X'
        ELSE
            SVALeaseContractA9.TextT9_1_Attic := ' ';

        IF SVALeaseContractA9.TypeA9_1_Other = TRUE THEN
            SVALeaseContractA9.TextT9_1_Other := 'X'
        ELSE
            SVALeaseContractA9.TextT9_1_Other := ' ';

        IF SVALeaseContractA9.TypeA9_3_Monthly = TRUE THEN
            SVALeaseContractA9.TextT9_3_Monthly := 'X'
        ELSE
            SVALeaseContractA9.TextT9_3_Monthly := ' ';

        IF SVALeaseContractA9.TypeA9_3_Quater = TRUE THEN
            SVALeaseContractA9.TextT9_3_Quater := 'X'
        ELSE
            SVALeaseContractA9.TextT9_3_Quater := ' ';

        IF SVALeaseContractA9.TypeA9_5_LandlordHeat = TRUE then begin
            SVALeaseContractA9.TextT9_5_LandlordHeatYes := 'X';
            SVALeaseContractA9.TextT9_5_LandlordHeatNo := ' ';
        END
        ELSE BEGIN
            SVALeaseContractA9.TextT9_5_LandlordHeatYes := ' ';
            SVALeaseContractA9.TextT9_5_LandlordHeatNo := 'X';
        END;

        IF SVALeaseContractA9.TypeA9_5_LandlorNatGas = TRUE THEN
            SVALeaseContractA9.TextT9_5_NatGasLandlord := 'X'
        ELSE
            SVALeaseContractA9.TextT9_5_NatGasLandlord := ' ';

        IF SVALeaseContractA9.TypeA9_5_LandlordOil = TRUE THEN
            SVALeaseContractA9.TextT9_5_LandlordOil := 'X'
        ELSE
            SVALeaseContractA9.TextT9_5_LandlordOil := ' ';

        IF SVALeaseContractA9.TypeA9_5_LandlordElHeating = TRUE THEN
            SVALeaseContractA9.TextT9_5_LandlordElHeating := 'X'
        ELSE
            SVALeaseContractA9.TextT9_5_LandlordElHeating := ' ';

        IF SVALeaseContractA9.TypeA9_5_LandlordOther = TRUE THEN
            SVALeaseContractA9.TextT9_5_Other := 'X'
        ELSE
            SVALeaseContractA9.TextT9_5_Other := ' ';

        IF SVALeaseContractA9.TypeA9_5_TenantHeat = TRUE then begin
            SVALeaseContractA9.TextT9_5_TenantHeatYes := 'X';
            SVALeaseContractA9.TextT9_5_TenantHeatNo := ' ';
        END
        ELSE BEGIN
            SVALeaseContractA9.TextT9_5_TenantHeatYes := ' ';
            SVALeaseContractA9.TextT9_5_TenantHeatNo := 'X';
        END;

        IF SVALeaseContractA9.TypeA9_5_TenantEl = TRUE THEN
            SVALeaseContractA9.TextT9_5_El := 'X'
        ELSE
            SVALeaseContractA9.TextT9_5_El := ' ';

        IF SVALeaseContractA9.TypeA9_5_TenantGas = TRUE THEN
            SVALeaseContractA9.TextT9_5_Gas := 'X'
        ELSE
            SVALeaseContractA9.TextT9_5_Gas := ' ';

        IF SVALeaseContractA9.TypeA9_5_TenantOil = TRUE THEN
            SVALeaseContractA9.TextT9_5_Oil := 'X'
        ELSE
            SVALeaseContractA9.TextT9_5_Oil := ' ';

        IF SVALeaseContractA9.TypeA9_5_TenantNatGas = TRUE THEN
            SVALeaseContractA9.TextT9_5_NatGas := 'X'
        ELSE
            SVALeaseContractA9.TextT9_5_NatGas := ' ';

        IF SVALeaseContractA9.TypeA9_5_TenOtherHeat = TRUE THEN
            SVALeaseContractA9.TextT9_5_OtherHeat := 'X'
        ELSE
            SVALeaseContractA9.TextT9_5_OtherHeat := ' ';

        IF SVALeaseContractA9.TypeA9_5_LandlordWater = TRUE then begin
            SVALeaseContractA9.TextT9_5_LandlordWaterYes := 'X';
            SVALeaseContractA9.TextT9_5_LandlordWaterNo := ' ';
        END
        ELSE BEGIN
            SVALeaseContractA9.TextT9_5_LandlordWaterYes := ' ';
            SVALeaseContractA9.TextT9_5_LandlordWaterNo := 'X';
        END;

        IF SVALeaseContractA9.TypeA9_5_WaterMeter = TRUE then begin
            SVALeaseContractA9.TextT9_5_WaterMeterYes := 'X';
            SVALeaseContractA9.TextT9_5_WaterMeterNo := ' ';
        END
        ELSE BEGIN
            SVALeaseContractA9.TextT9_5_WaterMeterYes := ' ';
            SVALeaseContractA9.TextT9_5_WaterMeterNo := 'X';
        END;

        IF SVALeaseContractA9.TypeA9_5_LandlordEl = TRUE then begin
            SVALeaseContractA9.TextT9_5_LandlordElYes := 'X';
            SVALeaseContractA9.TextT9_5_LandlordElNo := ' ';
        END
        ELSE BEGIN
            SVALeaseContractA9.TextT9_5_LandlordElYes := ' ';
            SVALeaseContractA9.TextT9_5_LandlordElNo := 'X';
        END;

        IF SVALeaseContractA9.TypeA9_5_LandlordCooling = TRUE then begin
            SVALeaseContractA9.TextT9_5_LandlordCoolingYes := 'X';
            SVALeaseContractA9.TextT9_5_LandlordCoolingNo := ' ';
        END
        ELSE BEGIN
            SVALeaseContractA9.TextT9_5_LandlordCoolingYes := ' ';
            SVALeaseContractA9.TextT9_5_LandlordCoolingNo := 'X';
        END;

        IF SVALeaseContractA9.TypeA9_5_CoolingMeter = TRUE then begin
            SVALeaseContractA9.TextT9_5_CoolingMeterYes := 'X';
            SVALeaseContractA9.TextT9_5_CoolingMeterNo := ' ';
        END
        ELSE BEGIN
            SVALeaseContractA9.TextT9_5_CoolingMeterYes := ' ';
            SVALeaseContractA9.TextT9_5_CoolingMeterNo := 'X';
        END;

        IF SVALeaseContractA9.TypeA9_6_AntennaLandlord = TRUE then begin
            SVALeaseContractA9.TextT9_6_AntennaLandlordYes := 'X';
            SVALeaseContractA9.TextT9_6_AntennaLandlordNo := ' ';
        END
        ELSE BEGIN
            SVALeaseContractA9.TextT9_6_AntennaLandlordYes := ' ';
            SVALeaseContractA9.TextT9_6_AntennaLandlordNo := 'X';
        END;

        IF SVALeaseContractA9.TypeA9_6_AntennaTenancies = TRUE then begin
            SVALeaseContractA9.TextT9_6_AntennaTenanciesYes := 'X';
            SVALeaseContractA9.TextT9_6_AntennaTenanciesNo := ' ';
        END
        ELSE BEGIN
            SVALeaseContractA9.TextT9_6_AntennaTenanciesYes := ' ';
            SVALeaseContractA9.TextT9_6_AntennaTenanciesNo := 'X';
        END;

        IF SVALeaseContractA9.TypeA9_6_AntennaTenancies = TRUE then begin
            SVALeaseContractA9.TextT9_6_AntennaTenanciesYes := 'X';
            SVALeaseContractA9.TextT9_6_AntennaTenanciesNo := ' ';
        END
        ELSE BEGIN
            SVALeaseContractA9.TextT9_6_AntennaTenanciesYes := ' ';
            SVALeaseContractA9.TextT9_6_AntennaTenanciesNo := 'X';
        END;

        IF SVALeaseContractA9.TypeA9_6_Internet = TRUE then begin
            SVALeaseContractA9.TextT9_6_InternetYes := 'X';
            SVALeaseContractA9.TextT9_6_InternetNo := ' ';
        END
        ELSE BEGIN
            SVALeaseContractA9.TextT9_6_InternetYes := ' ';
            SVALeaseContractA9.TextT9_6_InternetNo := 'X';
        END;

        IF SVALeaseContractA9.TypeA9_7_InspecionIn = TRUE then begin
            SVALeaseContractA9.TextT9_7_InspectionInYes := 'X';
            SVALeaseContractA9.TextT9_7_InspectionInNo := ' ';
        END
        ELSE BEGIN
            SVALeaseContractA9.TextT9_7_InspectionInYes := ' ';
            SVALeaseContractA9.TextT9_7_InspectionInNo := 'X';
        END;

        IF SVALeaseContractA9.TypeA9_8_MaintainceInsideTenan = TRUE THEN
            SVALeaseContractA9.TextT9_8_MaintainceInsideTenan := 'X'
        ELSE
            SVALeaseContractA9.TextT9_8_MaintainceInsideTenan := ' ';

        IF SVALeaseContractA9.TypeA9_8_MaintainceInsideLandl = TRUE THEN
            SVALeaseContractA9.TextT9_8_MaintainceInsideLandl := 'X'
        ELSE
            SVALeaseContractA9.TextT9_8_MaintainceInsideLandl := ' ';

        IF SVALeaseContractA9.TypeA9_9_Stove = TRUE THEN
            SVALeaseContractA9.TextT9_9_Stove := 'X'
        ELSE
            SVALeaseContractA9.TextT9_9_Stove := ' ';

        IF SVALeaseContractA9.TypeA9_9_Fridge = TRUE THEN
            SVALeaseContractA9.TextT9_9_Fridge := 'X'
        ELSE
            SVALeaseContractA9.TextT9_9_Fridge := ' ';

        IF SVALeaseContractA9.TypeA9_9_Freezer = TRUE THEN
            SVALeaseContractA9.TextT9_9_Freezer := 'X'
        ELSE
            SVALeaseContractA9.TextT9_9_Freezer := '  ';

        IF SVALeaseContractA9.TypeA9_9_dishwasher = TRUE THEN
            SVALeaseContractA9.TextT9_9_dishwasher := 'X'
        ELSE
            SVALeaseContractA9.TextT9_9_dishwasher := ' ';

        IF SVALeaseContractA9.TypeA9_9_Washer = TRUE THEN
            SVALeaseContractA9.TextT9_9_Washer := 'X'
        ELSE
            SVALeaseContractA9.TextT9_9_Washer := ' ';

        IF SVALeaseContractA9.TypeA9_9_Dryer = TRUE THEN
            SVALeaseContractA9.TextT9_9_Dryer := 'X'
        ELSE
            SVALeaseContractA9.TextT9_9_Dryer := ' ';

        IF SVALeaseContractA9.TypeA9_9_Hood = TRUE THEN
            SVALeaseContractA9.TextT9_9_Hood := 'X'
        ELSE
            SVALeaseContractA9.TextT9_9_Hood := ' ';

        IF SVALeaseContractA9.TypeA9_9_ElectricPanels = TRUE THEN
            SVALeaseContractA9.TextT9_9_ElectricPanels := 'X'
        ELSE
            SVALeaseContractA9.TextT9_9_ElectricPanels := ' ';

        IF SVALeaseContractA9.TypeA9_9_WaterHeater = TRUE THEN
            SVALeaseContractA9.TextT9_9_WaterHeater := 'X'
        ELSE
            SVALeaseContractA9.TextT9_9_WaterHeater := ' ';

        IF SVALeaseContractA9.TypeA9_9_Other1 = TRUE THEN
            SVALeaseContractA9.TextT9_9_Other1 := 'X'
        ELSE
            SVALeaseContractA9.TextT9_9_Other1 := ' ';

        IF SVALeaseContractA9.TypeA9_9_Other2 = TRUE THEN
            SVALeaseContractA9.TextT9_9_Other2 := 'X'
        ELSE
            SVALeaseContractA9.TextT9_9_Other2 := ' ';

        IF SVALeaseContractA9.TypeA9_9_Other3 = TRUE THEN
            SVALeaseContractA9.TextT9_9_Other3 := 'X'
        ELSE
            SVALeaseContractA9.TextT9_9_Other3 := ' ';

        IF SVALeaseContractA9.TypeA9_10_TenRep = TRUE then begin
            SVALeaseContractA9.TextT9_10_TenRepYes := 'X';
            SVALeaseContractA9.TextT9_10_TenRepNo := ' ';
        END
        ELSE BEGIN
            SVALeaseContractA9.TextT9_10_TenRepYes := ' ';
            SVALeaseContractA9.TextT9_10_TenRepNo := 'X';
        END;

        IF SVALeaseContractA9.TypeA9_10_LiveStock = TRUE then begin
            SVALeaseContractA9.TextT9_10_LiveStockYes := 'X';
            SVALeaseContractA9.TextT9_10_LiveStockNo := ' ';
        END
        ELSE BEGIN
            SVALeaseContractA9.TextT9_10_LiveStockYes := ' ';
            SVALeaseContractA9.TextT9_10_LiveStockNo := 'X';
        END;

        IF SVALeaseContractA9.TypeA9_10_HouseRules = TRUE then begin
            SVALeaseContractA9.TextT9_10_HouseRulesYes := 'X';
            SVALeaseContractA9.TextT9_10_HouseRulesNo := ' ';
        END
        ELSE BEGIN
            SVALeaseContractA9.TextT9_10_HouseRulesYes := ' ';
            SVALeaseContractA9.TextT9_10_HouseRulesNo := 'X';
        END;
    end;

    local procedure SetDate();
    begin
        SVALeaseContractA9.TextT9_2_Date := FORMAT(SVALeaseContractA9.TypeA9_2_Startdate);
        SVALeaseContractA9.TextT9_3_Taxes := Format(SVALeaseContractA9.TypeA9_3_TaxesPer);
        SVALeaseContractA9.TextT9_4_DueDate := FORMAT(SVALeaseContractA9.TypeA9_4_DueDate);
        SVALeaseContractA9.TextT9_4_PrepaidrentDate := FORMAT(SVALeaseContractA9.TypeA9_4_PrepaidRentDate);
        SVALeaseContractA9.TextT9_4_RentFrom := FORMAT(SVALeaseContractA9.TypeA9_4_RentFrom);
        SVALeaseContractA9.TextT9_4_RentTo := FORMAT(SVALeaseContractA9.TypeA9_4_RentTo);
        SVALeaseContractA9.TextT9_4_RentFirstTime := FORMAT(SVALeaseContractA9.TypeA9_4_RentFirstTime);
    end;

    local procedure MoveInAmount();
    begin
        SVALeaseContractA9.TypeA9_4_DepAmount := SVALeaseContractA9.TypeA9_4_DepMth * SVALeaseContractA9.TypeA9_3_RentPerYear / 12;
        SVALeaseContractA9.TypeA9_4_Depositum := SVALeaseContractA9.TypeA9_4_DepMth * SVALeaseContractA9.TypeA9_3_RentPerYear / 12;
        SVALeaseContractA9.TypeA9_4_PrepaidRent := SVALeaseContractA9.TypeA9_4_PrepaidRentMth * SVALeaseContractA9.TypeA9_3_RentPerYear / 12;
        SVALeaseContractA9.TypeA9_4_TotalAmount := 0;
        SVALeaseContractA9.TypeA9_4_DueAmount := 0;
        SVALeaseContractA9.TypeA9_4_TotalAmount := SVALeaseContractA9.TypeA9_4_PrepaidRent + SVALeaseContractA9.TypeA9_4_DepAmount + SVALeaseContractA9.TypeA9_4_Rentetc + SVALeaseContractA9.TypeA9_4_Amount1 + SVALeaseContractA9.TypeA9_4_Amount2 + SVALeaseContractA9.TypeA9_4_Amount3;
        SVALeaseContractA9.TypeA9_4_DueAmount := SVALeaseContractA9.TypeA9_4_TotalAmount;
    end;

    local procedure PeriodAmount();
    begin
        SVALeaseContractA9.TypeA9_3_TotalperPeriod := 0;
        SVALeaseContractA9.TypeA9_3_TotalperPeriod := SVALeaseContractA9.TypeA9_3_RentPerPeriode
                                  + SVALeaseContractA9.TypeA9_3_ACHeat
                                  + SVALeaseContractA9.TypeA9_3_ACWater
                                  + SVALeaseContractA9.TypeA9_3_ACElectricity
                                  + SVALeaseContractA9.TypeA9_3_ACCooling
                                  + SVALeaseContractA9.TypeA9_3_Antenna
                                  + SVALeaseContractA9.TypeA9_3_Internet
                                  + SVALeaseContractA9.TypeA9_3_TenantGroup
                                  + SVALeaseContractA9.TypeA9_3_OtherAmount1
                                  + SVALeaseContractA9.TypeA9_3_OtherAmount2;

        SVALeaseContractA9.TypeA9_4_Rentetc := SVALeaseContractA9.TypeA9_3_TotalperPeriod;
        if (DATE2DMY(SVALeaseContractA9.TypeA9_2_Startdate, 1) > 1) AND (DATE2DMY(SVALeaseContractA9.TypeA9_2_Startdate, 1) < 32) then begin
            SVAParameters.Reset();
            if SVAParameters.FindFirst() then begin
                if SVAParameters.Splitcalc = false then
                    SVALeaseContractA9.TypeA9_4_Rentetc := SVALeaseContractA9.TypeA9_3_TotalperPeriod / 2;
                if SVAParameters.Splitcalc = true then begin
                    Days := CalcDate('<1M-1D>', SVALeaseContractA9.TypeA9_2_Startdate) - SVALeaseContractA9.TypeA9_2_Startdate + 1;//qty of days in monht SVALeaseContractA9.TypeA9_"_Startdate
                    SVALeaseContractA9.TypeA9_4_Rentetc := SVALeaseContractA9.TypeA9_3_TotalperPeriod * ((Days - Date2DMY(SVALeaseContractA9.TypeA9_2_Startdate, 1) + 1) / Days);
                end;
            end;
        end;
    end;

    local procedure SetHeat();
    begin
        IF SVALeaseContractA9.TypeA9_5_TenantEl = TRUE then begin
            SVALeaseContractA9.TypeA9_5_TenantHeat := TRUE;
            SVALeaseContractA9.TypeA9_5_TenantGas := FALSE;
            SVALeaseContractA9.TypeA9_5_TenantNatGas := FALSE;
            SVALeaseContractA9.TypeA9_5_TenantOil := FALSE;
            SVALeaseContractA9.TypeA9_5_LandlordHeat := FALSE;
            SVALeaseContractA9.TypeA9_5_LandlordElHeating := FALSE;
            SVALeaseContractA9.TypeA9_5_LandlordOil := FALSE;
            SVALeaseContractA9.TypeA9_5_LandlorNatGas := FALSE;
            SVALeaseContractA9.TypeA9_5_LandlordOther := FALSE;
            SVALeaseContractA9.TypeA9_5_LandlordText := '';
        END;
        IF SVALeaseContractA9.TypeA9_5_TenantGas = TRUE then begin
            SVALeaseContractA9.TypeA9_5_TenantHeat := TRUE;
            SVALeaseContractA9.TypeA9_5_TenantEl := FALSE;
            SVALeaseContractA9.TypeA9_5_TenantNatGas := FALSE;
            SVALeaseContractA9.TypeA9_5_TenantOil := FALSE;
            SVALeaseContractA9.TypeA9_5_LandlordHeat := FALSE;
            SVALeaseContractA9.TypeA9_5_LandlordElHeating := FALSE;
            SVALeaseContractA9.TypeA9_5_LandlordOil := FALSE;
            SVALeaseContractA9.TypeA9_5_LandlorNatGas := FALSE;
            SVALeaseContractA9.TypeA9_5_LandlordOther := FALSE;
            SVALeaseContractA9.TypeA9_5_LandlordText := '';
        END;
        IF SVALeaseContractA9.TypeA9_5_TenantNatGas = TRUE then begin
            SVALeaseContractA9.TypeA9_5_TenantHeat := TRUE;
            SVALeaseContractA9.TypeA9_5_TenantEl := FALSE;
            SVALeaseContractA9.TypeA9_5_TenantGas := FALSE;
            SVALeaseContractA9.TypeA9_5_TenantOil := FALSE;
            SVALeaseContractA9.TypeA9_5_LandlordHeat := FALSE;
            SVALeaseContractA9.TypeA9_5_LandlordElHeating := FALSE;
            SVALeaseContractA9.TypeA9_5_LandlordOil := FALSE;
            SVALeaseContractA9.TypeA9_5_LandlorNatGas := FALSE;
            SVALeaseContractA9.TypeA9_5_LandlordOther := FALSE;
            SVALeaseContractA9.TypeA9_5_LandlordText := '';
        END;
        IF SVALeaseContractA9.TypeA9_5_TenantOil = TRUE then begin
            SVALeaseContractA9.TypeA9_5_TenantHeat := TRUE;
            SVALeaseContractA9.TypeA9_5_LandlordHeat := FALSE;
            SVALeaseContractA9.TypeA9_5_TenantEl := FALSE;
            SVALeaseContractA9.TypeA9_5_TenantGas := FALSE;
            SVALeaseContractA9.TypeA9_5_TenantNatGas := FALSE;
            SVALeaseContractA9.TypeA9_5_LandlordHeat := FALSE;
            SVALeaseContractA9.TypeA9_5_LandlordElHeating := FALSE;
            SVALeaseContractA9.TypeA9_5_LandlordOil := FALSE;
            SVALeaseContractA9.TypeA9_5_LandlorNatGas := FALSE;
            SVALeaseContractA9.TypeA9_5_LandlordOther := FALSE;
            SVALeaseContractA9.TypeA9_5_LandlordText := '';
        END;

        IF SVALeaseContractA9.TypeA9_5_LandlordElHeating = TRUE then begin
            SVALeaseContractA9.TypeA9_5_LandlordHeat := TRUE;
            SVALeaseContractA9.TypeA9_5_LandlordOil := FALSE;
            SVALeaseContractA9.TypeA9_5_LandlorNatGas := FALSE;
            SVALeaseContractA9.TypeA9_5_TenantHeat := FALSE;
            SVALeaseContractA9.TypeA9_5_TenantEl := FALSE;
            SVALeaseContractA9.TypeA9_5_TenantGas := FALSE;
            SVALeaseContractA9.TypeA9_5_TenantNatGas := FALSE;
            SVALeaseContractA9.TypeA9_5_TenantOil := FALSE;
            SVALeaseContractA9.TypeA9_5_TenOtherHeat := FALSE;
            SVALeaseContractA9.TypeA9_5_TenOtherText := '';
        END;
        IF SVALeaseContractA9.TypeA9_5_LandlordOil = TRUE then begin
            SVALeaseContractA9.TypeA9_5_LandlordHeat := TRUE;
            SVALeaseContractA9.TypeA9_5_LandlordElHeating := FALSE;
            SVALeaseContractA9.TypeA9_5_LandlorNatGas := FALSE;
            SVALeaseContractA9.TypeA9_5_TenantHeat := FALSE;
            SVALeaseContractA9.TypeA9_5_TenantEl := FALSE;
            SVALeaseContractA9.TypeA9_5_TenantGas := FALSE;
            SVALeaseContractA9.TypeA9_5_TenantNatGas := FALSE;
            SVALeaseContractA9.TypeA9_5_TenantOil := FALSE;
            SVALeaseContractA9.TypeA9_5_TenOtherHeat := FALSE;
            SVALeaseContractA9.TypeA9_5_TenOtherText := '';
        END;
        IF SVALeaseContractA9.TypeA9_5_LandlorNatGas = TRUE then begin
            SVALeaseContractA9.TypeA9_5_LandlordHeat := TRUE;
            SVALeaseContractA9.TypeA9_5_LandlordElHeating := FALSE;
            SVALeaseContractA9.TypeA9_5_LandlordOil := FALSE;
            SVALeaseContractA9.TypeA9_5_TenantHeat := FALSE;
            SVALeaseContractA9.TypeA9_5_TenantEl := FALSE;
            SVALeaseContractA9.TypeA9_5_TenantGas := FALSE;
            SVALeaseContractA9.TypeA9_5_TenantNatGas := FALSE;
            SVALeaseContractA9.TypeA9_5_TenantOil := FALSE;
            SVALeaseContractA9.TypeA9_5_TenOtherHeat := FALSE;
            SVALeaseContractA9.TypeA9_5_TenOtherText := '';
        END;


    end;

    local procedure SetAmounts(OcNumber: Code[10])
    var
        l_SVAOccupant: Record "SVA Occupant";
    begin
        l_SVAOccupant.Reset();
        l_SVAOccupant.SetRange(Number, OcNumber);
        if l_SVAOccupant.FindFirst() then begin

            SVASubscriptionLines.Reset();
            SVASubscriptionLines.SETRANGE(Tenancies, l_SVAOccupant.TenancyNo);
            SVASubscriptionLines.SetRange("Date From", Today - 20000, l_SVAOccupant.StartDate);
            IF SVASubscriptionLines.FindSet() THEN
                REPEAT
                    if (SVASubscriptionLines."Date To" = 0D) or (SVASubscriptionLines."Date To" > l_SVAOccupant.StartDate) then begin
                        SVACosttype.Reset();
                        SVACosttype.SETRANGE(Costtype, SVASubscriptionLines."Cost Types");
                        IF SVACosttype.FindSet() THEN
                            if SVACosttype.type = 0 then begin //andet, ex parking/garage
                                SVALeaseContractA9.TypeA9_3_OtherText1 := SVASubscriptionLines.Description;
                                SVALeaseContractA9.TypeA9_3_OtherAmount1 := SVASubscriptionLines."Amount Period";
                            end;
                        IF SVACosttype.Type = 1 then begin //Rent
                            SVALeaseContractA9.TypeA9_3_RentPerYear := SVASubscriptionLines."Amount Year";
                            SVALeaseContractA9.TypeA9_3_RentPerPeriode := SVASubscriptionLines."Amount Period";
                            SVALeaseContractA9.TypeA9_1_Vat := SVACosttype.VatGroup;
                        END;
                        IF SVACosttype.Type = 2 THEN//ACVarme
                            SVALeaseContractA9.TypeA9_3_ACHeat := SVASubscriptionLines."Amount Period";

                        IF SVACosttype.Type = 3 THEN//ACVand
                            SVALeaseContractA9.TypeA9_3_ACWater := SVASubscriptionLines."Amount Period";

                        IF SVACosttype.Type = 4 THEN  //ACEl
                            SVALeaseContractA9.TypeA9_3_ACElectricity := SVASubscriptionLines."Amount Period";

                        IF SVACosttype.Type = 5 THEN  //ACCooling
                            SVALeaseContractA9.TypeA9_3_ACCooling := SVASubscriptionLines."Amount Period";

                        IF SVACosttype.Type = 7 THEN  //Antenna
                            SVALeaseContractA9.TypeA9_3_Antenna := SVASubscriptionLines."Amount Period";

                        IF SVACosttype.Type = 8 THEN  //Internet
                            SVALeaseContractA9.TypeA9_3_Internet := SVASubscriptionLines."Amount Period";

                        IF SVACosttype.Type = 9 THEN //Tenantgroup
                            SVALeaseContractA9.TypeA9_3_TenantGroup := SVASubscriptionLines."Amount Period";

                        //SVACosttype find    
                    end;//range for Date to    
                UNTIL SVASubscriptionLines.NEXT() = 0;
            //SVASubscriptionLines
        end;
    end;
}