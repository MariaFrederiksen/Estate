report 50007 "SVA Consumption Water"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Consumption Water.rdlc';
    Caption='AC water';
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
                                    WHERE(Type=CONST(ACwater));
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
                    if ("Occupant Trans".Date < WaterFrom) OR ("Occupant Trans".Date > WaterTo) then
                        CurrReport.Skip;
                end;
            }

            trigger OnAfterGetRecord();
            begin
                 PropNo := PropertyNo;
                 PropertyRec.RESET;
                 PropertyRec.SETRANGE(PropertyRec.Property,PropNo);
                 IF PropertyRec.FINDFIRST() THEN BEGIN
                     If WaterTo = 0D then begin
                        if Date2dmy(Today,2) < PropertyRec.WaterYearTo then   
                            WaterTo := DMY2DATE(1, PropertyRec.WaterYearFrom, DATE2DMY(TODAY,3))-1; 
                        if Date2dmy(Today,2) > PropertyRec.WaterYearTo then 
                            WaterTo := DMY2DATE(1, PropertyRec.WaterYearFrom, DATE2DMY(TODAY,3));
                        WaterFrom := CalcDate('<-1Y>',WaterTo);
                        WaterTo := CALCDATE('<1Y-1D>',WaterFrom);
                     end;   
                  END;
                 IF (EndDate < WaterFrom) AND (EndDate <> 0D) THEN
                  CurrReport.SKIP;
                 IF StartDate > WaterTo THEN
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
        WaterFrom : Date;
        WaterTo : Date;
        PropertyRec : Record "SVA Property";
        PropNo : Code[10];
      
}

