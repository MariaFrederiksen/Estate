table 50012 "SVA Contract regulations"
{
    // Tabellen indeholder de nødvendige felter for aftalt regulering af leje samt evt. afdragsordning

    Caption = 'LeaseContractA9 regulations';
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
            var
                SVALeaseContractA9: record "SVA LeaseContract_A9";
                SVAOccupant: Record "SVA Occupant";
            begin
                if Startdate = 0D then begin  //empty record
                    SVALeaseContractA9.Reset();
                    SVALeaseContractA9.SetRange(Number, Number);
                    if SVALeaseContractA9.FindFirst() then begin
                        MonthDeposit := SVALeaseContractA9.TypeA9_4_DepMth;
                        DepositAmount := SVALeaseContractA9.TypeA9_4_DepAmount;
                        MonthPrepaidRent := SVALeaseContractA9.TypeA9_4_PrepaidRentMth;
                        PrepaidRentAMount := SVALeaseContractA9.TypeA9_4_PrepaidRent;
                    end;
                    SVAOccupant.Reset();
                    SVAOccupant.Setrange(number, Number);
                    if SVAOccupant.FindFirst() then
                        Startdate := SVAOccupant.StartDate;
                end;
            end;
        }
        field(2; MonthDeposit; Integer)
        {
            Caption = 'Month deposit';
            DataClassification = CustomerContent;
        }
        field(3; DepositAmount; Decimal)
        {
            Caption = 'Deposit amount';
            DataClassification = CustomerContent;
        }
        field(4; MonthPrepaidRent; Integer)
        {
            Caption = 'Month prepaid rent';
            DataClassification = CustomerContent;
        }
        field(5; PrepaidRentAMount; Decimal)
        {
            Caption = 'Prepaid rent amount';
            DataClassification = CustomerContent;
        }
        field(10; MinRegulation; Decimal)
        {
            Caption = 'Min. regulation';
            DataClassification = CustomerContent;
        }
        field(11; MaxRegulations; Decimal)
        {
            Caption = 'Max. regulation';
            DataClassification = CustomerContent;
        }
        field(12; Increase; Decimal)
        {
            Caption = 'Agreed increase (%)';
            DataClassification = CustomerContent;
        }
        field(20; RegDate; Date)
        {
            Caption = 'Regulation date';
            DataClassification = CustomerContent;
            
        }
        field(30; Indeks_Date; date)
        {
            Caption = 'Indeks date';
            DataClassification = CustomerContent;
            
        }
        Field(31; Latest_regulation; Date)
        {
            Caption = 'Latest regulation';
            DataClassification = CustomerContent;
        }
        field(32; EndDate; Date)
        {
            Caption = 'End date';
            DataClassification = CustomerContent;
        }
        field(33; "VAT charged"; Boolean)
        {

        }
        field(34; Startdate; Date)
        {
            Caption = 'Start date';
            DataClassification = CustomerContent;
        }

        field(40; RepaymentPeriod; Decimal)
        {
            Caption = 'Repayment amount per period';
            DataClassification = CustomerContent;
        }
        field(41; StartRepayment; Date)
        {
            Caption = 'First repayment';
            DataClassification = CustomerContent;
        }
        field(42; EndRepayment; Date)
        {
            Caption = 'Last repayment';
            DataClassification = CustomerContent;
        }
        field(43; Description; Text[20])
        {
            Caption = 'Description repayment';
            DataClassification = CustomerContent;
        }
    }
}
