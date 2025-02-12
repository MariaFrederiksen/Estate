report 50018 "SVA Deposit"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Deposit.rdlc';
    Caption = 'Deposit';
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
            column(PrDate; PrDate)
            {
            }

            dataitem("Occupant Trans"; "SVA Occupant Trans")
            {
                DataItemLink = Occupant = FIELD(Number);
                DataItemTableView = SORTING(Occupant, Date, "Cost type Estate", "Invoice No")
                                    WHERE(Type = CONST(Deposit));
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
                trigger OnAfterGetRecord()
                begin
                    if Date > PrDate then
                        CurrReport.Skip();
                end;


            }
            Trigger OnPreDataItem()
            begin
                PrDate := StatementDate;
                if PrDate = 0D then
                    PrDate := Today();
            end;

            trigger OnAfterGetRecord();
            var
                l_OccupantRec: Record "SVA Occupant";
                l_OccupantTrans: REcord "SVA Occupant Trans";
            begin
                Headline := 'Depositum';
                g_Amount := 0;
                l_OccupantRec.Reset();
                l_OccupantRec.SetRange(Number, Occupant.Number);
                if l_OccupantRec.FindFirst() then begin
                    l_OccupantTrans.Reset();
                    l_OccupantTrans.SetRange(Type, 10);
                    l_OccupantTrans.SetRange(l_OccupantTrans.Occupant, l_OccupantRec.Number);
                    l_OccupantTrans.SetRange(l_OccupantTrans.Date, 0D, PrDate);
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
            area(content)
            {
                group(Options)
                {
                    Caption = 'Filter';
                    field(StatementDate; StatementDate)
                    {
                        ApplicationArea = all;
                        Caption = 'Date';
                        ToolTip = 'Opgørelse pr.';
                        trigger OnValidate()
                        begin
                            if StatementDate = 0D then
                                StatementDate := Today();
                        end;
                    }
                }
            }

        }

    }

    labels
    {
    }

    var
        Headline: Text[20];
        g_Amount: Decimal;
        StatementDate: Date;
        PrDate: Date;



}