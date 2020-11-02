table 50012 "SVA Contract regulations"
{
    // Tabellen indeholder de nødvendige felter for aftalt regulering af leje samt evt. afdragsordning

    Caption = 'SVALeaseContractA9 regulations';
    DataClassification = CustomerContent;
    DrillDownPageID = "SVA Subscription reg List";
    LookupPageID = "SVA Subscription reg List";

    fields
    {
        field(1; Number; Code[10])
        {
            Caption = 'Number';
            TableRelation = "SVA Occupant".Number;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                IF RegDate = 0D THEN BEGIN  //Empty record
                    SVALeaseContractA9.Reset();
                    SVALeaseContractA9.SetRange(Number, Number);
                    IF SVALeaseContractA9.FindFirst() then begin
                        MonthDeposit := SVALeaseContractA9.TypeA9_4_DepMth;
                        DepositAmount := SVALeaseContractA9.TypeA9_4_DepAmount;
                        MonthPrepaidRent := SVALeaseContractA9.TypeA9_4_PrepaidRentMth;
                        PrepaidRentAMount := SVALeaseContractA9.TypeA9_4_PrepaidRent;
                    end;
                end;
                Insert();
            end;
        }
        field(2; MonthDeposit; Integer)
        {
            Caption = 'Month deposit';

        }
        field(3; DepositAmount; Decimal)
        {
            Caption = 'Deposit amount';
        }
        field(4; MonthPrepaidRent; Integer)
        {
            Caption = 'Month prepaid rent';
        }
        field(5; PrepaidRentAMount; Decimal)
        {
            Caption = 'Prepaid rent amount';
        }
        field(10; MinRegulation; Decimal)
        {
            Caption = 'Min. regulation';

        }
        field(11; MaxRegulations; Decimal)
        {
            Caption = 'Max. regulation';
        }
        field(12; Increase; Decimal)
        {
            Caption = 'Agreed increase (%)';
        }
        field(20; RegDate; Date)
        {
            Caption = 'Regulation date';
        }
        field(30; Indeks_Date; date)
        {
            Caption = 'Indeks date';
        }
        Field(31; Latest_regulation; Date)
        {
            Caption = 'Latest regulation';
        }
        field(32; EndDate; Date)
        {
            Caption = 'End date';
        }
        field(40; RepaymentPeriod; Decimal)
        {
            Caption = 'Repayment amount per period';
        }
        field(41; StartRepayment; Date)
        {
            Caption = 'First repayment';
        }
        field(42; EndRepayment; Date)
        {
            Caption = 'Last repayment';
        }

    }
    var
        SVALeaseContractA9: Record "SVA LeaseContract_A9";
}
