report 50026 "SVA Occupant Trans"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Occupant Trans.rdlc';
    Caption = 'Occupant Trans report';
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
                //DataItemTableView = WHERE(Date = FILTER(   ));


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
            var
                l_OccupantTrans: Record "SVA Occupant Trans";
            begin
                
                Headline := HeadlineLbl;
                CosttypeFilter := "Occupant Trans".GetFilter("Cost type Estate");
                DateFilter := "Occupant Trans".GetFilter(Date);
                TypeCostFilter := "Occupant Trans".GetFilter(Type);

                g_Amount := 0;
                l_OccupantTrans.Reset();
                l_OccupantTrans.SetRange(l_OccupantTrans.Occupant, Number);
                l_OccupantTrans.SetFilter(Date, DateFilter);
                l_OccupantTrans.SetFilter(Type, TypeCostFilter);
                l_OccupantTrans.SetFilter("Cost type Estate", CosttypeFilter);
                IF l_OccupantTrans.FindSet() then
                    repeat
                        g_Amount := g_Amount + l_OccupantTrans.Amount;
                    until l_OccupantTrans.Next() = 0;
                if g_amount = 0 then
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
        HeadlineLbl: Label 'Beboerposteringer';
        g_amount: Decimal;
        CosttypeFilter: Text;
        DateFilter: Text;
        TypeCostFilter: Text;
}

