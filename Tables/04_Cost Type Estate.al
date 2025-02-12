table 50004 "SVA Cost type"
{
    // Tabel for opsætning af konteringer for NAV Ejendom.

    Caption = 'Costtype';
    DataClassification = CustomerContent;
    DrillDownPageID = "SVA Cost Type Estate List";
    LookupPageID = "SVA Cost Type Estate List";

    fields
    {
        field(1; Costtype; Code[10])
        {
            Caption = 'Costtype';
        }
        field(2; Description; Text[30])
        {
            Caption = 'Description';
        }
        field(3; Account; Code[10])
        {
            Caption = 'Account';
            TableRelation = "G/L Account"."No.";
        }
        field(4; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = 'Other,Rent,ACheat,ACwater,ACElectric,ACCooling,ACOperating,Antenna,Internet,OccGroup,Deposit,Prepaid rent,Settlement,MovingCost';
            OptionMembers = Other,Rent,ACheat,ACwater,ACElectric,ACCooling,ACOperating,Antenna,Internet,OccGroup,Deposit,"Prepaid rent",Settlement,Movingcost;
        }
        field(5; Reminder; Boolean)
        {
            Caption = 'Reminder';
        }
        field(6; "Order"; Integer)
        {
            Caption = 'Order';
        }
        field(7; VatGroup; Code[10])
        {
            Caption = 'VAT Prod. Posting Group';
            TableRelation = "VAT Product Posting Group".Code;
            NotBlank = true;
        }
        field(8; ProductPostingGroup; Code[20])
        {
            Caption = 'Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group".Code;
            NotBlank = true;
            trigger OnValidate();
            begin
                GenProductPostingGroup.Reset();
                GenProductPostingGroup.SetRange(code, ProductPostingGroup);
                if GenProductPostingGroup.FindFirst() then
                    VatGroup := GenProductPostingGroup."Def. VAT Prod. Posting Group";

            end;
        }
        field(9; "Costtype type"; Enum "SVA Cost types")
        {
            Caption = 'Type';
        }
        field(10; Indeks; Boolean)
        {
            //Caption = 'Priceindekseres'; //New caption. It is not only priceindex.
            Caption = 'Regulate';
        }
    }
    keys
    {
        key(Key1; Costtype)
        {
        }
    }
    Fieldgroups
    {
    }

    var
        GenProductPostingGroup: Record "Gen. Product Posting Group";

}

