table 50007 "SVA LeaseContract_A9"
{
    // Tabellen indeholder de nødvendige felter for udskrivning af lejekontrakt Type A, 9. udgave.
    // Gælder kun danske boliglejekontrakter
    // Boolean er konverteret til text-tabelfelter, da udskriften er til Word.
    // Feltnavne referer både til udgave og hvilken paragraf. Således er TypeA9_1_ type A, 9. udgave paragraf 1.

    Caption='Leasecontract Type A 9. edition';

    fields
    {
        field(1;Number;Code[10])
        {
            Caption='Number';
            TableRelation = "SVA Occupant".Number;

            trigger OnValidate();
            begin
                IF TypeA9_2_Startdate = 0D THEN BEGIN  //Empty record
                  CompanyInfo.GET;
                  TypeA9_1_Landlord := CompanyInfo.Name;
                  TypeA9_1_LandlordCVR := CompanyInfo."VAT Registration No.";
                  TypeA9_1_LandlordAddress := CompanyInfo.Address + ', ' + CompanyInfo."Post Code" + ' ' + CompanyInfo.City;

                  Occupant.RESET;
                  Occupant.SETRANGE(Occupant.Number,Number);
                  IF Occupant.FINDFIRST() THEN BEGIN
                    TypeA9_1_TenentName := Occupant.Name1 + ' ' + Occupant.Name2;
                    TypeA9_1_TenantCPR := Occupant.CPRno1 + ' ' + Occupant.CPRno2;
                    TypeA9_2_Startdate := Occupant.StartDate;
                    TypeA9_4_RentFirstTime := CALCDATE('<+1M>',Occupant.StartDate);
                    END;

                  Property.RESET;
                  Property.SETRANGE(Property,Occupant.PropertyNo);
                  IF Property.FINDFIRST() THEN BEGIN
                    TypeA9_3_BankRegNo := Property.BankRegNo;
                    TypeA9_3_BankAccount := Property.Bankaccount;
                    TypeA9_3_Bankname := Property.Bankname;
                    TypeA9_3_TaxesPer := Property.TypeA9_3_Taxes;
                    TypeA9_5_WaterAccounting := FORMAT(Property.TypeA9_5_Wperiod);
                    TypeA9_5_HeatAccounting := FORMAT(Property.HeatingYearFrom);
                    TypeA9_5_ElAccounting := FORMAT(Property.ElectricYearFrom);
                    END;

                  Customer.RESET;
                  Customer.SETRANGE(Customer."No.",Occupant."Customer No");
                  IF Customer.FINDFIRST() THEN BEGIN
                    TypeA9_1_TenentAddress := Customer.Address + ', '+ Customer."Post Code"+' '+Customer.City;
                    END;
                  IF TypeA9_1_TenentAddress = '' THEN BEGIN
                    TypeA9_1_TenentAddress := Occupant.Address + ', '+ Occupant."Post Code"+' '+Occupant.City;
                    END;

                  SubscriptionLines.RESET;
                  SubscriptionLines.SETRANGE(Tenancies,Occupant.TenancyNo);
                  //SubscriptionLines.SETRANGE("Date From",0D);
                  IF SubscriptionLines.FIND('-') THEN
                    REPEAT
                    Costtype.RESET;
                    Costtype.SETRANGE(Costtype,SubscriptionLines."Cost Types");
                    IF Costtype.FIND('-') THEN

                    IF Costtype.Type = 1 THEN BEGIN //Rent
                      TypeA9_3_RentPerYear := SubscriptionLines."Amount Year";
                      TypeA9_3_RentPerPeriode := SubscriptionLines."Amount Period";
                      END;
                    IF Costtype.Type = 2 THEN BEGIN //ACVarme
                      TypeA9_3_ACHeat := SubscriptionLines."Amount Period";
                      END;
                    IF Costtype.Type = 3 THEN BEGIN //ACVand
                      TypeA9_3_ACWater := SubscriptionLines."Amount Period";
                      END;
                    IF Costtype.Type = 4 THEN BEGIN //ACEl
                      TypeA9_3_ACElectricity := SubscriptionLines."Amount Period";
                      END;
                    IF Costtype.Type = 5 THEN BEGIN //ACCooling
                      TypeA9_3_ACCooling := SubscriptionLines."Amount Period";
                      END;
                    IF Costtype.Type = 6 THEN BEGIN //Antenna
                      TypeA9_3_Antenna := SubscriptionLines."Amount Period";
                      END;
                    IF Costtype.Type = 7 THEN BEGIN //Internet
                      TypeA9_3_Internet := SubscriptionLines."Amount Period";
                      END;
                    IF Costtype.Type = 8 THEN BEGIN //Tenantgroup
                      TypeA9_3_TenantGroup := SubscriptionLines."Amount Period";
                      END;
                    UNTIL SubscriptionLines.NEXT = 0;

                  Tenancy.RESET;
                  Tenancy.SETRANGE(Number,Occupant.TenancyNo);
                  IF Tenancy.FIND('-') THEN BEGIN
                    TypeA9_1_Address := Tenancy.Address1;
                    TypeA9_1_City := Tenancy."Post Code" + ' '+ Tenancy.City;
                    TypeA9_3_DueDay := '1.';
                    IF Tenancy.Type = 0 THEN BEGIN //Boliglejemål
                      //1
                      TypeA9_1_Apartment := Tenancy.TypeA9_1_Apartment;
                      TypeA9_1_Room := Tenancy.TypeA9_1_Room;
                      TypeA9_1_Condominium := Tenancy.TypeA9_1_Condominium;
                      TypeA9_1_HousingCoop := Tenancy.TypeA9_1_HousingCoop;
                      TypeA9_1_Other := Tenancy.TypeA9_1_Other;
                      TypeA9_1_OtherTxt := Tenancy.TypeA9_1_OtherTxt;
                      TypeA9_1_AreaTotal := Tenancy.AreaTotal;
                      TypeA9_1_AreaProf := Tenancy.AreaPro;
                      TypeA9_1_Rooms := Tenancy.Rooms;
                      TypeA9_1_Laundy := Tenancy.TypeA9_1_Laundy;
                      TypeA9_1_BicycleStorage := Tenancy.TypeA9_1_BicycleStorage;
                      TypeA9_1_Courtyard := Tenancy.TypeA9_1_Courtyard;
                      TypeA9_1_Garage := Tenancy.TypeA9_1_Garage;
                      TypeA9_1_GarageNo := Tenancy.TypeA9_1_GarageNo;
                      TypeA9_1_Attic := Tenancy.TypeA9_1_Attic;
                      TypeA9_1_AtticNo := Tenancy.TypeA9_1_AtticNo;
                      TypeA9_1_OtherT := Tenancy.TypeA9_1_OtherT;
                      TypeA9_1_OtherTTxt := Tenancy.TypeA9_1_OtherTTxt;
                      TypeA9_1_Use := Tenancy.TypeA9_1_Use;
                      IF Tenancy.TypeA9_1_Use = '' THEN BEGIN
                        TypeA9_1_Use := 'Beboelse';
                        END;

                      //3
                      IF Tenancy.PeriodYear = 0 THEN BEGIN
                        TypeA9_3_Monthly := TRUE;
                        TypeA9_3_Quater := FALSE;
                        END;
                      IF Tenancy.PeriodYear <> 0 THEN BEGIN
                        TypeA9_3_Monthly := FALSE;
                        TypeA9_3_Quater := TRUE;
                      END;
                      //4
                      TypeA9_4_DepMth := Tenancy.Deposit;
                      TypeA9_4_PrepaidRentMth := Tenancy.PrepaidRent;
                      TypeA9_4_DepAmount := TypeA9_3_RentPerYear/12*TypeA9_4_DepMth;
                      TypeA9_4_PrepaidRent := TypeA9_3_RentPerYear/12*TypeA9_4_PrepaidRentMth;
                      TypeA9_4_RentFrom := Occupant.StartDate;
                      TypeA9_4_RentTo := CALCDATE('<+1M-1D>',Occupant.StartDate);
                      //5 - Varme
                      TypeA9_5_LandlordHeat := Tenancy.TypeA9_5_LandlordHeat;
                      TypeA9_5_LandlorNatGas := Tenancy.TypeA9_5_LNatgas;
                      TypeA9_5_LandlordOil := Tenancy.TypeA9_5_lOil;
                      TypeA9_5_LandlordElHeating := Tenancy.TypeA9_5_LElHeat;
                      TypeA9_5_LandlordOther := Tenancy.TypeA9_5_LOther;
                      TypeA9_5_LandlordText := Tenancy.TypeA9_5_LOtherText;

                      TypeA9_5_TenantHeat := Tenancy.TypeA9_5_TenantHeat;
                      TypeA9_5_TenantEl := Tenancy.TypeA9_5_TEl;
                      TypeA9_5_TenantGas := Tenancy.TypeA9_5_Tgas;
                      TypeA9_5_TenantOil := Tenancy.TypeA9_5_TOil;
                      TypeA9_5_TenantNatGas := Tenancy.TypeA9_5_TNatgas;
                      TypeA9_5_TenOtherHeat := Tenancy.TypeA9_5_TOTher;
                      TypeA9_5_TenOtherText := Tenancy.TypeA9_5_TOtherText;

                      //Vand
                      TypeA9_5_LandlordWater := Tenancy.TypeA9_5_LandlordWater;
                      TypeA9_5_WaterMeter := Tenancy.TypeA9_5_WaterMeter;
                      //El
                      TypeA9_5_LandlordEl := Tenancy.TypeA9_5_LandlordEl;
                      TypeA9_5_TenantEl := Tenancy.TypeA9_5_LNatgas;
                      //Køling
                      TypeA9_5_LandlordCooling := Tenancy.TypeA9_5_LandlordCooling;
                      TypeA9_5_CoolingMeter := Tenancy.TypeA9_5_CoolingMeter;
                      //6
                      TypeA9_6_AntennaLandlord := Tenancy.TypeA9_6_AntennaLandlord;
                      TypeA9_6_AntennaTenancies := Tenancy.TypeA9_6_AntennaTenancies;
                      TypeA9_6_Internet := Tenancy.TypeA9_6_Internet;
                      //7
                      TypeA9_7_InspecionIn := TypeA9_7_InspecionIn;
                      //8
                      TypeA9_8_MaintainceInsideLandl := Tenancy.TypeA9_8_MaintainceInsideLandl;
                      TypeA9_8_MaintainceInsideTenan := Tenancy.TypeA9_8_MaintainceInsideTenan;
                      IF TypeA9_8_MaintainceInsideLandl = TRUE THEN BEGIN
                        TypeA9_8_Date := Tenancy.TypeA9_8_Date;
                        TypeA9_8_Amount := Tenancy.TypeA9_8_Amount;
                        END;
                      IF TypeA9_8_MaintainceInsideLandl = FALSE
                         AND TypeA9_8_MaintainceInsideTenan = FALSE THEN BEGIN
                           TypeA9_8_MaintainceInsideTenan := TRUE;
                         END;
                      //9
                      TypeA9_9_Stove := Tenancy.TypeA9_9_Stove;
                      TypeA9_9_Fridge := Tenancy.TypeA9_9_Fridge;
                      TypeA9_9_Freezer := Tenancy.TypeA9_9_Freezer;
                      TypeA9_9_dishwasher := Tenancy.TypeA9_9_dishwasher;
                      TypeA9_9_Washer := Tenancy.TypeA9_9_Washer;
                      TypeA9_9_Dryer := Tenancy.TypeA9_9_Dryer;
                      TypeA9_9_Hood := Tenancy.TypeA9_9_Hood;
                      TypeA9_9_ElectricPanels := Tenancy.TypeA9_9_ElectricPanels;
                      TypeA9_9_ElectricPanels_qty := Tenancy.TypeA9_9_El_qty;
                      TypeA9_9_WaterHeater := Tenancy.TypeA9_9_WaterHeater;
                      TypeA9_9_WaterHeater_qty := Tenancy.TypeA9_9_WaterHeater_qty;
                      TypeA9_9_Other1 := Tenancy.TypeA9_9_Other1;
                      TypeA9_9_Other2 := Tenancy.TypeA9_9_Other2;
                      TypeA9_9_Other3 := Tenancy.TypeA9_9_Other3;
                      TypeA9_9_Other1Text := Tenancy.TypeA9_9_Other1Text;
                      TypeA9_9_Other2Text := Tenancy.TypeA9_9_Other2Text;
                      TypeA9_9_Other3Text := Tenancy.TypeA9_9_Other3Text;
                      //10
                      TypeA9_10_TenRep := Tenancy.TypeA9_10_TenRep;
                      TypeA9_10_LiveStock := Tenancy.TypeA9_10_LiveStock;
                      TypeA9_10_HouseRules := Tenancy.TypeA9_10_HouseRules;
                      END; //boliglejemål.

                      IF Tenancy.Type = 1 THEN BEGIN //Erhvervslejemål - i praksis garager.
                      //1
                      TypeA9_1_GarageNo := Tenancy.TypeA9_1_GarageNo;
                      //3
                      IF Tenancy.PeriodYear = 0 THEN BEGIN
                        TypeA9_3_Monthly := TRUE;
                        TypeA9_3_Quater := FALSE;
                        END;
                      IF Tenancy.PeriodYear = 1 THEN BEGIN
                        TypeA9_3_Monthly := FALSE;
                        TypeA9_3_Quater := TRUE;
                      END;
                      //4
                      TypeA9_4_DepMth := Tenancy.Deposit;
                      TypeA9_4_PrepaidRentMth := Tenancy.PrepaidRent;
                      TypeA9_4_DepAmount := TypeA9_3_RentPerYear/12*TypeA9_4_DepMth;
                      TypeA9_4_PrepaidRent := TypeA9_3_RentPerYear/12*TypeA9_4_PrepaidRentMth;
                    END; //erhvervslejemål - i praksis garager

                  END; //Lejemål
                  INSERT;
                END;
                MoveInAmount;
                PeriodAmount;
            end;
        }
        field(101;TypeA9_1_Apartment;Boolean)
        {
            Caption='Apartment';
        }
        field(102;TypeA9_1_Room;Boolean)
        {
            Caption='Room';
        }
        field(103;TypeA9_1_Condominium;Boolean)
        {
            Caption='Condomimium';
        }
        field(104;TypeA9_1_HousingCoop;Boolean)
        {
            Caption='Housing cooperative';
        }
        field(105;TypeA9_1_OtherT;Boolean)
        {
            Caption='Other';
        }
        field(106;TypeA9_1_OtherTTxt;Text[30])
        {
            Caption='Desciption';
        }
        field(107;TypeA9_1_Sublease;Boolean)
        {
            Caption='SubLease';
        }
        field(108;TypeA9_1_Address;Text[30])
        {
            Caption='Addresse';
        }
        field(109;TypeA9_1_City;Text[30])
        {
            Caption='City';
        }
        field(110;TypeA9_1_Landlord;Text[30])
        {
            Caption='Landlord';
        }
        field(111;TypeA9_1_LandlordCVR;Text[30])
        {
            Caption='RegNo';
        }
        field(112;TypeA9_1_LandlordAddress;Text[50])
        {
            Caption='Address';
        }
        field(113;TypeA9_1_TenentName;Text[30])
        {
            Caption='Tenant Name';
        }
        field(114;TypeA9_1_TenentAddress;Text[50])
        {
            Caption='Tenant address';
        }
        field(115;TypeA9_1_TenantCPR;Text[30])
        {
            Caption='Social security no';
        }
        field(116;TypeA9_1_AreaTotal;Decimal)
        {
            Caption='Area';
        }
        field(117;TypeA9_1_Rooms;Integer)
        {
            Caption='Rooms';
        }
        field(118;TypeA9_1_AreaProf;Decimal)
        {
            Caption='Prof. area';
        }
        field(140;TypeA9_1_Laundy;Boolean)
        {
            Caption='Laundry';
        }
        field(141;TypeA9_1_Courtyard;Boolean)
        {
            Caption='Courtyard';
        }
        field(142;TypeA9_1_BicycleStorage;Boolean)
        {
            Caption='Bicyclestorage';
        }
        field(143;TypeA9_1_Garage;Boolean)
        {
            Caption='Garage';
        }
        field(144;TypeA9_1_GarageNo;Text[10])
        {
            Caption='Garage no';
        }
        field(145;TypeA9_1_Attic;Boolean)
        {
            Caption='Attic';
        }
        field(146;TypeA9_1_AtticNo;Text[10])
        {
            Caption='Attic no.';
        }
        field(147;TypeA9_1_Other;Boolean)
        {
            Caption='Other';
        }
        field(148;TypeA9_1_OtherTxt;Text[20])
        {
            Caption='Description';
        }
        field(149;TypeA9_1_Use;Text[20])
        {
            Caption='Use';
        }
        field(201;TypeA9_2_Startdate;Date)
        {
            Caption='Start date';
        }
        field(301;TypeA9_3_RentPerYear;Decimal)
        {
            Caption='Rent per year';

            trigger OnValidate();
            begin
                SetPeriods;
                IF TypeA9_3_RentPerYear <> 0 THEN BEGIN
                  TypeA9_3_RentPerPeriode := TypeA9_3_RentPerYear/Periods;
                  END;
                PeriodAmount;
            end;
        }
        field(302;TypeA9_3_DueDay;Text[2])
        {
            Caption='Due date';
        }
        field(303;TypeA9_3_Monthly;Boolean)
        {
            Caption='Monthly';

            trigger OnValidate();
            begin
                IF TypeA9_3_Monthly = TRUE THEN BEGIN
                  TypeA9_3_Quater := FALSE
                  END;
            end;
        }
        field(304;TypeA9_3_Quater;Boolean)
        {
            Caption='Quarter';

            trigger OnValidate();
            begin
                IF TypeA9_3_Quater = TRUE THEN BEGIN
                  TypeA9_3_Monthly := FALSE
                  END;
            end;
        }
        field(310;TypeA9_3_RentPerPeriode;Decimal)
        {
            Caption='Rent per period';

            trigger OnValidate();
            begin
                SetPeriods;
                IF TypeA9_3_RentPerPeriode <> 0 THEN  BEGIN
                  TypeA9_3_RentPerYear := TypeA9_3_RentPerPeriode*Periods
                  END;
            end;
        }
        field(311;TypeA9_3_ACHeat;Decimal)
        {
            Caption='AC heat';
        }
        field(312;TypeA9_3_ACWater;Decimal)
        {
            Caption='AC water';
        }
        field(313;TypeA9_3_ACElectricity;Decimal)
        {
            Caption='AC el';
        }
        field(314;TypeA9_3_ACCooling;Decimal)
        {
            Caption='AC cooling';
        }
        field(315;TypeA9_3_Antenna;Decimal)
        {
            Caption='Antenna';
        }
        field(316;TypeA9_3_Internet;Decimal)
        {
            Caption='Internet';
        }
        field(317;TypeA9_3_TenantGroup;Decimal)
        {
            Caption='Tenant group';
        }
        field(318;TypeA9_3_OtherText1;Text[20])
        {
            Caption='Other';
        }
        field(319;TypeA9_3_OtherAmount1;Decimal)
        {
            Caption='Amount';
        }
        field(320;TypeA9_3_OtherText2;Text[20])
        {
            Caption='Other';
        }
        field(321;TypeA9_3_OtherAmount2;Decimal)
        {
            Caption='Amount';
        }
        field(322;TypeA9_3_TotalperPeriod;Decimal)
        {
            Caption='Total per period';
        }
        field(323;TypeA9_3_TaxesPer;Date)
        {
            Caption='Taxes per';
        }
        field(324;TypeA9_3_BankRegNo;Text[20])
        {
            Caption='Bank reg. no.';
        }
        field(325;TypeA9_3_BankAccount;Text[20])
        {
            Caption='Bankaccount';
        }
        field(326;TypeA9_3_Bankname;Text[20])
        {
            Caption='Bankname';
        }
        field(401;TypeA9_4_DateDep;Date)
        {
            Caption='DueDate deposit';
        }
        field(402;TypeA9_4_DepAmount;Decimal)
        {
            Caption='Amount deposit';

            trigger OnValidate();
            begin
                MoveInAmount;
            end;
        }
        field(403;TypeA9_4_DepMth;Integer)
        {
            Caption='Deposit month';

            trigger OnValidate();
            begin
                TypeA9_4_DepAmount := TypeA9_3_RentPerYear/12*TypeA9_4_DepMth;
                MoveInAmount;

            end;
        }
        field(411;TypeA9_4_PrepaidRentDate;Date)
        {
            Caption='Duedata prerent';
        }
        field(412;TypeA9_4_PrepaidRentMth;Integer)
        {
            Caption='Prepaid rent month';

            trigger OnValidate();
            begin
                TypeA9_4_PrepaidRent := TypeA9_3_RentPerYear/12*TypeA9_4_PrepaidRentMth;
                MoveInAmount;
            end;
        }
        field(421;TypeA9_4_DueDate;Date)
        {
            Caption='Duedate';
        }
        field(422;TypeA9_4_DueAmount;Decimal)
        {
            Caption='Total amount';
        }
        field(423;TypeA9_4_PrepaidRent;Decimal)
        {
            Caption='Prepaid rent';

            trigger OnValidate();
            begin
                MoveInAmount;
            end;
        }
        field(424;TypeA9_4_Rentetc;Decimal)
        {
            Caption='Rent etc.';
        }
        field(425;TypeA9_4_RentFrom;Date)
        {
            Caption='First rent from';
        }
        field(426;TypeA9_4_RentTo;Date)
        {
            Caption='First rent to';
        }
        field(427;TypeA9_4_Depositum;Decimal)
        {
            Caption='Deposit amount';

            trigger OnValidate();
            begin
                IF TypeA9_4_Depositum <> 0 THEN BEGIN
                  TypeA9_4_DepAmount := TypeA9_4_Depositum;
                  END;
                  MoveInAmount;
            end;
        }
        field(428;TypeA9_4_Text1;Text[20])
        {
            Caption='Text';
        }
        field(429;TypeA9_4_Amount1;Decimal)
        {
            Caption='Amount';

            trigger OnValidate();
            begin
                MoveInAmount;
            end;
        }
        field(430;TypeA9_4_Text2;Text[20])
        {
            Caption='Text';
        }
        field(431;TypeA9_4_Amount2;Decimal)
        {
            Caption='Amount';

            trigger OnValidate();
            begin
                MoveInAmount;
            end;
        }
        field(432;TypeA9_4_Text3;Text[20])
        {
            Caption='Text';
        }
        field(433;TypeA9_4_Amount3;Decimal)
        {
            Caption='Amount';

            trigger OnValidate();
            begin
                MoveInAmount;
            end;
        }
        field(434;TypeA9_4_TotalAmount;Decimal)
        {
            Caption='Total amount';
        }
        field(435;TypeA9_4_RentFirstTime;Date)
        {
            Caption='First time rent after this';
        }
        field(501;TypeA9_5_LandlordHeat;Boolean)
        {
            Caption='Heat by landlord';

            trigger OnValidate();
            begin
                IF TypeA9_5_LandlordHeat = TRUE THEN BEGIN
                  TypeA9_5_TenantHeat := FALSE;
                  TypeA9_5_TenantEl := FALSE;
                  TypeA9_5_TenantGas := FALSE;
                  TypeA9_5_TenantNatGas := FALSE;
                  TypeA9_5_TenantOil := FALSE;
                  TypeA9_5_TenOtherHeat := FALSE;
                  TypeA9_5_TenOtherText := '';
                  END;
                SetHeat;
            end;
        }
        field(502;TypeA9_5_LandlorNatGas;Boolean)
        {
            Caption='Dist. heat/nature gas';

            trigger OnValidate();
            begin
                SetHeat;
            end;
        }
        field(503;TypeA9_5_LandlordOil;Boolean)
        {
            Caption='Central heat, oil';

            trigger OnValidate();
            begin
                SetHeat;
            end;
        }
        field(504;TypeA9_5_LandlordElHeating;Boolean)
        {
            Caption='El for heating';

            trigger OnValidate();
            begin
                SetHeat;
            end;
        }
        field(505;TypeA9_5_LandlordOther;Boolean)
        {
            Caption='Other';

            trigger OnValidate();
            begin
                SetHeat;
            end;
        }
        field(506;TypeA9_5_LandlordText;Text[30])
        {
            Caption='Description';
        }
        field(507;TypeA9_5_HeatAccounting;Text[30])
        {
            Caption='Heat accounting start';
        }
        field(510;TypeA9_5_TenantHeat;Boolean)
        {
            Caption='Heat by tenant';

            trigger OnValidate();
            begin
                 IF TypeA9_5_TenantHeat = TRUE THEN BEGIN
                  TypeA9_5_LandlordHeat := FALSE;
                  TypeA9_5_LandlordElHeating := FALSE;
                  TypeA9_5_LandlordOil := FALSE;
                  TypeA9_5_LandlorNatGas := FALSE;
                  TypeA9_5_LandlordOther := FALSE;
                  TypeA9_5_LandlordText := '';
                  END;
                SetHeat;
            end;
        }
        field(511;TypeA9_5_TenantEl;Boolean)
        {
            Caption='Electricity';

            trigger OnValidate();
            begin
                SetHeat;
            end;
        }
        field(512;TypeA9_5_TenantGas;Boolean)
        {
            Caption='Gas';

            trigger OnValidate();
            begin
                SetHeat;
            end;
        }
        field(513;TypeA9_5_TenantOil;Boolean)
        {
            Caption='Oil/petrol';

            trigger OnValidate();
            begin
                SetHeat;
            end;
        }
        field(514;TypeA9_5_TenantNatGas;Boolean)
        {
            Caption='Dist. heat/nature gas';

            trigger OnValidate();
            begin
                SetHeat;
            end;
        }
        field(515;TypeA9_5_TenOtherHeat;Boolean)
        {
            Caption='Other heat';

            trigger OnValidate();
            begin
                SetHeat;
            end;
        }
        field(516;TypeA9_5_TenOtherText;Text[20])
        {
            Caption='Desciption';
        }
        field(530;TypeA9_5_LandlordWater;Boolean)
        {
            Caption='Water by landlord';
        }
        field(531;TypeA9_5_WaterMeter;Boolean)
        {
            Caption='Watermeter';
        }
        field(532;TypeA9_5_WaterAccounting;Text[20])
        {
            Caption='Water accounting from';
        }
        field(541;TypeA9_5_LandlordEl;Boolean)
        {
            Caption='Landlord provides electricity';
        }
        field(542;TypeA9_5_ElAccounting;Text[20])
        {
            Caption='El accounting';
        }
        field(550;TypeA9_5_LandlordCooling;Boolean)
        {
            Caption='Cooling by landlord';
        }
        field(551;TypeA9_5_CoolingMeter;Boolean)
        {
            Caption='CoolingMeter';
        }
        field(552;TypeA9_5_CooligAccounting;Text[20])
        {
            Caption='Cooling accing from';
        }
        field(601;TypeA9_6_AntennaLandlord;Boolean)
        {
            Caption='Antenna by Landlord';
        }
        field(602;TypeA9_6_AntennaTenancies;Boolean)
        {
            Caption='Antenna by tenantunion';
        }
        field(603;TypeA9_6_Internet;Boolean)
        {
            Caption='Internet by landlord';
        }
        field(703;TypeA9_7_InspecionIn;Boolean)
        {
            Caption='Inspection when moving in';
        }
        field(800;TypeA9_8_MaintainceInsideTenan;Boolean)
        {
            Caption='Inside maintenance by tenant';

            trigger OnValidate();
            begin
                IF TypeA9_8_MaintainceInsideTenan = TRUE THEN
                  TypeA9_8_MaintainceInsideLandl := FALSE;
            end;
        }
        field(801;TypeA9_8_MaintainceInsideLandl;Boolean)
        {
            Caption='Inside maintenance by landlord';

            trigger OnValidate();
            begin
                IF TypeA9_8_MaintainceInsideLandl = TRUE THEN
                  TypeA9_8_MaintainceInsideTenan := FALSE;
            end;
        }
        field(802;TypeA9_8_Date;Date)
        {
            Caption='Date';
        }
        field(803;TypeA9_8_Amount;Decimal)
        {
            Caption='Amount';
        }
        field(901;TypeA9_9_Stove;Boolean)
        {
            Caption='Stove';
        }
        field(902;TypeA9_9_Fridge;Boolean)
        {
            Caption='Fridge';
        }
        field(903;TypeA9_9_Freezer;Boolean)
        {
            Caption='Freezer';
        }
        field(904;TypeA9_9_dishwasher;Boolean)
        {
            Caption='Dishwasher';
        }
        field(905;TypeA9_9_Washer;Boolean)
        {
            Caption='Washer';
        }
        field(906;TypeA9_9_Dryer;Boolean)
        {
            Caption='Dryer';
        }
        field(907;TypeA9_9_Hood;Boolean)
        {
            Caption='Hood';
        }
        field(908;TypeA9_9_ElectricPanels;Boolean)
        {
            Caption='Electric panels';
        }
        field(909;TypeA9_9_ElectricPanels_qty;Integer)
        {
            Caption='Qty elpanels';
        }
        field(910;TypeA9_9_WaterHeater;Boolean)
        {
            Caption='Waterheater';
        }
        field(911;TypeA9_9_WaterHeater_qty;Integer)
        {
            Caption='Waterheater, qty';
        }
        field(912;TypeA9_9_Other1;Boolean)
        {
            Caption='Other';
        }
        field(913;TypeA9_9_Other1Text;Text[30])
        {
            Caption='Description';
        }
        field(914;TypeA9_9_Other2;Boolean)
        {
            Caption='Other';
        }
        field(915;TypeA9_9_Other2Text;Text[30])
        {
            Caption='Description';
        }
        field(916;TypeA9_9_Other3;Boolean)
        {
            Caption='Other';
        }
        field(917;TypeA9_9_Other3Text;Text[30])
        {
            Caption='Description';
        }
        field(1001;TypeA9_10_TenRep;Boolean)
        {
            Caption='Tenant represantion';
        }
        field(1002;TypeA9_10_LiveStock;Boolean)
        {
            Caption='Livestock allowed';
        }
        field(1003;TypeA9_10_HouseRules;Boolean)
        {
            Caption='Houserules';
        }
        field(1101;TextT9_1_Apartment;Text[2])
        {
            
        }
        field(1102;TextT9_1_Room;Text[2])
        {
                    }
        field(1103;TextT9_1_Condominium;Text[2])
        {
            
        }
        field(1104;TextT9_1_HousingCoop;Text[2])
        {
            
        }
        field(1105;TextT9_1_OtherT;Text[2])
        {
            
        }
        field(1107;TextT9_1_Sublease;Text[2])
        {
            
        }
        field(1140;TextT9_1_Laundy;Text[2])
        {
            
        }
        field(1141;TextT9_1_Courtyard;Text[2])
        {
            
        }
        field(1142;TextT9_1_BicycleStorage;Text[2])
        {
            
        }
        field(1143;TextT9_1_Garage;Text[2])
        {
            
        }
        field(1145;TextT9_1_Attic;Text[2])
        {
            
        }
        field(1147;TextT9_1_Other;Text[2])
        {
            
        }
        field(1201;TextT9_2_Date;Text[10])
        {
        }
        field(1303;TextT9_3_Monthly;Text[2])
        {
            
        }
        field(1304;TextT9_3_Quater;Text[2])
        {
            
        }
        field(1411;TextT9_4_PrepaidrentDate;Text[10])
        {
        }
        field(1421;TextT9_4_DueDate;Text[10])
        {
        }
        field(1424;TextT9_4_RentFrom;Text[10])
        {
        }
        field(1425;TextT9_4_RentTo;Text[10])
        {
        }
        field(1435;TextT9_4_RentFirstTime;Text[10])
        {
        }
        field(1501;TextT9_5_LandlordHeatYes;Text[2])
        {
                }
        field(1502;TextT9_5_NatGasLandlord;Text[2])
        {
        
        }
        field(1503;TextT9_5_LandlordOil;Text[2])
        {
        
        }
        field(1504;TextT9_5_LandlordElHeating;Text[2])
        {
        
        }
        field(1505;TextT9_5_Other;Text[2])
        {
        
        }
        field(1506;TextT9_5_LandlordHeatNo;Text[2])
        {
        }
        field(1509;TextT9_5_TenantHeatNo;Text[2])
        {
        }
        field(1510;TextT9_5_TenantHeatYes;Text[2])
        {
        
        }
        field(1511;TextT9_5_El;Text[2])
        {
        
        }
        field(1512;TextT9_5_Gas;Text[2])
        {
        
        }
        field(1513;TextT9_5_Oil;Text[2])
        {
        
        }
        field(1514;TextT9_5_NatGas;Text[2])
        {
        
        }
        field(1515;TextT9_5_OtherHeat;Text[2])
        {
        
        }
        field(1530;TextT9_5_LandlordWaterYes;Text[2])
        {
        
        }
        field(1531;TextT9_5_WaterMeterYes;Text[2])
        {
        
        }
        field(1532;TextT9_5_LandlordWaterNo;Text[2])
        {
        }
        field(1533;TextT9_5_WaterMeterNo;Text[2])
        {
        
        }
        field(1541;TextT9_5_LandlordElYes;Text[2])
        {
        
        }
        field(1542;TextT9_5_LandlordElNo;Text[2])
        {
        }
        field(1550;TextT9_5_LandlordCoolingYes;Text[2])
        {
        
        }
        field(1551;TextT9_5_CoolingMeterYes;Text[2])
        {
        
        }
        field(1552;TextT9_5_LandlordCoolingNo;Text[2])
        {
        }
        field(1553;TextT9_5_CoolingMeterNo;Text[2])
        {
        
        }
        field(1601;TextT9_6_AntennaLandlordYes;Text[2])
        {
        
        }
        field(1602;TextT9_6_AntennaTenanciesYes;Text[2])
        {
        
        }
        field(1603;TextT9_6_InternetYes;Text[2])
        {
        
        }
        field(1604;TextT9_6_AntennaLandlordNo;Text[2])
        {
        }
        field(1605;TextT9_6_AntennaTenanciesNo;Text[2])
        {
        }
        field(1606;TextT9_6_InternetNo;Text[2])
        {
        }
        field(1703;TextT9_7_InspectionInYes;Text[2])
        {
        }
        field(1704;TextT9_7_InspectionInNo;Text[2])
        {
        }
        field(1800;TextT9_8_MaintainceInsideTenan;Text[2])
        {
        
        }
        field(1801;TextT9_8_MaintainceInsideLandl;Text[2])
        {
        
        }
        field(1802;TextT9_8_Date;Text[10])
        {
        }
        field(1901;TextT9_9_Stove;Text[2])
        {
        
        }
        field(1902;TextT9_9_Fridge;Text[2])
        {
        
        }
        field(1903;TextT9_9_Freezer;Text[2])
        {
        
        }
        field(1904;TextT9_9_dishwasher;Text[2])
        {
        
        }
        field(1905;TextT9_9_Washer;Text[2])
        {
        
        }
        field(1906;TextT9_9_Dryer;Text[2])
        {
        
        }
        field(1907;TextT9_9_Hood;Text[2])
        {
        
        }
        field(1908;TextT9_9_ElectricPanels;Text[2])
        {
        
        }
        field(1910;TextT9_9_WaterHeater;Text[2])
        {
        
        }
        field(1912;TextT9_9_Other1;Text[2])
        {
        
        }
        field(1914;TextT9_9_Other2;Text[2])
        {
        
        }
        field(1916;TextT9_9_Other3;Text[2])
        {
        
        }
        field(2001;I_Minregulation;Decimal)
        {
        
        }
        field(2002;I_MaxRegulation;Decimal)
        {
        
        }
        field(2003;I_FixedRegulation;Decimal)
        {
        
        }
        field(2004;I_RegDate;Date)
        {
        
        }
        field(2005;I_RegIndeksDate;Date)
        {
        
        }
        field(2006;I_LastRegulation;Date)
        {
        
        }
        field(11001;TextT9_10_TenRepYes;Text[2])
        {
        
        }
        field(11002;TextT9_10_LiveStockYes;Text[2])
        {
        
        }
        field(11003;TextT9_10_HouseRulesYes;Text[2])
        {
        
        }
        field(11004;TextT9_10_TenRepNo;Text[2])
        {
        }
        field(11005;TextT9_10_LiveStockNo;Text[2])
        {
        
        }
        field(11006;TextT9_10_HouseRulesNo;Text[2])
        {
        
        }
    }

    keys
    {
        key(Key1;Number)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert();
    begin

        SetBoolean;
        SetDate;
        PeriodAmount;
        MoveInAmount;
        SetHeat;
        IF TypeA9_4_DueDate = 0D THEN
          TypeA9_4_DueDate := TODAY;
    end;

    trigger OnModify();
    begin

        SetBoolean;
        SetDate;
        PeriodAmount;
        MoveInAmount;
        SetHeat;
    end;

    var
        Occupant : Record "SVA Occupant";
        Tenancy : Record "SVA Tenancy";
        Customer : Record "Customer";
        CompanyInfo : Record "Company Information";
        Property : Record "SVA Property";
        PeriodType : Integer;
        Periods : Integer;
        SubscriptionLines : Record "SVA Subscription Lines";
        Costtype : Record "SVA Cost type";

    local procedure SetBoolean();
    begin

         IF TypeA9_1_Apartment = TRUE THEN
         TextT9_1_Apartment := 'X'
         ELSE TextT9_1_Apartment := ' ';

         IF TypeA9_1_Room = TRUE THEN
         TextT9_1_Room := 'X'
         ELSE TextT9_1_Room := ' ';

         IF TypeA9_1_Condominium = TRUE THEN
         TextT9_1_Condominium := 'X'
         ELSE TextT9_1_Condominium := ' ';

         IF TypeA9_1_HousingCoop = TRUE THEN
         TextT9_1_HousingCoop := 'X'
         ELSE TextT9_1_HousingCoop := ' ';

         IF TypeA9_1_OtherT = TRUE THEN
         TextT9_1_OtherT := 'X'
         ELSE TextT9_1_OtherT := ' ';

         IF TypeA9_1_Sublease = TRUE THEN
         TextT9_1_Sublease := 'X'
         ELSE TextT9_1_Sublease := ' ';

         IF TypeA9_1_Laundy = TRUE THEN
         TextT9_1_Laundy := 'X'
         ELSE TextT9_1_Laundy := ' ';

         IF TypeA9_1_Courtyard = TRUE THEN
         TextT9_1_Courtyard := 'X'
         ELSE TextT9_1_Courtyard := ' ';

         IF TypeA9_1_BicycleStorage = TRUE THEN
         TextT9_1_BicycleStorage := 'X'
         ELSE TextT9_1_BicycleStorage := ' ';

         IF TypeA9_1_Garage = TRUE THEN
         TextT9_1_Garage := 'X'
         ELSE TextT9_1_Garage := ' ';

         IF TypeA9_1_Attic = TRUE THEN
         TextT9_1_Attic := 'X'
         ELSE TextT9_1_Attic := ' ';

         IF TypeA9_1_Other = TRUE THEN
         TextT9_1_Other := 'X'
         ELSE TextT9_1_Other := ' ';

         IF TypeA9_3_Monthly = TRUE THEN
         TextT9_3_Monthly := 'X'
         ELSE TextT9_3_Monthly := ' ';

         IF TypeA9_3_Quater = TRUE THEN
         TextT9_3_Quater := 'X'
         ELSE TextT9_3_Quater := ' ';

         IF TypeA9_5_LandlordHeat = TRUE THEN BEGIN
          TextT9_5_LandlordHeatYes := 'X';
          TextT9_5_LandlordHeatNo := ' ';
          END
         ELSE BEGIN
          TextT9_5_LandlordHeatYes := ' ';
          TextT9_5_LandlordHeatNo := 'X';
          END;

         IF TypeA9_5_LandlorNatGas = TRUE THEN
         TextT9_5_NatGasLandlord := 'X'
         ELSE TextT9_5_NatGasLandlord := ' ';

         IF TypeA9_5_LandlordOil = TRUE THEN
         TextT9_5_LandlordOil := 'X'
         ELSE TextT9_5_LandlordOil := ' ';

         IF TypeA9_5_LandlordElHeating = TRUE THEN
         TextT9_5_LandlordElHeating := 'X'
         ELSE TextT9_5_LandlordElHeating := ' ';

         IF TypeA9_5_LandlordOther = TRUE THEN
         TextT9_5_Other := 'X'
         ELSE TextT9_5_Other := ' ';

         IF TypeA9_5_TenantHeat = TRUE THEN BEGIN
          TextT9_5_TenantHeatYes := 'X';
          TextT9_5_TenantHeatNo := ' ';
          END
         ELSE BEGIN
          TextT9_5_TenantHeatYes := ' ';
          TextT9_5_TenantHeatNo := 'X';
         END;

         IF TypeA9_5_TenantEl = TRUE THEN
         TextT9_5_El := 'X'
         ELSE TextT9_5_El := ' ';

         IF TypeA9_5_TenantGas = TRUE THEN
         TextT9_5_Gas := 'X'
         ELSE TextT9_5_Gas := ' ';

         IF TypeA9_5_TenantOil = TRUE THEN
         TextT9_5_Oil := 'X'
         ELSE TextT9_5_Oil := ' ';

         IF TypeA9_5_TenantNatGas = TRUE THEN
         TextT9_5_NatGas := 'X'
         ELSE TextT9_5_NatGas := ' ';

         IF TypeA9_5_TenOtherHeat = TRUE THEN
         TextT9_5_OtherHeat := 'X'
         ELSE TextT9_5_OtherHeat := ' ';

         IF TypeA9_5_LandlordWater = TRUE THEN BEGIN
          TextT9_5_LandlordWaterYes := 'X';
          TextT9_5_LandlordWaterNo := ' ';
          END
         ELSE BEGIN
          TextT9_5_LandlordWaterYes := ' ';
          TextT9_5_LandlordWaterNo := 'X';
          END;

         IF TypeA9_5_WaterMeter = TRUE THEN BEGIN
          TextT9_5_WaterMeterYes := 'X';
          TextT9_5_WaterMeterNo := ' ';
          END
         ELSE BEGIN
          TextT9_5_WaterMeterYes := ' ';
          TextT9_5_WaterMeterNo := 'X';
          END;

         IF TypeA9_5_LandlordEl = TRUE THEN BEGIN
          TextT9_5_LandlordElYes := 'X';
          TextT9_5_LandlordElNo := ' ';
          END
         ELSE BEGIN
          TextT9_5_LandlordElYes := ' ';
          TextT9_5_LandlordElNo := 'X';
          END;

         IF TypeA9_5_LandlordCooling = TRUE THEN BEGIN
          TextT9_5_LandlordCoolingYes := 'X';
          TextT9_5_LandlordCoolingNo := ' ';
          END
         ELSE BEGIN
          TextT9_5_LandlordCoolingYes := ' ';
          TextT9_5_LandlordCoolingNo := 'X';
          END;

         IF TypeA9_5_CoolingMeter = TRUE THEN BEGIN
          TextT9_5_CoolingMeterYes := 'X';
          TextT9_5_CoolingMeterNo := ' ';
          END
         ELSE BEGIN
          TextT9_5_CoolingMeterYes := ' ';
          TextT9_5_CoolingMeterNo := 'X';
         END;

         IF TypeA9_6_AntennaLandlord = TRUE THEN BEGIN
          TextT9_6_AntennaLandlordYes := 'X';
          TextT9_6_AntennaLandlordNo := ' ';
          END
         ELSE BEGIN
          TextT9_6_AntennaLandlordYes := ' ';
          TextT9_6_AntennaLandlordNo := 'X';
          END;

         IF TypeA9_6_AntennaTenancies = TRUE THEN BEGIN
          TextT9_6_AntennaTenanciesYes := 'X';
          TextT9_6_AntennaTenanciesNo := ' ';
          END
         ELSE BEGIN
          TextT9_6_AntennaTenanciesYes := ' ';
          TextT9_6_AntennaTenanciesNo := 'X';
          END;

         IF TypeA9_6_AntennaTenancies = TRUE THEN BEGIN
          TextT9_6_AntennaTenanciesYes := 'X';
          TextT9_6_AntennaTenanciesNo := ' ';
          END
         ELSE BEGIN
          TextT9_6_AntennaTenanciesYes := ' ';
          TextT9_6_AntennaTenanciesNo := 'X';
          END;

         IF TypeA9_6_Internet = TRUE THEN BEGIN
          TextT9_6_InternetYes := 'X';
          TextT9_6_InternetNo := ' ';
          END
         ELSE BEGIN
          TextT9_6_InternetYes := ' ';
          TextT9_6_InternetNo := 'X';
          END;

         IF TypeA9_7_InspecionIn = TRUE THEN BEGIN
          TextT9_7_InspectionInYes := 'X';
          TextT9_7_InspectionInYes := ' ';
          END
         ELSE BEGIN
          TextT9_7_InspectionInYes := ' ';
          TextT9_7_InspectionInNo := 'X';
          END;

         IF TypeA9_8_MaintainceInsideTenan = TRUE THEN
         TextT9_8_MaintainceInsideTenan := 'X'
         ELSE TextT9_8_MaintainceInsideTenan := ' ';

         IF TypeA9_8_MaintainceInsideLandl = TRUE THEN
         TextT9_8_MaintainceInsideLandl := 'X'
         ELSE TextT9_8_MaintainceInsideLandl := ' ';

         IF TypeA9_9_Stove = TRUE THEN
         TextT9_9_Stove := 'X'
         ELSE TextT9_9_Stove := ' ';

         IF TypeA9_9_Fridge = TRUE THEN
         TextT9_9_Fridge := 'X'
         ELSE TextT9_9_Fridge := ' ';

         IF TypeA9_9_Freezer = TRUE THEN
         TextT9_9_Freezer := 'X'
         ELSE TextT9_9_Freezer := '  ';

         IF TypeA9_9_dishwasher = TRUE THEN
         TextT9_9_dishwasher := 'X'
         ELSE TextT9_9_dishwasher := ' ';

         IF TypeA9_9_Washer = TRUE THEN
         TextT9_9_Washer := 'X'
         ELSE TextT9_9_Washer := ' ';

         IF TypeA9_9_Dryer = TRUE THEN
         TextT9_9_Dryer := 'X'
         ELSE TextT9_9_Dryer := ' ';

         IF TypeA9_9_Hood = TRUE THEN
         TextT9_9_Hood := 'X'
         ELSE TextT9_9_Hood := ' ';

         IF TypeA9_9_ElectricPanels = TRUE THEN
         TextT9_9_ElectricPanels := 'X'
         ELSE TextT9_9_ElectricPanels := ' ';

         IF TypeA9_9_WaterHeater = TRUE THEN
         TextT9_9_WaterHeater := 'X'
         ELSE TextT9_9_WaterHeater := ' ';

         IF TypeA9_9_Other1 = TRUE THEN
         TextT9_9_Other1 := 'X'
         ELSE TextT9_9_Other1 := ' ';

         IF TypeA9_9_Other2 = TRUE THEN
         TextT9_9_Other2 := 'X'
         ELSE TextT9_9_Other2 := ' ';

         IF TypeA9_9_Other3 = TRUE THEN
         TextT9_9_Other3 := 'X'
         ELSE TextT9_9_Other3 := ' ';

         IF TypeA9_10_TenRep = TRUE THEN BEGIN
          TextT9_10_TenRepYes := 'X';
          TextT9_10_TenRepNo := ' ';
          END
         ELSE BEGIN
          TextT9_10_TenRepYes := ' ';
          TextT9_10_TenRepNo := 'X';
          END;

         IF TypeA9_10_LiveStock = TRUE THEN BEGIN
          TextT9_10_LiveStockYes := 'X';
          TextT9_10_LiveStockNo := ' ';
          END
         ELSE BEGIN
          TextT9_10_LiveStockYes := ' ';
          TextT9_10_LiveStockNo := 'X';
          END;

         IF TypeA9_10_HouseRules = TRUE THEN BEGIN
          TextT9_10_HouseRulesYes := 'X';
          TextT9_10_HouseRulesNo := ' ';
          END
         ELSE BEGIN
          TextT9_10_HouseRulesYes := ' ';
          TextT9_10_HouseRulesNo := 'X';
          END;
    end;

    local procedure SetDate();
    begin
        TextT9_2_Date := FORMAT(TypeA9_2_Startdate);
        TextT9_4_DueDate := FORMAT(TypeA9_4_DueDate);
        TextT9_4_PrepaidrentDate := FORMAT(TypeA9_4_PrepaidRentDate);
        TextT9_4_RentFrom := FORMAT(TypeA9_4_RentFrom);
        TextT9_4_RentTo := FORMAT(TypeA9_4_RentTo);
        TextT9_4_RentFirstTime := FORMAT(TypeA9_4_RentFirstTime);
    end;

    local procedure MoveInAmount();
    begin
        TypeA9_4_DepAmount := TypeA9_4_DepMth*TypeA9_3_RentPerYear/12;
        TypeA9_4_Depositum := TypeA9_4_DepMth*TypeA9_3_RentPerYear/12;
        TypeA9_4_PrepaidRent := TypeA9_4_PrepaidRentMth * TypeA9_3_RentPerYear/12;
        TypeA9_4_TotalAmount := 0;
        TypeA9_4_DueAmount := 0;
        TypeA9_4_TotalAmount := TypeA9_4_PrepaidRent+TypeA9_4_DepAmount+TypeA9_4_Rentetc+TypeA9_4_Amount1+TypeA9_4_Amount2+TypeA9_4_Amount3;
        TypeA9_4_DueAmount := TypeA9_4_TotalAmount;
    end;

    local procedure SetPeriods();
    begin
        PeriodType := Tenancy.PeriodYear;
        IF PeriodType = 0 THEN BEGIN //Mth
          Periods := 12;
          END;
        IF PeriodType = 1 THEN BEGIN //Qty
          Periods := 4;
          END;
        IF PeriodType = 2 THEN BEGIN //½Yr
          Periods := 2;
          END;
        IF PeriodType = 3 THEN BEGIN //yr
          Periods := 1
          END;
    end;

    local procedure PeriodAmount();
    begin
        TypeA9_3_TotalperPeriod := 0;
        TypeA9_3_TotalperPeriod := TypeA9_3_RentPerPeriode
                                  +TypeA9_3_ACHeat
                                  +TypeA9_3_ACWater
                                  +TypeA9_3_ACElectricity
                                  +TypeA9_3_ACCooling
                                  +TypeA9_3_Antenna
                                  +TypeA9_3_Internet
                                  +TypeA9_3_TenantGroup
                                  +TypeA9_3_OtherAmount1
                                  +TypeA9_3_OtherAmount2;
        TypeA9_4_Rentetc := TypeA9_3_TotalperPeriod;
    end;

    local procedure SetHeat();
    begin
        IF TypeA9_5_TenantEl = TRUE THEN BEGIN
          TypeA9_5_TenantHeat := TRUE;
          TypeA9_5_TenantGas := FALSE;
          TypeA9_5_TenantNatGas := FALSE;
          TypeA9_5_TenantOil := FALSE;
          TypeA9_5_LandlordHeat := FALSE;
          TypeA9_5_LandlordElHeating := FALSE;
          TypeA9_5_LandlordOil := FALSE;
          TypeA9_5_LandlorNatGas := FALSE;
          TypeA9_5_LandlordOther := FALSE;
          TypeA9_5_LandlordText := '';
          END;
        IF TypeA9_5_TenantGas = TRUE THEN BEGIN
          TypeA9_5_TenantHeat := TRUE;
          TypeA9_5_TenantEl := FALSE;
          TypeA9_5_TenantNatGas := FALSE;
          TypeA9_5_TenantOil := FALSE;
          TypeA9_5_LandlordHeat := FALSE;
          TypeA9_5_LandlordElHeating := FALSE;
          TypeA9_5_LandlordOil := FALSE;
          TypeA9_5_LandlorNatGas := FALSE;
          TypeA9_5_LandlordOther := FALSE;
          TypeA9_5_LandlordText := '';
          END;
        IF TypeA9_5_TenantNatGas = TRUE THEN BEGIN
          TypeA9_5_TenantHeat := TRUE;
          TypeA9_5_TenantEl := FALSE;
          TypeA9_5_TenantGas := FALSE;
          TypeA9_5_TenantOil := FALSE;
          TypeA9_5_LandlordHeat := FALSE;
          TypeA9_5_LandlordElHeating := FALSE;
          TypeA9_5_LandlordOil := FALSE;
          TypeA9_5_LandlorNatGas := FALSE;
          TypeA9_5_LandlordOther := FALSE;
          TypeA9_5_LandlordText := '';
          END;
        IF TypeA9_5_TenantOil = TRUE THEN BEGIN
          TypeA9_5_TenantHeat := TRUE;
          TypeA9_5_LandlordHeat := FALSE;
          TypeA9_5_TenantEl := FALSE;
          TypeA9_5_TenantGas := FALSE;
          TypeA9_5_TenantNatGas := FALSE;
          TypeA9_5_LandlordHeat := FALSE;
          TypeA9_5_LandlordElHeating := FALSE;
          TypeA9_5_LandlordOil := FALSE;
          TypeA9_5_LandlorNatGas := FALSE;
          TypeA9_5_LandlordOther := FALSE;
          TypeA9_5_LandlordText := '';
          END;

         IF TypeA9_5_LandlordElHeating = TRUE THEN BEGIN
          TypeA9_5_LandlordHeat := TRUE;
          TypeA9_5_LandlordOil := FALSE;
          TypeA9_5_LandlorNatGas := FALSE;
          TypeA9_5_TenantHeat := FALSE;
          TypeA9_5_TenantEl := FALSE;
          TypeA9_5_TenantGas := FALSE;
          TypeA9_5_TenantNatGas := FALSE;
          TypeA9_5_TenantOil := FALSE;
          TypeA9_5_TenOtherHeat := FALSE;
          TypeA9_5_TenOtherText := '';
          END;
         IF TypeA9_5_LandlordOil = TRUE THEN BEGIN
          TypeA9_5_LandlordHeat := TRUE;
          TypeA9_5_LandlordElHeating := FALSE;
          TypeA9_5_LandlorNatGas := FALSE;
          TypeA9_5_TenantHeat := FALSE;
          TypeA9_5_TenantEl := FALSE;
          TypeA9_5_TenantGas := FALSE;
          TypeA9_5_TenantNatGas := FALSE;
          TypeA9_5_TenantOil := FALSE;
          TypeA9_5_TenOtherHeat := FALSE;
          TypeA9_5_TenOtherText := '';
          END;
         IF TypeA9_5_LandlorNatGas = TRUE THEN BEGIN
          TypeA9_5_LandlordHeat := TRUE;
          TypeA9_5_LandlordElHeating := FALSE;
          TypeA9_5_LandlordOil := FALSE;
          TypeA9_5_TenantHeat := FALSE;
          TypeA9_5_TenantEl := FALSE;
          TypeA9_5_TenantGas := FALSE;
          TypeA9_5_TenantNatGas := FALSE;
          TypeA9_5_TenantOil := FALSE;
          TypeA9_5_TenOtherHeat := FALSE;
          TypeA9_5_TenOtherText := '';
          END;


    end;
}

