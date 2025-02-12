table 50001 "SVA Property"
{
    // Tabel til håndtering af stamdata pr. ejendom

    Caption = 'Property';
    DataClassification = CustomerContent;
    DrillDownPageID = "SVA Property List";
    LookupPageID = "SVA Property List";
    DataCaptionFields = Property, Address1, City;

    fields
    {
        field(1; Property; Code[10])
        {
            Caption = 'Property number';
            NotBlank = true;
        }
        field(2; Name; Text[50])
        {
            Caption = 'Property name';
            trigger OnValidate()
            begin
                SVAParameters.Reset();
                IF SVAParameters.FindFirst() then begin
                    DimensionValue.SetRange("Dimension Code", SVAParameters.Dim1);
                    DimensionValue.SetRange(Code, Rec.Property);
                    IF DimensionValue.FindFirst() then begin
                        DimensionValue.Code := Rec.Property;
                        DimensionValue.Name := 'Ejendom ' + Rec.Name;
                        DimensionValue."Dimension Value Type" := 0;
                        DimensionValue."Global Dimension No." := 1;
                        DimensionValue.Modify(true);
                    end;
                end;
            end;
        }
        field(3; Address1; Text[50])
        {
            Caption = 'Address';
        }
        field(4; Address2; Text[50])
        {
            Caption = 'Address 2';
        }
        field(5; "Post Code"; Code[10])
        {
            Caption = 'Postcode';
            TableRelation = IF ("Country/Region Code" = CONST()) "Post Code".Code
            ELSE
            IF ("Country/Region Code" = FILTER(<> '')) "Post Code".Code WHERE("Country/Region Code" = FIELD("Country/Region Code"));
            ValidateTableRelation = false;

            trigger OnValidate();
            begin
                Postcode.ValidatePostCode(City, "Post Code", Country, "Country/Region Code", (CurrFieldNo <> 0));
            end;
        }
        field(6; City; Text[50])
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
        field(7; "Country/Region Code"; Code[10])
        {
            Caption = 'Country';
            TableRelation = "Country/Region".Name;
        }
        field(8; CompanyRegNo; Text[30])
        {
            Caption = 'Company Reg. No.';
        }
        field(9; CadastralNo; Text[50])
        {
            Caption = 'Cadastral no.';
        }
        field(10; Email; Text[250])
        {
            Caption = 'E-mail';
            ExtendedDatatype = EMail;
        }
        field(11; Emails; Text[2000])
        {
            Caption = 'Obsolite';
        }
        field(12; EmailAll; Blob)
        {
            Caption = 'Obsolite';
        }
        field(13; "Resident representation"; Boolean)
        {
            Caption = 'Resident representation';
        }
        field(14; RR_Fromdate; Date)
        {
            Caption = 'Res.rep. start at';
        }
        field(15; RR_Amount; Decimal)
        {
            Caption = 'Res. rep. amount per month';
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
        field(18; RR_Contact; Code[20])
        {
            Caption = 'Res. rep. contractno.';
            TableRelation = "SVA Occupant".Number where(PropertyNo = field(Property));
            trigger OnValidate()
            var
                SVAOccupant: Record "SVA Occupant";
            begin
                SVAOccupant.Get(RR_Contact);
                RR_Name := SVAOccupant.Name1;
                "Resident representation" := true;
            end;

        }
        field(19; RR_Name; Text[50])
        {
            Caption = 'Res. rep. name';
        }
        field(20; Owner; Text[50])
        {
            Caption = 'Owner';
        }
        field(21; OwnerAddress1; Text[50])
        {
            Caption = 'Address';
        }
        field(22; OwnerAddress2; Text[50])
        {
            Caption = 'Address 2';
        }
        field(23; OwnerPostCode; Code[10])
        {
            Caption = 'Postcode';
            TableRelation = IF (OwnerCountry = CONST()) "Post Code".Code
            ELSE
            IF (OwnerCountry = FILTER(<> '')) "Post Code".Code WHERE("Country/Region Code" = FIELD("Country/Region Code"));
            ValidateTableRelation = false;

            trigger OnValidate();
            begin
                Postcode.ValidatePostCode(OwnerCity, OwnerPostCode, Country, OwnerCountry, (CurrFieldNo <> 0) AND GUIALLOWED);
            end;
        }
        field(24; OwnerCity; Text[50])
        {
            Caption = 'City';
            TableRelation = IF ("Country/Region Code" = CONST()) "Post Code".City
            ELSE
            IF ("Country/Region Code" = FILTER(<> '')) "Post Code".City WHERE("Country/Region Code" = FIELD("Country/Region Code"));
            ValidateTableRelation = false;

            trigger OnValidate();
            begin
                Postcode.ValidateCity(OwnerCity, "Post Code", Country, OwnerCountry, (CurrFieldNo <> 0) AND GUIALLOWED);
            end;
        }
        field(25; OwnerCountry; Code[10])
        {
            Caption = 'Country';
            TableRelation = "Country/Region".Name;
            ValidateTableRelation = false;
        }
        field(26; OwnerPhone; Text[30])
        {
            Caption = 'Phone';
            ExtendedDatatype = PhoneNo;
        }
        field(27; OwnerCell; Text[30])
        {
            Caption = 'Cellphone';
            ExtendedDatatype = PhoneNo;
        }
        field(28; OwnerEmail; Text[50])
        {
            Caption = 'E-mail';
            ExtendedDatatype = EMail;
        }
        field(30; "VAT Prod. Posting Group"; Code[29])
        {
            Caption = 'VAT Prod. Posting Group';
            TableRelation = "VAT Product Posting Group";
        }
        field(40; SquareMetersTotal; Decimal)
        {
            Caption = 'Area';
        }
        field(41; SquareMetersProf; Decimal)
        {
            Caption = 'Area prof';

            trigger OnValidate();
            begin
                SquareMetersTotal := SquareMetersLiv + SquareMetersProf
            end;
        }
        field(42; SquareMetersLiv; Decimal)
        {
            Caption = 'Area residens';

            trigger OnValidate();
            begin
                SquareMetersTotal := SquareMetersLiv + SquareMetersProf
            end;
        }
        field(50; Bankname; Text[50])
        {
            Caption = 'Bank name';
        }
        field(51; BankRegNo; Text[10])
        {
            Caption = 'Bank branch no.';
        }
        field(52; Bankaccount; Text[30])
        {
            Caption = 'Bankaccount';
        }
        field(53; CGPNumber; Text[30])
        {
            Caption = 'CPG no.';
        }
        field(60; ESRNumber; Text[30])
        {
            Caption = 'ESR number';
        }
        field(61; ESRAgrType; Option)
        {
            Caption = 'ESR agreement type';
            OptionMembers = Basis,Total;
        }
        field(62; DataVendor; Text[30])
        {
            Caption = 'Data vendor';
        }
        field(63; ESRSystem; Text[10])
        {
            Caption = 'ESR system';
        }
        field(64; ESRCustgrp; Text[5])
        {

        }
        field(65; "ESR Advis"; Text[30])
        {

        }
        field(80; Startdate; Date)
        {
            Caption = 'Start date';
        }
        field(81; ArchiveDate; Date)
        {
            Caption = 'Archive date';
            trigger OnValidate()
            var
                SVATenancy: Record "SVA Tenancy";
            begin
                //Sold or archived
                if ArchiveDate > DMY2Date(1, 1, 1960) then begin
                    SVATenancy.Reset();
                    SVATenancy.SetRange(PropertyNo, Property);
                    if SVATenancy.FindSet() then
                        repeat
                            SVATenancy.Vacant := false;
                            SVATenancy.Modify();
                        until SVATenancy.Next() = 0;
                end;
            end;
        }
        field(110; FinancialYearFrom; Option)
        {
            Caption = 'Financial year start';
            OptionCaption = 'None,Jan,Feb,Mar,April,May,Jun,Jul,Aug,Sep,Oct,Nov,Dec';
            OptionMembers = None,Jan,Feb,Mar,April,Maj,Jun,Jul,Aug,Sep,Okt,Nov,Dec;

            trigger OnValidate();
            begin
                IF FinancialYearTo > 0 then
                    FinancialYearTo := FinancialYearFrom + 11;
                IF FinancialYearTo > 11 THEN
                    FinancialYearTo := FinancialYearTo - 12;
                IF FinancialYearFrom = 1 THEN
                    FinancialYearTo := 12;
            end;
        }
        field(111; FinancialYearTo; Option)
        {
            Caption = 'Financial year end';
            OptionCaption = 'None,Jan,Feb,Mar,April,May,Jun,Jul,Aug,Sep,Oct,Nov,Dec';
            OptionMembers = "-",Jan,Feb,Mar,April,Maj,Jun,Jul,Aug,Sep,Okt,Nov,Dec;

            trigger OnValidate();
            begin
                FinancialYearFrom := FinancialYearTo - 11;
                IF FinancialYearFrom < 0 THEN
                    FinancialYearFrom := FinancialYearFrom + 12;
                IF FinancialYearTo = 12 THEN
                    FinancialYearFrom := 1;
            end;
        }
        field(112; HeatingYearFrom; Option)
        {
            Caption = 'Heating year start';
            OptionCaption = 'None,Jan,Feb,Mar,April,May,Jun,Jul,Aug,Sep,Oct,Nov,Dec';
            OptionMembers = "-",Jan,Feb,Mar,April,Maj,Jun,Jul,Aug,Sep,Okt,Nov,Dec;

            trigger OnValidate();
            begin
                IF HeatingYearFrom > 0 THEN
                    HeatingYearTo := HeatingYearFrom + 11;
                IF HeatingYearTo > 11 THEN
                    HeatingYearTo := HeatingYearTo - 12;
                IF HeatingYearFrom = 1 THEN
                    HeatingYearTo := 12;
            end;
        }
        field(113; HeatingYearTo; Option)
        {
            Caption = 'Heating year end';
            OptionCaption = 'None,Jan,Feb,Mar,April,May,Jun,Jul,Aug,Sep,Oct,Nov,Dec';
            OptionMembers = "-",Jan,Feb,Mar,April,Maj,Jun,Jul,Aug,Sep,Okt,Nov,Dec;

            trigger OnValidate();
            begin
                HeatingYearFrom := HeatingYearTo - 11;
                IF HeatingYearFrom < 0 THEN
                    HeatingYearFrom := HeatingYearFrom + 12;
                IF HeatingYearTo = 12 THEN
                    HeatingYearFrom := 1;
            end;
        }
        field(114; WaterYearFrom; Option)
        {
            Caption = 'Water year start';
            OptionCaption = 'None,Jan,Feb,Mar,April,May,Jun,Jul,Aug,Sep,Oct,Nov,Dec';
            OptionMembers = "-",Jan,Feb,Mar,April,Maj,Jun,Jul,Aug,Sep,Okt,Nov,Dec;

            trigger OnValidate();
            begin
                IF WaterYearFrom > 0 then
                    WaterYearTo := WaterYearFrom + 11;
                IF WaterYearTo > 11 THEN
                    WaterYearTo := WaterYearTo - 12;
                IF WaterYearFrom = 1 THEN
                    WaterYearTo := 12;
            end;
        }
        field(115; WaterYearTo; Option)
        {
            Caption = 'Water year end';
            OptionCaption = 'None,Jan,Feb,Mar,April,May,Jun,Jul,Aug,Sep,Oct,Nov,Dec';
            OptionMembers = "-",Jan,Feb,Mar,April,Maj,Jun,Jul,Aug,Sep,Okt,Nov,Dec;

            trigger OnValidate();
            begin
                WaterYearFrom := WaterYearTo - 11;
                IF WaterYearFrom < 0 THEN
                    WaterYearFrom := WaterYearFrom + 12;
                IF WaterYearTo = 12 THEN
                    WaterYearFrom := 1;
            end;
        }
        field(116; ElectricYearFrom; Option)
        {
            Caption = 'Electric year start';
            OptionCaption = 'None,Jan,Feb,Mar,April,May,Jun,Jul,Aug,Sep,Oct,Nov,Dec';
            OptionMembers = "-",Jan,Feb,Mar,April,Maj,Jun,Jul,Aug,Sep,Okt,Nov,Dec;

            trigger OnValidate();
            begin
                IF ElectricYearFrom > 0 then
                    ElectricYearTo := ElectricYearFrom + 11;
                IF ElectricYearTo > 11 THEN
                    ElectricYearTo := ElectricYearTo - 12;
                IF ElectricYearFrom = 1 THEN
                    ElectricYearTo := 12;
            end;
        }
        field(117; ElectricYearTo; Option)
        {
            Caption = 'Electric year end';
            OptionCaption = 'None,Jan,Feb,Mar,April,May,Jun,Jul,Aug,Sep,Oct,Nov,Dec';
            OptionMembers = "-",Jan,Feb,Mar,April,Maj,Jun,Jul,Aug,Sep,Okt,Nov,Dec;

            trigger OnValidate();
            begin
                ElectricYearFrom := ElectricYearTo - 11;
                IF ElectricYearFrom < 0 THEN
                    ElectricYearFrom := ElectricYearFrom + 12;
                IF ElectricYearTo = 12 THEN
                    ElectricYearFrom := 1;
            end;
        }
        field(118; ManYearFrom; Option)
        {
            Caption = 'Mantainence year start';
            OptionCaption = 'None,Jan,Feb,Mar,April,May,Jun,Jul,Aug,Sep,Oct,Nov,Dec';
            OptionMembers = "-",Jan,Feb,Mar,April,Maj,Jun,Jul,Aug,Sep,Okt,Nov,Dec;

            trigger OnValidate();
            begin
                IF ManYearFrom > 0 then
                    ManYearTo := ManYearFrom + 11;
                IF ManYearTo > 11 THEN
                    ManYearTo := ManYearTo - 12;
                IF ManYearFrom = 1 THEN
                    ManYearTo := 12;
            end;
        }
        field(119; ManYearTo; Option)
        {
            Caption = 'Mantainence year end';
            OptionCaption = 'None,Jan,Feb,Mar,April,May,Jun,Jul,Aug,Sep,Oct,Nov,Dec';
            OptionMembers = "-",Jan,Feb,Mar,April,Maj,Jun,Jul,Aug,Sep,Okt,Nov,Dec;

            trigger OnValidate();
            begin
                ManYearFrom := ManYearTo - 11;
                IF ManYearFrom < 0 THEN
                    ManYearFrom := ManYearFrom + 12;
                IF ManYearTo = 12 THEN
                    ManYearFrom := 1;
            end;
        }
        field(150; FinCompany; Text[50])
        {
            Caption = 'Accountant';
        }
        field(151; FinCompanyNo; Text[50])
        {
            Caption = 'Case no.';
        }
        field(152; FinEmail; Text[50])
        {
            Caption = 'E-mail';
        }
        field(153; FinLatest; Date)
        {
            Caption = 'Latest report';
        }
        field(160; HeatCompany; Text[50])
        {
            Caption = 'Heat company';
        }
        field(161; HeatCompanyNo; Text[50])
        {
            Caption = 'Plant no.';
        }
        field(162; HeatEmail; Text[50])
        {
            Caption = 'E-mail';
        }
        field(163; HeatLatest; Date)
        {
            Caption = 'Latest report';
        }
        field(164; HeatCompanyLogin; Text[20])
        {
            Caption = 'Login';
        }
        field(165; HeatEmailMoving; Text[50])
        {
            Caption = 'E-mail (moving)';
        }
        field(170; WaterCompany; Text[50])
        {
            Caption = 'Water company';
        }
        field(171; WaterCompanyNo; Text[50])
        {
            Caption = 'Plant no.';
        }
        field(172; WaterEmail; Text[50])
        {
            Caption = 'E-mail';
        }
        field(173; WaterLatest; Date)
        {
            Caption = 'Latest report';
        }
        field(174; WaterCompanyLogin; Text[20])
        {
            Caption = 'Login';
        }
        field(175; WaterEmailMoving; Text[50])
        {
            Caption = 'E-mail (moving)';
        }
        field(180; ElCompany; Text[50])
        {
            Caption = 'Electric company';
        }
        field(181; ELCompanyNo; Text[50])
        {
            Caption = 'Plant no.';
        }
        field(182; ElEmail; Text[50])
        {
            Caption = 'E-mail';
        }
        field(183; ElLatest; Date)
        {
            Caption = 'Latest report';
        }
        field(190; ManLatest; Date)
        {
            Caption = 'Latest report';
        }
        field(500; TypeA9_1_Laundry; Boolean)
        {
            Caption = 'Laundry';
        }
        field(501; TypeA9_1_Bicycle; Boolean)
        {
            Caption = 'Bicycle';
        }
        field(502; TypeA9_1_Courtyard; Boolean)
        {
            Caption = 'Courtyard';
        }
        field(503; TypeA9_3_Taxes; Date)
        {
            Caption = 'Taxes pr.';
        }
        field(504; TypeA9_4_DepMth; Integer)
        {
            Caption = 'Deposit, month';
            trigger OnValidate();
            begin
                Deposit();
            end;
        }
        field(505; TypeA9_4_PrePaidMth; Integer)
        {
            Caption = 'PrePaid rent, month';
            trigger OnValidate();
            begin
                Deposit();
            end;
        }
        field(510; TypeA9_5_LandlordHeat; Boolean)
        {
            Caption = 'Landlord heat';

            trigger OnValidate();
            begin
                if TypeA9_5_LandlordHeat = true then begin
                    TypeA9_5_TenantHeat := false;
                    TypeA9_5_Tgas := false;
                    TypeA9_5_TNatgas := false;
                    TypeA9_5_TOil := false;
                    TypeA9_5_TOTher := false;
                    TypeA9_5_TOtherText := '';
                end;
                if TypeA9_5_LandlordHeat = false then begin
                    TypeA9_5_LNatgas := FALSE;
                    TypeA9_5_lOil := FALSE;
                    TypeA9_5_LEl := FALSE;
                    TypeA9_5_TOTher := false;
                    TypeA9_5_TOtherText := '';
                end;
            end;
        }
        field(511; TypeA9_5_LNatgas; Boolean)
        {
            Caption = 'Natural Gas';

            trigger OnValidate();
            begin
                IF TypeA9_5_LNatgas = true THEN BEGIN
                    TypeA9_5_lOil := FALSE;
                    TypeA9_5_LEl := FALSE;
                    TypeA9_5_LandlordHeat := TRUE;
                END;
                IF TypeA9_5_LNatgas = false THEN
                    TypeA9_5_LandlordHeat := false;
                Validate(TypeA9_5_LandlordHeat);
            end;
        }
        field(512; TypeA9_5_lOil; Boolean)
        {
            Caption = 'Central heating wtih oil';

            trigger OnValidate();
            begin
                IF TypeA9_5_lOil = true THEN BEGIN
                    TypeA9_5_LNatgas := FALSE;
                    TypeA9_5_LEl := FALSE;
                    TypeA9_5_LandlordHeat := TRUE;
                END;
                IF TypeA9_5_lOil = false THEN
                    TypeA9_5_LandlordHeat := false;
            end;
        }
        field(513; TypeA9_5_LEl; Boolean)
        {
            Caption = 'Electricity for heating';

            trigger OnValidate();
            begin
                IF TypeA9_5_LEl = true THEN BEGIN
                    TypeA9_5_lOil := FALSE;
                    TypeA9_5_LNatgas := FALSE;
                    TypeA9_5_LandlordHeat := TRUE;
                END;
                IF TypeA9_5_LEl = false THEN
                    TypeA9_5_LandlordHeat := false;

            end;
        }
        field(514; TypeA9_5_LOther; Boolean)
        {
            Caption = 'Other';

            trigger OnValidate();
            begin
                IF TypeA9_5_LOther = true then
                    TypeA9_5_LandlordHeat := TRUE;
                IF TypeA9_5_LOther = false THEN begin
                    TypeA9_5_LandlordHeat := false;
                    TypeA9_5_LOtherText := '';
                end;
            end;
        }
        field(515; TypeA9_5_LOtherText; Text[30])
        {
            Caption = 'Description';
        }
        field(520; TypeA9_5_TenantHeat; Boolean)
        {
            Caption = 'Tenant heating';

            trigger OnValidate();
            begin
                IF TypeA9_5_TenantHeat = true THEN BEGIN
                    TypeA9_5_LandlordHeat := FALSE;
                    TypeA9_5_LEl := FALSE;
                    TypeA9_5_LNatgas := FALSE;
                    TypeA9_5_lOil := FALSE;
                    TypeA9_5_LOther := FALSE;
                    TypeA9_5_LOtherText := '';
                END;
                if TypeA9_5_TenantHeat = false then begin
                    TypeA9_5_TenantHeat := false;
                    TypeA9_5_Tgas := false;
                    TypeA9_5_TNatgas := false;
                    TypeA9_5_TOil := false;
                    TypeA9_5_TOTher := false;
                    TypeA9_5_TOtherText := '';
                end;
            end;
        }
        field(521; TypeA9_5_TEl; Boolean)
        {
            Caption = 'Electricity';

            trigger OnValidate();
            begin
                IF TypeA9_5_TEl = true THEN BEGIN
                    TypeA9_5_Tgas := FALSE;
                    TypeA9_5_TNatgas := FALSE;
                    TypeA9_5_TOil := FALSE;
                    TypeA9_5_TenantHeat := TRUE;
                END;
                IF TypeA9_5_TEl = false THEN
                    TypeA9_5_TenantHeat := false;
            end;
        }
        field(522; TypeA9_5_Tgas; Boolean)
        {
            Caption = 'Gas';

            trigger OnValidate();
            begin
                IF TypeA9_5_Tgas = true THEN BEGIN
                    TypeA9_5_TEl := FALSE;
                    TypeA9_5_TNatgas := FALSE;
                    TypeA9_5_TOil := FALSE;
                    TypeA9_5_TenantHeat := TRUE;
                END;
                if TypeA9_5_Tgas = false THEN
                    TypeA9_5_TenantHeat := false;

            end;
        }
        field(523; TypeA9_5_TOil; Boolean)
        {
            Caption = 'Oil';

            trigger OnValidate();
            begin
                IF TypeA9_5_TOil = true THEN BEGIN
                    TypeA9_5_Tgas := FALSE;
                    TypeA9_5_TNatgas := FALSE;
                    TypeA9_5_TEl := FALSE;
                    TypeA9_5_TenantHeat := TRUE;
                END;
                IF TypeA9_5_TOil = false THEN
                    TypeA9_5_TenantHeat := false;
            end;
        }
        field(524; TypeA9_5_TNatgas; Boolean)
        {
            Caption = 'Natural gas';

            trigger OnValidate();
            begin
                IF TypeA9_5_TNatgas = true THEN BEGIN
                    TypeA9_5_Tgas := FALSE;
                    TypeA9_5_TOil := FALSE;
                    TypeA9_5_TEl := FALSE;
                    TypeA9_5_TenantHeat := TRUE;
                END;
                IF TypeA9_5_TNatgas = false THEN
                    TypeA9_5_TenantHeat := false;
            end;
        }
        field(525; TypeA9_5_TOTher; Boolean)
        {
            Caption = 'Other';

            trigger OnValidate();
            begin
                IF TypeA9_5_TOTher = true THEN
                    TypeA9_5_TenantHeat := TRUE;
                IF TypeA9_5_TOTher = false THEN begin
                    TypeA9_5_TenantHeat := false;
                    TypeA9_5_TOtherText := '';
                end;

            end;
        }
        field(526; TypeA9_5_TOtherText; Text[30])
        {
            Caption = 'Description';
        }
        field(530; TypeA9_5_Water; Boolean)
        {
            Caption = 'Landlord deliver water';
        }
        field(531; TypeA9_5_WM; Boolean)
        {
            Caption = 'Watermeter';
        }
        field(532; TypeA9_5_Wperiod; Date)
        {
            Caption = 'Water accounting';
        }
        field(540; TypeA9_5_El; Boolean)
        {
            Caption = 'Landlord deliver electricity';
        }
        field(541; TypeA9_5_ElPeriod; Date)
        {
            Caption = 'El accounting';
        }
        field(550; TypeA9_5_Cooling; Boolean)
        {
            Caption = 'Landlord deliver cooling';
        }
        field(551; TypeA9_5_CM; Boolean)
        {
            Caption = 'Coolingmeter';
        }
        field(552; TypeA9_5_CPeriod; Date)
        {
            Caption = 'Cooling accounting';
        }
        field(560; TypeA9_6_LAntenna; Boolean)
        {
            Caption = 'United antenna';
        }
        field(561; TypeA9_6_TAntenna; Boolean)
        {
            Caption = 'Tenant antenna';
        }
        field(562; TypeA9_6_Internet; Boolean)
        {
            Caption = 'Internet';
        }
        field(570; TypeA9_7_MoveIn; Boolean)
        {
            Caption = 'Inspection';
        }
        field(580; TypeA9_8_MainLandlord; Boolean)
        {
            Caption = 'Inside maintenance by landlord';
        }
        field(590; TypeA9_10_Occgroup; Boolean)
        {
            Caption = 'Occupant group';
        }
        field(591; TypeA9_10_HouseStock; Boolean)
        {
            Caption = 'Housestock allowed';
        }
        field(592; TypeA9_10_Houserules; Boolean)
        {
            Caption = 'Houserules';
        }
    }

    keys
    {
        key(Key1; Property)
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; Property, Address1, "Post Code", City)
        {
        }

    }

    trigger OnInsert();
    var

    begin
        SVAParameters.Reset();
        IF NOT SVAParameters.FindFirst() then
            Error('Dimensioner mangler opsætning. Kørslen afbrydes');

        SVAParameters.Reset();
        IF SVAParameters.FindFirst() then begin
            IF (SVAParameters.Dim1 = '') OR (SVAParameters.Dim2 = '') OR (SVAParameters.Dim3 = '') then
                Error('Dimensioner mangler opsætning. Kørslen afbrydes');
            if Bankname = '' then
                Bankname := SVAParameters."Bank Name";
            if BankRegNo = '' then
                BankRegNo := SVAParameters."Bank Branch No";
            if Bankaccount = '' then
                Bankaccount := SVAParameters."Bank Account No.";
        end;

        SVAParameters.Reset();
        IF SVAParameters.FindFirst() then begin
            DefaultDimension.SetRange("Table ID", 50001);
            DefaultDimension.SetRange("No.", Rec.Property);
            IF DefaultDimension.FindFirst() then begin
                DefaultDimension."Dimension Value Code" := Rec.Property;
                DefaultDimension.Modify(true);
            end else begin
                DefaultDimension.Init();
                DefaultDimension."Table ID" := 50001;
                DefaultDimension."No." := Rec.Property;
                DefaultDimension."Dimension Code" := SVAParameters.Dim1;
                DefaultDimension."Dimension Value Code" := Rec.Property;
                DefaultDimension."Value Posting" := "Default Dimension Value Posting Type"::"Code Mandatory";
                DefaultDimension.Insert();
            end;
        end;

        SVAParameters.Reset();
        IF SVAParameters.FindFirst() then begin
            DimensionValue.SetRange("Dimension Code", SVAParameters.Dim1);
            DimensionValue.SetRange(Code, Rec.Property);
            IF DimensionValue.FindFirst() then begin
                DimensionValue.Code := Rec.Property;
                DimensionValue.Modify(true);
            end else begin
                DimensionValue.Init();
                DimensionValue."Dimension Code" := SVAParameters.Dim1;
                DimensionValue.Code := Rec.Property;
                DimensionValue.Name := 'Ejendom ' + Rec.Name;
                DimensionValue."Dimension Value Type" := 0;
                DimensionValue."Global Dimension No." := 1;
                DimensionValue.SystemId := CreateGuid();
                DimensionValue."Last Modified Date Time" := CurrentDateTime;
                DimensionValue.Insert();
            end;
        end;
    end;



    var
        PostCode: Record "Post Code";
        SVATenancy: Record "SVA Tenancy";
        DimensionValue: Record "Dimension Value";
        DefaultDimension: Record "Default Dimension";
        SVAParameters: Record "SVA Parameters";
        Country: Text;



    local procedure Deposit();
    begin
        SVATenancy.Reset();
        SVATenancy.SETRANGE(PropertyNo, Property);
        IF SVATenancy.FindSet() THEN
            REPEAT
                SVATenancy.Deposit := TypeA9_4_DepMth;
                SVATenancy.PrepaidRent := TypeA9_4_PrePaidMth;
                SVATenancy.Modify();
            UNTIL SVATenancy.NEXT() = 0;
    end;

    procedure SendEmailToSomeOccupants()
    var
        SVAOccupant: Record "SVA Occupant";
        User: Record User;
        EmailMessage: Codeunit "Email Message";
        cu_Email: Codeunit Email;
        Recipients: List of [Text];
        CCRecipients: List of [Text];
        BCCRecipients: List of [Text];
        Subject: Text;
        Body: Text;
        TitleMsg: Label 'Information for occupants';
        BodyMsg: Label 'Dear occupant.<br><br>Attached to this mail, there is information regarding your lease<br><br><strong>Regards %1</strong>', Comment = '%1 = username';

    begin
        User.Reset();
        User.Get(UserSecurityId());
        Recipients.Add(User."Contact Email");
        SVAOccupant.Reset();
        SVAOccupant.SetRange(EndDate, 0D);
        SVAOccupant.SetRange(AddToMail, true);
        if SVAOccupant.FindSet() then
            repeat
                if SVAOccupant.Email1 <> '' then
                    BCCRecipients.Add(SVAOccupant.Email1);
                if SVAOccupant.Email2 <> '' then
                    BCCRecipients.Add(SVAOccupant.Email2);
            Until SVAOccupant.Next() = 0;

        Subject := StrSubstNo(TitleMsg);
        Body := StrSubstNo(BodyMsg, User."Full Name");
        EmailMessage.Create(Recipients, Subject, Body, true, CCRecipients, BCCRecipients);
        cu_Email.OpenInEditor(EmailMessage);

    end;

    procedure ResetAddToEmail(pProperty: Record "SVA Property")
    var
        SVAOccupant: Record "SVA Occupant";
    begin
        SVAOccupant.Reset();
        SVAOccupant.SetRange(PropertyNo, pProperty.Property);
        if SVAOccupant.FindSet() then
            SVAOccupant.ModifyAll(AddToMail, false);
    end;

    procedure SendEmailToOccupants(pProperty: Record "SVA Property"; CommitIsSuppressed: Boolean)
    var
        SVAOccupant: Record "SVA Occupant";
        User: Record User;
        EmailMessage: Codeunit "Email Message";
        cu_Email: Codeunit Email;
        Recipients: List of [Text];
        CCRecipients: List of [Text];
        BCCRecipients: List of [Text];
        Subject: Text;
        Body: Text;
        TitleMsg: Label 'Information for occupants in %1.', comment = '%1 = Property address';
        BodyMsg: Label 'Dear occupant.<br><br>Attached to this mail, there is information regarding your lease<br><br><strong>Regards %1</strong>', Comment = '%1 = username';

    begin
        User.Reset();
        User.Get(UserSecurityId());
        Recipients.Add(User."Contact Email");
        SVAOccupant.Reset();
        SVAOccupant.SetRange(PropertyNo, pProperty.Property);
        SVAOccupant.SetRange(EndDate, 0D);
        if SVAOccupant.FindSet() then
            repeat
                if SVAOccupant.Email1 <> '' then
                    BCCRecipients.Add(SVAOccupant.Email1);
                if SVAOccupant.Email2 <> '' then
                    BCCRecipients.Add(SVAOccupant.Email2);
            Until SVAOccupant.Next() = 0;

        Subject := StrSubstNo(TitleMsg, pProperty.Address1);
        Body := StrSubstNo(BodyMsg, User."Full Name");
        EmailMessage.Create(Recipients, Subject, Body, true, CCRecipients, BCCRecipients);
        cu_Email.OpenInEditor(EmailMessage);

    end;

    procedure CreateResRepOnOccupants(Properties: Record "SVA Property")
    var
        l_SVATenancy: Record "SVA Tenancy";
        SVASubscriptionLines: record "SVA Subscription Lines";
        SVACostType: Record "SVA Cost type";
    begin
        SVACostType.Reset();
        SVACostType.SetRange(Type, SVACostType.Type::OccGroup);
        if SVACostType.FindFirst() then begin
            l_SVATenancy.Reset();
            l_SVATenancy.SetRange(PropertyNo, Properties.Property);
            if l_SVATenancy.FindSet() then
                repeat
                    SVACostType.Reset();
                    SVASubscriptionLines.Init();
                    SVASubscriptionLines.Tenancies := l_SVATenancy.Number;
                    SVASubscriptionLines."Cost Types" := SVACostType.Costtype;
                    SVASubscriptionLines.Validate("Cost Types");
                    SVASubscriptionLines."Date From" := Properties.RR_Fromdate;
                    SVASubscriptionLines."Amount Period" := Properties.RR_Amount;
                    SVASubscriptionLines.Validate("Amount Period");
                    if not SVASubscriptionLines.Insert() then
                        SVASubscriptionLines.Modify();
                until l_SVATenancy.Next() = 0;
        end;
    end;

    trigger OnModify();
    var
    begin
        //Update SVATenancy when changes in Type A9 on property
        SVATenancy.Reset();
        SVATenancy.SetRange(PropertyNo, Property);
        if SVATenancy.FindSet() then
            repeat
                SVATenancy.TypeA9_1_Laundy := TypeA9_1_Laundry;
                SVATenancy.TypeA9_1_BicycleStorage := TypeA9_1_Bicycle;
                SVATenancy.TypeA9_1_Courtyard := TypeA9_1_Courtyard;
                SVATenancy.Deposit := TypeA9_4_DepMth;
                SVATenancy.PrepaidRent := TypeA9_4_PrePaidMth;
                SVATenancy.TypeA9_5_LandlordHeat := TypeA9_5_LandlordHeat;
                SVATenancy.TypeA9_5_LNatgas := TypeA9_5_LNatgas;
                SVATenancy.TypeA9_5_lOil := TypeA9_5_lOil;
                SVATenancy.TypeA9_5_LElHeat := TypeA9_5_LEl;
                SVATenancy.TypeA9_5_LOther := TypeA9_5_LOther;

                SVATenancy.TypeA9_5_TenantHeat := TypeA9_5_TenantHeat;
                SVATenancy.TypeA9_5_TEl := TypeA9_5_TEl;
                SVATenancy.TypeA9_5_Tgas := TypeA9_5_Tgas;
                SVATenancy.TypeA9_5_TOil := TypeA9_5_TOil;
                SVATenancy.TypeA9_5_TNatgas := TypeA9_5_TNatgas;
                SVATenancy.TypeA9_5_TOTher := TypeA9_5_TOTher;
                SVATenancy.TypeA9_5_TOtherText := TypeA9_5_TOtherText;

                SVATenancy.TypeA9_5_LandlordWater := TypeA9_5_Water;
                SVATenancy.TypeA9_5_WaterMeter := TypeA9_5_WM;
                SVATenancy.TypeA9_5_LandlordEl := TypeA9_5_El;
                SVATenancy.TypeA9_5_LandlordCooling := TypeA9_5_Cooling;
                SVATenancy.TypeA9_5_CoolingMeter := TypeA9_5_CM;
                SVATenancy.TypeA9_6_AntennaLandlord := TypeA9_6_LAntenna;
                SVATenancy.TypeA9_6_AntennaTenancies := TypeA9_6_TAntenna;
                SVATenancy.TypeA9_6_Internet := TypeA9_6_Internet;
                SVATenancy.TypeA9_7_InspecionIn := TypeA9_7_MoveIn;
                SVATenancy.TypeA9_8_MaintainceInsideLandl := TypeA9_8_MainLandlord;
                if SVATenancy.TypeA9_8_MaintainceInsideLandl = TRUE then
                    SVATenancy.TypeA9_8_MaintainceInsideTenan := FALSE;
                IF SVATenancy.TypeA9_8_MaintainceInsideLandl = FALSE then
                    SVATenancy.TypeA9_8_MaintainceInsideTenan := TRUE;

                SVATenancy.TypeA9_10_HouseRules := TypeA9_10_Houserules;
                SVATenancy.TypeA9_10_LiveStock := TypeA9_10_HouseStock;
                SVATenancy.TypeA9_10_TenRep := TypeA9_10_Occgroup;
                SVATenancy.ArchiveDate := ArchiveDate;
                SVATenancy.Modify(true);
            until SVATenancy.NEXT() = 0;
    end;

    trigger OnDelete();
    begin
        SVATenancy.Reset();
        SVATenancy.SetRange(PropertyNo, Property);
        if SVATenancy.FindFirst() then
            Error('Der findes lejemål på ejendommen. Slet disse først');
    end;

}

