page 50016 "SVA Regulations"
// Viser poster til regulering. Kan tilrettes efter behov
{
    Caption = 'Regulations';
    PageType = List;
    SourceTable = "SVA Regulations";
    DeleteAllowed = true;
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                //Bebeoerinfo
                field(Number; Onumber)
                {
                    ApplicationArea = All;
                    ToolTip = 'Occupant';
                }
                field(TenancyNo; TenancyNo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Tenancy number';
                }
                field(Name1; OName1)
                {
                    ApplicationArea = All;
                    ToolTip = 'Name';
                }
                field(Costtype; Costtype)
                {
                    ApplicationArea = All;
                    ToolTip = 'Costtype';
                }
                field(Indeks_Old; Indeks_Old)
                {
                    ApplicationArea = All;
                    ToolTip = 'Indeks old';
                }
                field(Indeks_New; Indeks_New)
                {
                    ApplicationArea = All;
                    ToolTip = 'Indeks new';
                }
                field(ActualRegulation; ActualRegulation)
                {
                    ApplicationArea = All;
                    ToolTip = 'Regulering';
                }
                field(RentPerNow; RentPerNow)
                {
                    ApplicationArea = All;
                    Tooltip = 'Current rent';
                }
                field(RentPerNew; RentPerNew)
                {
                    ApplicationArea = All;
                    ToolTip = 'New rent';
                }
                field(RegulationDeposit; RegulationDeposit)
                {
                    ApplicationArea = All;
                    ToolTip = 'Regulation deposit';
                }
                field(RegulationPrepaidrent; RegulationPrepaidrent)
                {
                    ApplicationArea = All;
                    ToolTip = 'Regulation prepaid rent';
                }
                field(Regulationdate; Regulationdate)
                {
                    ApplicationArea = All;
                    ToolTip = 'Regulation date';
                }

                field(Closed; Closed)
                {
                    ApplicationArea = All;
                    ToolTip = 'Updated';
                }

            }
        }
        area(factboxes)
        {
            systempart(Links; Links)
            {
                ApplicationArea = All;
            }
            systempart(Notes; Notes)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(MakeRegulations)
            {
                ApplicationArea = all;
                Caption = 'Make rent regulations';
                ToolTip = 'Making basic data for rent regulations.';
                Image = Recalculate;
                RunObject = Codeunit "SVA Create Regulations";
            }
            action(Letters)
            {
                Caption = 'Make letters';
                Image = Report;
                ApplicationArea = All;

                trigger OnAction();
                begin
                    SVAregulations.Reset();
                    if SVAregulations.FindSet() then
                        repeat

                            FirstSVARegulations.Reset();
                            FirstSVARegulations.SetRange(FirstSVARegulations.ONumber, SVAregulations.ONumber);
                            if FirstSVARegulations.FindFirst() then begin
                                //No max/min increase
                                //Indeks regulations and solid increase
                                if (FirstSVARegulations.Increase = 0) and (FirstSVARegulations.MaxRegulation = 0) and (FirstSVARegulations.MinRegulation = 0) then begin
                                    //Letters for indeksregulations
                                    //Only deposit
                                    if (FirstSVARegulations.RegulationPrepaidrent = 0) then begin
                                        Clear(SVARegulationIndeksDeposit);
                                        SVARegulationIndeksDeposit.SetTableView(FirstSVARegulations);
                                        SVARegulationIndeksDeposit.Run();
                                    end;
                                    if (FirstSVARegulations.RegulationPrepaidrent <> 0) then begin
                                        Clear(SVARegulationIndeks);
                                        SVARegulationIndeks.SetTableView(FirstSVARegulations);
                                        SVARegulationIndeks.Run();
                                    end;
                                end;
                                if (FirstSVARegulations.Increase <> 0) and (FirstSVARegulations.MaxRegulation = 0) and (FirstSVARegulations.MinRegulation = 0) then begin
                                    //Letters for solid Increase
                                    //Only deposit
                                    if (RegulationPrepaidrent = 0) then begin
                                        Clear(SVARegulIncreaseDeposit);
                                        SVARegulIncreaseDeposit.SetTableView(FirstSVARegulations);
                                        SVARegulIncreaseDeposit.Run();
                                    end;
                                    if (RegulationPrepaidrent <> 0) then begin
                                        Clear(SVARegulationIncrease);
                                        SVARegulationIncrease.SetTableView(FirstSVARegulations);
                                        SVARegulationIncrease.Run();
                                    end;
                                end;
                                if (FirstSVARegulations.MaxRegulation <> 0) OR (FirstSVARegulations.Minregulation <> 0) then begin
                                    //Letters for indeksregulations with max/min
                                    //Only deposit
                                    if (RegulationPrepaidrent = 0) then begin
                                        Clear(SVARegulationIndeksDepMin);
                                        SVARegulationIndeksDepMin.SetTableView(FirstSVARegulations);
                                        SVARegulationIndeksDepMin.Run();
                                    end;
                                    if (RegulationPrepaidrent <> 0) then begin
                                        Clear(SVARegulationIndeksMin);
                                        SVARegulationIndeksMin.SetTableView(FirstSVARegulations);
                                        SVARegulationIndeksMin.Run();
                                    end;
                                end;
                            end;
                        until SVAregulations.NEXT() = 0;
                end;
            }


            action(Updates)
            {
                Caption = 'Updates';
                Image = Report;
                ApplicationArea = All;

                trigger OnAction();
                begin
                    SVAregulations.Reset();
                    SVAregulations.SetRange(SVAregulations.Closed, false);
                    if SVAregulations.FindSet() then
                        repeat
                            FirstSVARegulations.Reset();
                            FirstSVARegulations.SetRange(FirstSVARegulations.ONumber, SVAregulations.ONumber);
                            if FirstSVARegulations.FindFirst() then begin
                                //Find ud af om der er moms på aftalen
                                SVASubscriptionLines.Reset();
                                SVASubscriptionLines.SetRange(type, 1);
                                if SVASubscriptionLines.FindFirst() then
                                    Vatgrp := SVASubscriptionLines.VatGroup;

                                //Find periode på aftalen
                                SVATenancy.Reset();
                                SVATenancy.SetRange(Number, FirstSVARegulations.TenancyNo);
                                if SVATenancy.FindFirst() then begin
                                    if SVATenancy.PeriodYear = 0 then
                                        Periods := 12;
                                    if SVATenancy.PeriodYear = 1 then
                                        Periods := 4;
                                    if SVATenancy.PeriodYear = 2 then
                                        Periods := 2;
                                    if SVATenancy.PeriodYear = 3 then
                                        Periods := 1;
                                end;

                                //Dan linje for regulering af deposita
                                SVACosttype.Reset();
                                SVACosttype.SetRange(type, 10); //deposita
                                SVACosttype.SetRange(VatGroup, Vatgrp);
                                if SVACosttype.FindFirst() then begin
                                    Clear(SVASubscriptionLines);
                                    SVASubscriptionLines.Tenancies := FirstSVARegulations.TenancyNo;
                                    SVASubscriptionLines.Type := SVACosttype.Type;
                                    SVASubscriptionLines.VatGroup := Vatgrp;
                                    SVASubscriptionLines.ProductPostingGroup := SVACosttype.ProductPostingGroup;
                                    SVASubscriptionLines.Order := SVACosttype.Order;
                                    SVASubscriptionLines.Description := 'Regulering af depositum';
                                    SVASubscriptionLines."Date From" := FirstSVARegulations.Regulationdate;
                                    SVASubscriptionLines."Cost Types" := SVACosttype.Costtype;
                                    SVASubscriptionLines."Amount Year" := FirstSVARegulations.RegulationDeposit * Periods;
                                    SVASubscriptionLines."Amount Period" := FirstSVARegulations.RegulationDeposit;
                                    IF Periods = 12 then
                                        SVASubscriptionLines."Date To" := CalcDate('<1m-1D>', SVASubscriptionLines."Date From");
                                    IF Periods = 4 then
                                        SVASubscriptionLines."Date To" := CalcDate('<3m-1D>', SVASubscriptionLines."Date From");
                                    IF Periods = 2 then
                                        SVASubscriptionLines."Date To" := CalcDate('<6m-1D>', SVASubscriptionLines."Date From");
                                    IF Periods = 1 then
                                        SVASubscriptionLines."Date To" := CalcDate('<1y-1D>', SVASubscriptionLines."Date From");
                                    if SVASubscriptionLines."Amount Year" <> 0 then
                                        SVASubscriptionLines.Insert();
                                end;
                                //Dan linje for regulering af forudbetalt leje
                                SVACosttype.Reset();
                                SVACosttype.SetRange(type, 11); //forudbetalt leje
                                SVACosttype.SetRange(VatGroup, Vatgrp);
                                if SVACosttype.FindFirst() then begin
                                    Clear(SVASubscriptionLines);
                                    SVASubscriptionLines.Tenancies := FirstSVARegulations.TenancyNo;
                                    SVASubscriptionLines.Type := SVACosttype.Type;
                                    SVASubscriptionLines.VatGroup := Vatgrp;
                                    SVASubscriptionLines.ProductPostingGroup := SVACosttype.ProductPostingGroup;
                                    SVASubscriptionLines.Order := SVACosttype.Order;
                                    SVASubscriptionLines.Description := 'Regulering af forudb. leje';
                                    SVASubscriptionLines."Date From" := FirstSVARegulations.Regulationdate;
                                    SVASubscriptionLines."Cost Types" := SVACosttype.Costtype;
                                    SVASubscriptionLines."Amount Year" := FirstSVARegulations.RegulationPrepaidrent * Periods;
                                    SVASubscriptionLines."Amount Period" := FirstSVARegulations.RegulationPrepaidrent;
                                    IF Periods = 12 then
                                        SVASubscriptionLines."Date To" := CalcDate('<1m-1D>', SVASubscriptionLines."Date From");
                                    IF Periods = 4 then
                                        SVASubscriptionLines."Date To" := CalcDate('<3m-1D>', SVASubscriptionLines."Date From");
                                    IF Periods = 2 then
                                        SVASubscriptionLines."Date To" := CalcDate('<6m-1D>', SVASubscriptionLines."Date From");
                                    IF Periods = 1 then
                                        SVASubscriptionLines."Date To" := CalcDate('<1y-1D>', SVASubscriptionLines."Date From");
                                    if SVASubscriptionLines."Amount Year" <> 0 then
                                        SVASubscriptionLines.Insert(true);
                                end;

                                //Dan ny linje til opkrævning af leje
                                Clear(SVASubscriptionLines);
                                SVASubscriptionLines.SetRange(Tenancies, FirstSVARegulations.TenancyNo);
                                SVASubscriptionLines.setrange(type, 1);
                                SVASubscriptionLines.SetRange("Date To", 0D);
                                if SVASubscriptionLines.FindFirst() then
                                    CosttypeVar := SVASubscriptionLines."Cost Types";

                                SVACosttype.Reset();
                                SVACosttype.SetRange(Costtype, CosttypeVar);
                                if SVACosttype.FindFirst() then begin
                                    Clear(SVASubscriptionLines);
                                    SVASubscriptionLines.Tenancies := FirstSVARegulations.TenancyNo;
                                    SVASubscriptionLines.Type := SVACosttype.Type;
                                    SVASubscriptionLines.VatGroup := Vatgrp;
                                    SVASubscriptionLines.ProductPostingGroup := SVACosttype.ProductPostingGroup;
                                    SVASubscriptionLines.Order := SVACosttype.Order;
                                    SVASubscriptionLines.Description := SVACosttype.Description;
                                    SVASubscriptionLines."Date From" := FirstSVARegulations.Regulationdate;
                                    SVASubscriptionLines."Cost Types" := SVACosttype.Costtype;
                                    SVASubscriptionLines."Amount Year" := FirstSVARegulations.RentYearNew;
                                    SVASubscriptionLines."Amount Period" := FirstSVARegulations.RentYearNew / Periods;
                                    SVASubscriptionLines.PriceIndeks := true;
                                    if SVASubscriptionLines."Amount Year" <> 0 then
                                        SVASubscriptionLines.Insert(true);

                                end;

                                //Luk gamle linje til opkrævning af leje
                                Clear(CloseSVASubscriptionLines);
                                Clear(SVASubscriptionLines);
                                CloseSVASubscriptionLines.SetRange(Tenancies, FirstSVARegulations.TenancyNo);
                                CloseSVASubscriptionLines.setrange(type, 1);
                                CloseSVASubscriptionLines.SetRange("Date To", 0D);
                                CloseSVASubscriptionLines.SetRange("Date From", 0D, CalcDate('<-1D>', FirstSVARegulations.Regulationdate));
                                if CloseSVASubscriptionLines.FindFirst() then begin
                                    //Opret kopi
                                    SVASubscriptionLines.Tenancies := CloseSVASubscriptionLines.Tenancies;
                                    SVASubscriptionLines.Type := CloseSVASubscriptionLines.Type;
                                    SVASubscriptionLines.VatGroup := CloseSVASubscriptionLines.VatGroup;
                                    SVASubscriptionLines.ProductPostingGroup := CloseSVASubscriptionLines.ProductPostingGroup;
                                    SVASubscriptionLines.PriceIndeks := false;
                                    SVASubscriptionLines.Order := CloseSVASubscriptionLines.order;
                                    SVASubscriptionLines.KeyNumber := CloseSVASubscriptionLines.KeyNumber;
                                    SVASubscriptionLines.Description := CloseSVASubscriptionLines.Description;
                                    SVASubscriptionLines."Date To" := CalcDate('<-1D>', FirstSVARegulations.Regulationdate);
                                    SVASubscriptionLines."Date From" := CloseSVASubscriptionLines."Date From";
                                    SVASubscriptionLines."Cost Types" := CloseSVASubscriptionLines."Cost Types";
                                    SVASubscriptionLines."Amount Year" := CloseSVASubscriptionLines."Amount Year";
                                    SVASubscriptionLines."Amount Period" := CloseSVASubscriptionLines."Amount Period";
                                    SVASubscriptionLines."Global Dimension 1 Code" := CloseSVASubscriptionLines."Global Dimension 1 Code";
                                    SVASubscriptionLines."Global Dimension 2 Code" := CloseSVASubscriptionLines."Global Dimension 2 Code";
                                    SVASubscriptionLines.Insert(true);
                                    //Slet linje
                                    CloseSVASubscriptionLines.Delete();
                                end;


                            end;
                            SVAregulations.Closed := true;
                            SVAregulations.Modify();

                            SVACOntractregulations.Reset();
                            SVACOntractregulations.SetRange(Number, SVAregulations.ONumber);
                            if SVACOntractregulations.FindFirst() then begin
                                SVACOntractregulations.Latest_regulation := Today;
                                SVACOntractregulations.PrepaidRentAmount := SVAregulations.PrepaidRentNew;
                                SVACOntractregulations.DepositAmount := SVAregulations.DepositNew;
                                SVACOntractregulations.RegDate := Calcdate('<1Y>', FirstSVARegulations.Regulationdate);
                                SVACOntractregulations.Indeks_Date := CalcDate('<1Y>', FirstSVARegulations.Indeksdate);
                                SVACOntractregulations.Modify();
                            end;

                        until SVAregulations.NEXT() = 0;

                    MESSAGE('Reguleringerne er overføret til beboeraftalerne.');
                end;
            }
        }
    }
    var
        FirstSVARegulations: Record "SVA Regulations";
        SVARegulations: Record "SVA Regulations";
        SVASubscriptionLines: Record "SVA Subscription Lines";
        CloseSVASubscriptionLines: Record "SVA Subscription Lines";
        SVACosttype: Record "SVA Cost type";
        SVATenancy: Record "SVA Tenancy";
        SVAContractregulations: Record "SVA Contract regulations";
        SVARegulationIndeks: Report "SVA Regulation Indeks";
        SVARegulationIndeksDeposit: Report "SVA Regulation Indeks Deposit";
        SVARegulationIndeksMin: Report "SVA Regulation Indeks Min";
        SVARegulationIndeksDepMin: Report "SVA Regulation Indeks Dep Min";
        SVARegulationIncrease: Report "SVA Regulation Increase";
        SVARegulIncreaseDeposit: Report "SVA Regul. Increase Deposit";
        Vatgrp: Text[10];
        Periods: Integer;
        CosttypeVar: Text[10];




}

