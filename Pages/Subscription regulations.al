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
                field(EndDate; Rec.EndDate)
                {
                    ApplicationArea = All;
                    ToolTip = 'Slutdato';
                }
            }
            group(Repayment)
            {
                Caption = 'Repayments';
                field(RepaymentPeriod; Rec.RepaymentPeriod)
                {
                    ApplicationArea = all;
                    ToolTip = 'Agreed amount for each period';
                }
                field(StartRepayment; Rec.StartRepayment)
                {
                    ApplicationArea = all;
                    ToolTip = 'First date of repayments';
                }
                field(EndRepayment; Rec.EndRepayment)
                {
                    ApplicationArea = all;
                    ToolTip = 'Last date of repayments';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                    ToolTip = 'Description of repayment or payment';
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
        CurrPage.UPDATE();
    end;

    trigger OnAfterGetRecord()
    begin
        Rec.Validate(Number);
    end;

}

