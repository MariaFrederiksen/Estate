codeunit 50004 "SVA Create Regulations"
// Finds agreements with index adjustments and fixed adjustments for updating incl. letters.
// Find in all properteis.

{
    trigger OnRun();
    begin
        //GetIndeks from Danmarks Statistik
        Codeunit.Run(Codeunit::"SVA Import Priceindeks");

        //Delete old calculations
        SVARegulations.DeleteAll();

        //Test for indeks date
        SVAContractregulations.Reset();
        SVAContractregulations.SetRange(RegDate, WorkDate(), WorkDate() + 50);
        if SVAContractregulations.FindSet() then
            if SVAContractRegulations.Indeks_Date < DMY2Date(1, 1, 1960) then
                Error(IndeksDateErr, SVAContractregulations.Number);

        //Start and enddate need to be updated
        SVAContractregulations.Reset();
        if SVAContractregulations.FindSet() then
            repeat
                SVAOccupant.Reset();
                SVAOccupant.SetRange(Number, SVAContractregulations.Number);
                if SVAOccupant.FindFirst() then begin
                    SVAContractregulations.Startdate := SVAOccupant.StartDate;
                    SVAContractregulations.EndDate := SVAOccupant.EndDate;
                    SVAContractregulations.Modify();
                end;
            until SVAContractregulations.Next() = 0;

        //Find indeksregulations
        SVAContractregulations.Reset();
        SVAContractregulations.SetRange(RegDate, WorkDate(), WorkDate() + 50);
        if SVAContractregulations.FindSet() then
            repeat
                //Calculate deposit, type 10
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
                            IF SVAOccupantTrans.Findset() then
                                repeat
                                    Deposit += SVAOccupantTrans.Amount;
                                until SVAOccupantTrans.NEXT() = 0;
                        until SVACosttype.NEXT() = 0;
                end;
                SVAContractregulations.DepositAmount := Deposit;
                SVAContractregulations.Modify(true);

                //Calculate prepaid rent, type 11
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

                //Occupant information
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
                    Customer.Get(SVAOccupant."Customer No");
                end;
                //Tenant information
                SVATenancy.Reset();
                SVATenancy.SetRange(Number, SVARegulations.TenancyNo);
                if SVATenancy.FindFirst() then begin
                    SVARegulations.TAddress1 := SVATenancy.Address1;
                    SVARegulations.TAddress2 := SVATenancy.Address2;
                    SVARegulations.TPostcode := SVATenancy."Post Code";
                    SVARegulations.TCity := SVATenancy.City;
                    SVARegulations.PropertyNo := SVATenancy.PropertyNo;
                end;
                //Contractinformation
                SVARegulations.Regulationdate := SVAContractregulations.RegDate;
                SVARegulations.DepositNow := SVAContractregulations.DepositAmount;
                SVARegulations.PrepaidRentNow := SVAContractregulations.PrepaidRentAmount;

                if SVAContractregulations.Increase = 0 then begin
                    SVARegulations.Indeksdate := SVAContractregulations.Indeks_Date;
                    SVARegulations.OldIndeksDate := CalcDate('<-1y>', SVARegulations.Indeksdate);

                    SVARegulations.MaxRegulation := SVAContractregulations.MaxRegulations;
                    SVARegulations.MinRegulation := SVAContractregulations.MinRegulation;
                    //Calculation basis
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
                            Error(IndeksMissingErr, format(SVARegulations.IndeksDate), SVAContractregulations.Number);
                        if SVARegulations.Indeks_Old <> 0 then
                            IndeksPct := (SVARegulations.Indeks_New - SVARegulations.Indeks_Old) / SVARegulations.Indeks_Old * 100;

                    end;
                end;
                if IndeksPct > SVARegulations.MinRegulation then
                    SVARegulations.ActualRegulation := IndeksPct;
                if IndeksPct <= SVARegulations.MinRegulation then
                    SVARegulations.ActualRegulation := SVARegulations.MinRegulation;
                if (SVARegulations.MaxRegulation <> 0) and (SVARegulations.ActualRegulation > SVARegulations.MaxRegulation) then
                    SVARegulations.ActualRegulation := SVARegulations.MaxRegulation;

                if SVAContractregulations.Increase <> 0 then
                    SVARegulations.ActualRegulation := SVAContractregulations.Increase;

                //Get rent
                //Empty enddate
                SVASubscriptionLines.Reset();
                SVASubscriptionLines.SetRange(Tenancies, SVARegulations.TenancyNo);
                SVASubscriptionLines.SetRange(PriceIndeks, true);
                SVASubscriptionLines.SetRange("Date To", 0D);
                if SVASubscriptionLines.FindFirst() then begin
                    SVARegulations.Costtype := SVASubscriptionLines."Cost Types";
                    SVARegulations.RentPerNow := SVASubscriptionLines."Amount Period";
                    SVARegulations.RentYearNow := SVASubscriptionLines."Amount Year";

                    //SVARegulations."Vat Charge" := false;
                    VATPostingSetup.Reset();
                    VATPostingSetup.SetRange("VAT Prod. Posting Group", SVASubscriptionLines.VatGroup);
                    VATPostingSetup.SetRange("VAT Bus. Posting Group", Customer."VAT Bus. Posting Group");
                    if VATPostingSetup.findfirst() then
                        if VATPostingSetup."VAT %" <> 0 then
                            SVARegulations."VAT Charge" := true;
                end;
                //Calculates new rent, deposit adjustment and adjustment of prepaid rent
                SVARegulations.RentYearNew := (SVARegulations.RentYearNow * SVARegulations.ActualRegulation / 100) + SVARegulations.RentYearNow;
                SVARegulations.RegulationYear := SVARegulations.RentYearNow * SVARegulations.ActualRegulation / 100;
                SVARegulations.RentPerNew := (SVARegulations.RentPerNow * SVARegulations.ActualRegulation / 100) + SVARegulations.RentPerNow;
                SVARegulations.RegulationPer := (SVARegulations.RentPerNow * SVARegulations.ActualRegulation / 100);
                SVARegulations.DepositNew := (SVARegulations.DepositNow * SVARegulations.ActualRegulation / 100) + SVARegulations.DepositNow;
                SVARegulations.RegulationDeposit := SVARegulations.DepositNow * SVARegulations.ActualRegulation / 100;
                SVARegulations.PrepaidRentNew := (SVARegulations.PrepaidRentNow * SVARegulations.ActualRegulation / 100) + SVARegulations.PrepaidRentNow;
                SVARegulations.RegulationPrepaidrent := SVARegulations.PrepaidRentNow * SVARegulations.ActualRegulation / 100;
                if SVARegulations.Costtype <> '' then begin
                    if SVAContractregulations.EndDate < DMY2Date(1, 1, 1960) then
                        SVARegulations.Insert(true);

                    if SVAContractregulations.EndDate > SVAContractregulations.RegDate then
                        SVARegulations.Insert(true);
                end;
            until SVAContractregulations.NEXT() = 0;
        Page.run(Page::"SVA Regulations");
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
        Customer: Record Customer;
        VATPostingSetup: Record "VAT Posting Setup";
        IndeksPct: Decimal;
        Deposit: Decimal;
        PrepaidRent: Decimal;
        IndeksMissingErr: Label 'Der mangler indeksdato pr. %1 på %2', comment = '%1 = Regulations.IndeksDate, %2 = Contract number.';
        IndeksDateErr: Label 'Der mangler indeksdato på kontrakt %1 ', comment = '%1 = SVA Contract Regulation.Number';


}