report 50022 "SVA Occupants regulations"
{
    Caption = 'List of Occupants regulations';
    DefaultLayout = rdlc;
    RDLCLayout = './Layouts/RegulationList.rdlc';
    UsageCategory = ReportsAndAnalysis;


    dataset
    {
        dataitem("SVA Occupant"; "SVA Occupant")
        {
            DataItemTableView = SORTING(PropertyNo, TenancyNo)
                                    ORDER(Ascending);

            column(Headline; Headline)
            {

            }
            column(CompanyName; COMPANYPROPERTY.DISPLAYNAME())
            {
            }

            column(PropertyNo; PropertyNo)
            {

            }

            column(TenancyNo; TenancyNo)
            {
            }
            column(Occupant; Number)
            {

            }
            column(Name1; Name1)
            {

            }


            dataitem("SVA Contract regulations"; "SVA Contract regulations")
            {
                DataItemLink = Number = field(Number);

                column(RegDate; format(RegDate))
                {

                }
                column(Indeks_Date; format(Indeks_Date))
                {

                }
                column(MaxRegulations; MaxRegulations)
                {

                }
                column(MinRegulation; MinRegulation)
                {

                }
                column(Increase; Increase)
                {

                }
                column(Latest_regulation; format(Latest_regulation))
                {

                }
                column(IndeksOld; Indeks1)
                {

                }
                column(IndeksNew; Indeks2)
                {

                }
                trigger OnAfterGetRecord();

                begin
                    IndeksNew := 0;
                    IndeksOld := 0;
                    if "SVA Contract regulations".Indeks_Date <> 0D then begin
                        SVAPriceIndeks.Reset();
                        SVAPriceIndeks.setrange(IndeksNo, 'Netto');
                        SVAPriceIndeks.SetRange(IndeksDate, CalcDate('<-1Y>', "SVA Contract regulations".Indeks_Date));
                        if SVAPriceIndeks.FindFirst() then
                            IndeksNew := SVAPriceIndeks.Indeksrate;
                        SVAPriceIndeks.Reset();
                        SVAPriceIndeks.setrange(IndeksNo, 'Netto');
                        SVAPriceIndeks.SetRange(IndeksDate, CalcDate('<-2Y>', "SVA Contract regulations".Indeks_Date));
                        if SVAPriceIndeks.FindFirst() then
                            IndeksOld := SVAPriceIndeks.Indeksrate;
                    end;
                    if IndeksNew = 0 then
                        Indeks2 := '';
                    if IndeksOld = 0 then
                        Indeks1 := '';
                    if IndeksNew <> 0 then
                        Indeks2 := Format(IndeksNew);
                    if IndeksOld <> 0 then
                        Indeks1 := Format(IndeksOld);
                    ;
                end;
            }

            trigger OnAfterGetRecord();
            begin
                IF (EndDate < Today) AND (Enddate <> 0D) THEN
                    CurrReport.Skip();
                Headline := HeadlineLbl;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }
    var
        SVAPriceIndeks: Record "SVA PriceIndeks";
        Headline: Text[30];
        IndeksOld: Decimal;
        IndeksNew: Decimal;
        Indeks1: Text[5];
        Indeks2: Text[5];
        HeadlineLbl: Label 'Planned regulations';

}