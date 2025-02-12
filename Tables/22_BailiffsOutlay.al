table 50022 "SVA Bailiff's Outlay"
{
    DataClassification = CustomerContent;
    DrillDownPageId = "SVA Bailiffs Outlay";
    LookupPageId = "SVA Bailiffs Outlay";

    fields
    {
        field(1; LawyerCaseNo; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Lawyer Case No.';
        }
        field(10; LawyerName; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Lawyer name';
        }
        field(11; LawyerAddress; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Lawyer address';
        }
        field(12; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
            TableRelation = "Post Code";

            trigger OnValidate();
            begin
                Postcode.ValidatePostCode(City, "Post Code", Country, "Country/Region Code", (CurrFieldNo <> 0) AND GUIALLOWED);
            end;
        }
        field(13; City; Text[50])
        {
            Caption = 'City';
            TableRelation = IF ("Country/Region Code" = CONST()) "Post Code".City
            ELSE
            IF ("Country/Region Code" = FILTER(<> '')) "Post Code".City WHERE("Country/Region Code" = FIELD("Country/Region Code"));

            trigger OnValidate();
            begin
                Postcode.ValidateCity(City, "Post Code", Country, "Country/Region Code", (CurrFieldNo <> 0) AND GUIALLOWED);
            end;
        }
        field(14; "Country/Region Code"; Code[10])
        {
            Caption = 'Country';
            TableRelation = "Country/Region";
        }
        field(15; "Contact name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Contact name';
        }
        field(16; LawyerPhone; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Phone';
        }
        field(17; "VAT registration No."; Text[20])
        {
            DataClassification = CustomerContent;
            Caption = 'VAT registration No.';
        }
        field(18; Bankname; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Bank name';
        }
        field(19; BankBranchNo; text[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Bank branch No.';
        }
        field(20; BankAccountNo; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Bank account No.';
        }
        field(21; LawyerEmail; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'Email';
        }
        field(30; Occupant; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Occupant';
            TableRelation = "SVA Occupant".Number;
            trigger OnValidate()
            var
                SVAOccupant: Record "SVA Occupant";
            begin
                SVAOccupant.Reset();
                SVAOccupant.SetRange(Number, rec.Occupant);
                if SVAOccupant.FindFirst() then
                    rec.OccupantName := SVAOccupant.Name1;
            end;
        }
        field(31; OccupantName; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Occupant name';
        }
        field(32; "Judgment date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Judgment date';
        }
        field(33; "Letter recieved"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Letter recieved';
        }
        field(40; Amount; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Amount';
        }

    }

    keys
    {
        key(LawyerCaseNo; LawyerCaseNo)
        {
            Clustered = true;
        }
    }

    var
        PostCode: Record "Post Code";
        Country: Text;


    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}