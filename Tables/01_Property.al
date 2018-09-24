table 50001 "SVA Property"
{
    // Tabel til håndtering af stamdata pr. ejendom

    Caption='Property';
    DrillDownPageID = 60510;
    LookupPageID = 60510;

    fields
    {
        field(1;Property;Code[10])
        {
            Caption='Number';
        }
        field(2;Name;Text[50])
        {
            Caption='Property name';
        }
        field(3;Address1;Text[50])
        {
            Caption='Address';
        }
        field(4;Address2;Text[50])
        {
            Caption='Address 2';
        }
        field(5;"Post Code";Code[10])
        {
            Caption='Postcode';
            TableRelation = IF ("Country/Region Code"=CONST()) "Post Code".Code
                            ELSE IF ("Country/Region Code"=FILTER(<>'')) "Post Code".Code WHERE ("Country/Region Code" =FIELD("Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate();
            begin
                Postcode.ValidatePostCode(City,"Post Code",Country,"Country/Region Code",(CurrFieldNo <> 0));
            end;
        }
        field(6;City;Text[50])
        {
            Caption='City';
            TableRelation = IF ("Country/Region Code"=CONST()) "Post Code".City
                            ELSE IF ("Country/Region Code"=FILTER(<>'')) "Post Code".City WHERE ("Country/Region Code"=FIELD("Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate();
            begin
                Postcode.ValidateCity(City,"Post Code",Country,"Country/Region Code",(CurrFieldNo <> 0) AND GUIALLOWED);
            end;
        }
        field(7;"Country/Region Code";Code[10])
        {
            Caption='Country';
            TableRelation = "Country/Region".Name;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(8;CompanyRegNo;Text[30])
        {
            Caption='Company Reg. No.';
        }
        field(9;CadastralNo;Text[50])
        {
            Caption='Cadastral no.';
        }
        field(10;Email;Text[250])
        {
            Caption='Email';
            ExtendedDatatype = EMail;
        }
        field(20;Owner;Text[50])
        {
            Caption='Owner';
        }
        field(21;OwnerAddress1;Text[50])
        {
            Caption='Address';
        }
        field(22;OwnerAddress2;Text[50])
        {
            Caption='Address 2';
        }
        field(23;OwnerPostCode;Code[10])
        {
            Caption='Postcode';
            TableRelation = IF (OwnerCountry=CONST()) "Post Code".Code
                            ELSE IF (OwnerCountry=FILTER(<>'')) "Post Code".Code WHERE ("Country/Region Code"=FIELD("Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate();
            begin
                Postcode.ValidatePostCode(OwnerCity,OwnerPostCode,Country,OwnerCountry,(CurrFieldNo <> 0) AND GUIALLOWED);
            end;
        }
        field(24;OwnerCity;Text[50])
        {
            Caption='City';
            TableRelation = IF ("Country/Region Code"=CONST()) "Post Code".City
                            ELSE IF ("Country/Region Code"=FILTER(<>'')) "Post Code".City WHERE ("Country/Region Code"=FIELD("Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate();
            begin
                Postcode.ValidateCity(OwnerCity,"Post Code",Country,OwnerCountry,(CurrFieldNo <> 0) AND GUIALLOWED);
            end;
        }
        field(25;OwnerCountry;Code[10])
        {
            Caption='Country';
            TableRelation = "Country/Region".Name;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(26;OwnerPhone;Text[30])
        {
            Caption='Phone';
            ExtendedDatatype = PhoneNo;
        }
        field(27;OwnerCell;Text[30])
        {
            Caption='Cellphone';
            ExtendedDatatype = PhoneNo;
        }
        field(28;OwnerEmail;Text[50])
        {
            Caption='E-mail';
            ExtendedDatatype = EMail;
        }
        field(40;SquareMetersTotal;Decimal)
        {
            Caption='Square meters Total';
        }
        field(41;SquareMetersProf;Decimal)
        {
            Caption='Square meters Prof';

            trigger OnValidate();
            begin
                SquareMetersTotal := SquareMetersLiv+SquareMetersProf
            end;
        }
        field(42;SquareMetersLiv;Decimal)
        {
            Caption='Square meters Living';

            trigger OnValidate();
            begin
                SquareMetersTotal := SquareMetersLiv+SquareMetersProf
            end;
        }
        field(50;Bankname;Text[50])
        {
            Caption='Bank name';
        }
        field(51;BankRegNo;Text[10])
        {
            Caption='Bank reg.no.';
        }
        field(52;Bankaccount;Text[30])
        {
            Caption='Bankaccount';
        }
        field(53;CGPNumber;Text[30])
        {
            Caption='CPG no.';
        }
        field(60;ESRNumber;Text[30])
        {
            Caption='ESR number';
        }
        field(61;ESRAgrType;Option)
        {
            Caption='ESR agreement type';
            OptionMembers = Basis,Total;
        }
        field(62;DataVendor;Text[30])
        {
            Caption='Data vendor';
        }
        field(63;ESRSystem;Text[10])
        {
            Caption='ESR system';
        }
        field(80;Startdate;Date)
        {
            Caption='Start date';
        }
        field(81;ArchiveDate;Date)
        {
            Caption='Archive date';
        }
        field(110;FinancialYearFrom;Option)
        {
            Caption='Financial year start';
            OptionMembers = "-",Jan,Feb,Mar,April,Maj,Jun,Jul,Aug,Sep,Okt,Nov,Dec;

            trigger OnValidate();
            begin
                FinancialYearTo := FinancialYearFrom + 11;
                IF FinancialYearTo > 11 THEN
                  FinancialYearTo := FinancialYearTo - 12;
                IF FinancialYearFrom = 1 THEN
                  FinancialYearTo := 12;
            end;
        }
        field(111;FinancialYearTo;Option)
        {
            Caption='Financial year end';
            OptionCaption='-,Jan,Feb,Mar,April,May,Jun,Jul,Aug,Sep,Oct,Nov,Dec';
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
        field(112;HeatingYearFrom;Option)
        {
            Caption='Heating year start';
            OptionCaption='None,Jan,Feb,Mar,April,May,Jun,Jul,Aug,Sep,Oct,Nov,Dec';
            OptionMembers = "-",Jan,Feb,Mar,April,Maj,Jun,Jul,Aug,Sep,Okt,Nov,Dec;

            trigger OnValidate();
            begin
                HeatingYearTo := HeatingYearFrom + 11;
                IF HeatingYearTo > 11 THEN
                  HeatingYearTo := HeatingYearTo - 12;
                IF HeatingYearFrom = 1 THEN
                  HeatingYearTo := 12;
            end;
        }
        field(113;HeatingYearTo;Option)
        {
            Caption='Heating year end';
            OptionCaption='-,Jan,Feb,Mar,April,May,Jun,Jul,Aug,Sep,Oct,Nov,Dec';
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
        field(114;WaterYearFrom;Option)
        {
            Caption='Water year start';
            OptionCaption='-,Jan,Feb,Mar,April,May,Jun,Jul,Aug,Sep,Oct,Nov,Dec';
            OptionMembers = "-",Jan,Feb,Mar,April,Maj,Jun,Jul,Aug,Sep,Okt,Nov,Dec;

            trigger OnValidate();
            begin
                WaterYearTo := WaterYearFrom + 11;
                IF WaterYearTo > 11 THEN
                  WaterYearTo := WaterYearTo - 12;
                IF WaterYearFrom = 1 THEN
                  WaterYearTo := 12;
            end;
        }
        field(115;WaterYearTo;Option)
        {
            Caption='Water year end';
            OptionCaption='-,Jan,Feb,Mar,April,May,Jun,Jul,Aug,Sep,Oct,Nov,Dec';
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
        field(116;ElectricYearFrom;Option)
        {
            Caption='Electric year start';
            OptionCaption='-,Jan,Feb,Mar,April,May,Jun,Jul,Aug,Sep,Oct,Nov,Dec';
            OptionMembers = "-",Jan,Feb,Mar,April,Maj,Jun,Jul,Aug,Sep,Okt,Nov,Dec;

            trigger OnValidate();
            begin
                ElectricYearTo := ElectricYearFrom + 11;
                IF ElectricYearTo > 11 THEN
                  ElectricYearTo := ElectricYearTo - 12;
                IF ElectricYearFrom = 1 THEN
                  ElectricYearTo := 12;
            end;
        }
        field(117;ElectricYearTo;Option)
        {
            Caption='Electric year end';
            OptionCaption='-,Jan,Feb,Mar,April,May,Jun,Jul,Aug,Sep,Oct,Nov,Dec';
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
        field(118;ManYearFrom;Option)
        {
            Caption='Mantainence year start';
            OptionCaption='-,Jan,Feb,Mar,April,May,Jun,Jul,Aug,Sep,Oct,Nov,Dec';
            OptionMembers = "-",Jan,Feb,Mar,April,Maj,Jun,Jul,Aug,Sep,Okt,Nov,Dec;

            trigger OnValidate();
            begin
                ManYearTo := ManYearFrom + 11;
                IF ManYearTo > 11 THEN
                  ManYearTo := ManYearTo - 12;
                IF ManYearFrom = 1 THEN
                  ManYearTo := 12;
            end;
        }
        field(119;ManYearTo;Option)
        {
            Caption='Mantainence year end';
            OptionCaption='-,Jan,Feb,Mar,April,May,Jun,Jul,Aug,Sep,Oct,Nov,Dec';
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
        field(150;FinCompany;Text[50])
        {
            Caption='Accountant';
        }
        field(151;FinCompanyNo;Text[50])
        {
            Caption='Case no.';
        }
        field(152;FinEmail;Text[50])
        {
            Caption='E-mail';
        }
        field(153;FinLatest;Date)
        {
            Caption='Latest report';
        }
        field(160;HeatCompany;Text[50])
        {
            Caption='Heat company';
        }
        field(161;HeatCompanyNo;Text[50])
        {
            Caption='Plant no.';
        }
        field(162;HeatEmail;Text[50])
        {
            Caption='E-mail';
        }
        field(163;HeatLatest;Date)
        {
            Caption='Latest report';
        }
        field(170;WaterCompany;Text[50])
        {
            Caption='Water company';
        }
        field(171;WaterCompanyNo;Text[50])
        {
            Caption='Plant no.';
        }
        field(172;WaterEmail;Text[50])
        {
            Caption='E-mail';
        }
        field(173;WaterLatest;Date)
        {
            Caption='Latest report';
        }
        field(180;ElCompany;Text[50])
        {
            Caption='Electric company';
        }
        field(181;ELCompanyNo;Text[50])
        {
            Caption='Plant no.';
        }
        field(182;ElEmail;Text[50])
        {
            Caption='E-mail';
        }
        field(183;ElLatest;Date)
        {
            Caption='Latest report';
        }
        field(190;ManLatest;Date)
        {
        }
        field(500;TypeA9_1_Laundry;Boolean)
        {
            Caption='Laundry';
        }
        field(501;TypeA9_1_Bicycle;Boolean)
        {
            Caption='Bicycle';
        }
        field(502;TypeA9_1_Courtyard;Boolean)
        {
            Caption='Courtyard';
        }
        field(503;TypeA9_3_Taxes;Date)
        {
            Caption='Taxes pr.';
        }
        field(504;TypeA9_4_DepMth;Integer)
        {
            Caption='Deposit, month';
        }
        field(505;TypeA9_4_PrePaidMth;Integer)
        {
            Caption='PrePaid rent, month';
        }
        field(510;TypeA9_5_LandlordHeat;Boolean)
        {
            Caption='Landlord heat';

            trigger OnValidate();
            begin
                IF TypeA9_5_LandlordHeat THEN BEGIN
                  TypeA9_5_TenantHeat := FALSE;
                  TypeA9_5_Tgas := FALSE;
                  TypeA9_5_TNatgas := FALSE;
                  TypeA9_5_TOil := FALSE;
                  TypeA9_5_TOTher :=FALSE;
                  TypeA9_5_TOtherText := '';
                  END;
            end;
        }
        field(511;TypeA9_5_LNatgas;Boolean)
        {
            Caption='Natural Gas';

            trigger OnValidate();
            begin
                IF TypeA9_5_LNatgas THEN BEGIN
                  TypeA9_5_lOil := FALSE;
                  TypeA9_5_LEl := FALSE;
                  TypeA9_5_LandlordHeat := TRUE;
                  END;
            end;
        }
        field(512;TypeA9_5_lOil;Boolean)
        {
            Caption='Central heating wtih oil';

            trigger OnValidate();
            begin
                IF TypeA9_5_lOil THEN BEGIN
                 TypeA9_5_LNatgas := FALSE;
                 TypeA9_5_LEl := FALSE;
                 TypeA9_5_LandlordHeat := TRUE;
                 END;
            end;
        }
        field(513;TypeA9_5_LEl;Boolean)
        {
            Caption='Electricity for heating';

            trigger OnValidate();
            begin
                IF TypeA9_5_LEl THEN BEGIN
                  TypeA9_5_lOil := FALSE;
                  TypeA9_5_LNatgas := FALSE;
                  TypeA9_5_LandlordHeat := TRUE;
                  END;
            end;
        }
        field(514;TypeA9_5_LOther;Boolean)
        {
            Caption='Other';

            trigger OnValidate();
            begin
                IF TypeA9_5_LOther THEN BEGIN
                  TypeA9_5_LandlordHeat := TRUE;
                END;
            end;
        }
        field(515;TypeA9_5_LOtherText;Text[30])
        {
            Caption='Description';
        }
        field(520;TypeA9_5_TenantHeat;Boolean)
        {
            Caption='Tenant heating';

            trigger OnValidate();
            begin
                IF TypeA9_5_TenantHeat THEN BEGIN
                  TypeA9_5_LandlordHeat := FALSE;
                 TypeA9_5_LEl := FALSE;
                 TypeA9_5_LNatgas := FALSE;
                 TypeA9_5_lOil := FALSE;
                 TypeA9_5_LOther := FALSE;
                 TypeA9_5_LOtherText := '';
                 END;
            end;
        }
        field(521;TypeA9_5_TEl;Boolean)
        {
            Caption='Electricity';

            trigger OnValidate();
            begin
                IF TypeA9_5_TEl THEN BEGIN
                  TypeA9_5_Tgas := FALSE;
                  TypeA9_5_TNatgas := FALSE;
                  TypeA9_5_TOil := FALSE;
                  TypeA9_5_TenantHeat := TRUE;
                  END;
            end;
        }
        field(522;TypeA9_5_Tgas;Boolean)
        {
            Caption='Gas';

            trigger OnValidate();
            begin
                IF TypeA9_5_Tgas THEN BEGIN
                  TypeA9_5_TEl := FALSE;
                  TypeA9_5_TNatgas := FALSE;
                  TypeA9_5_TOil := FALSE;
                  TypeA9_5_TenantHeat := TRUE;
                  END;
            end;
        }
        field(523;TypeA9_5_TOil;Boolean)
        {
            Caption='Oil';

            trigger OnValidate();
            begin
                IF TypeA9_5_TOil THEN BEGIN
                  TypeA9_5_Tgas := FALSE;
                  TypeA9_5_TNatgas := FALSE;
                  TypeA9_5_TEl := FALSE;
                  TypeA9_5_TenantHeat := TRUE;
                  END;
            end;
        }
        field(524;TypeA9_5_TNatgas;Boolean)
        {
            Caption='natural gas';

            trigger OnValidate();
            begin
                IF TypeA9_5_TNatgas THEN BEGIN
                  TypeA9_5_Tgas := FALSE;
                  TypeA9_5_TOil := FALSE;
                  TypeA9_5_TEl := FALSE;
                  TypeA9_5_TenantHeat := TRUE;
                  END;
            end;
        }
        field(525;TypeA9_5_TOTher;Boolean)
        {
            Caption='Other';

            trigger OnValidate();
            begin
                IF TypeA9_5_TOTher THEN BEGIN
                  TypeA9_5_TenantHeat := TRUE;
                  END;
            end;
        }
        field(526;TypeA9_5_TOtherText;Text[30])
        {
            Caption='Description';
        }
        field(530;TypeA9_5_Water;Boolean)
        {
            Caption='Landlord deliver water';
        }
        field(531;TypeA9_5_WM;Boolean)
        {
            Caption='Watermeter';
        }
        field(532;TypeA9_5_Wperiod;Date)
        {
            Caption='Water accounting';
        }
        field(540;TypeA9_5_El;Boolean)
        {
            Caption='Landlord deliver electricity';
        }
        field(541;TypeA9_5_ElPeriod;Date)
        {
            Caption='El accounting';
        }
        field(550;TypeA9_5_Cooling;Boolean)
        {
            Caption='Landlord deliver cooling';
        }
        field(551;TypeA9_5_CM;Boolean)
        {
            Caption='Coolingmeter';
        }
        field(552;TypeA9_5_CPeriod;Date)
        {
            Caption='Cooling accounting';
        }
        field(560;TypeA9_6_LAntenna;Boolean)
        {
            Caption='United antenna';
        }
        field(561;TypeA9_6_TAntenna;Boolean)
        {
            Caption='Tenant antenna';
        }
        field(562;TypeA9_6_Internet;Boolean)
        {
            Caption='Internet';
        }
        field(570;TypeA9_7_MoveIn;Boolean)
        {
            Caption='Inspection';
        }
        field(580;TypeA9_8_MainLandlord;Boolean)
        {
            Caption='Inside maintenance by landlord';
        }
        field(590;TypeA9_10_Occgroup;Boolean)
        {
            Caption='Occupant group';
        }
        field(591;TypeA9_10_HouseStock;Boolean)
        {
            Caption='Housestock allowed';
        }
        field(592;TypeA9_10_Houserules;Boolean)
        {
            Caption='Houserules';
        }
    }

    keys
    {
        key(Key1;Property)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnModify();
    begin
        Areas
    end;

    var
        Postcode : Record "Post Code";
        Country : Text;
        Occupant : Record "SVA Occupant";
        Tenancies : Record "SVA Tenancy";

    local procedure Areas();
    begin
        Tenancies.RESET;
        Tenancies.SETRANGE(PropertyNo,Property);
          SquareMetersLiv := 0;
          SquareMetersProf := 0;
          SquareMetersTotal := 0;
        IF Tenancies.FIND('-') THEN BEGIN
          REPEAT
            //SquareMetersLiv += Tenancies.AreaLiv;
            //SquareMetersProf += Tenancies.AreaPro;
            UNTIL Tenancies.NEXT = 0;
            END;
        SquareMetersTotal := SquareMetersLiv+SquareMetersProf;
    end;
}

