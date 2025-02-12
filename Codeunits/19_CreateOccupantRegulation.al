codeunit 50019 "SVA Create Occupant regulation"
{
    TableNo = "SVA Occupant";

    trigger OnRun()
    begin
        SVAOccupant.Copy(Rec);
        Rec := SVAOccupant;
        if SVAOccupant.StartDate = 0D then
            Error('Der skal indtastes startdato.');

        SVAContractRegulations.Reset();
        SVAContractRegulations.SetRange(Number, SVAOccupant.Number);
        if SVAContractRegulations.Findfirst() then
            ;

        if not SVAContractRegulations.Findfirst() then begin
            SVAContractRegulations.Init();
            SVAContractRegulations.Number := SVAOccupant.Number;
            SVAContractRegulations.Validate(Number);
            if not SVAContractRegulations.Insert() then
                SVAContractRegulations.Modify();
        end;
    end;


    var
        SVAOccupant: Record "SVA Occupant";
        SVAContractRegulations: Record "SVA Contract regulations";
}