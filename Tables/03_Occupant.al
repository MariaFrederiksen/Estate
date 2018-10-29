table 50003 "SVA Occupant"
{
    // Tabel 50003, Occupants
    // Tabel til håndtering af stamdata pr. beboeraftale.

    Caption='Occupant';
    DrillDownPageID = 60530;
    LookupPageID = 60530;

    fields
    {
        field(1;Number;Code[10])
        {
            Caption='Number';
        }
        field(2;PropertyNo;Code[10])
        {
            Caption='Property';
            TableRelation = "SVA Tenancy".PropertyNo;
        }
        field(3;TenancyNo;Code[10])
        {
            Caption='Tenancy';
            TableRelation = "SVA Tenancy".Number;

            trigger OnValidate();
            begin
                TenancyCard.RESET;
                TenancyCard.SETRANGE(TenancyCard.Number,TenancyNo);
                IF TenancyCard.FINDFIRST() THEN BEGIN
                  Address := TenancyCard.Address1;
                  Address2 := TenancyCard.Address2;
                  "Post Code" := TenancyCard."Post Code";
                  City := TenancyCard.City;
                  "Country/Region Code" := TenancyCard."Country/Region Code";
                  PropertyNo  := TenancyCard.PropertyNo;
                  END;

                //Sæt forbrugskontonummer.
                Lbno := 2;
                ConsumptionAccountNo := TenancyNo+'0'+FORMAT(Lbno);
                ConsumptionAccountNo := DELSTR(ConsumptionAccountNo,STRPOS(ConsumptionAccountNo,'-'),1);

                  OccupantList.RESET;
                  OccupantList.SETRANGE(ConsumptionAccountNo,ConsumptionAccountNo);
                  IF OccupantList.FIND('-') THEN BEGIN
                    REPEAT
                    Lbno += 2;
                    ConsumptionAccountNo := TenancyNo+'0'+FORMAT(Lbno);
                    ConsumptionAccountNo := DELSTR(ConsumptionAccountNo,STRPOS(ConsumptionAccountNo,'-'),1);
                    UNTIL NEXT = 0
                    END;

            end;
        }
        field(4;"Customer No";Code[10])
        {
            Caption='Customer No.';
            TableRelation = Customer."No.";

            trigger OnValidate();
            begin
                Custcard.RESET;
                Custcard.SETRANGE(Custcard."No.","Customer No");
                IF Custcard.FINDFIRST() THEN BEGIN
                  Name1 := Custcard.Name;
                  Name2 := Custcard."Name 2";
                  Email1 := Custcard."E-Mail";
                  Phone := Custcard."Phone No.";
                  END;
            end;
        }
        field(5;Name1;Text[50])
        {
            Caption='Name';
        }
        field(6;Name2;Text[50])
        {
            Caption='Name 2';
        }
        field(10;Address;Text[50])
        {
            Caption='Address';
        }
        field(11;Address2;Text[50])
        {
            Caption='Address 2';
        }
        field(12;"Post Code";Code[10])
        {
            Caption='Post code';

            trigger OnValidate();
            begin
                Postcode.ValidatePostCode(City,"Post Code",COUNTRY,"Country/Region Code",(CurrFieldNo <> 0) AND GUIALLOWED);
            end;
        }
        field(13;City;Text[50])
        {
            Caption='City';

            trigger OnValidate();
            begin
                Postcode.ValidateCity(City,"Post Code",COUNTRY,"Country/Region Code",(CurrFieldNo <> 0) AND GUIALLOWED);
            end;
        }
        field(14;"Country/Region Code";Code[10])
        {
            Caption='Country';
        }
        field(16;CPRno1;Text[10])
        {
            Caption='Social Securety No (1. tenant)';
        }
        field(17;CPRno2;Text[10])
        {
            Caption='Social Securety No (2. tenant)';
        }
        field(20;Phone;Text[20])
        {
            Caption='Phone';
            ExtendedDatatype = PhoneNo;
        }
        field(22;CellPhone1;Text[20])
        {
            Caption='Cellphone';
            ExtendedDatatype = PhoneNo;
        }
        field(23;CellPhone2;Text[20])
        {
            Caption='Cellphone 2';
            ExtendedDatatype = PhoneNo;
        }
        field(24;Email1;Text[80])
        {
            Caption='E-mail';
            ExtendedDatatype = EMail;
        }
        field(25;Email2;Text[80])
        {
            Caption='E-mail 2';
            ExtendedDatatype = EMail;
        }
        field(30;StartDate;Date)
        {
            Caption='Startdate';

            trigger OnValidate();
            begin
                IF StartDate > 0D THEN BEGIN
                  TenancyCard.RESET;
                  TenancyCard.SETRANGE(TenancyCard.Number,TenancyNo);
                  TenancyCard.SETRANGE(Vacant, TRUE);
                  IF TenancyCard.FINDFIRST() THEN BEGIN
                    //Ingen opsagt dato på lejemålet
                    IF TenancyCard.vacantDate <= StartDate THEN
                      IF (TenancyCard.vacantDate = 0D) AND (TenancyCard.Vacant = FALSE) THEN BEGIN
                      MESSAGE('lejemålet er ikke ledigt.');
                      StartDate := 0D;
                      END;
                    //Opsagt dato efter nye startdato
                    IF TenancyCard.vacantDate > StartDate THEN BEGIN
                      MESSAGE('Lejemålet er ikke ledigt før '+FORMAT(TenancyCard.vacantDate));
                      StartDate := 0D;
                      END;
                    //Lejemålet er ledigt
                    IF TenancyCard.vacantDate <= StartDate THEN BEGIN //Ledigt lejemål
                      IF TenancyCard.vacantDate <> 0D THEN BEGIN
                        TenancyCard.Vacant := FALSE;
                        TenancyCard.vacantDate := 0D;
                        TenancyCard.MODIFY(TRUE);
                        //MESSAGE('lejemål opdateret');
                        END;
                      END;
                   END;
                END;
            end;
        }
        field(31;EndDate;Date)
        {
            Caption='Enddate';

            trigger OnValidate();
            begin
                IF EndDate > 0D THEN BEGIN
                  TenancyCard.RESET;
                  TenancyCard.SETRANGE(TenancyCard.Number,TenancyNo);
                  IF TenancyCard.FINDFIRST() THEN BEGIN
                    TenancyCard.Vacant := TRUE;
                    TenancyCard.vacantDate := EndDate+1;
                    TenancyCard.MODIFY(TRUE);
                    END;
                  END;
                IF EndDate = 0D THEN BEGIN //Empty Date => Not vacant
                  TenancyCard.RESET;
                  TenancyCard.SETRANGE(TenancyCard.Number,TenancyNo);
                  IF TenancyCard.FINDFIRST THEN BEGIN
                    TenancyCard.Vacant := FALSE;
                    TenancyCard.vacantDate := 0D;
                    TenancyCard.MODIFY(TRUE);
                    END;
                END;
            end;
        }
        field(32;FirstNets;Date)
        {
            Caption='First time for NETS';
        }
        field(33;Blocked;Date)
        {
            Caption='Blocked';
        }
        field(34;Bankname;Text[30])
        {
            Caption='Bankname';
        }
        field(35;"Bankreg-no";Text[30])
        {
            Caption='Bank branch no';
        }
        field(36;BankAccount;Text[30])
        {
            Caption='Bankaccount';
        }
        field(37;"Collection Month";Option)
        {
            Caption='Collection Month';
            OptionCaption='Jan,Feb,Mar,Apr,May,Jun,Jul,Aug,Sep,Oct,Nov,Dec';
            OptionMembers = jan,feb,mar,apr,may,jun,jul,aug,sep,oct,nov,dec;
        }
        field(40;ChairmanOfTheBoard;Boolean)
        {
            Caption='Chairmann of the Board';
        }
        field(41;BoardMember;Boolean)
        {
            Caption='Board member';
        }
        field(42;BoardAccountent;Boolean)
        {
            Caption='Board accountent';
        }
        field(43;ResidentRepresentative;Boolean)
        {
            Caption='ResidentRepresentative';
        }
        field(50;ConsumptionAccountNo;Text[30])
        {
            Caption='ConsumptionAccountNo';
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

    var
        Postcode : Record "Post Code";
        COUNTRY : Text;
        TenancyCard : Record "SVA Tenancy";
        Custcard : Record "Customer";
        OccupantList : Record "SVA Occupant";
        Lbno : Integer;
        Property : Record "SVA Property";
        Occupant : Record "SVA Occupant";
}

