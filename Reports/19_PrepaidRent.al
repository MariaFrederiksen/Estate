report 50019 "SVA Prepaid Rent"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/PrepaidRent.rdlc';
    Caption = 'Prepaid Rent';
    UsageCategory = ReportsAndAnalysis;


    dataset
    {
        dataitem(Occupant; "SVA Occupant")
        {
            column(Headline; Headline)
            {
            }
            column(CompanyName; COMPANYPROPERTY.DISPLAYNAME())
            {
            }

            column(PropertyNo; PropertyNo)
            {
            }
            column(Number; Number)
            {
            }
            column(TenancyNo; TenancyNo)
            {
            }
            column(Customer; "Customer No")
            {
            }
            column(Name1; Name1)
            {
            }
            column(EndDate; EndDate)
            {
            }
            column(StartDate; StartDate)
            {
            }

            dataitem("Occupant Trans"; "SVA Occupant Trans")
            {
                DataItemLink = Occupant = FIELD(Number);
                DataItemTableView = SORTING(Occupant, Date, "Cost type Estate", "Invoice No")
                                    WHERE(Type = CONST("Prepaid Rent"));
                column(OccupantNo; Occupant)
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
            var
                l_OccupantRec: Record "SVA Occupant";
                l_OccupantTrans: REcord "SVA Occupant Trans";
            begin
                Headline := 'Prepaid rent';
                g_Amount := 0;
                l_OccupantRec.Reset();
                l_OccupantRec.SetRange(Number, Occupant.Number);
                if l_OccupantRec.FindFirst() then begin
                    l_OccupantTrans.Reset();
                    l_OccupantTrans.SetRange(Type, 10);
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
        Headline: Text[20];
        g_Amount: Decimal;

}