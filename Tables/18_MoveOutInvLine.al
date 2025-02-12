table 50018 "SVA MoveOut Invoice Line"
{
    Caption = 'Move out invoice line';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Line Number"; Code[10])
        {
            Caption = 'Occupant';
            TableRelation = "SVA Occupant".Number;
        }
        field(10; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(11; "Cost Type"; Code[20])
        {
            Caption = 'Costtype';
            TableRelation = "SVA Cost type";

            trigger OnValidate();
            begin
                SVACosttype.RESET();
                SVACosttype.SETRANGE(SVACosttype.Costtype, "Cost Type");
                IF SVACosttype.FindFirst() THEN BEGIN
                    Account := SVACosttype.Account;
                    Description := SVACosttype.Description;
                    "VAT Prod. Posting Group" := SVACosttype.VatGroup;
                    "Gen. Prod. Posting Group" := SVACosttype.ProductPostingGroup;
                    Quantity := 1;
                END;
            end;
        }
        field(12; Account; Code[20])
        {
            Caption = 'G/L Account';
        }
        field(13; Description; Text[50])
        {
            Caption = 'Description';
        }

        field(14; Quantity; Decimal)
        {
            Caption = 'Quantity';
            trigger OnValidate();
            begin
                "Line Amount" := Quantity * "Unit Price";
            end;
        }
        field(15; "Unit Price"; Decimal)
        {
            Caption = 'Unit price';
            trigger OnValidate();
            begin
                "Line Amount" := Quantity * "Unit Price";
            end;
        }
        field(16; "Line Amount"; Decimal)
        {
            Caption = 'Line Amount';
            Editable = false;
        }
        field(17; "VAT Prod. Posting Group"; Code[20])
        {
            Caption = 'VAT Prod. Posting Group';
            TableRelation = "VAT Product Posting Group".Code;
            NotBlank = true;
            trigger OnValidate();
            begin
                "Line Amount" := Quantity * "Unit Price";
            end;

        }
        field(18; "Gen. Prod. Posting Group"; Code[20])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group".Code;
            NotBlank = true;
            trigger OnValidate();
            begin
                "Line Amount" := Quantity * "Unit Price";
            end;

        }
        field(20; "Line Amount Incl. VAT"; Decimal)
        {
            Caption = 'Obsolite';
        }
        field(480; "Dimension Set Id"; Integer)
        {
            Caption = 'Dimension set Id';
        }
    }

    keys
    {
        key(Key1; "Line Number", "Line No.")
        {
        }
    }
    var
        SVACosttype: Record "SVA Cost type";
        VatRate: Decimal;

    trigger OnInsert()
    var
        SVAMoveOutInvoiceHeader: record "SVA MoveOut Invoice Header";

    begin
        if "Line No." < xRec."Line No." then
            "Line No." := xRec."Line No." + 10000;
        SVAMoveOutInvoiceHeader.Reset();
        SVAMoveOutInvoiceHeader.SetRange(Number, "Line Number");
        if SVAMoveOutInvoiceHeader.FindFirst() then
            Rec."Dimension Set Id" := SVAMoveOutInvoiceHeader."Dimension Set Id";

    end;

    procedure FindVat(f_number: Code[20]; f_LinNo: Integer)
    var
        l_MoveoutInvLine: Record "SVA MoveOut Invoice Line";
        l_MoveoutInvHeader: Record "SVA MoveOut Invoice Header";
        VatPostingSetup: Record "VAT Posting Setup";
        Customer: Record Customer;
    begin
        l_MoveoutInvHeader.Get(f_number);
        l_MoveoutInvLine.Get(f_Number, f_LinNo);
        Customer.Reset();
        Customer.SetRange("No.", l_MoveoutInvHeader."Customer No");
        if Customer.FindFirst() then begin
            VATPostingSetup.Reset();
            VATPostingSetup.SetRange("VAT Prod. Posting Group", l_MoveoutInvLine."VAT Prod. Posting Group");
            VATPostingSetup.SetRange("VAT Bus. Posting Group", Customer."VAT Bus. Posting Group");
            IF VATPostingSetup.FindFirst() then
                VatRate := 1 + (VATPostingSetup."VAT %" / 100);
            IF VatRate = 0 then
                VatRate := 1;
        end;

    end;
}
