table 50000 "SVA Parameters"
{
    // Opsætningstabel for NAV Ejendom

    Caption = 'Parameters';
    DataClassification = CustomerContent;
    Permissions = TableData 50000 = rimd;
    DrillDownPageID = "SVA Setup Estate List";
    LookupPageID = "SVA Setup Estate List";

    fields
    {
        field(10; Number; Code[10])
        {
            Caption = 'Parameter number';
            Description = 'Rownumber';
        }
        field(20; Name; Text[50])
        {
            Caption = 'Name';
            Description = 'Udlejers navn (på betalingservice)';
        }
        field(30; Address; Text[50])
        {
            Caption = 'Address';
            Description = 'Udlejers adresse';
        }
        field(40; "Post code"; Code[20])
        {
            Caption = 'Zipcode';
            Description = 'Udlejers postnummer';
            TableRelation = IF ("Country/Region Code" = CONST()) "Post Code".Code
            ELSE
            IF ("Country/Region Code" = FILTER(<> '')) "Post Code".Code WHERE("Country/Region Code" = FIELD("Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate();
            begin
                PostCode.ValidatePostCode(City, "Post code", Country, "Country/Region Code", (CurrFieldNo <> 0));
            end;
        }
        field(45; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            Description = 'Udlejers landekode';
            TableRelation = "Country/Region";
        }
        field(50; City; Text[50])
        {
            Caption = 'City';
            Description = 'Udlejers by';
            TableRelation = IF ("Country/Region Code" = CONST()) "Post Code".City
            ELSE
            IF ("Country/Region Code" = FILTER(<> '')) "Post Code".City WHERE("Country/Region Code" = FIELD("Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate();
            begin
                PostCode.ValidateCity(City, "Post code", Country, "Country/Region Code", (CurrFieldNo <> 0) AND GUIALLOWED);
            end;
        }
        field(60; "VAT Registration No."; Text[10])
        {
            Caption = 'VAT Registration No.';
            Description = 'Udlejers cvrnr';

            trigger OnValidate();
            var
                VATRegNoFormat: Record "VAT Registration No. Format";
            begin
                VATRegNoFormat.Test("VAT Registration No.", "Country/Region Code", '', DATABASE::"Company Information");
            end;
        }
        field(100; "Bank Name"; Text[50])
        {
            Caption = 'Bank Name';
            Description = 'Bank navn';
        }
        field(110; "Bank Branch No"; Text[4])
        {
            Caption = 'Bank Branch No';
            Description = 'Bank reg.nr.';
        }
        field(120; "Bank Account No."; Text[10])
        {
            Caption = 'Bank Account No.';
            Description = 'Bank kontonummer';
        }
        field(150; BS_Dataprovider; Text[10])
        {
            Caption = 'Data provider';
            Description = 'Dataleverandørens cvr nr.';

            trigger OnValidate();
            begin
                IF STRLEN(BS_Dataprovider) <> 8 THEN
                    ERROR(TEXT008);
            end;
        }
        field(170; BS_Delsystem; Text[5])
        {
            Caption = 'BS Partcode';
            Description = 'NETS delsystem (leveres fra NETS)';

            trigger OnValidate();
            begin
                IF STRLEN(BS_Delsystem) <> 3 THEN
                    ERROR(TEXT003);
            end;
        }
        field(180; BS_DebGrp; Text[5])
        {
            Caption = 'BS Custgroup';
            Description = 'NETS debitorgruppe (leveres fra NETS)';

            trigger OnValidate();
            begin
                IF STRLEN(BS_DebGrp) <> 5 THEN
                    ERROR(TEXT005);
            end;
        }
        field(200; BS_AftaleNo; Text[10])
        {
            Caption = 'AppointmentNo';
            Description = 'NETS aftalenr (leveres fra NETS)';

            trigger OnValidate();
            begin
                IF STRLEN(BS_AftaleNo) <> 8 THEN
                    ERROR(TEXT008);
            end;
        }
        field(220; BS_Advis; Text[60])
        {
            Caption = 'Advis';
            Description = 'Overskriftslinje til betalingsservice';
        }

        field(450; BS_Ledgeraccount; Code[10])
        {
            Caption = 'LedgerAccount';
            Description = 'Finanskonto for bankkonto';
            TableRelation = "G/L Account"."No.";
        }
        field(451; BS_ImportText; Text[50])
        {
            Caption = 'Trans Text';
            Description = 'Tekst til bogføring af betalinger';
            InitValue = 'NETS indbetaling';
        }
        field(452; BS_WorkSheet; Code[10])
        {
            Caption = 'Worksheet';
            Description = 'Finanskladde til bogføring af betalinger';
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = field(BS_Worksheettype));
        }
        field(500; ReminderFeeRes; Decimal)
        {
            Caption = 'Fee for residens';
            Description = 'Rykkergebyr boliglejemål';
        }
        field(501; ReminderFeeProf; Decimal)
        {
            Caption = 'Fee for prof. rent';
            Description = 'Rykkergebyr erhvervslejemål';
        }
        field(550; IntMaintenance; Decimal)
        {
            Caption = 'Rate for §22 stk. 1.';
            Description = 'Sats for vedligeholdelse (§22)';
        }
        field(560; Numberserie; Code[20])
        {
            Caption = 'Numberserie for contracts';
            Description = 'Nummerserie for beboeraftaler';
            TableRelation = "No. Series".Code;
        }
        field(565; Splitcalc; Boolean)
        {
            Caption = 'Contract calc. days?';
        }
        field(570; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(580; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(610; Dim1; Code[20])
        {
            Caption = 'Dimension for property';
            TableRelation = Dimension.Code;
        }
        field(620; Dim2; Code[20])
        {
            Caption = 'Dimension for tenancy';
            TableRelation = Dimension.Code;
        }

        field(630; Dim3; Code[20])
        {
            Caption = 'Dimension for occupants';
            TableRelation = Dimension.Code;
        }
        field(640; BS_WorkSheetType; Code[10])
        {
            Caption = 'Worksheettype';
            Description = 'Finanskladdetype til bogføring af betalinger';
            TableRelation = "Gen. Journal Template".Name;
        }
        field(650; CustomerArrears; Boolean)
        {
            Caption = 'Arrears withdraw in files to NETS';
        }
        field(660; PaymentMethodForNets; Code[10])
        {
            Caption = 'Payment method for NETS';
            Description = 'Betalingsmetode for faktura, der medtages til NETS.';
            TableRelation = "Payment Method".Code;
        }
        field(670; PaymentTerms; Code[10])
        {
            Caption = 'Payment terms for NETS';
            Description = 'Betalingsbetingelser for faktura, der medtages til NETS.';
            TableRelation = "Payment Terms".Code;
        }


    }

    keys
    {
        key(Key1; Number)
        {
        }
    }

    fieldgroups
    {
    }

    var
        PostCode: Record "Post Code";
        Country: Text;
        TEXT005: Label 'There must be 5 digits';
        PathError: Label 'Path must have a valid value';
        VATRegNoFormat: Record "VAT Registration No. Format";
        TEXT008: Label 'There must be 8 digits';
        TEXT003: Label 'There must be 3 sign';
        Properties: Record "SVA Property";

    trigger OnInsert();
    begin
        Properties.Reset;
        if Properties.findset then begin
            Properties.DataVendor := BS_Dataprovider;
            Properties.Modify;
        end;
    end;
}

