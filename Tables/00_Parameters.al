table 50000 "SVA Parameters"
{
    // Opsætningstabel for NAV Ejendom

    Caption = 'Parameters';
    DataClassification = CustomerContent;

    fields
    {
        field(10; Number; Code[10])
        {
            Caption = 'Parameter number';
        }
        field(20; Name; Text[50])
        {
            Caption = 'Name';
        }
        field(30; Address; Text[50])
        {
            Caption = 'Address';
        }
        field(40; "Post code"; Code[20])
        {
            Caption = 'Zipcode';
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
            TableRelation = "Country/Region";
        }
        field(50; City; Text[50])
        {
            Caption = 'City';
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
        }
        field(110; "Bank Branch No"; Text[4])
        {
            Caption = 'Bank Branch No';
        }
        field(120; "Bank Account No."; Text[10])
        {
            Caption = 'Bank Account No.';
        }
        field(150; BS_Dataprovider; Text[10])
        {
            Caption = 'Data provider';

            trigger OnValidate();
            begin
                IF STRLEN(BS_Dataprovider) <> 8 THEN
                    ERROR(Digits8Lbl);
            end;
        }
        field(170; BS_Delsystem; Text[5])
        {
            Caption = 'BS Partcode';

            trigger OnValidate();
            begin
                IF STRLEN(BS_Delsystem) <> 3 THEN
                    ERROR(Digits3Lbl);
            end;
        }
        field(180; BS_DebGrp; Text[5])
        {
            Caption = 'BS Custgroup';

            trigger OnValidate();
            begin
                IF STRLEN(BS_DebGrp) <> 5 THEN
                    ERROR(Digits5Lbl);
            end;
        }
        field(200; BS_AftaleNo; Text[10])
        {
            Caption = 'AppointmentNo';

            trigger OnValidate();
            begin
                IF STRLEN(BS_AftaleNo) <> 8 THEN
                    ERROR(Digits8Lbl);
            end;
        }
        field(220; BS_Advis; Text[60])
        {
            Caption = 'Advis';
        }

        field(450; BS_Ledgeraccount; Code[10])
        {
            Caption = 'LedgerAccount';
            TableRelation = "G/L Account"."No.";
        }
        field(451; BS_ImportText; Text[50])
        {
            Caption = 'Trans Text';
            InitValue = 'NETS indbetaling';
        }
        field(452; BS_WorkSheet; Code[10])
        {
            Caption = 'Worksheet';
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = field(BS_Worksheettype));
        }
        field(453; IM_WorkSheet; Code[10])
        {
            Caption = 'Worksheet';
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = field(IM_Worksheettype));
        }
        field(454; IM_Account; Code[10])
        {
            Caption = 'Obsolite';
        }
        field(455; IM_Costtype; Code[10])
        {
            Caption = 'Costtype';
            TableRelation = "SVA Cost type";
        }
        field(456; "Balance account dim"; Option)
        {
            ObsoleteState = Removed;
            ObsoleteReason = 'Not in use';
            OptionMembers = OnePost,PostPerDepartment;
            OptionCaption = 'Obsolite';
        }
        field(500; ReminderFeeRes; Decimal)
        {
            Caption = 'Fee for residens';
        }
        field(501; ReminderFeeProf; Decimal)
        {
            Caption = 'Fee for prof. rent';
        }
        field(550; IntMaintenance; Decimal)
        {
            Caption = 'Rate §22 stk. 1.';
        }
        field(551; IM_Autoposting; Boolean)
        {
            Caption = 'Posting §22';
        }
        field(552; IM_WorkSheetType; Code[10])
        {
            Caption = 'Worksheettype';
            TableRelation = "Gen. Journal Template".Name;
        }
        field(560; Numberserie; Code[20])
        {
            Caption = 'Numberserie for contracts';
            TableRelation = "No. Series".Code;
        }
        field(561; ContactNumberserie; Code[20])
        {
            Caption = 'Obsolite';
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
            TableRelation = "Gen. Journal Template".Name;
        }
        field(650; CustomerArrears; Boolean)
        {
            Caption = 'Arrears withdraw in files to NETS';
        }
        field(651; MaxAmountForArrears; Decimal)
        {
            Caption = 'Max amount for withdraws';
        }
        field(660; PaymentMethodForNets; Code[10])
        {
            Caption = 'Payment method for NETS';
            TableRelation = "Payment Method".Code;
        }
        field(670; PaymentTerms; Code[10])
        {
            Caption = 'Payment terms for NETS';
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
        SVAProperty: Record "SVA Property";
        Country: Text;
        Digits5Lbl: Label 'There must be 5 digits';
        Digits8Lbl: Label 'There must be 8 digits';
        Digits3Lbl: Label 'There must be 3 sign';

    trigger OnInsert();
    begin
        SVAProperty.Reset();
        if SVAProperty.FindSet() then begin
            SVAProperty.DataVendor := BS_Dataprovider;
            SVAProperty.Modify();
        end;
    end;
}

