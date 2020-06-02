report 50006 "SVA Consumption Heat"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Consumption Heat.rdlc';
    Caption = 'AC heat';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("SVA Property"; "SVA Property")
        {
            column(HeatingYearFrom; HeatingYearFrom)
            {
            }
            column(HeatingYearTo; HeatingYearTo)
            {
            }
        }
        dataitem(Occupant; "SVA Occupant")
        {
            column(CompanyName; COMPANYPROPERTY.DISPLAYNAME)
            {
            }
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
                DataItemLink = Occupant = FIELD(Number);
                DataItemTableView = SORTING(Occupant, Date, "Cost type Estate", "Invoice No")
                                    WHERE(Type = CONST(ACheat));
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

                trigger OnAfterGetRecord();
                begin
                    if ("Occupant Trans".Date < ConsumptionFrom) OR ("Occupant Trans".Date > ConsumptionTo) then
                        CurrReport.Skip;
                end;
            }

            trigger OnAfterGetRecord();
            begin
                PropNo := PropertyNo;
                PropertyRec.RESET;
                PropertyRec.SETRANGE(PropertyRec.Property, PropNo);
                IF PropertyRec.FINDFIRST() THEN begin
                    If ConsumptionTo = 0D then begin
                        ConsumptionFrom := DMY2DATE(1, PropertyRec.HeatingYearFrom, DATE2DMY(TODAY, 3));
                        ConsumptionTo := CALCDATE('<1Y-1D>', ConsumptionFrom);
                        while Today < ConsumptionTo do begin
                            ConsumptionFrom := CalcDate('<-1Y>', ConsumptionFrom);
                            ConsumptionTo := CalcDate('<-1Y>', ConsumptionTo);
                        end;
                    end;
                END;
                IF (EndDate < ConsumptionFrom) AND (EndDate <> 0D) THEN
                    CurrReport.SKIP;
                IF StartDate > ConsumptionTo THEN
                    CurrReport.SKIP;
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
        ConsumptionFrom: Date;
        ConsumptionTo: Date;
        PropertyRec: Record "SVA Property";
        PropNo: Code[10];

}


