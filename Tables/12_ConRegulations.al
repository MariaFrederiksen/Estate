table 50012 "SVA Contract regulations"
{
    // Tabellen indeholder de nødvendige felter for regulering af leje

    Caption = 'Contract regulations';
    DataClassification = CustomerContent;
    Permissions = TableData 50012 = rimd;
    DrillDownPageID = "SVA Subscription reg List";
    LookupPageID = "SVA Subscription reg List";

    fields
    {
        field(1; Number; Code[10])
        {
            Caption = 'Number';
            TableRelation = "SVA Occupant".Number;

            trigger OnValidate();
            begin
                IF RegDate = 0D THEN BEGIN  //Empty record
                    Contract.Reset;
                    Contract.SetRange(Number,Number);
                    IF Contract.FindFirst then begin
                        MonthDeposit := Contract.TypeA9_4_DepMth;
                        DepositAmount := Contract.TypeA9_4_DepAmount;
                        MonthPrepaidRent := Contract.TypeA9_4_PrepaidRentMth;
                        PrepaidRentAMount := Contract.TypeA9_4_PrepaidRent;
                    end;
                end;
                Insert;
            end;
        }
        field(2; MonthDeposit; Integer)
        {

        }
        field(3; DepositAmount; Decimal)
        {

        }
        field(4; MonthPrepaidRent; Integer)
        {

        }
        field(5; PrepaidRentAMount; Decimal)
        {

        }
        field(10; MinRegulation; Decimal)
        {

        }
        field(11; MaxRegulations; Decimal)
        {

        }
        field(12; Increase; Decimal)
        {

        }
        field(20; RegDate; Date)
        {

        }
        field(30; Indeks_Date; date)
        {

        }
        Field(31; Latest_regulation; Date)
        {

        }
        field(32; EndDate; Date)
        {

        }
    }
    var
        Contract: Record "SVA LeaseContract_A9";
}
