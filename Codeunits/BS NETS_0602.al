codeunit 50005 "SVA BS NETS 0602"
//Read and insert to ledgerline each post from NETS for this company
{
    trigger OnRun();
    begin
        Parameters.Reset;
        if Parameters.FindFirst then
            Aftaleno := Parameters.BS_AftaleNo;
        JournalType := Parameters.BS_WorkSheetType;
        JournalName := Parameters.BS_WorkSheet;
        LedAccount := Parameters.BS_Ledgeraccount;
        PostingText := Parameters.BS_ImportText;

        Importtable.reset;
        if Importtable.FindSet then
            repeat
                if CopyStr(Importtable.Value, 3, 3) = '002' then
                    ;
                if (CopyStr(Importtable.Value, 3, 3) = '012') then begin
                    IF (CopyStr(Importtable.Value, 6, 8) <> Aftaleno) then
                        Error('Filen tilhører ikke dette regnskab.');
                    Sektion := (CopyStr(Importtable.Value, 15, 3));
                end;
                IF Sektion = '211' then begin
                    //NETS payment info Data Delivery 0602, automatic payments 
                    //0236, completed automated payment
                    //0237, rejected automated payment
                    //0238, cancelled automated payment
                    //0239, charged back payment
                    if (CopyStr(Importtable.Value, 3, 3) = '042') then begin
                        Evaluate(DueDate, CopyStr(Importtable.Value, 50, 6)); //exp. payment date
                        if CopyStr(Importtable.Value, 104, 6) <> '000000' then
                            Evaluate(PaymentDate, CopyStr(Importtable.Value, 104, 6)); //act. payment date
                        if CopyStr(importtable.Value, 15, 3) = '236' then begin
                            Payment;
                        end;
                        if CopyStr(importtable.Value, 15, 3) = '237' then begin
                            ReturnPayment();
                        end;
                        if CopyStr(importtable.Value, 15, 3) = '238' then begin
                            ReturnPayment;
                        end;
                        if CopyStr(importtable.Value, 15, 3) = '239' then begin
                            ReturnPayment;
                        end;
                    end; //042
                    if CopyStr(Importtable.Value, 3, 3) = '092' then
                        InsOffsetAccount;

                end; //sektion 211

                //NETS paymentinfo for payments via giro
                IF Sektion = '215' then begin
                    //NETS betalingsinfo
                    if (CopyStr(Importtable.Value, 3, 3) = '042') then begin
                        Evaluate(PaymentDate, CopyStr(Importtable.Value, 104, 6)); //act. payment date
                        Evaluate(DueDate, CopyStr(Importtable.Value, 53, 6)); //exp. payment date
                        if (CopyStr(importtable.Value, 15, 3) = '297') then
                            Payment;
                        if (CopyStr(importtable.Value, 15, 3) = '299') then
                            ReturnPayment;
                    end;
                    if CopyStr(Importtable.Value, 3, 3) = '092' then
                        InsOffsetAccount;
                end; //sektion 215            
                if CopyStr(Importtable.Value, 3, 3) = '099' then
                    Message('Filen er indlæst');
            until Importtable.Next = 0;

        Importtable.DeleteAll;
        Journal.Reset;
        Journal.SetRange(Journal."Journal Template Name", JournalType);
        Journal.SetRange(Journal."Journal Batch Name", JournalName);
        if Journal.findfirst then
            Page.Run(page::"Cash Receipt Journal", Journal);
    end;

    var
        Importtable: Record "CSV Buffer";
        Parameters: Record "SVA Parameters";
        Aftaleno: Text[8];
        GeneralLedgerLine: Record "Gen. Journal Line";
        GeneralLedgerName: Record "Gen. Journal Batch";
        JournalName: Code[10];
        JournalType: Code[10];
        AmountVar: Decimal;
        AmountOut: Decimal;
        AmountStr: Text[13];
        AmountStr15: Text[15];
        PaymentDate: Date;
        DueDate: Date;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        SourceCodeSetup: Record "Source Code Setup";
        Sektion: text[3];
        Ledaccount: Text[10];
        DocNo: Text[20];
        PostingText: Text[50];
        Journal: Record "Gen. Journal Line";

    local procedure Payment()
    begin
        SourceCodeSetup.Get;
        GeneralLedgerName.Reset;
        GeneralLedgerName.SetRange(Name, JournalName);
        GeneralLedgerName.SetRange("Journal Template Name", JournalType);
        if not GeneralLedgerName.FindFirst then
            Error('Der er ikke opsat finanskladde til indlæsening af NETS-betalinger');
        if GeneralLedgerName.FindFirst then begin
            if DocNo = '' then begin
                IF GeneralLedgerName."No. Series" <> '' then begin
                    Clear(NoSeriesMgt);
                    DocNo := NoSeriesMgt.GetNextNo(GeneralLedgerName."No. Series", GeneralLedgerLine."Posting Date", false);
                end;
            end;
            GeneralLedgerLine.Reset;
            GeneralledgerLine."Journal Template Name" := JournalType;
            GeneralLedgerLine."Journal Batch Name" := JournalName;
            GeneralLedgerLine.Validate("Journal Batch Name");
            GeneralLedgerLine."Posting No. Series" := GeneralLedgerName."Posting No. Series";
            GeneralLedgerLine."Source Code" := SourceCodeSetup."General Journal";
            if CopyStr(Importtable.Value, 15, 3) = '297' then begin
                GeneralLedgerLine."Document Date" := PaymentDate;
                GeneralLedgerLine."Posting Date" := PaymentDate;
                GeneralLedgerLine.Validate("Posting Date");
                GeneralLedgerLine."Document No." := DocNo;
                GeneralLedgerLine."Document Type" := 1;
                GeneralLedgerLine.Validate("Document Type");
                GeneralLedgerLine."Account Type" := 1;
                GeneralLedgerLine.Validate("Account Type");
                GeneralLedgerLine."Account No." := CopyStr(Importtable.Value, 30, 15);
                RemoveZero(GeneralLedgerLine."Account No.");
                GeneralLedgerLine.Validate("Account No.");
                if PostingText <> '' then
                    GeneralLedgerLine.Description := PostingText;
                AmountStr := CopyStr(Importtable.Value, 116, 13);
                Evaluate(AmountVar, AmountStr);
                GeneralLedgerLine.Amount := -AmountVar / 100;
                GeneralLedgerLine."Amount (LCY)" := -AmountVar;
                GeneralLedgerLine.Validate(Amount);
                GeneralLedgerLine."Bal. Account Type" := 3; //bankkonto
                GeneralLedgerLine.Validate("Line No.", GeneralLedgerLine.GetNewLineNo(Journaltype, JournalName));
                if PaymentDate >= DueDate then begin
                    GeneralLedgerLine."Applies-to Doc. Type" := 2; //Invoice
                    GeneralLedgerLine."Applies-to Doc. No." := CopyStr(Importtable.Value, 73, 7); //Invoice No
                    GeneralLedgerLine."Applies-to Doc. No." := DelChr(GeneralLedgerLine."Applies-to Doc. No.", '=', ' ');
                    GeneralLedgerLine.Validate("Applies-to Doc. No.");
                end;
                if PaymentDate < DueDate then
                    PostingText := PostingText + ' F: ' + CopyStr(Importtable.Value, 73, 7);
                GeneralLedgerLine.Insert(true);
            end;
            if CopyStr(Importtable.Value, 15, 3) = '236' then begin
                GeneralLedgerLine."Document Date" := PaymentDate;
                GeneralLedgerLine."Posting Date" := PaymentDate;
                GeneralLedgerLine.Validate("Posting Date");
                GeneralLedgerLine."Document No." := DocNo;
                GeneralLedgerLine."Document Type" := 1;
                GeneralLedgerLine.Validate("Document Type");
                GeneralLedgerLine."Account Type" := 1;
                GeneralLedgerLine.Validate("Account Type");
                GeneralLedgerLine."Account No." := CopyStr(Importtable.Value, 26, 15);
                RemoveZero(GeneralLedgerLine."Account No.");
                GeneralLedgerLine.Validate("Account No.");
                GeneralLedgerLine."Bal. Account Type" := 3; //bankkonto
                if PostingText <> '' then
                    GeneralLedgerLine.Description := PostingText;
                AmountStr := CopyStr(Importtable.Value, 116, 13);
                Evaluate(AmountVar, AmountStr);
                GeneralLedgerLine.Amount := -AmountVar / 100;
                GeneralLedgerLine."Amount (LCY)" := -AmountVar;
                GeneralLedgerLine.Validate(Amount);
                GeneralLedgerLine.Validate("Line No.", GeneralLedgerLine.GetNewLineNo(Journaltype, JournalName));
                GeneralLedgerLine."Applies-to Doc. Type" := 2; //Invoice
                if PaymentDate >= DueDate then begin
                    GeneralLedgerLine."Applies-to Doc. No." := CopyStr(Importtable.Value, 70, 7); //Invoice No
                    GeneralLedgerLine."Applies-to Doc. No." := DelChr(GeneralLedgerLine."Applies-to Doc. No.", '=', ' ');
                    GeneralLedgerLine.Validate("Applies-to Doc. No.");
                end;
                if PaymentDate < DueDate then
                    PostingText := PostingText + ' F: ' + CopyStr(Importtable.Value, 70, 7);
                GeneralLedgerLine.Insert(true);
            end;
        end;
    end;

    local procedure InsOffsetAccount()
    begin
        if CopyStr(Importtable.Value, 3, 3) = '092' then begin
            GeneralLedgerLine."Document Date" := PaymentDate;
            GeneralLedgerLine."Posting Date" := PaymentDate;
            GeneralLedgerLine.Validate("Posting Date");
            GeneralLedgerLine."Document No." := DocNo;
            GeneralLedgerLine."Document Type" := 1;
            GeneralLedgerLine.Validate("Document Type");
            GeneralLedgerLine."Bal. Account Type" := GeneralLedgerName."Bal. Account Type";
            GeneralLedgerLine."Account Type" := GeneralLedgerName."Bal. Account Type";
            GeneralLedgerLine.Validate("Account Type");
            GeneralLedgerLine."Account No." := GeneralLedgerName."Bal. Account No.";
            if GeneralLedgerLine."Account No." = '' then
                GeneralLedgerLine."Account No." := Ledaccount;
            GeneralLedgerLine.Validate("Account No.");    
            
            AmountStr15 := CopyStr(Importtable.Value, 43, 15);
            Evaluate(AmountVar, AmountStr15);
            GeneralLedgerLine.Amount := (AmountVar / 100) - AmountOut;
            GeneralLedgerLine."Amount (LCY)" := (AmountVar / 100) - AmountOut;
            GeneralLedgerLine.Validate(Amount);
            GeneralLedgerLine.Validate("Line No.", GeneralLedgerLine.GetNewLineNo(Journaltype, JournalName));

            
            if PostingText <> '' then
                GeneralLedgerLine.Description := PostingText;


            GeneralLedgerLine."Applies-to Doc. No." := '';
            GeneralLedgerLine."Applies-to Doc. Type" := 0;
            if GeneralLedgerLine.Amount > 0 then
                GeneralLedgerLine.Insert(true);
            if GeneralLedgerLine.Amount <= 0 then begin
                GeneralLedgerLine.Amount := -AmountOut;
                GeneralLedgerLine."Amount (LCY)" := -AmountOut;
                GeneralLedgerLine.Validate(Amount);
                GeneralLedgerLine.Insert(true);
            end;
            AmountOut := 0;
        end;
    end;

    local procedure ReturnPayment()
    begin
        SourceCodeSetup.Get;
        GeneralLedgerName.Reset;
        GeneralLedgerName.SetRange(Name, JournalName);
        GeneralLedgerName.SetRange("Journal Template Name", JournalType);
        if not GeneralLedgerName.FindFirst then
            Error('Der er ikke opsat finanskladde til indlæsening af NETS-betalinger');
        if GeneralLedgerName.FindFirst then begin
            if DocNo = '' then begin
                IF GeneralLedgerName."No. Series" <> '' then begin
                    Clear(NoSeriesMgt);
                    DocNo := NoSeriesMgt.GetNextNo(GeneralLedgerName."No. Series", GeneralLedgerLine."Posting Date", true);
                end;
            end;
            GeneralLedgerLine.Reset;
            GeneralledgerLine."Journal Template Name" := JournalType;
            GeneralLedgerLine."Journal Batch Name" := JournalName;
            GeneralLedgerLine.Validate("Journal Batch Name");
            GeneralLedgerLine."Posting No. Series" := GeneralLedgerName."Posting No. Series";
            GeneralLedgerLine."Source Code" := SourceCodeSetup."General Journal";
            if (CopyStr(Importtable.Value, 15, 3) = '299') or
                (CopyStr(Importtable.Value, 15, 3) = '237') or
                (CopyStr(Importtable.Value, 15, 3) = '239') then begin

                GeneralLedgerLine."Document Date" := PaymentDate;
                GeneralLedgerLine."Posting Date" := PaymentDate;
                GeneralLedgerLine.Validate("Posting Date");
                GeneralLedgerLine."Document No." := DocNo;
                GeneralLedgerLine."Document Type" := 0;
                GeneralLedgerLine.Validate("Document Type");
                GeneralLedgerLine."Account Type" := 1;
                GeneralLedgerLine.Validate("Account Type");
                GeneralLedgerLine."Bal. Account Type" := 3; //bankkonto
                if (CopyStr(Importtable.Value, 15, 3) = '299') then
                    GeneralLedgerLine."Account No." := CopyStr(Importtable.Value, 30, 15);
                if (CopyStr(Importtable.Value, 15, 3) = '237') then
                    GeneralLedgerLine."Account No." := CopyStr(Importtable.Value, 26, 15);
                if (CopyStr(Importtable.Value, 15, 3) = '239') then
                    GeneralLedgerLine."Account No." := CopyStr(Importtable.Value, 26, 15);
                RemoveZero(GeneralLedgerLine."Account No.");
                GeneralLedgerLine.Validate("Account No.");
                GeneralLedgerLine.Description := 'NETS betaling retur';
                AmountStr := CopyStr(Importtable.Value, 116, 13);
                Evaluate(AmountVar, AmountStr);
                GeneralLedgerLine.Amount := AmountVar / 100;
                if (CopyStr(Importtable.Value, 15, 3) = '299') then
                    AmountOut += AmountVar / 100;
                if (CopyStr(Importtable.Value, 15, 3) = '237') then
                    AmountOut += AmountVar / 100;
                if (CopyStr(Importtable.Value, 15, 3) = '239') then
                    AmountOut += AmountVar / 100;
                GeneralLedgerLine."Amount (LCY)" := AmountVar;
                GeneralLedgerLine.Validate(Amount);
                GeneralLedgerLine.Validate("Line No.", GeneralLedgerLine.GetNewLineNo(Journaltype, JournalName));
                GeneralLedgerLine.Insert(true);
            end;
        end;
    end;

    local procedure RemoveZero(Account: Text[15])
    begin
        while CopyStr(Account, 1, 1) = '0' do
            Account := CopyStr(Account, 2, 15);
        GeneralLedgerLine."Account No." := Account;
    end;
}