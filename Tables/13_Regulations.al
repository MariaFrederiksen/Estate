table 50013 "SVA Regulations"
{
    // Tabellen indeholder de nødvendige felter for regulering af leje samt udskrivning af breve.
    // Mange felter vises ikke og har derfor ingen kode på f.eks. postnummer og by.

    Caption = 'Regulations';
    DataClassification = CustomerContent;
    Permissions = TableData 50013 = rimd;
    fields
    {//Beboer
        field(1; ONumber; Code[10])
        {
            Caption = 'Number';
            TableRelation = "SVA Occupant".Number;
            
        }
        field(2; PropertyNo; Code[10])
        {
            Caption = 'Property';
            
        }
        field(10; OName1; Text[50])
        {
            Caption = 'Name';
        }
        field(11; OName2; Text[50])
        {
            Caption = 'Name 2';
        }
        field(12; OAddress; Text[50])
        {
            Caption = 'Address';
        }
        field(13; OAddress2; Text[50])
        {
            Caption = 'Address 2';
        }
        field(14; OPostcode; Code[10])
        {
            Caption = 'Post code';
        }
        field(15; OCity; Text[50])
        {
            Caption = 'City';
        }
        field(16; OCountry; Code[10])
        {
            Caption = 'Country';
        }
        //Lejemål
        field(20; TenancyNo; Code[10])
        {
            Caption = 'Tenancy';
        }
        field(21; TAddress1; Text[50])
        {
            Caption = 'Address';
        }
        field(22; TAddress2; Text[50])
        {
            Caption = 'Address 2';
        }
        field(23; TPostcode; Code[10])
        {
            Caption = 'Post Code';
        }
        field(24; TCity; Text[50])
        {
            Caption = 'City';
        }
        //Beregningsgrundlag
        field(30; Indeksdate; date)
        {
            Caption = 'Indeksdate';
        }
        field(31; Regulationdate; date)
        {
            Caption = 'Regulationdate';
        }
        field(32; Indeks_Old; Decimal)
        {
            Caption = 'Indeks old';
        }
        field(33; Indeks_New; Decimal)
        {
            Caption = 'Indeks new';
        }
        field(34; Increase; Decimal)
        {
            Caption = 'Increase pct';
        }
        field(35; Costtype; Text[10])
        {
            Caption = 'Costtype';
        }
        field(36; MaxRegulation; Decimal)
        {
            Caption = 'Max. regulation pct';
        }
        field(37; MinRegulation; Decimal)
        {
            Caption = 'Min. regulation pct';
        }
        field(38; ActualRegulation; Decimal)
        {
            Caption = 'Actual regulation pct';
        }
        field(40; RentYearNow; Decimal)
        {
            Caption = 'Rent year now';
        }
        field(41; RentYearNew; Decimal)
        {
            Caption = 'Rent year new';
        }
        field(42; RegulationYear; Decimal)
        {
            Caption = 'Regulation year';
        }
        field(50; RentPerNow; Decimal)
        {
            Caption = 'Rent period now';
        }
        field(51; RentPerNew; Decimal)
        {
            Caption = 'Rent period new';
        }
        field(45; RegulationPer; Decimal)
        {
            Caption = 'Regulation period';
        }
        field(60; DepositNow; Decimal)
        {
            Caption = 'Deposit now';
        }
        field(61; DepositNew; Decimal)
        {
            Caption = 'Deposit new';
        }
        field(62; RegulationDeposit; Decimal)
        {
            Caption = 'Regulation deposit';
        }
        field(70; Closed; Boolean)
        {
            Caption = 'Updated';
        }
        field(71; Printet; Boolean)
        {
            Caption = 'Printet';
        }
        field(80; PrepaidRentNow; Decimal)
        {
            Caption = 'Prepaid rent now';
        }
        field(81; PrepaidRentNew; Decimal)
        {
            Caption = 'Prepaid rent new';
        }
        field(82; RegulationPrepaidrent; Decimal)
        {
            Caption = 'Regulation prepaid rent';
        }
    }
    keys
    {
        key(Key1; ONumber)
        {
        }
    }
    
}
