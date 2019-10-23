report 50008 "SVA Consumption Electricity"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Consumption Electricity.rdlc';
    Caption='AC Electricity';

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
                                    WHERE(Type=CONST(ACElectric));
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

                trigger OnPreDataItem();
                begin
                     if ("Occupant Trans".Date < ElFrom) OR ("Occupant Trans".Date > ElTo) then
                        CurrReport.Skip;
                end;
            }

            trigger OnAfterGetRecord();
            begin
                PropNo := PropertyNo;
                 PropertyRec.RESET;
                 PropertyRec.SETRANGE(PropertyRec.Property,PropNo);
                 IF PropertyRec.FINDFIRST() THEN BEGIN
                     If ElTo = 0D then begin
                        if Date2dmy(Today,2) < PropertyRec.WaterYearTo then   
                            ElTo := DMY2DATE(1, PropertyRec.WaterYearFrom, DATE2DMY(TODAY,3))-1; 
                        if Date2dmy(Today,2) > PropertyRec.WaterYearTo then 
                            ElTo := DMY2DATE(1, PropertyRec.WaterYearFrom, DATE2DMY(TODAY,3));
                        ElFrom := CalcDate('<-1Y>',ElTo);
                        ElTo := CALCDATE('<1Y-1D>',ElFrom);
                     end;   
                  END;
                 IF (EndDate < ElFrom) AND (EndDate <> 0D) THEN
                  CurrReport.SKIP;
                 IF StartDate > ElTo THEN
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
        ElFrom : Date;
        ElTo : Date;
        PropertyRec : Record "SVA Property";
        PropNo : Code[10];
}

