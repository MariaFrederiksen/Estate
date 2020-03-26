report 50022 "SVA Occupants regulations"
{
    Caption = 'List of Occupants regulations';
    DefaultLayout = Word;
    WordLayout = './Layouts/SVA List regulations.docx';
    UsageCategory = ReportsAndAnalysis;


    dataset
    {
        dataitem("SVA Occupant"; "SVA Occupant")
        {
            DataItemTableView = SORTING(PropertyNo, TenancyNo)
                                    ORDER(Ascending);
            column(CompanyName; COMPANYPROPERTY.DISPLAYNAME)
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
                    if "SVA Contract regulations".Latest_regulation <> 0D then begin
                        PriceIndeksRecord.Reset;
                        PriceIndeksRecord.setrange(IndeksNo, 'Netto');
                        PriceIndeksRecord.SetRange(IndeksDate, CalcDate('<-1Y>', "SVA Contract regulations".Indeks_Date));
                        if PriceIndeksRecord.FindFirst then
                            IndeksNew := PriceIndeksRecord.Indeksrate;
                        PriceIndeksRecord.Reset;
                        PriceIndeksRecord.setrange(IndeksNo, 'Netto');
                        PriceIndeksRecord.SetRange(IndeksDate, CalcDate('<-2Y>', "SVA Contract regulations".Indeks_Date));
                        if PriceIndeksRecord.FindFirst then
                            IndeksOld := PriceIndeksRecord.Indeksrate;
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
                    CurrReport.SKIP
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
        IndeksdateOld: Date;
        IndeksOld: Decimal;
        IndeksNew: Decimal;
        Indeks1: Text[5];
        Indeks2: Text[5];
        PriceIndeksRecord: Record "SVA PriceIndeks";

}