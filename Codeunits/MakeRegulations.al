codeunit 50004 "SVA Create Regulations"
// Finds agreements with index adjustments and fixed adjustments for updating incl. letters.
// Find in all properteis.

{
    trigger OnRun();
    begin
        Regulations.DeleteAll;

        //Find indeksreguleringerne
        ContractReg.Reset;
        ContractReg.SetRange(RegDate, Today, Today + 40);
        ContractReg.SetRange(EndDate,0D);
        if ContractReg.Findset then
            repeat //De fundne kontrakter med indeksreguleringer
            //Efterberegn deposita, type 10
            Deposit := 0;
            Occupant.Reset;
            Occupant.SetRange(Number, ContractReg.Number);
            if Occupant.FindFirst() then begin
                Costtype.Reset;
                Costtype.SetRange(type, 10);
                if Costtype.FindSet then
                    repeat
                    OccupantTrans.Reset;
                    OccupantTrans.SetRange("Cost type Estate",Costtype.Costtype);
                    OccupantTrans.SetRange(Occupant,ContractReg.Number);
                    IF OccupantTrans.FindSet then  
                        repeat
                            Deposit += OccupantTrans.Amount;
                        until OccupantTrans.Next = 0;
                    until Costtype.Next = 0;
            end;
            ContractReg.DepositAmount := Deposit;
            ContractReg.Modify(true);   

            //Beboeroplysninger
            Occupant.Reset;
            Occupant.SetRange(Number, ContractReg.Number);
            if Occupant.FindFirst() then begin
                Regulations.ONumber := ContractReg.Number;
                Regulations.OName1 := Occupant.Name1;
                Regulations.OName2 := Occupant.Name2;
                Regulations.OAddress := Occupant.Address;
                Regulations.OAddress2 := Occupant.Address2;
                Regulations.OPostcode := Occupant."Post Code";
                Regulations.OCity := Occupant.City;
                Regulations.OCountry := Occupant."Country/Region Code";
                Regulations.TenancyNo := Occupant.TenancyNo;
            end;
            //Lejemålsoplysninger
            TenancyCard.Reset;
            TenancyCard.SetRange(Number, Regulations.TenancyNo);
            if TenancyCard.FindFirst() then begin
                Regulations.TAddress1 := TenancyCard.Address1;
                Regulations.TAddress2 := TenancyCard.Address2;
                Regulations.TPostcode := TenancyCard."Post Code";
                Regulations.TCity := TenancyCard.City;
                Regulations.PropertyNo := TenancyCard.PropertyNo;
            end;
            //Kontraktoplysninger

            Regulations.Regulationdate := ContractReg.RegDate;
            Regulations.DepositNow := ContractReg.DepositAmount;
            Regulations.PrepaidRentNow := ContractReg.PrepaidRentAmount;
            Regulations.Indeksdate := ContractReg.Indeks_Date;
            Regulations.Increase := ContractReg.Increase;
            Regulations.MaxRegulation := ContractReg.MaxRegulations;
            Regulations.MinRegulation := ContractReg.MinRegulation;
            //Beregningsgrundlag
            if ContractReg.Indeks_Date <> 0D then begin
                IndeksOld.Reset;
                IndeksOld.SetRange(IndeksDate, Calcdate('<-1y>', Regulations.Indeksdate));
                if IndeksOld.FindFirst then begin
                    Regulations.Indeks_Old := IndeksOld.Indeksrate;
                end;
                IndeksNew.Reset;
                IndeksNew.SetRange(IndeksDate, Regulations.Indeksdate);
                Regulations.Indeks_New := 0;
                if IndeksNew.FindFirst then begin
                    Regulations.Indeks_New := IndeksNew.Indeksrate;
                end;
                if IndeksNew.Indeksrate = 0 then
                    Message('Der mangler indeks pr. '+format(Regulations.IndeksDate));
                if Regulations.Indeks_Old <> 0 then begin
                    IndeksPct := (Regulations.Indeks_New - Regulations.Indeks_Old) / Regulations.Indeks_Old * 100;
                end;
            end;
            if IndeksPct > Regulations.MinRegulation then
                Regulations.ActualRegulation := IndeksPct;
            if IndeksPct <= Regulations.MinRegulation then
                Regulations.ActualRegulation := Regulations.MinRegulation;
            if (Regulations.MaxRegulation <> 0) and (Regulations.ActualRegulation > Regulations.MaxRegulation) then
                    Regulations.ActualRegulation := Regulations.MaxRegulation;
            if Regulations.Increase <> 0 then
               Regulations.ActualRegulation := Regulations.Increase;
                    
            //Henter leje
            //Tom slutdato
            Sublines.Reset;
            Sublines.SetRange(Tenancies, Regulations.TenancyNo);
            Sublines.SetRange(PriceIndeks, true);
            Sublines.SetRange("Date To", 0D);
            if Sublines.FindFirst then begin
                Regulations.Costtype := Sublines."Cost Types";
                Regulations.RentPerNow := Sublines."Amount Period";
                Regulations.RentYearNow := Sublines."Amount Year";
            end;
            //Beregner ny leje, depositum-regulering og regulering af forudbetalt leje
            Regulations.RentYearNew := (Regulations.RentYearNow * Regulations.ActualRegulation / 100) + Regulations.RentYearNow;
            Regulations.RegulationYear := (Regulations.RentYearNow * Regulations.ActualRegulation / 100);
            Regulations.RentPerNew := (Regulations.RentPerNow * Regulations.ActualRegulation / 100) + Regulations.RentPerNow;
            Regulations.RegulationPer := (Regulations.RentPerNow * Regulations.ActualRegulation / 100);
            Regulations.DepositNew := (Regulations.DepositNow * Regulations.ActualRegulation / 100) + Regulations.DepositNow;
            Regulations.RegulationDeposit := Regulations.DepositNow * Regulations.ActualRegulation / 100;
            Regulations.PrepaidRentNew := Regulations.PrepaidRentNow * Regulations.ActualRegulation / 100 + Regulations.PrepaidRentNow;
            Regulations.RegulationPrepaidrent := Regulations.PrepaidRentNow * Regulations.ActualRegulation / 100;

            Regulations.Insert(true);
            until ContractReg.Next = 0;
        Message('Der er dannet grundlag for indeksreguleringer.');


    end;

    var
        Occupant: Record "SVA Occupant";
        TenancyCard: Record "SVA Tenancy";
        ContractReg: Record "SVA Contract regulations";
        Regulations: Record "SVA Regulations";
        RegLetter: Record "SVA Regulations";
        IndeksOld: Record "SVA PriceIndeks";
        IndeksNew: Record "SVA PriceIndeks";
        IndeksPct: Decimal;
        Sublines: Record "SVA Subscription Lines";
        Letter: Report "SVA Regulation Indeks";
        LetterIncrease: Report "SVA Regulation Increase";
        Costtype : Record "SVA Cost type";
        OccupantTrans : Record "SVA Occupant Trans";
        Deposit: Decimal;

}