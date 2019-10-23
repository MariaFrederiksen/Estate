report 50018 "SVA Deposit"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Deposit.rdlc';
    Caption = 'Deposit';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Tenancy; "SVA Tenancy")
        {
            column(PropertyNo; PropertyNo)
            {

            }
            column(Number; Number)
            {

            }

            dataitem(Occupant; "SVA Occupant")
            {
                DataItemLink = TenancyNo = FIELD (Number);
                DataItemTableView = SORTING (TenancyNo, Number);

                column(OProperty; PropertyNo)
                {
                }
                column(ONo; Number)
                {
                }
                column(OTenancy; TenancyNo)
                {
                }
                column(OCustomer; "Customer No")
                {
                }
                column(OName; Name1)
                {
                }
                column(OEndDate; EndDate)
                {
                }
                column(OStartDate; StartDate)
                {
                }
                column(OID; ConsumptionAccountNo)
                {
                }
                dataitem("Occupant Trans"; "SVA Occupant Trans")
                {
                    DataItemLink = Occupant = FIELD (Number);
                    DataItemTableView = SORTING (Occupant, Date, "Cost type Estate", "Invoice No")
                                    WHERE (Type = CONST (Deposit));
                    column(OTransNo; Occupant)
                    {
                    }
                    column(Costtype; "Cost type Estate")
                    {
                    }
                    column(Date; Date)
                    {
                    }
                    column(Amount; Amount)
                    {
                    }

                }
                trigger OnAfterGetRecord();
                begin
                    AmountVar := 0;
                    OccupantOK := false;
                    OccupantTrans.reset;
                    OccupantTrans.Setrange(Type, 10);
                    OccupantTrans.SetRange(Occupant, Occupant.number);
                    if OccupantTrans.FindSet then
                        repeat
                            AmountVar := AmountVar + OccupantTrans.Amount;
                        until OccupantTrans.Next = 0;
                    if AmountVar <> 0 then
                        OccupantOK := true;
                    if OccupantOK = false then
                        CurrReport.Skip;
                end;
            }

            trigger OnAfterGetRecord();
            begin
                TenancyOK := false;
                AmountVar := 0;
                OccupantTable.reset;
                OccupantTable.SetRange(TenancyNo, Tenancy.Number);
                if Occupanttable.findset then
                    repeat
                        OccupantTrans.reset;
                    OccupantTrans.SetRange(Occupant, OccupantTable.Number);
                    OccupantTrans.Setrange(Type, 10);
                    if OccupantTrans.findset then
                        repeat
                                AmountVar := AmountVar + OccupantTrans.Amount;
                        until OccupantTrans.Next = 0;
                    if AmountVar <> 0 then
                        TenancyOK := true;
                    until OccupantTable.Next = 0;
                if TenancyOK = false then
                    CurrReport.skip;

            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        AmountVar: Decimal;
        OccupantTable: Record "SVA Occupant";
        OccupantTrans: record "SVA Occupant Trans";
        TenancyOK: Boolean;
        OccupantOK: Boolean;
}

