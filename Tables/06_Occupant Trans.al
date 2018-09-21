table 50006 "SVA Occupant Trans"
{
    Caption='Occupant postings';

    fields
    {
        field(1;Occupant;Code[10])
        {
            Caption='Occupant';
            TableRelation = "SVA Occupant".Number;
        }
        field(2;Date;Date)
        {
            Caption='Date';
        }
        field(3;"Cost type Estate";Code[10])
        {
            Caption='Cost type';
            TableRelation = "SVA Cost type Estate".Costtype;
        }
        field(4;Description;Text[30])
        {
            Caption='Text';
        }
        field(5;Qty;Decimal)
        {
            Caption='Qty';
        }
        field(6;Price;Decimal)
        {
            Caption='Price';
        }
        field(7;Amount;Decimal)
        {
            Caption='Amount';
        }
        field(8;"Invoice No";Text[30])
        {
            Caption='Invoice No';
        }
        field(9;Type;Option)
        {
            Caption='Type';
            OptionCaption='Other,Rent,ACheat,ACwater,ACElectric,ACCooling,Antenna,Internet,OccGroup,Deposit,Prepaid rent, Settlement,Move Out';
            OptionMembers = Other,Rent,ACheat,ACwater,ACElectric,ACCooling,Antenna,Internet,OccGroup,Deposit,"Prepaid rent"," Settlement",MoveOut;
        }
    }

    keys
    {
        key(Key1;Occupant,Date,"Cost type Estate","Invoice No")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert();
    begin
        CosttypeEstateRec.RESET;
        CosttypeEstateRec.SETRANGE(Costtype,"Cost type Estate");
        IF FINDFIRST() THEN BEGIN
          Type := CosttypeEstateRec.Type;
          END;
    end;

    var
        CosttypeEstateRec : Record "SVA Cost type Estate";
}

