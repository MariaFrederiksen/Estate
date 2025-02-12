report 50036 "SVA Tenancy Balance"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    WordLayout = './layouts/TenancyBalance_Ny.docx';
    DefaultLayout = Word;
    Caption = 'Balance';

    dataset
    {
        dataitem("SVA Occupant"; "SVA Occupant")
        {
            column(Occupant; Number)
            {

            }
            column(TenancyNo; TenancyNo)
            {

            }
            column(Name1; Name1)
            {

            }
            column(Startdate; Format(StartDate))
            {

            }
            column(EndDate; Format(EndDate))
            {

            }

            column(LeaseYr; LeaseYr)
            {

            }
            column(Deposit; Deposit)
            {

            }
            column(CalcDeposit; CalcDeposit)
            {

            }
            column(PrepaidRent; PrepaidRent)
            {

            }

            trigger OnAfterGetRecord()
            var
                SVAOccupantTrans: Record "SVA Occupant Trans";
                SVASubscriptionLines: Record "SVA Subscription Lines";
            begin
                Deposit := 0;
                PrepaidRent := 0;
                SVAOccupantTrans.Reset();
                SVAOccupantTrans.SetRange(Occupant, Number);
                SVAOccupantTrans.SetRange(Type, SVAOccupantTrans.Costtype::Deposit);
                if SVAOccupantTrans.FindSet() then
                    repeat
                        Deposit := Deposit + SVAOccupantTrans.Amount;
                    until SVAOccupantTrans.Next() = 0;
                SVAOccupantTrans.Reset();
                SVAOccupantTrans.SetRange(Occupant, Number);
                SVAOccupantTrans.SetRange(Type, SVAOccupantTrans.Costtype::"Prepaid rent");
                if SVAOccupantTrans.FindSet() then
                    repeat
                        PrepaidRent := PrepaidRent + SVAOccupantTrans.Amount;
                    until SVAOccupantTrans.Next() = 0;
                SVASubscriptionLines.Reset();
                SVASubscriptionLines.SetRange(Tenancies, TenancyNo);
                SVASubscriptionLines.SetRange(Type, SVAOccupantTrans.Costtype::Rent);
                if SVASubscriptionLines.FindFirst() then
                    if (SVASubscriptionLines."Date To" > Today) OR (SVASubscriptionLines."Date To" = 0D) then
                        LeaseYr := SVASubscriptionLines."Amount Year";
                CalcDeposit := LeaseYr / 4;
                LeaseYr := LeaseYr / 12;
                /* if (EndDate < Today) AND (Deposit = 0) AND (PrepaidRent = 0) then
                    CurrReport.Skip();
                */
            end;

        }

    }

    requestpage
    {

    }


    var
        LeaseYr: Decimal;
        CalcDeposit: Decimal;
        Deposit: Decimal;
        PrepaidRent: Decimal;

}