codeunit 50099 "SVA Gen. JournalLine"
//Posting on occupant trans if there is a occupant.
//Build only for §22
//Only for BC
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterPostGLAcc', '', false, false)]

    local procedure MakeOccupantTrans(GenJnlLine: Record "Gen. Journal Line"; Balancing: Boolean; NextTransactionNo: Integer; TempGlEntryBuf: record "G/L Entry")
    var
        SVAParameters: Record "SVA Parameters";
        SVACosttype: Record "SVA Cost type";
        SVAOccupantTrans: Record "SVA Occupant Trans";
        JournalName: Code[10];
        JournalType: Code[10];
        Costtype22: Code[20];
        Account22: Code[20];
    begin
        if GenJnlLine."SVA Occupant" <> '' then begin
            SVAParameters.Reset();
            if SVAParameters.FindFirst() then begin
                JournalType := SVAParameters.IM_WorkSheetType;
                JournalName := SVAParameters.IM_WorkSheet;
                Costtype22 := SVAParameters.IM_Costtype;
            end;
            SVACosttype.Reset();
            SVACosttype.SetRange(Costtype, Costtype22);
            if SVACosttype.FindFirst() then
                Account22 := SVACosttype.Account;
            //Build for savings §22
            if (GenJnlLine."Journal Template Name" = JournalType) and (GenJnlLine."Journal Batch Name" = JournalName) then
                if (GenJnlLine."Account No." = Account22) and (Balancing = true) and (GenJnlLine.Description = GenJnlLine."SVA Occupant" + ' ' + '§22') then begin
                    SVAOccupantTrans.Reset();
                    if SVAOccupantTrans.FindSet() then begin
                        SVAOccupantTrans.Occupant := GenJnlLine."SVA Occupant";
                        SVAOccupantTrans.Date := GenJnlLine."Posting Date";
                        SVAOccupantTrans.Amount := -GenJnlLine.Amount;
                        SVAOccupantTrans."Cost type Estate" := Costtype22;
                        SVAOccupantTrans.Description := 'Hensættelse §22';
                        SVAOccupantTrans."Invoice No" := GenJnlLine."Document No.";
                        SVAOccupantTrans.Price := SVAOccupantTrans.Amount;
                        SVAOccupantTrans.Qty := 1;
                        SVAOccupantTrans.Type := 0;
                        SVAOccupantTrans.Insert(true);
                    end;
                end;
            //Build for costs §22
            if (GenJnlLine."Journal Template Name" = JournalType) and (GenJnlLine."Journal Batch Name" = JournalName) then
                if (GenJnlLine."Account No." = Account22)
                    and (Balancing = false)
                    and (GenJnlLine.Description <> GenJnlLine."SVA Occupant" + ' ' + '§22') then begin
                    SVAOccupantTrans.Reset();
                    SVAOccupantTrans.Occupant := GenJnlLine."SVA Occupant";
                    SVAOccupantTrans.Date := GenJnlLine."Posting Date";
                    SVAOccupantTrans.Amount := -GenJnlLine.Amount;
                    SVAOccupantTrans."Cost type Estate" := Costtype22;
                    SVAOccupantTrans.Description := GenJnlLine.Description;
                    SVAOccupantTrans."Invoice No" := GenJnlLine."Document No.";
                    SVAOccupantTrans.Price := SVAOccupantTrans.Amount;
                    SVAOccupantTrans.Qty := -1;
                    SVAOccupantTrans.Type := 0;
                    SVAOccupantTrans.Insert(true);
                end;

        end;
    end;
}