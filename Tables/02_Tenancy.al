table 50002 "SVA Tenancy"
{
    Caption = 'Tenancies';
    DataClassification = CustomerContent;
    DrillDownPageID = "SVA Tenancy List";
    LookupPageID = "SVA Tenancy List";


    fields
    {
        field(1; Number; Code[10])
        {
            Caption = 'Tenancy number';
            NotBlank = true;
        }
        field(2; PropertyNo; Code[10])
        {
            Caption = 'Property';
            TableRelation = "SVA Property";
            NotBlank = true;

            trigger OnValidate();
            begin

                SVAProperty.Reset();
                SVAProperty.SETRANGE(SVAProperty.Property, PropertyNo);
                IF SVAProperty.FINDFIRST() THEN BEGIN
                    Address1 := SVAProperty.Address1;
                    Address2 := SVAProperty.Address2;
                    "Post Code" := SVAProperty."Post Code";
                    City := SVAProperty.City;
                    "Country/Region Code" := SVAProperty."Country/Region Code";
                    TypeA9_1_Laundy := SVAProperty.TypeA9_1_Laundry;
                    TypeA9_1_BicycleStorage := SVAProperty.TypeA9_1_Bicycle;
                    TypeA9_1_Courtyard := SVAProperty.TypeA9_1_Courtyard;
                    TypeA9_1_Use := 'Beboelse';
                    Deposit := SVAProperty.TypeA9_4_DepMth;
                    PrepaidRent := SVAProperty.TypeA9_4_PrePaidMth;
                    TypeA9_5_LandlordHeat := SVAProperty.TypeA9_5_LandlordHeat;
                    TypeA9_5_LNatgas := SVAProperty.TypeA9_5_LNatgas;
                    TypeA9_5_lOil := SVAProperty.TypeA9_5_lOil;
                    TypeA9_5_LElHeat := SVAProperty.TypeA9_5_LEl;
                    TypeA9_5_LOther := SVAProperty.TypeA9_5_LOther;
                    TypeA9_5_LandlordWater := SVAProperty.TypeA9_5_Water;
                    TypeA9_5_WaterMeter := SVAProperty.TypeA9_5_WM;
                    TypeA9_5_LandlordEl := SVAProperty.TypeA9_5_El;
                    TypeA9_5_LandlordCooling := SVAProperty.TypeA9_5_Cooling;
                    TypeA9_5_CoolingMeter := SVAProperty.TypeA9_5_CM;
                    TypeA9_6_AntennaLandlord := SVAProperty.TypeA9_6_LAntenna;
                    TypeA9_6_AntennaTenancies := SVAProperty.TypeA9_6_TAntenna;
                    TypeA9_6_Internet := SVAProperty.TypeA9_6_Internet;
                    TypeA9_7_InspecionIn := SVAProperty.TypeA9_7_MoveIn;
                    TypeA9_8_MaintainceInsideLandl := SVAProperty.TypeA9_8_MainLandlord;
                    IF TypeA9_8_MaintainceInsideLandl = TRUE THEN
                        TypeA9_8_MaintainceInsideTenan := FALSE;

                    IF TypeA9_8_MaintainceInsideLandl = FALSE THEN
                        TypeA9_8_MaintainceInsideTenan := TRUE;

                    TypeA9_10_HouseRules := SVAProperty.TypeA9_10_Houserules;
                    TypeA9_10_LiveStock := SVAProperty.TypeA9_10_HouseStock;
                    TypeA9_10_TenRep := SVAProperty.TypeA9_10_Occgroup;
                END;
            end;
        }
        field(3; Name; Text[50])
        {
            Caption = 'Name';
        }
        field(4; Address1; Text[50])
        {
            Caption = 'Address';
            trigger OnValidate();
            begin
                SVAOccupant.Reset();
                SVAOccupant.SetRange(TenancyNo, Number);
                Rec.Vacant := true;
                Rec.vacantDate := DMY2Date(1, 1, 1960);
                IF SVAOccupant.FindLast() then begin
                    IF SVAOccupant.EndDate > 0D THEN
                        vacantDate := calcdate('<1D>', SVAOccupant.EndDate);

                    IF SVAOccupant.EndDate = 0D THEN begin
                        VacantDate := 0D;
                        Vacant := false;
                    end;
                end;
            end;
        }
        field(5; Address2; Text[50])
        {
            Caption = 'Address 2';
        }
        field(6; "Post Code"; Code[10])
        {
            Caption = 'Post Code';
            TableRelation = "Post Code";

            trigger OnValidate();
            begin
                Postcode.ValidatePostCode(City, "Post Code", Country, "Country/Region Code", (CurrFieldNo <> 0) AND GUIALLOWED);
            end;
        }
        field(7; City; Text[50])
        {
            Caption = 'City';
            TableRelation = IF ("Country/Region Code" = CONST()) "Post Code".City
            ELSE
            IF ("Country/Region Code" = FILTER(<> '')) "Post Code".City WHERE("Country/Region Code" = FIELD("Country/Region Code"));

            trigger OnValidate();
            begin
                Postcode.ValidateCity(City, "Post Code", Country, "Country/Region Code", (CurrFieldNo <> 0) AND GUIALLOWED);
            end;
        }
        field(8; "Country/Region Code"; Code[10])
        {
            Caption = 'Country';
            TableRelation = "Country/Region";
        }
        field(10; Vacant; Boolean)
        {
            Caption = 'Vacant';
        }
        field(11; vacantDate; Date)
        {
            Caption = 'Vacant from';
            Description = 'DAN=Ledigt fra;ENU=Vacant from';
        }
        field(16; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

        }
        field(17; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

        }
        field(20; Type; Option)
        {
            Caption = 'Type';
            Description = 'Type of tenancy';
            OptionCaption = 'Living,Commercial Leases,Partial,Owner,House,Other';
            OptionMembers = Bolig,Erhverv,Andel,Ejer,hus,andet;
        }
        field(21; Contract; Option)
        {
            //Not in use
            Caption = 'Contract type';
            Description = 'Contrakt type';
            OptionCaption = 'Living,Commercial Lease';
            OptionMembers = Bolig,Erhverv;
        }
        field(22; PeriodYear; Option)
        {
            Caption = 'Charge per';
            OptionCaption = 'Mth,Qtr,Half year,Year';
            OptionMembers = "Måned",Kvartal,"Halvår","År";
        }
        field(30; Deposit; Integer)
        {
            Caption = 'Deposit mth';
        }
        field(31; PrepaidRent; Integer)
        {
            Caption = 'Prepaid rent mth';
        }
        field(32; "AreaTotal"; Decimal)
        {
            Caption = 'Total Area';

            trigger OnValidate();
            Var
                Contract: Record "SVA LeaseContract_A9";
            begin
                AreaLiv := AreaTotal;
                Contract.Reset();
                Contract.SetRange(TypeA9_1_TenancyNo, Number);
                if Contract.FindSet() then begin
                    Contract.TypeA9_1_AreaTotal := AreaTotal;
                    Contract.Modify();
                end;

            end;
        }
        field(33; AreaLiv; Decimal)
        {
            Caption = 'Living area';

            trigger OnValidate();

            begin
                AreaTotal := AreaLiv + AreaPro;
            end;
        }
        field(34; AreaPro; Decimal)
        {
            Caption = 'Prof. area';

            trigger OnValidate();
            var
                Contract: Record "SVA LeaseContract_A9";
            begin
                AreaTotal := AreaLiv + AreaPro;
                Contract.Reset();
                Contract.SetRange(TypeA9_1_TenancyNo, Number);
                if Contract.FindSet() then begin
                    Contract.TypeA9_1_AreaProf := AreaPro;
                    Contract.Modify();
                end;
            end;
        }
        field(35; Rooms; Integer)
        {
            Caption = 'Rooms';
        }
        field(101; TypeA9_1_Apartment; Boolean)
        {
            Caption = 'Apartment';

            trigger OnValidate();
            begin
                IF TypeA9_1_Apartment THEN BEGIN
                    TypeA9_1_Room := FALSE;
                    TypeA9_1_Condominium := FALSE;
                    TypeA9_1_HousingCoop := FALSE;
                    TypeA9_1_OtherT := FALSE;
                    TypeA9_1_OtherTTxt := '';
                END;
            end;
        }
        field(102; TypeA9_1_Room; Boolean)
        {
            Caption = 'Room';

            trigger OnValidate();
            begin
                IF TypeA9_1_Room THEN BEGIN
                    TypeA9_1_Apartment := FALSE;
                    TypeA9_1_Condominium := FALSE;
                    TypeA9_1_HousingCoop := FALSE;
                    TypeA9_1_OtherT := FALSE;
                    TypeA9_1_OtherTTxt := '';
                END;
            end;
        }
        field(103; TypeA9_1_Condominium; Boolean)
        {
            Caption = 'Condomimium';

            trigger OnValidate();
            begin
                IF TypeA9_1_Condominium THEN BEGIN
                    TypeA9_1_Apartment := FALSE;
                    TypeA9_1_Room := FALSE;
                    TypeA9_1_HousingCoop := FALSE;
                    TypeA9_1_OtherT := FALSE;
                    TypeA9_1_OtherTTxt := '';
                END;
            end;
        }
        field(104; TypeA9_1_HousingCoop; Boolean)
        {
            Caption = 'Housing cooperative';

            trigger OnValidate();
            begin
                IF TypeA9_1_HousingCoop THEN BEGIN
                    TypeA9_1_Apartment := FALSE;
                    TypeA9_1_Room := FALSE;
                    TypeA9_1_Condominium := FALSE;
                    TypeA9_1_OtherT := FALSE;
                    TypeA9_1_OtherTTxt := '';
                END;
            end;
        }
        field(105; TypeA9_1_OtherT; Boolean)
        {
            Caption = 'Other';

            trigger OnValidate();
            begin
                IF TypeA9_1_OtherT THEN BEGIN
                    TypeA9_1_Apartment := FALSE;
                    TypeA9_1_Room := FALSE;
                    TypeA9_1_Condominium := FALSE;
                    TypeA9_1_HousingCoop := FALSE;
                END;
            end;
        }
        field(106; TypeA9_1_OtherTTxt; Text[20])
        {
            Caption = 'Desciption';
        }
        field(110; TypeA9_1_Laundy; Boolean)
        {
            Caption = 'Laundry';
        }
        field(111; TypeA9_1_Courtyard; Boolean)
        {
            Caption = 'Courtyard';
        }
        field(112; TypeA9_1_BicycleStorage; Boolean)
        {
            Caption = 'Bicyclestorage';
        }
        field(113; TypeA9_1_Garage; Boolean)
        {
            Caption = 'Garage';

            trigger OnValidate();
            begin
                IF NOT TypeA9_1_Garage THEN
                    TypeA9_1_GarageNo := ''
            end;
        }
        field(114; TypeA9_1_GarageNo; Text[30])
        {
            Caption = 'Garage no';
        }
        field(115; TypeA9_1_Attic; Boolean)
        {
            Caption = 'Attic';

            trigger OnValidate();
            begin
                IF NOT TypeA9_1_Attic THEN
                    TypeA9_1_AtticNo := ''
            end;
        }
        field(116; TypeA9_1_AtticNo; Text[30])
        {
            Caption = 'Attic no.';
        }
        field(117; TypeA9_1_Other; Boolean)
        {
            Caption = 'Other';
        }
        field(118; TypeA9_1_OtherTxt; Text[20])
        {
            Caption = 'Description';
        }
        field(120; TypeA9_1_Use; Text[20])
        {
            Caption = 'Use';

            trigger OnValidate();
            begin
                TypeA9_1_Use := 'Beboelse';
            end;
        }
        field(510; TypeA9_5_LandlordHeat; Boolean)
        {
            Caption = 'Landlord heat';

            trigger OnValidate();
            begin
                IF TypeA9_5_LandlordHeat THEN BEGIN
                    TypeA9_5_TenantHeat := FALSE;
                    TypeA9_5_Tgas := FALSE;
                    TypeA9_5_TNatgas := FALSE;
                    TypeA9_5_TOil := FALSE;

                END;
            end;
        }
        field(511; TypeA9_5_LNatgas; Boolean)
        {
            Caption = 'Natural Gas';

            trigger OnValidate();
            begin
                IF TypeA9_5_LNatgas THEN BEGIN
                    TypeA9_5_lOil := FALSE;
                    TypeA9_5_LElHeat := FALSE;

                END;
            end;
        }
        field(512; TypeA9_5_lOil; Boolean)
        {
            Caption = 'Central heating with oil';

            trigger OnValidate();
            begin
                IF TypeA9_5_lOil THEN BEGIN
                    TypeA9_5_LNatgas := FALSE;
                    TypeA9_5_LElHeat := FALSE;

                END;
            end;
        }
        field(513; TypeA9_5_LElHeat; Boolean)
        {
            Caption = 'Electricity for heating';

            trigger OnValidate();
            begin
                IF TypeA9_5_LElHeat THEN BEGIN
                    TypeA9_5_lOil := FALSE;
                    TypeA9_5_LNatgas := FALSE;

                END;
            end;
        }
        field(514; TypeA9_5_LOther; Boolean)
        {
            Caption = 'Other';
        }
        field(515; TypeA9_5_LOtherText; Text[20])
        {
            Caption = 'Description';
        }
        field(520; TypeA9_5_TenantHeat; Boolean)
        {
            Caption = 'Tenant heating';

            trigger OnValidate();
            begin
                IF TypeA9_5_TenantHeat THEN BEGIN
                    TypeA9_5_LElHeat := FALSE;
                    TypeA9_5_LNatgas := FALSE;
                    TypeA9_5_lOil := FALSE;
                END;
            end;
        }
        field(521; TypeA9_5_TEl; Boolean)
        {
            Caption = 'Electricity';

            trigger OnValidate();
            begin
                IF TypeA9_5_TEl THEN BEGIN
                    TypeA9_5_Tgas := FALSE;
                    TypeA9_5_TNatgas := FALSE;
                    TypeA9_5_TEl := FALSE;

                END;
            end;
        }
        field(522; TypeA9_5_Tgas; Boolean)
        {
            Caption = 'Gas';

            trigger OnValidate();
            begin
                IF TypeA9_5_Tgas THEN BEGIN
                    TypeA9_5_TEl := FALSE;
                    TypeA9_5_TNatgas := FALSE;
                    TypeA9_5_TEl := FALSE;

                END;
            end;
        }
        field(523; TypeA9_5_TOil; Boolean)
        {
            Caption = 'Oil';

            trigger OnValidate();
            begin
                IF TypeA9_5_TOil THEN BEGIN
                    TypeA9_5_Tgas := FALSE;
                    TypeA9_5_TNatgas := FALSE;
                    TypeA9_5_TEl := FALSE;

                END;
            end;
        }
        field(524; TypeA9_5_TNatgas; Boolean)
        {
            Caption = 'Natural gas';

            trigger OnValidate();
            begin
                IF TypeA9_5_TNatgas THEN BEGIN
                    TypeA9_5_Tgas := FALSE;
                    TypeA9_5_TOil := FALSE;
                    TypeA9_5_TEl := FALSE;
                END;
            end;
        }
        field(525; TypeA9_5_TOTher; Boolean)
        {
            Caption = 'Other';
        }
        field(526; TypeA9_5_TOtherText; Text[20])
        {
            Caption = 'Description';
        }
        field(530; TypeA9_5_LandlordWater; Boolean)
        {
            Caption = 'Water by landlord';
        }
        field(531; TypeA9_5_WaterMeter; Boolean)
        {
            Caption = 'Watermeter';
        }
        field(541; TypeA9_5_LandlordEl; Boolean)
        {
            Caption = 'Landlord provides electricity';
        }
        field(550; TypeA9_5_LandlordCooling; Boolean)
        {
            Caption = 'Cooling by landlord';
        }
        field(551; TypeA9_5_CoolingMeter; Boolean)
        {
            Caption = 'CoolingMeter';
        }
        field(601; TypeA9_6_AntennaLandlord; Boolean)
        {
            Caption = 'Antenna by Landlord';
        }
        field(602; TypeA9_6_AntennaTenancies; Boolean)
        {
            Caption = 'Antenna by tenantunion';
        }
        field(603; TypeA9_6_Internet; Boolean)
        {
            Caption = 'Internet by landlord';
        }
        field(703; TypeA9_7_InspecionIn; Boolean)
        {
            Caption = 'Inspection when moving in';
        }
        field(800; TypeA9_8_MaintainceInsideTenan; Boolean)
        {
            Caption = 'Inside maintenance by tenant';

            trigger OnValidate();
            begin
                IF TypeA9_8_MaintainceInsideTenan THEN
                    TypeA9_8_MaintainceInsideLandl := FALSE;

            end;
        }
        field(801; TypeA9_8_MaintainceInsideLandl; Boolean)
        {
            Caption = 'Inside maintenance by landlord';

            trigger OnValidate();
            begin
                IF TypeA9_8_MaintainceInsideLandl THEN
                    TypeA9_8_MaintainceInsideTenan := FALSE;

            end;
        }
        field(802; TypeA9_8_Date; Date)
        {
            Caption = 'Date';
        }
        field(803; TypeA9_8_Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(901; TypeA9_9_Stove; Boolean)
        {
            Caption = 'Stove';
        }
        field(902; TypeA9_9_Fridge; Boolean)
        {
            Caption = 'Fridge';
        }
        field(903; TypeA9_9_Freezer; Boolean)
        {
            Caption = 'Freezer';
        }
        field(904; TypeA9_9_dishwasher; Boolean)
        {
            Caption = 'Dishwasher';
        }
        field(905; TypeA9_9_Washer; Boolean)
        {
            Caption = 'Washer';
        }
        field(906; TypeA9_9_Dryer; Boolean)
        {
            Caption = 'Dryer';
        }
        field(907; TypeA9_9_Hood; Boolean)
        {
            Caption = 'Hood';
        }
        field(908; TypeA9_9_ElectricPanels; Boolean)
        {
            Caption = 'Electric panels';

            trigger OnValidate();
            begin
                IF NOT TypeA9_9_ElectricPanels THEN
                    TypeA9_9_El_qty := 0;
            end;
        }
        field(909; TypeA9_9_El_qty; Integer)
        {
            Caption = 'Electric panels, qty';
        }
        field(910; TypeA9_9_WaterHeater; Boolean)
        {
            Caption = 'Waterheater';

            trigger OnValidate();
            begin
                IF NOT TypeA9_9_WaterHeater THEN
                    TypeA9_9_WaterHeater_qty := 0

            end;
        }
        field(911; TypeA9_9_WaterHeater_qty; Integer)
        {
            Caption = 'Waterheater, qty';
        }
        field(912; TypeA9_9_Other1; Boolean)
        {
            Caption = 'Other';
        }
        field(913; TypeA9_9_Other1Text; Text[20])
        {
            Caption = 'Description';
            trigger OnValidate();
            begin
                TypeA9_9_Other1 := True;
            end;
        }
        field(914; TypeA9_9_Other2; Boolean)
        {
            Caption = 'Other';
            trigger OnValidate();
            begin
                TypeA9_9_Other2 := True;
            end;
        }
        field(915; TypeA9_9_Other2Text; Text[20])
        {
            Caption = 'Description';
        }
        field(916; TypeA9_9_Other3; Boolean)
        {
            Caption = 'Other';
            trigger OnValidate();
            begin
                TypeA9_9_Other3 := True;
            end;
        }
        field(917; TypeA9_9_Other3Text; Text[20])
        {
            Caption = 'Description';
        }
        field(1001; TypeA9_10_TenRep; Boolean)
        {
            Caption = 'Tenant represantion';
        }
        field(1002; TypeA9_10_LiveStock; Boolean)
        {
            Caption = 'Livestock allowed';
        }
        field(1003; TypeA9_10_HouseRules; Boolean)
        {
            Caption = 'Houserules';
        }
        field(2011; StoveYear; Text[10])
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
        }
        field(2012; StoveManufactor; Text[30])
        {
            Caption = 'Manufactor';
            DataClassification = CustomerContent;
        }
        field(2013; StoveModel; Text[30])
        {
            Caption = 'Model';
            DataClassification = CustomerContent;
        }
        field(2014; CookYear; Text[10])
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
        }
        field(2015; CookManufactor; Text[30])
        {
            Caption = 'Manufactor';
            DataClassification = CustomerContent;
        }
        field(2016; CookModel; Text[30])
        {
            Caption = 'Model';
            DataClassification = CustomerContent;
        }
        field(2017; OvenYear; Text[10])
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
        }
        field(2018; OvenManufactor; Text[30])
        {
            Caption = 'Manufactor';
            DataClassification = CustomerContent;
        }
        field(2019; OvenModel; Text[30])
        {
            Caption = 'Model';
            DataClassification = CustomerContent;
        }
        field(2020; HoodYear; Text[10])
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
        }
        field(2021; HoodManufactor; Text[30])
        {
            Caption = 'Manufactor';
            DataClassification = CustomerContent;
        }
        field(2022; HoodStoveModel; Text[30])
        {
            Caption = 'Model';
            DataClassification = CustomerContent;
        }
        field(2023; FridgeYear; Text[10])
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
        }
        field(2024; FridgeManufactor; Text[30])
        {
            Caption = 'Manufactor';
            DataClassification = CustomerContent;
        }
        field(2025; FridgeModel; Text[30])
        {
            Caption = 'Model';
            DataClassification = CustomerContent;
        }
        field(2026; FreezerYear; Text[10])
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
        }
        field(2027; FreezerManufactor; Text[30])
        {
            Caption = 'Manufactor';
            DataClassification = CustomerContent;
        }
        field(2028; FreezerModel; Text[30])
        {
            Caption = 'Model';
            DataClassification = CustomerContent;
        }
        field(2029; DishwasherYear; Text[10])
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
        }
        field(2030; DishwasherManufactor; Text[30])
        {
            Caption = 'Manufactor';
            DataClassification = CustomerContent;
        }
        field(2031; DishwasherModel; Text[30])
        {
            Caption = 'Model';
            DataClassification = CustomerContent;
        }
        field(2032; WasherYear; Text[10])
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
        }
        field(2033; WasherManufactor; Text[30])
        {
            Caption = 'Manufactor';
            DataClassification = CustomerContent;
        }
        field(2034; WasherModel; Text[30])
        {
            Caption = 'Model';
            DataClassification = CustomerContent;
        }
        field(2035; DryerYear; Text[10])
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
        }
        field(2036; DryerManufactor; Text[30])
        {
            Caption = 'Manufactor';
            DataClassification = CustomerContent;
        }
        field(2037; DryerModel; Text[30])
        {
            Caption = 'Model';
            DataClassification = CustomerContent;
        }
        field(4800; "Dimension Set Id"; Integer)
        {
            Caption = 'Dimension set Id';
        }
    }

    keys
    {
        key(Key1; PropertyNo, Number)
        {
        }
        key(key2; Number)
        {

        }
    }

    fieldgroups
    {
    }

    trigger OnInsert();
    begin
        Vacant := TRUE;
        vacantDate := DMY2DATE(1, 1, 1960);
        SVAParameters.Reset();
        IF SVAParameters.FindSet() then
            IF (SVAParameters.Dim1 = '') OR (SVAParameters.Dim2 = '') OR (SVAParameters.Dim3 = '') then
                Error('Dimensioner mangler opsætning. Kørslen afbrydes');

        //Dimension lejemål på lejemål og dimension ejendom på lejemål
        SVAParameters.Reset();
        if SVAParameters.FindSet() then begin
            DefaultDimension.SetRange("Table ID", 50002);
            DefaultDimension.SetRange("No.", Number);
            if DefaultDimension.FindFirst() then begin
                DefaultDimension."Dimension Value Code" := Number;
                DefaultDimension."Dimension Code" := SVAParameters.Dim1;
                DefaultDimension.Modify(true);
            end else begin
                DefaultDimension.Init();
                DefaultDimension."Table ID" := 50002;
                DefaultDimension."No." := Number;
                DefaultDimension."Dimension Code" := SVAParameters.Dim2;
                DefaultDimension."Dimension Value Code" := Number;
                DefaultDimension."Value Posting" := 1;
                DefaultDimension."Table Caption" := 'Lejemål';
                DefaultDimension.Insert(true);
                //Dimension ejendom på lejemål
                DefaultDimension."Dimension Code" := SVAParameters.Dim1;
                DefaultDimension."Dimension Value Code" := PropertyNo;
                DefaultDimension.Insert(true);
            end;
        end;
        //dimensionsværdi lejemål
        DimensionValue.Reset();
        DimensionValue.SetRange("Dimension Code", SVAParameters.Dim2);
        DimensionValue.SetRange(Code, Number);
        if DimensionValue.FindFirst() then begin
            DimensionValue.code := Number;
            DimensionValue.Modify(true);
        end else begin
            DimensionValue.Init();
            DimensionValue."Dimension Code" := SVAParameters.Dim2;
            DimensionValue.Code := Number;
            DimensionValue.Name := 'Lejemål ' + Number;
            DimensionValue."Dimension Value Type" := 0;
            DimensionValue."Global Dimension No." := 2;
            DimensionValue.Id := CreateGuid();
            DimensionValue."Last Modified Date Time" := CurrentDateTime;
            DimensionValue.Insert(true);
        end;
    end;

    trigger OnRename()
    begin
        TenNoOld := xrec.Number;
        DimensionManagement.RenameDefaultDim(Database::"SVA Tenancy", xrec.Number, Number);
        //Dimension lejemål på lejemål og dimension ejendom på lejemål
        SVAParameters.Reset();
        if SVAParameters.FindSet() then begin
            DefaultDimension.SetRange("Table ID", 50002);
            DefaultDimension.SetRange("No.", Number);
            if DefaultDimension.FindFirst() then begin
                DefaultDimension."Dimension Value Code" := Number;
                DefaultDimension."Dimension Code" := SVAParameters.Dim1;
                DefaultDimension.Modify(true);
                //Message('Modify Dim1');
            end else begin
                DefaultDimension."Table ID" := 50002;
                DefaultDimension."No." := Number;
                DefaultDimension."Dimension Code" := SVAParameters.Dim2;
                DefaultDimension."Dimension Value Code" := Number;
                DefaultDimension."Value Posting" := 1;
                DefaultDimension."Table Caption" := 'Lejemål';
                DefaultDimension.Insert(true);
                //Dimension ejendom på lejemål
                DefaultDimension."Dimension Code" := SVAParameters.Dim1;
                DefaultDimension."Dimension Value Code" := PropertyNo;
                //Message('Insert dim1');
                DefaultDimension.Insert(true);
            end;
        end;

    end;

    trigger OnDelete();
    begin
        SVAOccupant.Reset();
        SVAOccupant.SetRange(TenancyNo, Number);
        SVAOccupant.SetRange(PropertyNo, PropertyNo);
        if SVAOccupant.FindFirst() then
            Error('Der findes beboeraftale på lejemålet. Slet disse først');


        SVASubscriptionLines.Reset();
        SVASubscriptionLines.SetRange(Tenancies, Number);
        if SVASubscriptionLines.FindSet() then
            SVASubscriptionLines.Delete();

        DimensionManagement.DeleteDefaultDim(DATABASE::"SVA Tenancy", Number);
    end;

    var
        PostCode: Record "Post Code";
        SVAProperty: Record "SVA Property";
        SVAOccupant: Record "SVA Occupant";
        DimensionValue: Record "Dimension Value";
        DefaultDimension: Record "Default Dimension";
        SVAParameters: Record "SVA Parameters";
        SVASubscriptionLines: Record "SVA Subscription Lines";
        DimensionManagement: Codeunit DimensionManagement;
        TenNoOld: Text[20];
        Country: Text;

}

