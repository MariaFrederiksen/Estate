enum 50001 "SVA NETS Transfer"
{
    Extensible = true;

    Caption = 'Transfer NETS';

    value(0; Empty)
    {
        Caption = 'Unknown';
    }
    value(1; Transfer)
    {
        Caption = 'Transfer';
    }
    value(2; Enrolled)
    {
        Caption = 'Enrolled';
    }
    value(3; ClosedBank)
    {
        Caption = 'Closed (by bank)';
    }
    value(4; ClosedCreditor)
    {
        Caption = 'Closed (by creditor)';
    }
    value(5; ClosedBS)
    {
        Caption = 'Closed (by BS)';
    }
}