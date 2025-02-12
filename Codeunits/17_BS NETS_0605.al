codeunit 50017 "SVA NETS BS 0605"
{
    // Flere ejendomme med forskellige aftalenr eller debitorgrupper i regnskabet, men samme dataleverandør
    // Windows encoding. (korrekt æøå)

    trigger OnRun();
    begin
        Codeunit.Run(Codeunit::"SVA Send");
        SVAExport.Reset();
        SVAExport.SetRange(Name, 'BS0605');
        if SVAExport.FindSet() then
            SVAExport.DeleteAll();

        SVAParameters.Reset();
        IF SVAParameters.Findfirst() then begin
            Datasupplier := SVAParameters.BS_Dataprovider;
            Subsystem := SVAParameters.BS_Delsystem;
            CreditorPBSno := SVAParameters.BS_AftaleNo;
            DebtorGroupNo := SVAParameters.BS_DebGrp;
        end;
        IF StrLen(Datasupplier) = 0 then
            Error('Der mangler opsætning. Kørslen afbrydes.');

        F002();
        F012();
        SVAOccupant.Reset();
        SVAOccupant.SetRange(SVAOccupant.TransferNETS, SVAOccupant.TransferNETS::Transfer);
        if SVAOccupant.FindSet() then
            repeat
                if (StrLen(SVAOccupant."Bankreg-no") = 4) and (StrLen(SVAOccupant.BankAccount) > 4) and (StrLen(SVAOccupant.CPRno1) > 9) then begin
                    F042();
                    Count42 += 1;
                    SVAOccupant.TransferNETS := "SVA NETS Transfer"::Enrolled;
                    SVAOccupant.Modify();
                end;
            until SVAOccupant.Next() = 0;

        F092(); //section end
        F992(); //File End
        Commit();
        if Count42 <> 0 then
            Xmlport.Run(Xmlport::"SVA File 0605 for NETS", false);
    end;

    var
        SVAParameters: Record "SVA Parameters";
        SVAExport: Record "SVA Export Temp";
        SVAOccupant: Record "SVA Occupant";
        STR002: Text[128];
        TMP: Text[128];
        STR012: Text[128];
        STR042: Text[128];
        STR092: Text[128];
        STR992: Text[150];
        Count42: Integer;
        SpecText: Text[128];
        TempCount: Integer;
        Datasupplier: text[8];
        Subsystem: text[3];
        CreditorPBSno: text[8];
        DebtorGroupNo: text[5];

    local procedure F002();
    begin
        CLEAR(TMP);
        CLEAR(STR002);
        STR002 := 'BS002';

        IF STRLEN(Datasupplier) > 8 THEN
            TMP := DELSTR(Datasupplier, 9, 2)
        ELSE
            TMP := Datasupplier;

        STR002 := INSSTR(STR002, TMP, 6);
        TMP := Subsystem;
        STR002 := INSSTR(STR002, TMP, 14);
        TMP := '0605';
        STR002 := INSSTR(STR002, TMP, 17);
        TMP := '0000' + FORMAT(TODAY, 6, 2);
        STR002 := INSSTR(STR002, TMP, 21);
        TMP := '';
        TMP := PADSTR(TMP, 19, ' ');
        STR002 := INSSTR(STR002, TMP, 31);
        TMP := '';
        TMP := FORMAT(TODAY, 6, 2);
        STR002 := INSSTR(STR002, TMP, 50);
        TMP := '';
        TMP := PADSTR(TMP, 73, ' ');
        STR002 := INSSTR(STR002, TMP, 56);
        STR002 := DELSTR(STR002, 129, 100);
        F_Save_Table(STR002);
    end;

    local procedure F012();
    begin

        CLEAR(TMP);
        CLEAR(STR012);
        STR012 := 'BS012';
        TMP := CreditorPBSno;
        STR012 := INSSTR(STR012, TMP, 6);
        TMP := '0120';
        STR012 := INSSTR(STR012, TMP, 14);
        TMP := '';
        TMP := PADSTR(TMP, 3, ' ');
        STR012 := INSSTR(STR012, TMP, 18);
        TMP := '';
        TMP := '000000000' + FORMAT(TODAY, 6, 2); //own use
        STR012 := INSSTR(STR012, TMP, 21);
        TMP := '';
        TMP := PADSTR(TMP, 9, ' ');
        STR012 := INSSTR(STR012, TMP, 36);
        TMP := '';
        TMP := PADSTR(TMP, 6, '0');
        STR012 := INSSTR(STR012, TMP, 45);
        TMP := '';
        TMP := PADSTR(TMP, 78, ' ');
        STR012 := INSSTR(STR012, TMP, 51);
        STR012 := DELSTR(STR012, 129, 150);
        F_Save_Table(STR012);
        CLEAR(SpecText);
    end;



    local procedure F042();
    begin
        CLEAR(TMP);
        CLEAR(STR042);
        STR042 := 'BS042';
        TMP := CreditorPBSno;
        STR042 := INSSTR(STR042, TMP, 6);
        TMP := '0200';
        STR042 := INSSTR(STR042, TMP, 14);
        TMP := '000';
        STR042 := INSSTR(STR042, TMP, 18);
        TMP := DebtorGroupNo;
        STR042 := INSSTR(STR042, TMP, 21);
        TMP := '';
        TMP := PADSTR(TMP, 15, '0');
        TMP := INSSTR(TMP, SVAOccupant."Customer No", 16 - STRLEN(SVAOccupant."Customer No"));
        STR042 := INSSTR(STR042, TMP, 26);
        TMP := '';
        TMP := PADSTR(TMP, 9, '0');
        STR042 := INSSTR(STR042, TMP, 41);
        TMP := '000000';
        STR042 := INSSTR(STR042, TMP, 50);
        TMP := '000000';
        STR042 := INSSTR(STR042, TMP, 56);
        STR042 := DELSTR(STR042, 62, 10);
        TMP := SVAOccupant.CPRno1;
        STR042 := INSSTR(STR042, TMP, 62);
        TMP := '          ';
        STR042 := INSSTR(STR042, TMP, 72);
        TMP := SVAOccupant."Bankreg-no";
        STR042 := INSSTR(STR042, TMP, 82);
        TMP := '';
        TMP := PADSTR(TMP, 4, ' ');
        STR042 := INSSTR(STR042, TMP, 86);
        TMP := '';
        TMP := PADSTR(TMP, 10, '0');
        TMP := INSSTR(TMP, Copystr(SVAOccupant.BankAccount, 1, 10), 11 - STRLEN(SVAOccupant.BankAccount));
        TMP := DelStr(TMP, 11, 10);
        STR042 := INSSTR(STR042, TMP, 90);
        TMP := '';
        TMP := PADSTR(TMP, 10, ' ');
        STR042 := INSSTR(STR042, TMP, 100);
        TMP := '0';
        STR042 := INSSTR(STR042, TMP, 110);
        TMP := '0000';
        STR042 := INSSTR(STR042, TMP, 111);
        TMP := '';
        TMP := PADSTR(TMP, 14, ' ');
        STR042 := INSSTR(STR042, TMP, 115);
        STR042 := DELSTR(STR042, 129, 150);
        F_Save_Table(STR042);
        CLEAR(SpecText);
    end;



    local procedure F092();
    begin
        CLEAR(TMP);
        CLEAR(STR092);
        STR092 := 'BS092';
        TMP := CreditorPBSno;
        STR092 := INSSTR(STR092, TMP, 6);
        TMP := '0120';
        STR092 := INSSTR(STR092, TMP, 14);
        TMP := '         ';
        STR092 := INSSTR(STR092, TMP, 18);
        TMP := '';
        TMP := PADSTR(TMP, 11, '0');
        IF Count42 < 10 THEN BEGIN
            SpecText := FORMAT(Count42, 1);
            TMP := INSSTR(TMP, SpecText, 11);
        END;
        IF Count42 > 9 THEN
            IF Count42 < 100 THEN BEGIN
                SpecText := FORMAT(Count42, 2);
                TMP := INSSTR(TMP, SpecText, 10);
            END;
        IF Count42 > 99 THEN
            IF Count42 < 1000 THEN BEGIN
                SpecText := FORMAT(Count42, 3);
                TMP := INSSTR(TMP, SpecText, 9);
            END;
        IF Count42 > 999 THEN
            IF Count42 < 10000 THEN BEGIN
                SpecText := FORMAT(Count42, 4);
                TMP := INSSTR(TMP, SpecText, 8);
            END;
        IF Count42 > 9999 THEN
            IF Count42 < 100000 THEN BEGIN
                SpecText := FORMAT(Count42, 5);
                TMP := INSSTR(TMP, SpecText, 7);
            END;
        STR092 := INSSTR(STR092, TMP, 27);
        TMP := '';
        TMP := PADSTR(TMP, 26, '0');
        STR092 := INSSTR(STR092, TMP, 38);
        TMP := '';
        TMP := PADSTR(TMP, 15, ' ');
        STR092 := INSSTR(STR092, TMP, 64);
        TMP := '';
        TMP := PADSTR(TMP, 11, '0');
        STR092 := INSSTR(STR092, TMP, 79);
        TMP := '';
        TMP := PADSTR(TMP, 38, '0');
        STR092 := INSSTR(STR092, TMP, 090);
        STR092 := DELSTR(STR092, 129, 100);
        F_Save_Table(STR092);
    end;

    local procedure F992();
    begin
        CLEAR(TMP);
        CLEAR(STR992);
        STR992 := 'BS992';
        TMP := Datasupplier;
        STR992 := INSSTR(STR992, TMP, 6);
        TMP := Subsystem;
        STR992 := INSSTR(STR992, TMP, 14);
        TMP := '0605';
        STR992 := INSSTR(STR992, TMP, 17);
        TMP := '';
        TMP := PADSTR(TMP, 11, '0');
        STR992 := INSSTR(STR992, TMP, 21);
        TMP := '';
        TMP := '1';
        STR992 := INSSTR(STR992, TMP, 31);
        TMP := '';
        TMP := PADSTR(TMP, 11, '0');

        IF Count42 < 10 THEN BEGIN
            SpecText := FORMAT(Count42, 1);
            TMP := INSSTR(TMP, SpecText, 11);
        END;
        IF Count42 > 9 THEN
            IF Count42 < 100 THEN BEGIN
                SpecText := FORMAT(Count42, 2);
                TMP := INSSTR(TMP, SpecText, 10);
            END;
        IF Count42 > 99 THEN
            IF Count42 < 1000 THEN BEGIN
                SpecText := FORMAT(Count42, 3);
                TMP := INSSTR(TMP, SpecText, 9);
            END;
        IF Count42 > 999 THEN
            IF Count42 < 10000 THEN BEGIN
                SpecText := FORMAT(Count42, 4);
                TMP := INSSTR(TMP, SpecText, 8);
            END;
        IF Count42 > 9999 THEN
            IF Count42 < 100000 THEN BEGIN
                SpecText := FORMAT(Count42, 5);
                TMP := INSSTR(TMP, SpecText, 7);
            END;
        STR992 := INSSTR(STR992, TMP, 32);
        TMP := '';
        TMP := PADSTR(TMP, 86, '0');
        STR992 := INSSTR(STR992, TMP, 43);
        STR992 := DELSTR(STR992, 129, 100);
        F_Save_Table(STR992);

        IF Count42 = 0 THEN
            MESSAGE('Der er ingen tilmeldinger til NETS.');
        IF Count42 <> 0 then
            MESSAGE('Fil med ' + Format(Count42) + ' tilmeldinger til NETS er klar.');
    end;

    local procedure F_Save_Table(Text128: Text[128]);
    begin
        SVAExport.Init();
        TempCount += 1;
        SVAExport."Line No." := TempCount;
        SVAExport.Name := 'BS0605';
        SVAExport."Output Line 128" := Text128;
        SVAExport.Insert();
    end;
}

