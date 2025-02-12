report 50037 "SVA Ledger report"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    DefaultLayout = Word;

    dataset
    {
        dataitem("G/L Entry"; "G/L Entry")
        {
            column(Posting_Date; "Posting Date")
            {

            }
            column(G_L_Account_No_; "G/L Account No.")
            {

            }
            column(Description; Description)
            {

            }
            column(Debit_Amount; "Debit Amount")
            {

            }
            column(Credit_Amount; "Credit Amount")
            {

            }
            column(TotalAmount; TotalAmount)
            {

            }
            trigger OnAfterGetRecord()
            begin
                TotalAmount += Amount;
            end;

        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field(Postingdate; "G/L Entry"."Posting date")
                    {
                        ApplicationArea = All;
                        Tooltip = 'Postingdate';
                    }
                }
            }
        }


    }

    var
        TotalAmount: Decimal;
}