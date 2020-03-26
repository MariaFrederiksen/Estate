codeunit 50005 "SVA BS NETS 0602"
//Indlæser BS filer til table SVA Import BUFFER
//tester for korrekt regnskab
//Indlæser poster i finanskladde som opsat på NETS Parametre.
//Der kontrolleres for hver linje omkring PBS aftalenr. for at forhindre at der ved mange brugere sker en sammmenblaning af indlæsninger.
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
            if(CopyStr(Importtable.Value, 3, 3) = '012') then begin
                IF(CopyStr(Importtable.Value, 6, 8) <> Aftaleno) then
                    Error('Filen tilhører ikke dette regnskab.');
                Sektion := (CopyStr(Importtable.Value, 15, 3));
            end;
            IF Sektion = '211' then begin
                //NETS betalingsinfo for automatiske opkrævninger
                //0236, completed automated payment
                //0237, rejected automated payment
                //0238, cancelled automated payment
                //0239, charged back payment
                if(CopyStr(Importtable.Value, 3, 3) = '042') then begin
                    Pos := StrPos(Importtable.Value,' ');
                    Evaluate(DueDate, CopyStr(Importtable.Value,50,6)); //exp. payment date
                    if CopyStr(importtable.Value, 15, 3) = '236' then begin
                        Evaluate(PaymentDate, CopyStr(Importtable.Value, Pos+1, 6)); //act. payment date
                        Payment;
                    end; //036    
                    if CopyStr(importtable.Value, 15, 3) = '237' then begin
                        AmountStr := CopyStr(Importtable.Value, 57, 13);
                        while CopyStr(AmountStr, 1, 1) = '0' do
                            AmountStr := CopyStr(AmountStr, 2, 15);
                        if StrLen(AmountStr) > 0 then begin
                            Evaluate(AmountVar, AmountStr);
                            AmountVar := AmountVar / 100;
                            AmountOut := AmountOut + AmountVar;
                        end;
                    if CopyStr(importtable.Value, 15, 3) = '238' then
                        ;

                    if CopyStr(importtable.Value, 15, 3) = '239' then
                        ;
                    ReturnPayment;
                    end;//237, 238, 239
                end; //042
                if CopyStr(Importtable.Value, 3, 3) = '092' then
                    InsOffsetAccount;

            end; //sektion 211

            //NETS betalingsinfo for indbetalinger via girokort
            IF Sektion = '215' then begin
                //NETS betalingsinfo
                if(CopyStr(Importtable.Value, 3, 3) = '042') then begin
                    Pos := StrPos(Importtable.Value,' ');
                    Evaluate(PaymentDate, CopyStr(Importtable.Value, Pos+29, 6)); //act. payment date
                    Evaluate(DueDate, CopyStr(Importtable.Value,53,6)); //exp. payment date
                    if(CopyStr(importtable.Value, 15, 3) = '297') then
                        Payment;
                    if(CopyStr(importtable.Value, 15, 3) = '299') then
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
        Journal.SetRange(Journal."Journal Template Name",JournalType);
        Journal.SetRange(Journal."Journal Batch Name",JournalName);
        if Journal.findfirst then
            Page.Run(page::"Cash Receipt Journal",Journal);
    end;

    var
        Importtable: Record "CSV Buffer";
        Parameters: Record "SVA Parameters";
        Aftaleno: Text[8];
        GeneralLedgerLine: Record "Gen. Journal Line";
        GeneralLedgerName: Record "Gen. Journal Batch";
        Datarecordtype: Text[3];
        JournalName: Code[10];
        JournalType: Code[10];
        AmountVar: Decimal;
        AmountOut: Decimal;
        AmountStr: Text[13];
        AmountStr15: Text[15];
        PaymentDate: Date;
        DueDate : Date;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        SourceCodeSetup: Record "Source Code Setup";
        Sektion: text[3];
        Ledaccount: Text[10];
        DocNo: Text[20];
        PostingText: Text[50];
        Pos: Integer;
        Journal : Record "Gen. Journal Line";

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
                if PostingText <> '' then
                    GeneralLedgerLine.Description := PostingText;
                AmountStr := CopyStr(Importtable.Value, 57, 13);
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
                    PostingText := PostingText + ' F: '+CopyStr(Importtable.Value, 70, 7);
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
            GeneralLedgerLine."Account Type" := 0;
            GeneralLedgerLine.Validate("Account Type");
            AmountStr15 := CopyStr(Importtable.Value, 38, 15);
            Evaluate(AmountVar, AmountStr15);
            GeneralLedgerLine.Amount := (AmountVar / 100) - AmountOut;
            GeneralLedgerLine."Amount (LCY)" := (AmountVar / 100) - AmountOut;
            GeneralLedgerLine.Validate(Amount);
            GeneralLedgerLine.Validate("Line No.", GeneralLedgerLine.GetNewLineNo(Journaltype, JournalName));
            GeneralLedgerLine."Account No." := Ledaccount;
            GeneralLedgerLine.Validate("Account No.");
            if PostingText <> '' then
                    GeneralLedgerLine.Description := PostingText;
            GeneralLedgerLine."Applies-to Doc. Type" := 3; //bankkonto
            GeneralLedgerLine."Applies-to Doc. No." := '';
            GeneralLedgerLine.Insert(true);
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
            if CopyStr(Importtable.Value, 15, 3) = '299' then begin
                GeneralLedgerLine."Document Date" := DueDate;
                GeneralLedgerLine."Posting Date" := DueDate;
                GeneralLedgerLine.Validate("Posting Date");
                GeneralLedgerLine."Document No." := DocNo;
                GeneralLedgerLine."Document Type" := 1;
                GeneralLedgerLine.Validate("Document Type");
                GeneralLedgerLine."Account Type" := 1;
                GeneralLedgerLine.Validate("Account Type");
                GeneralLedgerLine."Account No." := CopyStr(Importtable.Value, 30, 15);
                RemoveZero(GeneralLedgerLine."Account No.");
                GeneralLedgerLine.Validate("Account No.");
                GeneralLedgerLine.Description := 'NETS betaling retur';
                AmountStr := CopyStr(Importtable.Value, 116, 13);
                Evaluate(AmountVar, AmountStr);
                GeneralLedgerLine.Amount := AmountVar / 100;
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