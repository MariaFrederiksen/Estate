codeunit 50012 "SVA Regulation Letters"
//Prints a letter for each occupant with a regulation line
{
    trigger OnRun()
    begin
        SVAregulations.Reset();
        if SVAregulations.FindSet() then
            repeat
                if (SVARegulations.Increase = 0) and (SVARegulations.MaxRegulation = 0) and (SVARegulations.MinRegulation = 0) then
                    IndeksLetters(SVARegulations.ONumber);
                if (SVARegulations.Increase <> 0) and (SVARegulations.MaxRegulation = 0) and (SVARegulations.MinRegulation = 0) then
                    SolidIncreaseLetters(SVARegulations.ONumber);
                if (SVARegulations.MaxRegulation <> 0) OR (SVARegulations.Minregulation <> 0) then
                    MaxMinLetters(SVARegulations.ONumber);
            until SVAregulations.NEXT() = 0;
    end;

    var
        SVARegulations: Record "SVA Regulations";
        ReportSVARegulationIndeks: Report "SVA Regulation Indeks";
        ReportSVARegulationIndeksDeposit: Report "SVA Regulation Indeks Deposit";
        ReportSVARegulationIndeksMin: Report "SVA Regulation Indeks Min";
        ReportSVARegulationIndeksDepMin: Report "SVA Regulation Indeks Dep Min";
        ReportRegulationIncrease: Report "SVA Regulation Increase";
        ReportSVARegulIncreaseDeposit: Report "SVA Regul. Increase Deposit";

    local procedure SolidIncreaseLetters(Number: Text[20])
    var
        Local_SVARegulations: Record "SVA Regulations";
    begin
        //Letters for indeksregulations
        Local_SVARegulations.Reset();
        Local_SVARegulations.SetRange(ONumber, Number);
        if Local_SVARegulations.FindFirst() then begin
            //Only deposit
            if (Local_SVARegulations.RegulationPrepaidrent = 0) then begin
                Local_SVARegulations.SetRecFilter();
                ReportSVARegulIncreaseDeposit.SetTableView(Local_SVARegulations);
                ReportSVARegulIncreaseDeposit.Run();
            end;
            if (Local_SVARegulations.RegulationPrepaidrent <> 0) then begin
                Local_SVARegulations.SetRecFilter();
                ReportRegulationIncrease.SetTableView(Local_SVARegulations);
                ReportRegulationIncrease.Run();
            end;
        end;
    end;

    local procedure IndeksLetters(Number: Text[20])
    var
        Local_SVARegulations: Record "SVA Regulations";

    begin
        //Letters for indeksregulations
        Local_SVARegulations.Reset();
        Local_SVARegulations.SetRange(ONumber, Number);
        if Local_SVARegulations.FindFirst() then begin
            //Only deposit
            if (Local_SVARegulations.RegulationPrepaidrent = 0) then begin
                Local_SVARegulations.SetRecFilter();
                ReportSVARegulationIndeksDeposit.SetTableView(Local_SVARegulations);
                ReportSVARegulationIndeksDeposit.Run();
            end;
            //Deposit and prepaid rent
            if (Local_SVARegulations.RegulationPrepaidrent <> 0) then begin
                Local_SVARegulations.SetRecFilter();
                ReportSVARegulationIndeks.SetTableView(Local_SVARegulations);
                ReportSVARegulationIndeks.Run();
            end;
        end;

    end;

    local procedure MaxMinLetters(Number: Text[20])
    var
        Local_SVARegulations: Record "SVA Regulations";

    begin
        //Letters for indeksregulations with max/min
        //Only deposit
        Local_SVARegulations.Reset();
        Local_SVARegulations.SetRange(ONumber, Number);
        if Local_SVARegulations.FindFirst() then begin
            if (Local_SVARegulations.RegulationPrepaidrent = 0) then begin
                Local_SVARegulations.SetRecFilter();
                ReportSVARegulationIndeksDepMin.SetTableView(Local_SVARegulations);
                ReportSVARegulationIndeksDepMin.Run();
            end;
            //Deposit and prepaid rent
            if (Local_SVARegulations.RegulationPrepaidrent <> 0) then begin
                Local_SVARegulations.SetRecFilter();
                ReportSVARegulationIndeksMin.SetTableView(Local_SVARegulations);
                ReportSVARegulationIndeksMin.Run();
            end;
        end;

    end;

}




