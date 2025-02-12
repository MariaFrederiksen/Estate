page 50021 "SVA Subscription reg List"
{
    Caption = 'Subscription regulations';
    CardPageID = "SVA Subscription regulations";
    PageType = List;
    SourceTable = "SVA Contract regulations";
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(group)
            {
                field(Number; Rec.Number)
                {
                    ApplicationArea = All;
                    ToolTip = 'Nummer på beboeraftalen';
                }
                field(MonthDeposit; Rec.MonthDeposit)
                {
                    ApplicationArea = All;
                    ToolTip = 'Måneders depositum.';
                }
                field(DepositAmount; Rec.DepositAmount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Depositum i kr.';
                }
                field(MonthPrepaidRent; Rec.MonthPrepaidRent)
                {
                    ApplicationArea = All;
                    ToolTip = 'Måneders forudbetalt leje';
                }
                field(PrepaidRentAMount; Rec.PrepaidRentAMount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Forudbetalt leje i kr.';
                }
                field(MinRegulation; Rec.MinRegulation)
                {
                    ApplicationArea = All;
                    ToolTip = 'Mindste regulering i %';
                }
                field(MaxRegulations; Rec.MaxRegulations)
                {
                    ApplicationArea = All;
                    ToolTip = 'Max. regulering i %';
                }
                field(Increase; Rec.Increase)
                {
                    ApplicationArea = All;
                    ToolTip = 'Fast reguleringsprocent';
                }
                field(RegDate; Rec.RegDate)
                {
                    ApplicationArea = All;
                    ToolTip = 'Reguleringsdato';
                }
                field(Indeks_Date; Rec.Indeks_Date)
                {
                    ApplicationArea = All;
                    ToolTip = 'Hvis der skal indeksreguleres, skal indeks pr. denne dato benyttes.';
                }
                field(Latest_regulation; Rec.Latest_regulation)
                {
                    ApplicationArea = All;
                    ToolTip = 'Seneste regulering';
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
    trigger OnAfterGetRecord()
    begin
        Rec.Validate(Number);
    end;

}

