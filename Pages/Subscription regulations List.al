page 50021 "SVA Subscription reg List"
{
    Caption='Subscription regulations';
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
                field(Number;Number)
                {                    
                    ApplicationArea = All;
                    ToolTip = 'Nummer på beboeraftalen';
                }
                field(MonthDeposit;MonthDeposit)
                {                    
                    ApplicationArea = All;
                    ToolTip = 'Måneders depositum.';
                }
                field(DepositAmount;DepositAmount)
                {                    
                    ApplicationArea = All;
                    ToolTip = 'Depotitum i kr.';
                }
                field(MonthPrepaidRent;MonthPrepaidRent)
                {                    
                    ApplicationArea = All;
                    ToolTip = 'Måneders forudbetalt leje';
                }
                field(PrepaidRentAMount;PrepaidRentAMount)
                {                    
                    ApplicationArea = All;
                    ToolTip = 'Forudbetalt leje i kr.';
                }
                field(MinRegulation;MinRegulation)
                {                    
                    ApplicationArea = All;
                    ToolTip = 'Mindste regulering i %';
                }
                field(MaxRegulations;MaxRegulations)
                {                    
                    ApplicationArea = All;
                    ToolTip = 'Max. regulering i %';
                }
                field(Increase;Increase)
                {                    
                    ApplicationArea = All;
                    ToolTip = 'Fast reguleringsprocent';
                }
                field(RegDate;RegDate)
                {                    
                    ApplicationArea = All;
                    ToolTip = 'Reguleringsdato';
                }
                field(Indeks_Date;Indeks_Date)
                {                    
                    ApplicationArea = All;
                    ToolTip = 'Hvis der skal indeksreguleres, skal indeks pr. denne dato benyttes.';
                }
                field(Latest_regulation;Latest_regulation)
                {                    
                    ApplicationArea = All;
                    ToolTip = 'Seneste regulering';
                }
            }
        }
    }

    actions
    {
    }
   
}

