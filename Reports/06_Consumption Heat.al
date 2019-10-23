report 50006 "SVA Consumption Heat"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Consumption Heat.rdlc';
    Caption='AC heat';
    UsageCategory=ReportsAndAnalysis;

    dataset
    {
        dataitem(Occupant;"SVA Occupant")
        {
            column(OProperty;PropertyNo)
            {
            }
            column(ONo;Number)
            {
            }
            column(OTenancy;TenancyNo)
            {
            }
            column(OCustomer;"Customer No")
            {
            }
            column(OName;Name1)
            {
            }
            column(OEndDate;EndDate)
            {
            }
            column(OStartDate;StartDate)
            {
            }
            column(OID;ConsumptionAccountNo)
            {
            }
            dataitem("Occupant Trans";"SVA Occupant Trans")
            {
                DataItemLink = Occupant=FIELD(Number);
                DataItemTableView = SORTING(Occupant,Date,"Cost type Estate","Invoice No")
                                    WHERE(Type=CONST(ACheat));
                column(OTransNo;Occupant)
                {
                }
                column(Costtype;"Cost type Estate")
                {
                }
                column(Date;Date)
                {
                }
                column(Amount;Amount)
                {
                }

                trigger OnAfterGetRecord();
                begin
                    if ("Occupant Trans".Date < HeatFrom) OR ("Occupant Trans".Date > HeatTo) then
                        CurrReport.Skip;
                end;
            }

            trigger OnAfterGetRecord();
            begin
                 PropNo := PropertyNo;
                 PropertyRec.RESET;
                 PropertyRec.SETRANGE(PropertyRec.Property,PropNo);
                 IF PropertyRec.FINDFIRST() THEN BEGIN
                     If HeatTo = 0D then begin
                        if Date2dmy(Today,2) < PropertyRec.WaterYearTo then   
                            HeatTo := DMY2DATE(1, PropertyRec.WaterYearFrom, DATE2DMY(TODAY,3))-1; 
                        if Date2dmy(Today,2) > PropertyRec.WaterYearTo then 
                            HeatTo := DMY2DATE(1, PropertyRec.WaterYearFrom, DATE2DMY(TODAY,3));
                        HeatFrom := CalcDate('<-1Y>',HeatTo);
                        HeatTo := CALCDATE('<1Y-1D>',HeatFrom);
                     end;   
                  END;
                 IF (EndDate < HeatFrom) AND (EndDate <> 0D) THEN
                  CurrReport.SKIP;
                 IF StartDate > HeatTo THEN
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
        HeatFrom : Date;
        HeatTo : Date;
        PropertyRec : Record "SVA Property";
        PropNo : Code[10];
}

