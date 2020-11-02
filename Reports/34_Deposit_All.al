report 50034 "SVA Deposit All"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Deposit_all.rdlc';
    Caption = 'Deposit Trans report';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("SVA Property"; "SVA Property")

        {
            column(Headline; Headline)
            {
            }
            column(Property; Property)
            {
            }
            column(CompanyName; COMPANYPROPERTY.DISPLAYNAME())
            {
            }

            dataitem(Occupant; "SVA Occupant")
            {
                DataItemLink = PropertyNo = field(Property);
                DataItemTableView = sorting(Number);

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
                dataitem("Occupant Trans"; "SVA Occupant Trans")
                {
                    DataItemLink = Occupant = FIELD(Number);
                    DataItemTableView = SORTING(Occupant, Date, "Cost type Estate", "Invoice No")
                                    WHERE(Type = CONST(Deposit));

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
            }
            trigger OnAfterGetRecord();
            var
                l_OccupantRec: Record "SVA Occupant";
                l_OccupantTrans: REcord "SVA Occupant Trans";
            begin
                Headline := HeadlineLbl;
                g_Amount := 0;
                l_OccupantRec.Reset();
                l_OccupantRec.SetRange(Number, Occupant.Number);
                if l_OccupantRec.FindFirst() then begin
                    l_OccupantTrans.Reset();
                    l_OccupantTrans.SetRange(Type, 9);
                    l_OccupantTrans.SetRange(l_OccupantTrans.Occupant, l_OccupantRec.Number);
                    IF l_OccupantTrans.FindSet() then
                        repeat
                            g_Amount := g_Amount + l_OccupantTrans.Amount;
                        until l_OccupantTrans.NEXT() = 0;
                end;
                if (g_Amount = 0) AND ((l_OccupantRec.Enddate < Today) AND (l_OccupantRec.Enddate <> 0D)) then
                    CurrReport.Skip();

            end;

        }
    }

    var
        Headline: Text[30];
        HeadlineLbl: Label 'Deposit report';
        g_amount: Decimal;

}


