table 50006 "SVA Occupant Trans"
{
    Caption = 'Occupant postings';
    DataClassification = CustomerContent;
    Permissions = TableData 50006 = rimd;
    DrillDownPageID = "SVA Occupant Trans List";
    LookupPageID = "SVA Occupant Trans List";

    fields
    {
        field(1; Occupant; Code[10])
        {
            Caption = 'Occupant';
            TableRelation = "SVA Occupant".Number;
        }
        field(2; Date; Date)
        {
            Caption = 'Date';
        }
        field(3; "Cost type Estate"; Code[10])
        {
            Caption = 'Costtype';
            TableRelation = "SVA Cost type".Costtype;
        }
        field(4; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(5; Qty; Decimal)
        {
            Caption = 'Qty';
        }
        field(6; Price; Decimal)
        {
            Caption = 'Price';
        }
        field(7; Amount; Decimal)
        {
            Caption = 'Amount';
        }
        field(8; "Invoice No"; Text[30])
        {
            Caption = 'Invoice No';
        }
        field(9; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Other,Rent,ACheat,ACwater,ACElectric,ACCooling,ACOperating,Antenna,Internet,OccGroup,Deposit,Prepaid rent,Settlement,MovingCost';
            OptionMembers = Other, Rent, ACheat, ACwater, ACElectric, ACCooling, ACOperating, Antenna, Internet, OccGroup, Deposit, "Prepaid rent", Settlement, Movingcost;
        }
    }

    keys
    {
        key(Key1; Occupant, Date, "Cost type Estate", "Invoice No")
        {
        }
    }

    fieldgroups
    {
    }


    var
        CosttypeEstateRec: Record "SVA Cost type";
}

