page 50032 "SVA Reg Contract Overview"
{
    Caption = 'Overview of lines for regulation.';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "SVA Contract regulations";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Number; Rec.Number)
                {
                    ApplicationArea = All;
                    ToolTip = 'Number of the occupants aggrement';
                    Editable = false;
                }
                field(MonthDeposit; Rec.MonthDeposit)
                {
                    ApplicationArea = All;
                    ToolTip = 'Months deposit.';
                    Editable = false;
                }
                field(DepositAmount; Rec.DepositAmount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Deposit amount';
                    Editable = false;

                }
                field(MonthPrepaidRent; Rec.MonthPrepaidRent)
                {
                    ApplicationArea = All;
                    ToolTip = 'Months prepaid rent';
                    Editable = false;
                }
                field(PrepaidRentAMount; Rec.PrepaidRentAMount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Prepaid rent amount';
                    Editable = false;
                }
                field(MinRegulation; Rec.MinRegulation)
                {
                    ApplicationArea = All;
                    ToolTip = 'Minimum regulation in percentage';
                }
                field(MaxRegulations; Rec.MaxRegulations)
                {
                    ApplicationArea = All;
                    ToolTip = 'Maximum regulation in percentage';
                }
                field(Increase; Rec.Increase)
                {
                    ApplicationArea = All;
                    ToolTip = 'Fixed regulation percentage';
                }
                field(RegDate; Rec.RegDate)
                {
                    ApplicationArea = All;
                    ToolTip = 'Regulation date';
                }
                field(Indeks_Date; Rec.Indeks_Date)
                {
                    ApplicationArea = All;
                    ToolTip = 'If the index is to be regulated, the index per this date is used.';
                }
            }
        }
        area(Factboxes)
        {

        }
    }


}