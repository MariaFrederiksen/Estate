codeunit 50018 "SVA BS NETS 0603"
//Data delivery BS0603 contains information about the registration and cancellation of mandates NETS
{
    trigger OnRun();
    begin
        SVAParameters.Reset();
        if SVAParameters.FindFirst() then
            Aftaleno := SVAParameters.BS_AftaleNo;

        CSVBuffer.Reset();
        if CSVBuffer.FindSet() then
            repeat
                if CopyStr(CSVBuffer.Value, 3, 3) = '002' then begin
                    Evaluate(FileDate, CopyStr(CSVBuffer.Value, 50, 6)); //actual payment date and bankdate
                    if CopyStr(CSVBuffer.Value, 17, 4) <> '0603' then
                        Error('Filen er ikke en BS 0603 fil');
                end;

                if (CopyStr(CSVBuffer.Value, 3, 3) = '012') then begin
                    IF (CopyStr(CSVBuffer.Value, 6, 8) <> Aftaleno) then
                        Error('Filen tilhører ikke dette regnskab.');
                    Sektion := (CopyStr(CSVBuffer.Value, 14, 4));
                    Evaluate(FileDate, CopyStr(CSVBuffer.Value, 50, 6));
                end;
                IF Sektion = '0210' then   //Active mandate
                    if (CopyStr(CSVBuffer.Value, 3, 3) = '042') and (CopyStr(CSVBuffer.Value, 14, 4) = '0230') then begin
                        CustomerNo := CopyStr(CSVBuffer.Value, 26, 15);
                        RemoveZero(CustomerNo);
                        SVAOccupant.Reset();
                        SVAOccupant.SetRange("Customer No", CustomerNo);
                        if SVAOccupant.Findset() then
                            repeat
                                if CopyStr(CSVBuffer.Value, 56, 6) = '000000' then begin
                                    SVAOccupant.TransferNETS := SVAOccupant.TransferNETS::Enrolled;
                                    SVAOccupant."Effective Date" := FileDate;
                                    SVAOccupant.Modify();
                                end;
                            until SVAOccupant.Next() = 0;
                    end;
                if Sektion = '0212' then
                    // Transactioncode 
                    // 0232 Cancelled by bank
                    // 0233 Cancelled by creditor
                    // 0234 Cancelled by betalingsservice
                    if (CopyStr(CSVBuffer.Value, 3, 3) = '042') and ((CopyStr(CSVBuffer.Value, 14, 4) = '0231') or (CopyStr(CSVBuffer.Value, 14, 4) = '0232') or (CopyStr(CSVBuffer.Value, 14, 4) = '0233') or (CopyStr(CSVBuffer.Value, 14, 4) = '0234')) then begin
                        CustomerNo := CopyStr(CSVBuffer.Value, 26, 15);
                        RemoveZero(CustomerNo);
                        if CopyStr(CSVBuffer.Value, 56, 6) <> '000000' then
                            Evaluate(DeletionDate, CopyStr(CSVBuffer.Value, 56, 6));
                        SVAOccupant.Reset();
                        SVAOccupant.SetRange("Customer No", CustomerNo);
                        if SVAOccupant.Findset() then
                            repeat
                                if (DeletionDate <> 0D) and (CopyStr(CSVBuffer.Value, 14, 4) = '0232') then begin
                                    SVAOccupant.TransferNETS := SVAOccupant.TransferNETS::ClosedBank;
                                    SVAOccupant."Effective Date" := FileDate;
                                end;
                                if (DeletionDate <> 0D) and (CopyStr(CSVBuffer.Value, 14, 4) = '0233') then begin
                                    SVAOccupant.TransferNETS := SVAOccupant.TransferNETS::ClosedCreditor;
                                    SVAOccupant."Effective Date" := FileDate;
                                end;
                                if (DeletionDate <> 0D) and (CopyStr(CSVBuffer.Value, 14, 4) = '0234') then begin
                                    SVAOccupant.TransferNETS := SVAOccupant.TransferNETS::ClosedBS;
                                    SVAOccupant."Effective Date" := FileDate;
                                end;
                                if (CopyStr(CSVBuffer.Value, 56, 6) = '000000') and (CopyStr(CSVBuffer.Value, 14, 4) = '0231') then begin
                                    SVAOccupant.TransferNETS := SVAOccupant.TransferNETS::Enrolled;
                                    SVAOccupant."Effective Date" := FileDate;
                                end;
                                SVAOccupant.Modify();
                            until SVAOccupant.Next() = 0;
                    end;
                if CopyStr(CSVBuffer.Value, 3, 3) = '092' then
                    Sektion := '';
                if CopyStr(CSVBuffer.Value, 3, 3) = '992' then
                    Message('Filen er indlæst');
            until CSVBuffer.NEXT() = 0;

        CSVBuffer.DeleteAll();
    end;

    var
        CSVBuffer: Record "CSV Buffer";
        SVAParameters: Record "SVA Parameters";
        SVAOccupant: Record "SVA Occupant";
        CustomerNo: Text[15];
        Aftaleno: Text[8];
        FileDate: Date;
        DeletionDate: Date;
        Sektion: text[4];

    local procedure RemoveZero(Account: Text[15])
    begin
        while CopyStr(Account, 1, 1) = '0' do
            Account := CopyStr(Account, 2, 15);
        CustomerNo := Account;
    end;
}