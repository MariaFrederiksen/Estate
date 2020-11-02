codeunit 50004 "SVA Create Regulations"
// Finds agreements with index adjustments and fixed adjustments for updating incl. letters.
// Find in all properteis.

{
    trigger OnRun();
    begin
        SVARegulations.DeleteAll();

        //Find indeksreguleringerne
        SVAContractregulations.Reset();
        SVAContractregulations.SetRange(RegDate, Today, Today + 40);
        SVAContractregulations.SetRange(EndDate, 0D);
        if SVAContractregulations.Findset() then
            repeat //De fundne kontrakter med indeksreguleringer
                   //Efterberegn deposita, type 10
                Deposit := 0;
                SVAOccupant.Reset();
                SVAOccupant.SetRange(Number, SVAContractregulations.Number);
                if SVAOccupant.FindFirst() then begin
                    SVACosttype.Reset();
                    SVACosttype.SetRange(type, 10);
                    if SVACosttype.FIndset() then
                        repeat
                            SVAOccupantTrans.Reset();
                            SVAOccupantTrans.SetRange("Cost type Estate", SVACosttype.Costtype);
                            SVAOccupantTrans.SetRange(Occupant, SVAContractregulations.Number);
                            IF SVAOccupantTrans.FIndset() then
                                repeat
                                    Deposit += SVAOccupantTrans.Amount;
                                until SVAOccupantTrans.NEXT() = 0;
                        until SVACosttype.NEXT() = 0;
                end;
                SVAContractregulations.DepositAmount := Deposit;
                SVAContractregulations.Modify(true);

                //Efterberegn forudbetalt leje, type 11
                PrepaidRent := 0;
                SVAOccupant.Reset();
                SVAOccupant.SetRange(Number, SVAContractregulations.Number);
                if SVAOccupant.FindFirst() then begin
                    SVACosttype.Reset();
                    SVACosttype.SetRange(type, 11);
                    if SVACosttype.FIndset() then
                        repeat
                            SVAOccupantTrans.Reset();
                            SVAOccupantTrans.SetRange("Cost type Estate", SVACosttype.Costtype);
                            SVAOccupantTrans.SetRange(Occupant, SVAContractregulations.Number);
                            IF SVAOccupantTrans.FIndset() then
                                repeat
                                    PrepaidRent += SVAOccupantTrans.Amount;
                                until SVAOccupantTrans.NEXT() = 0;
                        until SVACosttype.NEXT() = 0;
                end;
                SVAContractregulations.PrepaidRentAMount := PrepaidRent;
                SVAContractregulations.Modify(true);
                SVARegulations.Init();

                //Beboeroplysninger
                SVAOccupant.Reset();
                SVAOccupant.SetRange(Number, SVAContractregulations.Number);
                if SVAOccupant.FindFirst() then begin
                    SVARegulations.ONumber := SVAContractregulations.Number;
                    SVARegulations.OName1 := SVAOccupant.Name1;
                    SVARegulations.OName2 := SVAOccupant.Name2;
                    SVARegulations.OAddress := SVAOccupant.Address;
                    SVARegulations.OAddress2 := SVAOccupant.Address2;
                    SVARegulations.OPostcode := SVAOccupant."Post Code";
                    SVARegulations.OCity := SVAOccupant.City;
                    SVARegulations.OCountry := SVAOccupant."Country/Region Code";
                    SVARegulations.TenancyNo := SVAOccupant.TenancyNo;
                end;
                //Lejemålsoplysninger
                SVATenancy.Reset();
                SVATenancy.SetRange(Number, SVARegulations.TenancyNo);
                if SVATenancy.FindFirst() then begin
                    SVARegulations.TAddress1 := SVATenancy.Address1;
                    SVARegulations.TAddress2 := SVATenancy.Address2;
                    SVARegulations.TPostcode := SVATenancy."Post Code";
                    SVARegulations.TCity := SVATenancy.City;
                    SVARegulations.PropertyNo := SVATenancy.PropertyNo;
                end;
                //Kontraktoplysninger

                SVARegulations.Regulationdate := SVAContractregulations.RegDate;
                SVARegulations.DepositNow := SVAContractregulations.DepositAmount;
                SVARegulations.PrepaidRentNow := SVAContractregulations.PrepaidRentAmount;
                SVARegulations.Indeksdate := SVAContractregulations.Indeks_Date;
                SVARegulations.Increase := SVAContractregulations.Increase;
                SVARegulations.MaxRegulation := SVAContractregulations.MaxRegulations;
                SVARegulations.MinRegulation := SVAContractregulations.MinRegulation;
                //Beregningsgrundlag
                if SVAContractregulations.Indeks_Date <> 0D then begin
                    OldSVAPriceIndeks.Reset();
                    OldSVAPriceIndeks.SetRange(IndeksDate, Calcdate('<-1y>', SVARegulations.Indeksdate));
                    if OldSVAPriceIndeks.FindFirst() then
                        SVARegulations.Indeks_Old := OldSVAPriceIndeks.Indeksrate;

                    NewSVAPriceIndeks.Reset();
                    NewSVAPriceIndeks.SetRange(IndeksDate, SVARegulations.Indeksdate);
                    SVARegulations.Indeks_New := 0;
                    if NewSVAPriceIndeks.FindFirst() then
                        SVARegulations.Indeks_New := NewSVAPriceIndeks.Indeksrate;

                    if NewSVAPriceIndeks.Indeksrate = 0 then
                        Error(IndeksMissingErr, format(SVARegulations.IndeksDate));
                    if SVARegulations.Indeks_Old <> 0 then
                        IndeksPct := (SVARegulations.Indeks_New - SVARegulations.Indeks_Old) / SVARegulations.Indeks_Old * 100;

                end;
                if IndeksPct > SVARegulations.MinRegulation then
                    SVARegulations.ActualRegulation := IndeksPct;
                if IndeksPct <= SVARegulations.MinRegulation then
                    SVARegulations.ActualRegulation := SVARegulations.MinRegulation;
                if (SVARegulations.MaxRegulation <> 0) and (SVARegulations.ActualRegulation > SVARegulations.MaxRegulation) then
                    SVARegulations.ActualRegulation := SVARegulations.MaxRegulation;
                if SVARegulations.Increase <> 0 then
                    SVARegulations.ActualRegulation := SVARegulations.Increase;

                //Henter leje
                //Tom slutdato
                SVASubscriptionLines.Reset();
                SVASubscriptionLines.SetRange(Tenancies, SVARegulations.TenancyNo);
                SVASubscriptionLines.SetRange(PriceIndeks, true);
                SVASubscriptionLines.SetRange("Date To", 0D);
                if SVASubscriptionLines.FindFirst() then begin
                    SVARegulations.Costtype := SVASubscriptionLines."Cost Types";
                    SVARegulations.RentPerNow := SVASubscriptionLines."Amount Period";
                    SVARegulations.RentYearNow := SVASubscriptionLines."Amount Year";
                end;
                //Beregner ny leje, depositum-regulering og regulering af forudbetalt leje
                SVARegulations.RentYearNew := (SVARegulations.RentYearNow * SVARegulations.ActualRegulation / 100) + SVARegulations.RentYearNow;
                SVARegulations.RegulationYear := (SVARegulations.RentYearNow * SVARegulations.ActualRegulation / 100);
                SVARegulations.RentPerNew := (SVARegulations.RentPerNow * SVARegulations.ActualRegulation / 100) + SVARegulations.RentPerNow;
                SVARegulations.RegulationPer := (SVARegulations.RentPerNow * SVARegulations.ActualRegulation / 100);
                SVARegulations.DepositNew := (SVARegulations.DepositNow * SVARegulations.ActualRegulation / 100) + SVARegulations.DepositNow;
                SVARegulations.RegulationDeposit := SVARegulations.DepositNow * SVARegulations.ActualRegulation / 100;
                SVARegulations.PrepaidRentNew := SVARegulations.PrepaidRentNow * SVARegulations.ActualRegulation / 100 + SVARegulations.PrepaidRentNow;
                SVARegulations.RegulationPrepaidrent := SVARegulations.PrepaidRentNow * SVARegulations.ActualRegulation / 100;

                SVARegulations.Insert(true);
            until SVAContractregulations.NEXT() = 0;
        Message('Der er dannet grundlag for indeksreguleringer.');


    end;

    var
        SVAOccupant: Record "SVA Occupant";
        SVATenancy: Record "SVA Tenancy";
        SVAContractregulations: Record "SVA Contract regulations";
        SVARegulations: Record "SVA Regulations";
        OldSVAPriceIndeks: Record "SVA PriceIndeks";
        NewSVAPriceIndeks: Record "SVA PriceIndeks";
        SVASubscriptionLines: Record "SVA Subscription Lines";
        SVACosttype: Record "SVA Cost type";
        SVAOccupantTrans: Record "SVA Occupant Trans";
        IndeksPct: Decimal;
        Deposit: Decimal;
        PrepaidRent: Decimal;
        IndeksMissingErr: Label 'Der mangler indeks pr. %1', comment = '%1 = Regulations.IndeksDate';


}