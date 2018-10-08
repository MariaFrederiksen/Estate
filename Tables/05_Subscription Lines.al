table 50005 "SVA Subscription Lines"
{
    Caption='Subscription lines';

    fields
    {
        field(2;Tenancies;Code[10])
        {
            Caption='Tenancy no';
            TableRelation = "SVA Tenancy".Number;
        }
        field(3;"Cost Types";Code[10])
        {
            Caption='Costtype';
            TableRelation = "SVA Cost type";

            trigger OnValidate();
            begin
                SetPeriods;
                CosttypeEstate.RESET();
                CosttypeEstate.SETRANGE(CosttypeEstate.Costtype,"Cost Types");
                IF CosttypeEstate.FINDFIRST THEN BEGIN
                  Description := CosttypeEstate.Description;
                  VatGroup := CosttypeEstate.VatGroup;
                  Type := CosttypeEstate.Type
                  END;
            end;
        }
        field(4;Description;Text[30])
        {
            Caption='Description';
        }
        field(5;Type;Option)
        {
            Caption='Type';
            DataClassification = ToBeClassified;
            OptionCaption='Other,Rent,ACheat,ACwater,ACElectric,ACCooling,Antenna,Internet,OccGroup,Deposit,Prepaid rent, Settlement,Move Out';
            OptionMembers = Other,Rent,ACheat,ACwater,ACElectric,ACCooling,Antenna,Internet,OccGroup,Deposit,"Prepaid rent"," Settlement",MoveOut;
        }
        field(11;"Date From";Date)
        {
            Caption='From date';
        }
        field(12;"Date To";Date)
        {
            Caption='To date';
        }
        field(21;"Amount Year";Decimal)
        {
            Caption='Amount Year';

            trigger OnValidate();
            begin
                SetPeriods;
                IF "Amount Year" <> 0 THEN BEGIN
                  "Amount Period" := "Amount Year"/Periods;
                  END;
            end;
        }
        field(22;"Amount Period";Decimal)
        {
            Caption='Amount period';

            trigger OnValidate();
            begin
                SetPeriods;
                IF "Amount Period" <> 0 THEN BEGIN
                  "Amount Year" := "Amount Period"*Periods;
                  END;
            end;
        }
        field(30;KeyNumber;Decimal)
        {
        }
        field(31;VatGroup;Code[10])
        {
            Caption='VAT Bus. Posting Group';
            TableRelation = "VAT Product Posting Group".Code;
        }
        field(40;PriceIndeks;Boolean)
        {
            Caption='Priceindekseres';
            trigger OnValidate();
            begin
                IF Type <> 1 then
                    PriceIndeks := false;
            end;    
        }
    }

    keys
    {
        key(Key1;Tenancies,"Cost Types","Date From","Date To",KeyNumber)
        {
        }
    }

    fieldgroups
    {
    }

    var
        TEXT001 : Label 'To date must be after from date';
        CosttypeEstate : Record "SVA Cost type";
        Periodtype : Integer;
        Periods : Integer;
        Tenancy : Record "SVA Tenancy";

    local procedure SetPeriods();
    begin
        Tenancy.RESET;
        Tenancy.SETRANGE(Number,Tenancies);
        IF Tenancy.FINDFIRST() THEN BEGIN
        Periodtype := Tenancy.PeriodYear;
        IF Periodtype = 0 THEN BEGIN //Mth
          Periods := 12;
          END;
        IF Periodtype = 1 THEN BEGIN //Qty
          Periods := 4;
          END;
        IF Periodtype = 2 THEN BEGIN //½Yr
          Periods := 2;
          END;
        IF Periodtype = 3 THEN BEGIN //yr
          Periods := 1
          END;
        END;
    end;
}

