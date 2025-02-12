table 50005 "SVA Subscription Lines"
{
    Caption = 'Subscription lines';
    DataClassification = CustomerContent;

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
                SetPeriods();
                SVACosttype.RESET();
                SVACosttype.SETRANGE(SVACosttype.Costtype, "Cost Types");
                IF SVACosttype.FindFirst() THEN BEGIN
                    Description := SVACosttype.Description;
                    VatGroup := SVACosttype.VatGroup;
                    ProductPostingGroup := SVACosttype.ProductPostingGroup;
                    Type := SVACosttype.Type;
                    Order := SVACosttype.Order;
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
            OptionCaption = 'Other,Rent,ACheat,ACwater,ACElectric,ACCooling,ACOperating,Antenna,Internet,OccGroup,Deposit,Prepaid rent,Settlement,MovingCost';
            OptionMembers = Other,Rent,ACheat,ACwater,ACElectric,ACCooling,ACOperating,Antenna,Internet,OccGroup,Deposit,"Prepaid rent",Settlement,Movingcost;
        }
        field(6; Order; Integer)
        {
            Caption = 'Order';
        }
        field(9; Costtype; Enum "SVA Cost types")
        {
            Caption = 'Type';
        }

        field(11; "Date From"; Date)
        {
            Caption = 'From date';
            NotBlank = true;
            trigger OnValidate();
            begin
                if (DATE2DMY("Date From", 1) > 1) then
                    "Date from" := DMY2Date(1, DATE2DMY("Date From", 2), DATE2DMY("Date From", 3))
            end;

        }
        field(12; "Date To"; Date)
        {
            Caption = 'To date';
        }
        field(16; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

        }
        field(17; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }

        field(21; "Amount Year"; Decimal)
        {
            Caption = 'Amount Year';

            trigger OnValidate();
            begin
                SetPeriods();
                IF "Amount Year" <> 0 THEN
                    "Amount Period" := "Amount Year" / Periods;

            end;
        }
        field(22; "Amount Period"; Decimal)
        {
            Caption = 'Amount period';

            trigger OnValidate();
            begin
                SetPeriods();
                IF "Amount Period" <> 0 THEN
                    "Amount Year" := "Amount Period" * Periods;

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
            //Caption = 'Priceindekseres'; //New caption. It is not only priceindex.
            Caption = 'Regulated';
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
                GenProductPostingGroup.Reset();
                GenProductPostingGroup.SetRange(code, ProductPostingGroup);
                if GenProductPostingGroup.FindFirst() then
                    VatGroup := GenProductPostingGroup."Def. VAT Prod. Posting Group";

            end;
        }
    }
    keys
    {
        key(Key1; Tenancies, Order, "Cost Types", "Date From", Keynumber)
        {
        }
    }

    fieldgroups
    {
    }

    var
        SVACosttype: Record "SVA Cost type";
        SVATenancy: Record "SVA Tenancy";
        GenProductPostingGroup: Record "Gen. Product Posting Group";
        Periodtype: Integer;
        Periods: Integer;




    trigger OnInsert();
    begin
        if ProductPostingGroup = '' then
            Error('Der manger produktbogføringsgruppe');
        if VatGroup = '' then
            Error('Der mangler momsproduktbogføringsgrupppe');
    end;

    local procedure SetPeriods();
    begin
        SVATenancy.Reset();
        SVATenancy.SETRANGE(Number, Tenancies);
        IF SVATenancy.FINDFIRST() THEN BEGIN
            Periodtype := SVATenancy.PeriodYear;
            IF Periodtype = 0 THEN  //Mth
                Periods := 12;

            IF Periodtype = 1 THEN  //Qty
                Periods := 4;

            IF Periodtype = 2 THEN //½Yr
                Periods := 2;

            IF Periodtype = 3 THEN  //yr
                Periods := 1

        END;
    end;
}

