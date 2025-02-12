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
                field(Number; Rec.Onumber)
                {
                    ApplicationArea = All;
                    ToolTip = 'Occupant';
                }
                field(TenancyNo; Rec.TenancyNo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Tenancy number';
                }
                field(Name1; Rec.OName1)
                {
                    ApplicationArea = All;
                    ToolTip = 'Name';
                }
                field(Costtype; Rec.Costtype)
                {
                    ApplicationArea = All;
                    ToolTip = 'Costtype';
                }
                field(Indeks_Old; Rec.Indeks_Old)
                {
                    ApplicationArea = All;
                    ToolTip = 'Indeks old';
                }
                field(Indeks_New; Rec.Indeks_New)
                {
                    ApplicationArea = All;
                    ToolTip = 'Indeks new';
                }
                field(ActualRegulation; Rec.ActualRegulation)
                {
                    ApplicationArea = All;
                    ToolTip = 'Regulering';
                }
                field(RentPerNow; Rec.RentPerNow)
                {
                    ApplicationArea = All;
                    Tooltip = 'Current rent';
                }
                field(RentPerNew; Rec.RentPerNew)
                {
                    ApplicationArea = All;
                    ToolTip = 'New rent';
                }
                field(RegulationDeposit; Rec.RegulationDeposit)
                {
                    ApplicationArea = All;
                    ToolTip = 'Regulation deposit';
                }
                field(RegulationPrepaidrent; Rec.RegulationPrepaidrent)
                {
                    ApplicationArea = All;
                    ToolTip = 'Regulation prepaid rent';
                }
                field(Regulationdate; Rec.Regulationdate)
                {
                    ApplicationArea = All;
                    ToolTip = 'Regulation date';
                }

                field(Closed; Rec.Closed)
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
                ToolTip = 'Make regulation letters for occupants';
                Image = Report;
                ApplicationArea = All;
                RunObject = codeunit "SVA Regulation Letters";
            }

            action(Updates)
            {
                Caption = 'Updates';
                ToolTip = 'Create subscriptionlines for each regulation on each occupant.';
                Image = Report;
                ApplicationArea = All;

                trigger OnAction();
                var
                    l_SVAOccupantTrans: Record "SVA Occupant Trans";
                    l_SVACosttype: Record "SVA Cost type";
                    VATgrpDeposita: Text[10];
                    VATGrpPrepaidRent: Text[10];
                    ProdGrpDeposita: Text[10];
                    ProdGrpPrepaidRent: Text[10];

                begin
                    SVAregulations.Reset();
                    SVAregulations.SetRange(SVAregulations.Closed, false);
                    if SVAregulations.FindSet() then
                        repeat
                            //Find VATcodes
                            l_SVAOccupantTrans.Reset();
                            l_SVAOccupantTrans.SetRange(Occupant, SVARegulations.ONumber);
                            l_SVAOccupantTrans.SetRange(Type, 10);
                            if l_SVAOccupantTrans.FindFirst() then begin
                                l_SVACosttype.Get(l_SVAOccupantTrans."Cost type Estate");
                                VATgrpDeposita := l_SVACosttype.VatGroup;
                                ProdGrpDeposita := l_SVACosttype.ProductPostingGroup;
                            end;
                            l_SVAOccupantTrans.Reset();
                            l_SVAOccupantTrans.SetRange(Occupant, SVARegulations.ONumber);
                            l_SVAOccupantTrans.SetRange(Type, 11);
                            if l_SVAOccupantTrans.FindFirst() then begin
                                l_SVACosttype.Get(l_SVAOccupantTrans."Cost type Estate");
                                VATGrpPrepaidRent := l_SVACosttype.VatGroup;
                                ProdGrpPrepaidRent := l_SVACosttype.ProductPostingGroup;
                            end;

                            FirstSVARegulations.Reset();
                            FirstSVARegulations.SetRange(FirstSVARegulations.ONumber, SVAregulations.ONumber);
                            if FirstSVARegulations.FindFirst() then begin

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
                                SVACosttype.SetRange(VatGroup, VATgrpDeposita);
                                if SVACosttype.FindFirst() then begin
                                    Clear(SVASubscriptionLines);
                                    SVASubscriptionLines.Tenancies := FirstSVARegulations.TenancyNo;
                                    SVASubscriptionLines.Type := SVACosttype.Type;
                                    SVASubscriptionLines.VatGroup := VATgrpDeposita;
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
                                    if SVASubscriptionLines."Amount Year" <> 0 then begin
                                        SVASubscriptionLines."Amount Year" := Round(SVASubscriptionLines."Amount Year", 0.01, '=');
                                        SVASubscriptionLines."Amount Year" := Round(SVASubscriptionLines."Amount Period", 0.01, '=');
                                        SVASubscriptionLines.Insert();
                                    end;
                                end;
                                //Dan linje for regulering af forudbetalt leje
                                SVACosttype.Reset();
                                SVACosttype.SetRange(type, 11); //forudbetalt leje
                                SVACosttype.SetRange(VatGroup, VATGrpPrepaidRent);
                                if SVACosttype.FindFirst() then begin
                                    Clear(SVASubscriptionLines);
                                    SVASubscriptionLines.Tenancies := FirstSVARegulations.TenancyNo;
                                    SVASubscriptionLines.Type := SVACosttype.Type;
                                    SVASubscriptionLines.VatGroup := VATGrpPrepaidRent;
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
                                    if SVASubscriptionLines."Amount Year" <> 0 then begin
                                        SVASubscriptionLines."Amount Year" := Round(SVASubscriptionLines."Amount Year", 0.01, '=');
                                        SVASubscriptionLines."Amount Year" := Round(SVASubscriptionLines."Amount Period", 0.01, '=');
                                        SVASubscriptionLines.Insert(true);
                                    end;
                                end;

                                //Dan ny linje til opkrævning af leje
                                Clear(SVASubscriptionLines);
                                SVASubscriptionLines.SetRange(Tenancies, FirstSVARegulations.TenancyNo);
                                SVASubscriptionLines.setrange(type, 1);
                                SVASubscriptionLines.SetRange("Date To", 0D);
                                SVASubscriptionLines.SetRange(PriceIndeks, true);
                                if SVASubscriptionLines.FindFirst() then
                                    CosttypeVar := SVASubscriptionLines."Cost Types";

                                SVACosttype.Reset();
                                SVACosttype.SetRange(Costtype, CosttypeVar);
                                if SVACosttype.FindFirst() then begin
                                    Clear(SVASubscriptionLines);
                                    SVASubscriptionLines.Tenancies := FirstSVARegulations.TenancyNo;
                                    SVASubscriptionLines.Type := SVACosttype.Type;
                                    SVASubscriptionLines.VatGroup := SVACosttype.VatGroup;
                                    SVASubscriptionLines.ProductPostingGroup := SVACosttype.ProductPostingGroup;
                                    SVASubscriptionLines.Order := SVACosttype.Order;
                                    SVASubscriptionLines.Description := SVACosttype.Description;
                                    SVASubscriptionLines."Date From" := FirstSVARegulations.Regulationdate;
                                    SVASubscriptionLines."Cost Types" := SVACosttype.Costtype;
                                    SVASubscriptionLines."Amount Year" := FirstSVARegulations.RentYearNew;
                                    SVASubscriptionLines."Amount Period" := FirstSVARegulations.RentYearNew / Periods;
                                    SVASubscriptionLines.PriceIndeks := true;
                                    if SVASubscriptionLines."Amount Year" <> 0 then begin
                                        SVASubscriptionLines."Amount Year" := Round(SVASubscriptionLines."Amount Year", 0.01, '=');
                                        SVASubscriptionLines."Amount Year" := Round(SVASubscriptionLines."Amount Period", 0.01, '=');
                                        SVASubscriptionLines.Insert(true);
                                    end;

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
                                if SVACOntractregulations.Indeks_Date <> 0D then
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
        Periods: Integer;
        CosttypeVar: Text[10];

}

