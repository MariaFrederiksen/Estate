table 50005 "SVA Subscription Lines"
{
    Caption = 'Subscription lines';
    DataClassification = CustomerContent;
    Permissions = TableData 50005 = rimd;

    fields
    {
        field(2; Tenancies; Code[10])
        {
            Caption = 'Tenancy no';
            TableRelation = "SVA Tenancy".Number;
            NotBlank = true;

        }
        field(3; "Cost Types"; Code[10])
        {
            Caption = 'Costtype';
            TableRelation = "SVA Cost type";

            trigger OnValidate();
            begin
                SetPeriods;
                CosttypeEstate.RESET();
                CosttypeEstate.SETRANGE(CosttypeEstate.Costtype, "Cost Types");
                IF CosttypeEstate.FINDFIRST THEN BEGIN
                    Description := CosttypeEstate.Description;
                    VatGroup := CosttypeEstate.VatGroup;
                    ProductPostingGroup := CosttypeEstate.ProductPostingGroup;
                    Type := CosttypeEstate.Type;
                    Order := CosttypeEstate.Order;
                END;
            end;
        }
        field(4; Description; Text[30])
        {
            Caption = 'Description';
        }
        field(5; Type; Option)
        {
            Caption = 'Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'Other,Rent,ACheat,ACwater,ACElectric,ACCooling,ACOperating,Antenna,Internet,OccGroup,Deposit,Prepaid rent,Settlement,MovingCost';
            OptionMembers = Other, Rent, ACheat, ACwater, ACElectric, ACCooling, ACOperating, Antenna, Internet, OccGroup, Deposit, "Prepaid rent", Settlement, Movingcost;
        }
        field(6; Order; Integer)
        {
            Caption = 'Order';
        }

        field(11; "Date From"; Date)
        {
            Caption = 'From date';
            NotBlank = true;
            
        }
        field(12; "Date To"; Date)
        {
            Caption = 'To date';
        }
        field(16; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (1));

        }
        field(17; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (2));
        }

        field(21; "Amount Year"; Decimal)
        {
            Caption = 'Amount Year';

            trigger OnValidate();
            begin
                SetPeriods;
                IF "Amount Year" <> 0 THEN BEGIN
                    "Amount Period" := "Amount Year" / Periods;
                END;
            end;
        }
        field(22; "Amount Period"; Decimal)
        {
            Caption = 'Amount period';

            trigger OnValidate();
            begin
                SetPeriods;
                IF "Amount Period" <> 0 THEN BEGIN
                    "Amount Year" := "Amount Period" * Periods;
                END;
            end;
        }
        field(30; KeyNumber; Decimal)
        {
        }
        field(31; VatGroup; Code[10])
        {
            Caption = 'VAT Prod. Posting Group';
            TableRelation = "VAT Product Posting Group".Code;
            NotBlank = true;
        }
        field(40; PriceIndeks; Boolean)
        {
            Caption = 'Priceindekseres';
            trigger OnValidate();
            begin
                IF Type <> 1 then
                    PriceIndeks := false;
            end;
        }
        field(41; ProductPostingGroup; Code[10])
        {
            Caption = 'Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group".Code;
            NotBlank = true;
            trigger OnValidate();
            begin
                ProdPostGrp.Reset;
                ProdPostGrp.SetRange(code, ProductPostingGroup);
                if ProdPostGrp.FindFirst then begin
                    VatGroup := ProdPostGrp."Def. VAT Prod. Posting Group";
                end;
            end;
        }
    }
    keys
    {
        key(Key1; Tenancies, Order, "Cost Types", "Date From", "Date To", Keynumber)
        {
        }
    }

    fieldgroups
    {
    }

    var
        CosttypeEstate: Record "SVA Cost type";
        Periodtype: Integer;
        Periods: Integer;
        Tenancy: Record "SVA Tenancy";
        ProdPostGrp: Record "Gen. Product Posting Group";
        Subscription: record "SVA Subscription Lines";
        Enddate: Date;

    trigger OnInsert();
    begin
        if ProductPostingGroup = '' then
            Error('Der manger produktbogføringsgruppe');
        if VatGroup = '' then
            Error('Der mangler momsproduktbogføringsgrupppe');    
    end;

    local procedure SetPeriods();
    begin
        Tenancy.RESET;
        Tenancy.SETRANGE(Number, Tenancies);
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

