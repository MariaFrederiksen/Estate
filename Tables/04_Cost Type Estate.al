table 50004 "SVA Cost type"
{
    // Tabel for opsætning af konteringer for NAV Ejendom.

    Caption='Costtype';
    DataClassification = CustomerContent;
    Permissions = TableData 50004 = rimd;
    DrillDownPageID = "SVA Cost Type Estate List";
    LookupPageID = "SVA Cost Type Estate List";

    fields
    {
        field(1;Costtype;Code[10])
        {
            Caption='Costtype';
        }
        field(2;Description;Text[30])
        {
            Caption='Description';
        }
        field(3;Account;Code[10])
        {
            Caption='Account';
            TableRelation = "G/L Account"."No.";
        }
        field(4;Type;Option)
        {
            Caption='Type';
            OptionCaption='Other,Rent,ACheat,ACwater,ACElectric,ACCooling,ACOperating,Antenna,Internet,OccGroup,Deposit,Prepaid rent,Settlement,MovingCost';
            OptionMembers = Other,Rent,ACheat,ACwater,ACElectric,ACCooling,ACOperating,Antenna,Internet,OccGroup,Deposit,"Prepaid rent",Settlement,Movingcost;
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
            Caption='VAT Prod. Posting Group';
            TableRelation = "VAT Product Posting Group".Code;
            NotBlank = true;
        }
        field(8;ProductPostingGroup;Code[20])
        {
            Caption='Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group".Code;
            NotBlank = true;
            trigger OnValidate();
            begin
                ProdPostGrp.Reset;
                ProdPostGrp.SetRange(code,ProductPostingGroup);
                if ProdPostGrp.FindFirst then begin
                    VatGroup := ProdPostGrp."Def. VAT Prod. Posting Group";
                    end;
            end;
        }
    }
     keys
    {
        key(Key1;Costtype)
        {
        }
    }
    Fieldgroups
    {
    }
     
    var
    ProdPostGrp : Record "Gen. Product Posting Group";
   
}

