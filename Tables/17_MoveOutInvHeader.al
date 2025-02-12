table 50017 "SVA MoveOut Invoice Header"
{
    Caption = 'Move out invoice header';
    DataClassification = CustomerContent;

    fields
    {
        field(1; Number; Code[10])
        {
            Caption = 'Occupant';
        }
        field(10; "Customer No"; Code[10])
        {
            Caption = 'Customer No.';
        }
        field(11; Name1; Text[50])
        {
            Caption = 'Name';
        }
        field(12; Name2; Text[50])
        {
            Caption = 'Name 2';
        }
        field(13; Address; Text[50])
        {
            Caption = 'Address';
        }
        field(14; Address2; Text[50])
        {
            Caption = 'Address 2';
        }
        field(15; "Post Code"; Code[10])
        {
            Caption = 'Post code';
            TableRelation = "Post Code";

            trigger OnValidate();
            begin
                Postcode.ValidatePostCode(City, "Post Code", COUNTRY, "Country/Region Code", (CurrFieldNo <> 0) AND GUIALLOWED);
            end;
        }
        field(16; City; Text[50])
        {
            Caption = 'City';
            TableRelation = IF ("Country/Region Code" = CONST()) "Post Code".City
            ELSE
            IF ("Country/Region Code" = FILTER(<> '')) "Post Code".City WHERE("Country/Region Code" = FIELD("Country/Region Code"));

            trigger OnValidate();
            begin
                Postcode.ValidateCity(City, "Post Code", COUNTRY, "Country/Region Code", (CurrFieldNo <> 0) AND GUIALLOWED);
            end;
        }
        field(17; "Country/Region Code"; Code[10])
        {
            Caption = 'Country';
            TableRelation = "Country/Region";
        }

        field(20; StartDate; Date)
        {
            Caption = 'Startdate';
            NotBlank = true;
        }
        field(21; EndDate; Date)
        {
            Caption = 'Enddate';
        }
        field(22; InvoiceAmount; Decimal)
        {
            Caption = 'Invoice balance';
            Editable = false;
        }
        field(23; Amount; Decimal)
        {
            Caption = 'Obsolite';
        }

        field(24; AmountInclVat; Decimal)
        {
            Caption = 'Obsolite';
        }
        field(29; "Posting Date"; Date)
        {
            Caption = 'Posting date';
        }
        field(30; DueDate; Date)
        {
            Caption = 'Duedate';
        }
        field(480; "Dimension Set Id"; Integer)
        {
            Caption = 'Dimension set Id';
        }
    }

    keys
    {
        key(Key1; Number)
        {
        }
    }
    var
        PostCode: Record "Post Code";
        COUNTRY: Text;
        PostingLbl: Label 'Moving settlement';

    trigger OnModify();
    var
        Customer: record Customer;

    begin
        Customer.Reset();
        Customer.Get("Customer No");
        Customer.Address := Address;
        Customer."Address 2" := Address2;
        Customer."Post Code" := "Post Code";
        Customer.City := City;
        Customer."Country/Region Code" := "Country/Region Code";
        Customer.Modify(True);
    end;

    trigger OnDelete()
    var
        SVAMoveOutInvoiceLine: Record "SVA MoveOut Invoice Line";
    begin
        SVAMoveOutInvoiceLine.Reset();
        SVAMoveOutInvoiceLine.SetRange("Line Number", Number);
        if SVAMoveOutInvoiceLine.FindSet() then
            repeat
                SVAMoveOutInvoiceLine.Delete();
            until SVAMoveOutInvoiceLine.Next() = 0
    end;

    procedure CreatePosting(f_Customer: Code[20]; f_Number: Code[20]; f_Send: Boolean)
    var
        Customer: Record Customer;
        SVAMoveOutInvoiceHeader: Record "SVA MoveOut Invoice Header";
        SVAMoveOutInvoiceLine: Record "SVA MoveOut Invoice Line";
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        SVAOccupant: Record "SVA Occupant";
        l_Choise: Boolean;
        l_Amount: Decimal;
    begin
        l_Amount := 0;
        SVAMoveOutInvoiceLine.Reset();
        SVAMoveOutInvoiceLine.SetRange(SVAMoveOutInvoiceLine."Line Number", f_Number);
        if SVAMoveOutInvoiceLine.FindSet() then
            repeat
                l_Amount := l_Amount + (SVAMoveOutInvoiceLine.Quantity * SVAMoveOutInvoiceLine."Unit Price");
            until SVAMoveOutInvoiceLine.Next() = 0;
        if l_amount >= 0 then
            l_Choise := true; //invoice
        if l_amount < 0 then
            l_Choise := false; //Credit Memo

        //Dan ordrehoved
        SalesHeader.INIT();
        if l_Choise = true then
            SalesHeader.VALIDATE("Document Type", SalesHeader."Document Type"::Invoice);
        if l_Choise = false then
            SalesHeader.VALIDATE("Document Type", SalesHeader."Document Type"::"Credit Memo");
        SalesHeader."No." := '';
        SalesHeader."Bill-to Customer No." := f_Customer;
        //SalesHeader.Validate("Bill-to Customer No.");
        SalesHeader."Sell-to Customer No." := f_Customer;
        //SalesHeader.Validate("Sell-to Customer No.");
        SalesHeader.Invoice := l_Choise;
        SVAMoveOutInvoiceHeader.Reset();
        SVAMoveOutInvoiceHeader.SetRange(Number, f_Number);
        IF SVAMoveOutInvoiceHeader.FindFirst() then begin
            SalesHeader."Due Date" := SVAMoveOutInvoiceHeader.DueDate;
            SalesHeader."Posting Date" := SVAMoveOutInvoiceHeader."Posting Date";
        end;
        Customer.Reset();
        Customer.SetRange("No.", f_Customer);
        if Customer.FINDFIRST() then begin
            SalesHeader."Bill-to Name" := Customer.Name;
            SalesHeader."Bill-to Address" := Customer.Address;
            SalesHeader."Bill-to Address 2" := Customer."Address 2";
            SalesHeader."Bill-to Post Code" := Customer."Post Code";
            SalesHeader."Bill-to City" := Customer.City;
            SalesHeader."Bill-to Country/Region Code" := Customer."Country/Region Code";
            SalesHeader."Sell-to Customer Name" := Customer.Name;
            SalesHeader."Sell-to Address" := Customer.Address;
            SalesHeader."Sell-to Address 2" := Customer."Address 2";
            SalesHeader."Sell-to Post Code" := Customer."Post Code";
            SalesHeader."Sell-to City" := Customer.City;
            SalesHeader."Sell-to Country/Region Code" := Customer."Country/Region Code";
            SalesHeader."SVA Included" := TRUE;
            SalesHeader."SVA Occupant" := SVAOccupant.Number;
            SalesHeader."Payment Terms Code" := Customer."Payment Terms Code";
            SalesHeader."Currency Code" := Customer."Currency Code";
            SalesHeader."Customer Posting Group" := Customer."Customer Posting Group";
            SalesHeader.Validate("Customer Posting Group");
            SalesHeader."Payment Method Code" := Customer."Payment Method Code";
            SalesHeader."VAT Bus. Posting Group" := Customer."VAT Bus. Posting Group";
            SalesHeader.Validate("VAT Bus. Posting Group");
            SalesHeader."Gen. Bus. Posting Group" := Customer."Gen. Bus. Posting Group";
            SalesHeader.Validate("Gen. Bus. Posting Group");
        end; //Customer
        SalesHeader."Dimension Set ID" := SVAMoveOutInvoiceHeader."Dimension Set Id";
        SalesHeader.Validate("Dimension Set ID");
        SalesHeader.Insert(true);
        SalesHeader."Dimension Set ID" := SVAMoveOutInvoiceHeader."Dimension Set Id";
        SalesHeader.Validate("Dimension Set ID");
        SalesHeader.Modify(true);

        SVAMoveOutInvoiceLine.Reset();
        SVAMoveOutInvoiceLine.SetRange(SVAMoveOutInvoiceLine."Line Number", f_Number);
        if SVAMoveOutInvoiceLine.FindSet() then
            repeat
                SalesLine.Init();
                if l_Choise = true then
                    SalesLine.VALIDATE(SalesLine."Document Type", SalesHeader."Document Type"::Invoice);
                if l_Choise = false then
                    SalesLine.VALIDATE(SalesLine."Document Type", SalesHeader."Document Type"::"Credit Memo");
                SalesLine."Line No." := SVAMoveOutInvoiceLine."Line No.";
                SalesLine.Type := "Sales Line Type"::"G/L Account";
                SalesLine."Document No." := SalesHeader."No.";
                if l_Choise = true then
                    SalesLine.Quantity := SVAMoveOutInvoiceLine.Quantity;
                if l_Choise = false then
                    SalesLine.Quantity := SVAMoveOutInvoiceLine.Quantity * -1;
                SalesLine."Qty. to Invoice" := SalesLine.Quantity;
                SalesLine.Validate(Quantity);
                if l_Choise = true then
                    SalesLine."Qty. to Ship" := SalesLine.Quantity;
                if l_Choise = false then
                    SalesLine."Qty. to Ship" := 0;
                SalesLine."No." := SVAMoveOutInvoiceLine.Account;
                SalesLine.Description := SVAMoveOutInvoiceLine.Description;
                SalesLine."Unit Price" := SVAMoveOutInvoiceLine."Unit Price";
                SalesLine.Validate("Unit Price");
                SalesLine."Line Amount" := SalesLine.Quantity * SalesLine."Unit Price";
                SalesLine."Dimension Set ID" := SalesHeader."Dimension Set ID";
                SalesLine."Gen. Bus. Posting Group" := SalesHeader."Gen. Bus. Posting Group";
                SalesLine.Validate("Gen. Bus. Posting Group");
                Salesline."VAT Bus. Posting Group" := SalesHeader."VAT Bus. Posting Group";
                Salesline."VAT Prod. Posting Group" := SVAMoveOutInvoiceLine."VAT Prod. Posting Group";
                SalesLine.Validate("VAT Prod. Posting Group");
                SalesLine."Gen. Prod. Posting Group" := SVAMoveOutInvoiceLine."Gen. Prod. Posting Group";
                SalesLine.Validate("Gen. Prod. Posting Group");
                SalesLine."SVA CostType" := SVAMoveOutInvoiceLine."Cost Type";
                SalesLine."Description 2" := PostingLbl;
                SalesLine."Dimension Set ID" := SalesHeader."Dimension Set ID";
                SalesLine.Validate("Dimension Set ID");
                SalesLine.Insert(true);
            until SVAMoveOutInvoiceLine.Next() = 0;

        if f_Send = false then
            CODEUNIT.RUN(CODEUNIT::"Sales-Post", SalesHeader);
        if f_Send = true then
            Codeunit.Run(Codeunit::"Sales-Post and Send", SalesHeader);


        SVAMoveOutInvoiceHeader.Reset();
        SVAMoveOutInvoiceHeader.SetRange(Number, f_Number);
        IF SVAMoveOutInvoiceHeader.FindFirst() then
            SVAMoveOutInvoiceHeader.Delete(true);
    end;
}



