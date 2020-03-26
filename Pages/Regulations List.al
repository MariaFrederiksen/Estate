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
                    Regulations.reset;
                    if Regulations.FindSet() then
                        repeat
                            Message(Regulations.ONumber);
                            RegLetter.reset;
                            RegLetter.SetRange(RegLetter.ONumber, Regulations.ONumber);
                            if RegLetter.FindFirst then begin
                                //No max/min increase
                                //Indeks regulations and solid increase
                                if (RegLetter.Increase = 0) and (RegLetter.MaxRegulation = 0) and (RegLetter.MinRegulation = 0) then begin
                                    //Letters for indeksregulations
                                    //Only deposit
                                    if (RegLetter.RegulationPrepaidrent = 0) then begin
                                        Clear(IndeksLetterDep);
                                        IndeksLetterDep.SetTableView(RegLetter);
                                        IndeksLetterDep.Run;
                                    end;
                                    if (RegLetter.RegulationPrepaidrent <> 0) then begin
                                        Clear(IndeksLetter);
                                        IndeksLetter.SetTableView(RegLetter);
                                        IndeksLetter.Run;
                                    end;
                                end;
                                if (RegLetter.Increase <> 0) and (RegLetter.MaxRegulation = 0) and (RegLetter.MinRegulation = 0) then begin
                                    //Letters for solid Increase
                                    //Only deposit
                                    if (RegulationPrepaidrent = 0) then begin
                                        Clear(IncreaseDepLetter);
                                        IncreaseDepLetter.SetTableView(RegLetter);
                                        IncreaseDepLetter.Run;
                                    end;
                                    if (RegulationPrepaidrent <> 0) then begin
                                        Clear(IncreaseLetter);
                                        IncreaseLetter.SetTableView(RegLetter);
                                        IncreaseLetter.Run;
                                    end;
                                end;
                                if (RegLetter.MaxRegulation <> 0) OR (RegLetter.Minregulation <> 0) then begin
                                    //Letters for indeksregulations with max/min
                                    //Only deposit
                                    if (RegulationPrepaidrent = 0) then begin
                                        Clear(IndeksLetterDepMax);
                                        IndeksLetterDepMax.SetTableView(RegLetter);
                                        IndeksLetterDepMax.Run;
                                    end;
                                    if (RegulationPrepaidrent <> 0) then begin
                                        Clear(IndeksLetterMax);
                                        IndeksLetterMax.SetTableView(RegLetter);
                                        IndeksLetterMax.Run;
                                    end;
                                end;
                            end;
                        until Regulations.Next = 0;
                end;
            }


            action(Updates)
            {
                Caption = 'Updates';
                Image = Report;
                ApplicationArea = All;

                trigger OnAction();
                begin
                    Regulations.Reset;
                    Regulations.SetRange(Regulations.Closed, false);
                    if Regulations.FindSet then begin
                        repeat
                            RegLetter.reset;
                            RegLetter.SetRange(RegLetter.ONumber, Regulations.ONumber);
                            if RegLetter.FindFirst then begin
                                //Find ud af om der er moms på aftalen
                                Sublines.Reset;
                                Sublines.SetRange(type, 1);
                                if Sublines.FindFirst then begin
                                    Vatgrp := Sublines.VatGroup;
                                end;
                                //Find periode på aftalen
                                TenancyRec.Reset;
                                TenancyRec.SetRange(Number, Regletter.TenancyNo);
                                if TenancyRec.FindFirst then begin
                                    if TenancyRec.PeriodYear = 0 then
                                        Periods := 12;
                                    if TenancyRec.PeriodYear = 1 then
                                        Periods := 4;
                                    if TenancyRec.PeriodYear = 2 then
                                        Periods := 2;
                                    if TenancyRec.PeriodYear = 3 then
                                        Periods := 1;
                                end;

                                //Dan linje for regulering af deposita
                                CosttypeRec.Reset;
                                CosttypeRec.SetRange(type, 10); //deposita
                                CosttypeRec.SetRange(VatGroup, Vatgrp);
                                if CosttypeRec.FindFirst() then begin
                                    Clear(Sublines);
                                    Sublines.Tenancies := RegLetter.TenancyNo;
                                    Sublines.Type := CosttypeRec.Type;
                                    Sublines.VatGroup := Vatgrp;
                                    Sublines.ProductPostingGroup := CosttypeRec.ProductPostingGroup;
                                    Sublines.Order := CosttypeRec.Order;
                                    Sublines.Description := 'Regulering af depositum';
                                    Sublines."Date From" := RegLetter.Regulationdate;
                                    Sublines."Cost Types" := CosttypeRec.Costtype;
                                    Sublines."Amount Year" := RegLetter.RegulationDeposit * Periods;
                                    Sublines."Amount Period" := RegLetter.RegulationDeposit;
                                    IF Periods = 12 then
                                        Sublines."Date To" := CalcDate('<1m-1D>', Sublines."Date From");
                                    IF Periods = 4 then
                                        Sublines."Date To" := CalcDate('<3m-1D>', Sublines."Date From");
                                    IF Periods = 2 then
                                        Sublines."Date To" := CalcDate('<6m-1D>', Sublines."Date From");
                                    IF Periods = 1 then
                                        Sublines."Date To" := CalcDate('<1y-1D>', Sublines."Date From");
                                    if Sublines."Amount Year" <> 0 then
                                        Sublines.Insert;
                                end;
                                //Dan linje for regulering af forudbetalt leje
                                CosttypeRec.Reset;
                                CosttypeRec.SetRange(type, 11); //forudbetalt leje
                                CosttypeRec.SetRange(VatGroup, Vatgrp);
                                if CosttypeRec.FindFirst() then begin
                                    Clear(Sublines);
                                    Sublines.Tenancies := RegLetter.TenancyNo;
                                    Sublines.Type := CosttypeRec.Type;
                                    Sublines.VatGroup := Vatgrp;
                                    Sublines.ProductPostingGroup := CosttypeRec.ProductPostingGroup;
                                    Sublines.Order := CosttypeRec.Order;
                                    Sublines.Description := 'Regulering af forudb. leje';
                                    Sublines."Date From" := RegLetter.Regulationdate;
                                    Sublines."Cost Types" := CosttypeRec.Costtype;
                                    Sublines."Amount Year" := RegLetter.RegulationPrepaidrent * Periods;
                                    Sublines."Amount Period" := RegLetter.RegulationPrepaidrent;
                                    IF Periods = 12 then
                                        Sublines."Date To" := CalcDate('<1m-1D>', Sublines."Date From");
                                    IF Periods = 4 then
                                        Sublines."Date To" := CalcDate('<3m-1D>', Sublines."Date From");
                                    IF Periods = 2 then
                                        Sublines."Date To" := CalcDate('<6m-1D>', Sublines."Date From");
                                    IF Periods = 1 then
                                        Sublines."Date To" := CalcDate('<1y-1D>', Sublines."Date From");
                                    if Sublines."Amount Year" <> 0 then
                                        Sublines.Insert(true);
                                end;

                                //Dan ny linje til opkrævning af leje
                                Clear(Sublines);
                                Sublines.SetRange(Tenancies, RegLetter.TenancyNo);
                                Sublines.setrange(type, 1);
                                Sublines.SetRange("Date To", 0D);
                                if Sublines.FindFirst() then begin
                                    CosttypeVar := Sublines."Cost Types";
                                end;
                                CosttypeRec.Reset;
                                CosttypeRec.SetRange(Costtype, CosttypeVar);
                                if CosttypeRec.FindFirst() then begin
                                    Clear(Sublines);
                                    Sublines.Tenancies := RegLetter.TenancyNo;
                                    Sublines.Type := CosttypeRec.Type;
                                    Sublines.VatGroup := Vatgrp;
                                    Sublines.ProductPostingGroup := CosttypeRec.ProductPostingGroup;
                                    Sublines.Order := CosttypeRec.Order;
                                    Sublines.Description := CosttypeRec.Description;
                                    Sublines."Date From" := RegLetter.Regulationdate;
                                    Sublines."Cost Types" := CosttypeRec.Costtype;
                                    Sublines."Amount Year" := RegLetter.RentYearNew;
                                    Sublines."Amount Period" := RegLetter.RentYearNew / Periods;
                                    Sublines.PriceIndeks := true;
                                    if Sublines."Amount Year" <> 0 then begin
                                        Sublines.Insert(true);
                                    end;
                                end;

                                //Luk gamle linje til opkrævning af leje
                                Clear(SublineClose);
                                Clear(Sublines);
                                SublineClose.SetRange(Tenancies, RegLetter.TenancyNo);
                                SublineClose.setrange(type, 1);
                                SublineClose.SetRange("Date To", 0D);
                                SublineClose.SetRange("Date From", 0D, CalcDate('-1D>', Regletter.Regulationdate));
                                if SublineClose.Findfirst then begin
                                    //Opret kopi
                                    Sublines.Tenancies := SublineClose.Tenancies;
                                    Sublines.Type := SublineClose.Type;
                                    Sublines.VatGroup := SublineClose.VatGroup;
                                    Sublines.ProductPostingGroup := SublineClose.ProductPostingGroup;
                                    Sublines.PriceIndeks := false;
                                    Sublines.Order := SublineClose.order;
                                    Sublines.KeyNumber := SublineClose.KeyNumber;
                                    Sublines.Description := SublineClose.Description;
                                    Sublines."Date To" := CalcDate('<-1D>', Regletter.Regulationdate);
                                    Sublines."Date From" := SublineClose."Date From";
                                    Sublines."Cost Types" := SublineClose."Cost Types";
                                    Sublines."Amount Year" := SublineClose."Amount Year";
                                    Sublines."Amount Period" := SublineClose."Amount Period";
                                    Sublines."Global Dimension 1 Code" := SublineClose."Global Dimension 1 Code";
                                    Sublines."Global Dimension 2 Code" := SublineClose."Global Dimension 2 Code";
                                    Sublines.Insert(true);
                                    //Slet linje
                                    SublineClose.Delete();
                                end;


                            end;
                            Regulations.Closed := true;
                            Regulations.Modify;

                            ContractRegulations.reset;
                            ContractRegulations.SetRange(Number, Regulations.ONumber);
                            if ContractRegulations.FindFirst then begin
                                ContractRegulations.Latest_regulation := Today;
                                ContractRegulations.PrepaidRentAmount := Regulations.PrepaidRentNew;
                                ContractRegulations.DepositAmount := Regulations.DepositNew;
                                ContractRegulations.RegDate := Calcdate('<1Y>', RegLetter.Regulationdate);
                                ContractRegulations.Indeks_Date := CalcDate('<1Y>', RegLetter.Indeksdate);
                                ContractRegulations.Modify();
                            end;

                        until Regulations.Next = 0;
                    end;
                    MESSAGE('Reguleringerne er overføret til beboeraftalerne.');
                end;
            }
        }
    }
    var
        RegLetter: Record "SVA Regulations";
        IndeksLetter: Report "SVA Regulation Indeks";
        IndeksLetterDep: Report "SVA Regulation Indeks Deposit";
        IndeksLetterMax: Report "SVA Regulation Indeks Min";
        IndeksLetterDepMax: Report "SVA Regulation Indeks Dep Min";
        IncreaseLetter: Report "SVA Regulation Increase";
        IncreaseDepLetter: Report "SVA Regul. Increase Deposit";
        //Used in update
        Regulations: Record "SVA regulations";
        Sublines: Record "SVA Subscription Lines";
        SublineClose: Record "SVA Subscription Lines";
        CosttypeRec: Record "SVA Cost type";
        Vatgrp: Text[10];
        TenancyRec: Record "SVA Tenancy";
        Periods: Integer;
        CosttypeVar: Text[10];
        ContractRegulations: Record "SVA Contract regulations";



}

