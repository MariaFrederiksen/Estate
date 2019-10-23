report 50009 "SVA Consumption Man"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Consumption Man.rdlc';
    Caption='AC man';

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
                                    WHERE(Type=CONST(ACOperating));
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
                     if ("Occupant Trans".Date < ManFrom) OR ("Occupant Trans".Date > ManTo) then
                        CurrReport.Skip;
                end;
            }

            trigger OnAfterGetRecord();
            begin
                PropNo := PropertyNo;
                 PropertyRec.RESET;
                 PropertyRec.SETRANGE(PropertyRec.Property,PropNo);
                 IF PropertyRec.FINDFIRST() THEN BEGIN
                     If ManTo = 0D then begin
                        if Date2dmy(Today,2) < PropertyRec.WaterYearTo then   
                            ManTo := DMY2DATE(1, PropertyRec.WaterYearFrom, DATE2DMY(TODAY,3))-1; 
                        if Date2dmy(Today,2) > PropertyRec.WaterYearTo then 
                            ManTo := DMY2DATE(1, PropertyRec.WaterYearFrom, DATE2DMY(TODAY,3));
                        ManFrom := CalcDate('<-1Y>',ManTo);
                        ManTo := CALCDATE('<1Y-1D>',ManFrom);
                     end;   
                  END;
                 IF (EndDate < ManFrom) AND (EndDate <> 0D) THEN
                  CurrReport.SKIP;
                 IF StartDate > ManTo THEN
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
        ManFrom : Date;
        ManTo : Date;
        PropertyRec : Record "SVA Property";
        PropNo : Code[10];
}

