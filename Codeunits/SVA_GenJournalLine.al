codeunit 50099 "SVA Gen. JournalLine"
//Posting on occupant trans if there is a occupant.
//Build only for §22
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterPostGLAcc', '', false, false)]
    local procedure MakeOccupantTrans(GenJnlLine: Record "Gen. Journal Line"; Balancing: Boolean; NextTransactionNo: Integer; TempGlEntryBuf: record "G/L Entry")
    var
        Parameters: Record "SVA Parameters";
        CosttypeList: Record "SVA Cost type";
        JournalName: Code[10];
        JournalType: Code[10];
        OccupantTrans: Record "SVA Occupant Trans";
        Costtype22: Code[20];
        Account22: Code[20];
    begin
        if GenJnlLine."SVA Occupant" <> '' then begin
            Parameters.Reset;
            if Parameters.FindFirst then begin
                JournalType := Parameters.IM_WorkSheetType;
                JournalName := Parameters.IM_WorkSheet;
                Costtype22 := Parameters.IM_Costtype;
            end;
            CosttypeList.Reset();
            CosttypeList.SetRange(Costtype, Costtype22);
            if CosttypeList.FindFirst then
                Account22 := CosttypeList.Account;
            //Build for savings §22
            if (GenJnlLine."Journal Template Name" = JournalType) and (GenJnlLine."Journal Batch Name" = JournalName) then begin
                if (GenJnlLine."Account No." = Account22)
                    and (Balancing = true)
                    and (GenJnlLine.Description = GenJnlLine."SVA Occupant" + ' ' + '§22') then begin
                    OccupantTrans.Reset();
                    if OccupantTrans.FindSet() then begin
                        OccupantTrans.Occupant := GenJnlLine."SVA Occupant";
                        OccupantTrans.Date := GenJnlLine."Posting Date";
                        OccupantTrans.Amount := -GenJnlLine.Amount;
                        OccupantTrans."Cost type Estate" := Costtype22;
                        OccupantTrans.Description := 'Hensættelse §22';
                        OccupantTrans."Invoice No" := GenJnlLine."Document No.";
                        OccupantTrans.Price := OccupantTrans.Amount;
                        OccupantTrans.Qty := 1;
                        OccupantTrans.Type := 0;
                        OccupantTrans.Insert(true);
                    end;
                end;
            end;
            //Build for costs §22
            if (GenJnlLine."Journal Template Name" = JournalType) and (GenJnlLine."Journal Batch Name" = JournalName) then begin
                if (GenJnlLine."Account No." = Account22)
                    and (Balancing = false)
                    and (GenJnlLine.Description <> GenJnlLine."SVA Occupant" + ' ' + '§22') then begin
                    OccupantTrans.Reset();
                    OccupantTrans.Occupant := GenJnlLine."SVA Occupant";
                    OccupantTrans.Date := GenJnlLine."Posting Date";
                    OccupantTrans.Amount := -GenJnlLine.Amount;
                    OccupantTrans."Cost type Estate" := Costtype22;
                    OccupantTrans.Description := GenJnlLine.Description;
                    OccupantTrans."Invoice No" := GenJnlLine."Document No.";
                    OccupantTrans.Price := OccupantTrans.Amount;
                    OccupantTrans.Qty := -1;
                    OccupantTrans.Type := 0;
                    OccupantTrans.Insert(true);
                end;
            end;
        end;
    end;
}