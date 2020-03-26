page 50022 "SVA Subscription regulations"
{
    Caption = 'Subscription regulations';
    PageType = Card;
    SourceTable = "SVA Contract regulations";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(Number; Number)
                {
                    ApplicationArea = All;
                    ToolTip = 'Nummer på beboeraftalen';
                }
                field(MonthDeposit; MonthDeposit)
                {
                    ApplicationArea = All;
                    ToolTip = 'Måneders depositum.';
                }
                field(DepositAmount; DepositAmount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Depotitum i kr.';
                }
                field(MonthPrepaidRent; MonthPrepaidRent)
                {
                    ApplicationArea = All;
                    ToolTip = 'Måneders forudbetalt leje';
                }
                field(PrepaidRentAMount; PrepaidRentAMount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Forudbetalt leje i kr.';
                }
                field(MinRegulation; MinRegulation)
                {
                    ApplicationArea = All;
                    ToolTip = 'Mindste regulering i %';
                }
                field(MaxRegulations; MaxRegulations)
                {
                    ApplicationArea = All;
                    ToolTip = 'Max. regulering i %';
                }
                field(Increase; Increase)
                {
                    ApplicationArea = All;
                    ToolTip = 'Fast reguleringsprocent';
                }
                field(RegDate; RegDate)
                {
                    ApplicationArea = All;
                    ToolTip = 'Reguleringsdato';
                }
                field(Indeks_Date; Indeks_Date)
                {
                    ApplicationArea = All;
                    ToolTip = 'Hvis der skal indeksreguleres, skal indeks pr. denne dato benyttes.';
                }
                field(Latest_regulation; Latest_regulation)
                {
                    ApplicationArea = All;
                    ToolTip = 'Seneste regulering';
                }
                field(EndDate; EndDate)
                {
                    ApplicationArea = All;
                    ToolTip = 'Slutdato';
                }
            }
            group(Repayment)
            {
                Caption = 'Repayments';
                field(RepaymentPeriod; RepaymentPeriod)
                {
                    ApplicationArea = all;
                    ToolTip = 'Agreed amount for each period';
                }
                field(StartRepayment; StartRepayment)
                {
                    ApplicationArea = all;
                    ToolTip = 'First date of repayments';
                }
                field(EndRepayment; EndRepayment)
                {
                    ApplicationArea = all;
                    ToolTip = 'Last date of repayments';
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
    }

    trigger OnAfterGetCurrRecord();
    begin
        CurrPage.UPDATE;
    end;
}

