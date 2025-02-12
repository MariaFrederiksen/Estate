report 50006 "SVA Consumption Heat"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Consumption Heat.rdlc';
    Caption = 'AC heat';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Occupant; "SVA Occupant")
        {
            column(Headline; Headline)
            {
            }
            column(CompanyName; PropertyName)
            {
            }
            column(ConsumptionFrom; ConsumptionFrom)
            {
            }
            column(ConsumptionTo; ConsumptionTo)
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
            column(Address; Address)
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
                                    WHERE(Type = CONST(ACheat));
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

                trigger OnAfterGetRecord();
                begin
                    if ("Occupant Trans".Date < ConsumptionFrom) OR ("Occupant Trans".Date > ConsumptionTo) then
                        CurrReport.Skip();
                end;
            }

            trigger OnAfterGetRecord();
            begin
                Headline := HeadlineLbl;
                PropNo := PropertyNo;
                SVAProperty.Reset();
                SVAProperty.SETRANGE(SVAProperty.Property, PropNo);
                IF SVAProperty.FINDFIRST() then begin
                    PropertyName := SVAProperty.Name;
                    if PropertyName = '' then
                        PropertyName := SVAProperty.Address1;
                    If ConsumptionTo = 0D then begin
                        ConsumptionFrom := DMY2DATE(1, SVAProperty.HeatingYearFrom, DATE2DMY(TODAY, 3));
                        ConsumptionTo := CALCDATE('<1Y-1D>', ConsumptionFrom);
                        while Today < ConsumptionTo do begin
                            ConsumptionFrom := CalcDate('<-1Y>', ConsumptionFrom);
                            ConsumptionTo := CalcDate('<-1Y>', ConsumptionTo);
                        end;
                    end;
                end;

                IF (EndDate < ConsumptionFrom) AND (EndDate <> 0D) THEN
                    CurrReport.Skip();
                IF StartDate > ConsumptionTo THEN
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
        SVAProperty: Record "SVA Property";
        Headline: Text[20];
        ConsumptionTo: Date;
        ConsumptionFrom: Date;
        PropNo: Code[10];
        HeadlineLbl: Label 'A conto heat';
        PropertyName: Text[50];

}


