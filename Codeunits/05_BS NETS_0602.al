codeunit 50005 "SVA BS NETS 0602"
//Read and insert to ledgerline each post from NETS for this company
{
    trigger OnRun();
    begin
        SVAParameters.Reset();
        if SVAParameters.FindFirst() then
            Aftaleno := SVAParameters.BS_AftaleNo;
        JournalType := SVAParameters.BS_WorkSheetType;
        JournalName := SVAParameters.BS_WorkSheet;
        LedAccount := SVAParameters.BS_Ledgeraccount;
        PostingText := SVAParameters.BS_ImportText;

        CSVBuffer.Reset();
        if CSVBuffer.FindSet() then
            repeat
                if CopyStr(CSVBuffer.Value, 3, 3) = '002' then
                    Evaluate(PaymentDate, CopyStr(CSVBuffer.Value, 50, 6)); //actual payment date and bankdate
                if (CopyStr(CSVBuffer.Value, 3, 3) = '012') then begin
                    IF (CopyStr(CSVBuffer.Value, 6, 8) <> Aftaleno) then
                        Error('Filen tilhører ikke dette regnskab.');
                    Sektion := (CopyStr(CSVBuffer.Value, 15, 3));
                end;
                IF Sektion = '211' then begin
                    //NETS payment info Data Delivery 0602, automatic payments 
                    //0236, completed automated payment
                    //0237, rejected automated payment
                    //0238, cancelled automated payment
                    //0239, charged back payment
                    if (CopyStr(CSVBuffer.Value, 3, 3) = '042') then begin
                        Evaluate(DueDate, CopyStr(CSVBuffer.Value, 50, 6)); //expected payment date
                        if CopyStr(CSVBuffer.Value, 104, 6) <> '000000' then
                            Evaluate(PaymentDate, CopyStr(CSVBuffer.Value, 104, 6)); //actual payment date

                        if CopyStr(CSVBuffer.Value, 15, 3) = '236' then
                            Payment();

                        if CopyStr(CSVBuffer.Value, 15, 3) = '237' then
                            ReturnPayment();

                        if CopyStr(CSVBuffer.Value, 15, 3) = '238' then
                            ReturnPayment();

                        if CopyStr(CSVBuffer.Value, 15, 3) = '239' then
                            ReturnPayment();

                    end; //042
                    if CopyStr(CSVBuffer.Value, 3, 3) = '092' then
                        InsOffsetAccount();

                end; //sektion 211

                //NETS paymentinfo for payments via giro
                IF Sektion = '215' then begin
                    if (CopyStr(CSVBuffer.Value, 3, 3) = '012') then
                        Evaluate(PaymentDate, CopyStr(CSVBuffer.Value, 50, 6)); //actual payment date and bankdate
                    //NETS betalingsinfo
                    if (CopyStr(CSVBuffer.Value, 3, 3) = '042') then begin
                        if (CopyStr(CSVBuffer.Value, 15, 3) = '297') then
                            Payment();
                        if (CopyStr(CSVBuffer.Value, 15, 3) = '299') then
                            ReturnPayment();
                    end;
                    if CopyStr(CSVBuffer.Value, 3, 3) = '092' then
                        InsOffsetAccount();
                end; //sektion 215

                if CopyStr(CSVBuffer.Value, 3, 3) = '099' then
                    Message('Filen er indlæst');
            until CSVBuffer.NEXT() = 0;

        CSVBuffer.DeleteAll();
        GenJournalLine.Reset();
        GenJournalLine.SetRange(GenJournalLine."Journal Template Name", JournalType);
        GenJournalLine.SetRange(GenJournalLine."Journal Batch Name", JournalName);
        if GenJournalLine.FindFirst() then
            Page.Run(page::"Cash Receipt Journal", GenJournalLine);
    end;

    var
        CSVBuffer: Record "CSV Buffer";
        SVAParameters: Record "SVA Parameters";
        GenJournalLine: Record "Gen. Journal Line";
        GenJournalBatch: Record "Gen. Journal Batch";
        SourceCodeSetup: Record "Source Code Setup";
        InvoiceHeader: Record "Sales Invoice Header";
        Customer: Record Customer;
        SVAOccupant: Record "SVA Occupant";
        NoSeriesManagement: Codeunit NoSeriesManagement;

        Aftaleno: Text[8];
        JournalName: Code[10];
        JournalType: Code[10];
        AmountVar: Decimal;
        AmountOut: Decimal;
        AmountStr: Text[13];
        AmountStr15: Text[15];
        PaymentDate: Date;
        DueDate: Date;
        Sektion: text[3];
        Ledaccount: Text[10];
        DocNo: Text[20];
        PostingText: Text[50];
        InvoiceNumber: Code[20];


    local procedure Payment()
    var
        SalesInvoiceHeader: record "Sales Invoice Header";
    begin
        SourceCodeSetup.GET();
        GenJournalBatch.Reset();
        GenJournalBatch.SetRange(Name, JournalName);
        GenJournalBatch.SetRange("Journal Template Name", JournalType);
        if not GenJournalBatch.FindFirst() then
            Error('Der er ikke opsat finanskladde til indlæsening af NETS-betalinger');
        if GenJournalBatch.FindFirst() then begin
            if DocNo = '' then
                IF GenJournalBatch."No. Series" <> '' then begin
                    Clear(NoSeriesManagement);
                    DocNo := NoSeriesManagement.GetNextNo(GenJournalBatch."No. Series", GenJournalLine."Posting Date", false);
                end;

            GenJournalLine.Init();
            GenJournalLine."Journal Template Name" := JournalType;
            GenJournalLine."Journal Batch Name" := JournalName;
            GenJournalLine.Validate("Journal Batch Name");
            GenJournalLine."Posting No. Series" := GenJournalBatch."Posting No. Series";
            GenJournalLine."Source Code" := SourceCodeSetup."General Journal";
            if CopyStr(CSVBuffer.Value, 15, 3) = '297' then begin
                GenJournalLine."Document Date" := PaymentDate;
                GenJournalLine."Posting Date" := PaymentDate;
                GenJournalLine.Validate("Posting Date");
                GenJournalLine."Document No." := DocNo;
                GenJournalLine."Document Type" := "Gen. Journal Document Type"::Payment;
                GenJournalLine.Validate("Document Type");
                GenJournalLine."Account Type" := "Gen. Journal Account Type"::Customer;
                GenJournalLine.Validate("Account Type");
                GenJournalLine."Account No." := CopyStr(CSVBuffer.Value, 30, 15);
                RemoveZero(GenJournalLine."Account No.");
                Customer.Reset();
                Customer.SetRange("No.", GenJournalLine."Account No.");
                if Customer.IsEmpty() then begin
                    //Så er det en faktura, som ikke har debitornummer på plads 30,15, men fakturanummer på plads 30,14
                    InvoiceNumber := CopyStr(CSVBuffer.value, 30, 14);
                    while CopyStr(InvoiceNumber, 1, 1) = '0' do
                        InvoiceNumber := CopyStr(InvoiceNumber, 2, 15);
                    InvoiceNumber := CopyStr(InvoiceNumber, 1, 6);
                    InvoiceHeader.Reset();
                    InvoiceHeader.SetRange("No.", InvoiceNumber);
                    if InvoiceHeader.FindFirst() then
                        GenJournalLine."Account No." := InvoiceHeader."Sell-to Customer No.";
                end;
                SVAOccupant.Reset();
                SVAOccupant.SetRange("Customer No", GenJournalLine."Account No.");
                if SVAOccupant.FindFirst() then begin
                    GenJournalLine."Dimension Set ID" := SVAOccupant."Dimension Set Id";
                    GenJournalLine.Validate(GenJournalLine."Dimension Set ID");
                end;
                GenJournalLine.Validate("Account No.");
                if PostingText <> '' then
                    GenJournalLine.Description := PostingText;
                AmountStr := CopyStr(CSVBuffer.Value, 116, 13);
                Evaluate(AmountVar, AmountStr);
                GenJournalLine.Amount := -AmountVar / 100;
                GenJournalLine."Amount (LCY)" := -AmountVar;
                GenJournalLine.Validate(Amount);
                GenJournalLine."Bal. Account Type" := "Gen. Journal Account Type"::"Bank Account";  //3; //bankkonto
                GenJournalLine.Validate("Line No.", GenJournalLine.GetNewLineNo(Journaltype, JournalName));


                //udligning
                GenJournalLine."Applies-to Doc. Type" := "Gen. Journal Document Type"::Invoice; //Invoice
                GenJournalLine."Applies-to Doc. No." := CopyStr(CSVBuffer.Value, 73, 7); //Invoice No
                GenJournalLine."Applies-to Doc. No." := DelChr(GenJournalLine."Applies-to Doc. No.", '=', ' ');
                if GenJournalLine."Applies-to Doc. No." = '' then begin
                    GenJournalLine."Applies-to Doc. Type" := "Gen. Journal Document Type"::Invoice; //Invoice
                    GenJournalLine."Applies-to Doc. No." := InvoiceNumber; //Invoice No
                    GenJournalLine."Applies-to Doc. No." := DelChr(GenJournalLine."Applies-to Doc. No.", '=', ' ');
                end;
                //Only if date is on or after postingdate
                SalesInvoiceHeader.Reset();
                SalesInvoiceHeader.SetRange("No.", GenJournalLine."Applies-to Doc. No.");
                if SalesInvoiceHeader.FindFirst() then begin
                    if SalesInvoiceHeader."Posting Date" <= GenJournalLine."Posting Date" then
                        if GenJournalLine."Applies-to Doc. No." <> '' then
                            GenJournalLine.Validate("Applies-to Doc. No.");
                    if SalesInvoiceHeader."Posting Date" > GenJournalLine."Posting Date" then
                        GenJournalLine."Applies-to Doc. No." := '';
                    GenJournalLine.Validate("Applies-to Doc. No.");

                end;
                //Write invoicenumber in description line, when not posible to settle
                if GenJournalLine."Applies-to Doc. No." = '' then begin
                    GenJournalLine.Description := PostingText + ' F: ' + CopyStr(CSVBuffer.Value, 73, 7);
                    GenJournalLine."Applies-to Doc. Type" := "Gen. Journal Document Type"::" ";
                end;
                GenJournalLine.Insert(true);

            end;
            if CopyStr(CSVBuffer.Value, 15, 3) = '236' then begin
                GenJournalLine."Document Date" := PaymentDate;
                GenJournalLine."Posting Date" := PaymentDate;
                GenJournalLine.Validate("Posting Date");
                GenJournalLine."Document No." := DocNo;
                GenJournalLine."Document Type" := "Gen. Journal Document Type"::Payment;
                GenJournalLine.Validate("Document Type");
                GenJournalLine."Account Type" := "Gen. Journal Account Type"::Customer;
                GenJournalLine.Validate("Account Type");
                GenJournalLine."Account No." := CopyStr(CSVBuffer.Value, 26, 15);
                RemoveZero(GenJournalLine."Account No.");
                GenJournalLine.Validate("Account No.");
                GenJournalLine."Bal. Account Type" := "Gen. Journal Account Type"::"Bank Account";  //3; //bankkonto
                if PostingText <> '' then
                    GenJournalLine.Description := PostingText;
                AmountStr := CopyStr(CSVBuffer.Value, 116, 13);
                Evaluate(AmountVar, AmountStr);
                GenJournalLine.Amount := -AmountVar / 100;
                GenJournalLine."Amount (LCY)" := -AmountVar;
                GenJournalLine.Validate(Amount);
                GenJournalLine.Validate("Line No.", GenJournalLine.GetNewLineNo(Journaltype, JournalName));
                GenJournalLine."Applies-to Doc. Type" := "Gen. Journal Document Type"::Invoice; //Invoice
                if PaymentDate >= DueDate then begin
                    GenJournalLine."Applies-to Doc. No." := CopyStr(CSVBuffer.Value, 70, 7); //Invoice No
                    GenJournalLine."Applies-to Doc. No." := DelChr(GenJournalLine."Applies-to Doc. No.", '=', ' ');
                    GenJournalLine.Validate("Applies-to Doc. No.");
                end;
                if PaymentDate < DueDate then begin
                    GenJournalLine.Description := PostingText + ' F: ' + CopyStr(CSVBuffer.Value, 70, 7);
                    GenJournalLine."Applies-to Doc. No." := '';
                    GenJournalLine."Applies-to Doc. Type" := "Gen. Journal Document Type"::" ";
                end;
                GenJournalLine.Insert(true);
            end;
        end;
    end;

    local procedure InsOffsetAccount()
    begin
        if CopyStr(CSVBuffer.Value, 3, 3) = '092' then begin
            GenJournalLine."Document Date" := PaymentDate;
            GenJournalLine."Posting Date" := PaymentDate;
            GenJournalLine.Validate("Posting Date");
            GenJournalLine."Document No." := DocNo;
            GenJournalLine."Document Type" := "Gen. Journal Document Type"::Payment;
            GenJournalLine.Validate("Document Type");
            GenJournalLine."Bal. Account Type" := GenJournalBatch."Bal. Account Type";
            GenJournalLine."Account Type" := GenJournalBatch."Bal. Account Type";
            GenJournalLine.Validate("Account Type");
            GenJournalLine."Account No." := GenJournalBatch."Bal. Account No.";
            if GenJournalLine."Account No." = '' then
                GenJournalLine."Account No." := Ledaccount;
            GenJournalLine.Validate("Account No.");

            AmountStr15 := CopyStr(CSVBuffer.Value, 43, 15);
            Evaluate(AmountVar, AmountStr15);
            GenJournalLine.Amount := (AmountVar / 100) - AmountOut;
            GenJournalLine."Amount (LCY)" := (AmountVar / 100) - AmountOut;
            GenJournalLine.Validate(Amount);
            GenJournalLine.Validate("Line No.", GenJournalLine.GetNewLineNo(Journaltype, JournalName));


            if PostingText <> '' then
                GenJournalLine.Description := PostingText;


            GenJournalLine."Applies-to Doc. No." := '';
            GenJournalLine."Applies-to Doc. Type" := "Gen. Journal Document Type"::" ";
            if GenJournalLine.Amount > 0 then
                GenJournalLine.Insert(true);
            if GenJournalLine.Amount <= 0 then begin
                GenJournalLine."Document Type" := "Gen. Journal Document Type"::" ";
                GenJournalLine.Amount := -AmountOut;
                GenJournalLine."Amount (LCY)" := -AmountOut;
                GenJournalLine.Validate(Amount);
                GenJournalLine.Insert(true);
            end;
            AmountOut := 0;
        end;
    end;

    local procedure ReturnPayment()
    begin
        SourceCodeSetup.GET();
        GenJournalBatch.Reset();
        GenJournalBatch.SetRange(Name, JournalName);
        GenJournalBatch.SetRange("Journal Template Name", JournalType);
        if not GenJournalBatch.FindFirst() then
            Error('Der er ikke opsat finanskladde til indlæsening af NETS-betalinger');
        if GenJournalBatch.FindFirst() then
            if DocNo = '' then
                IF GenJournalBatch."No. Series" <> '' then begin
                    Clear(NoSeriesManagement);
                    DocNo := NoSeriesManagement.GetNextNo(GenJournalBatch."No. Series", GenJournalLine."Posting Date", true);
                end;


        GenJournalLine.Reset();
        GenJournalLine."Journal Template Name" := JournalType;
        GenJournalLine."Journal Batch Name" := JournalName;
        GenJournalLine.Validate("Journal Batch Name");
        GenJournalLine."Posting No. Series" := GenJournalBatch."Posting No. Series";
        GenJournalLine."Source Code" := SourceCodeSetup."General Journal";
        if (CopyStr(CSVBuffer.Value, 15, 3) = '299') or
            (CopyStr(CSVBuffer.Value, 15, 3) = '237') or
            (CopyStr(CSVBuffer.Value, 15, 3) = '239') then begin

            GenJournalLine."Document Date" := PaymentDate;
            GenJournalLine."Posting Date" := PaymentDate;
            GenJournalLine.Validate("Posting Date");
            GenJournalLine."Document No." := DocNo;
            GenJournalLine."Document Type" := "Gen. Journal Document Type"::" ";
            GenJournalLine.Validate("Document Type");
            GenJournalLine."Account Type" := "Gen. Journal Account Type"::Customer;
            GenJournalLine.Validate("Account Type");
            GenJournalLine."Bal. Account Type" := "Gen. Journal Account Type"::"Bank Account";  //3; //bankkonto
            if (CopyStr(CSVBuffer.Value, 15, 3) = '299') then
                GenJournalLine."Account No." := CopyStr(CSVBuffer.Value, 30, 15);
            if (CopyStr(CSVBuffer.Value, 15, 3) = '237') then
                GenJournalLine."Account No." := CopyStr(CSVBuffer.Value, 26, 15);
            if (CopyStr(CSVBuffer.Value, 15, 3) = '239') then
                GenJournalLine."Account No." := CopyStr(CSVBuffer.Value, 26, 15);
            RemoveZero(GenJournalLine."Account No.");
            GenJournalLine.Validate("Account No.");
            GenJournalLine.Description := 'NETS betaling retur/afvist';
            AmountStr := CopyStr(CSVBuffer.Value, 116, 13);
            Evaluate(AmountVar, AmountStr);
            GenJournalLine.Amount := AmountVar / 100;
            if (CopyStr(CSVBuffer.Value, 15, 3) = '299') then
                AmountOut += AmountVar / 100;
            if (CopyStr(CSVBuffer.Value, 15, 3) = '237') then
                AmountOut += AmountVar / 100;
            if (CopyStr(CSVBuffer.Value, 15, 3) = '239') then
                AmountOut += AmountVar / 100;
            GenJournalLine."Amount (LCY)" := AmountVar;
            GenJournalLine.Validate(Amount);
            GenJournalLine.Validate("Line No.", GenJournalLine.GetNewLineNo(Journaltype, JournalName));
            GenJournalLine.Insert(true);
        end;

    end;

    local procedure RemoveZero(Account: Text[15])
    begin
        while CopyStr(Account, 1, 1) = '0' do
            Account := CopyStr(Account, 2, 15);
        GenJournalLine."Account No." := Account;
    end;
}