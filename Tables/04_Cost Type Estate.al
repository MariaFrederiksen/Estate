table 50004 "SVA Cost type"
{
    // Tabel for opsætning af konteringer for NAV Ejendom.

    Caption='Costtype';
    DrillDownPageID = 60540;
    LookupPageID = 60540;

    fields
    {
        field(1;Costtype;Code[10])
        {
            Caption='Costtype';
        }
        field(2;Description;Text[30])
        {
            Caption='Desciption';
        }
        field(3;Account;Code[10])
        {
            Caption='Account';
            TableRelation = "G/L Account"."No.";
        }
        field(4;Type;Option)
        {
            Caption='Type';
            OptionCaption='Other,Rent,ACheat,ACwater,ACElectric,ACCooling,Antenna,Internet,OccGroup,Deposit,Prepaid rent,Settlement,MovingCost';
            OptionMembers = Other,Rent,ACheat,ACwater,ACElectric,ACCooling,Antenna,Internet,OccGroup,Deposit,"Prepaid rent",Settlement,Movingcost;
        }
        field(5;Reminder;Boolean)
        {
            Caption='Reminder';
        }
        field(6;"Order";Integer)
        {
            Caption='Order';
        }
        field(7;VatGroup;Code[10])
        {
            Caption='VAT Bus. Posting Group';
            TableRelation = "VAT Product Posting Group".Code;
        }
    }

    keys
    {
        key(Key1;Costtype)
        {
        }
    }

    fieldgroups
    {
    }
}

