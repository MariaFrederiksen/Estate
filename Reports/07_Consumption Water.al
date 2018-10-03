report 50420 "SVA Consumption Water"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Consumption Water.rdlc';
    Caption='AC water';

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
                    SETRANGE(Date,WaterFrom,WaterTo);
                end;
            }

            trigger OnAfterGetRecord();
            begin
                 PropNo := PropertyNo;
                 PropertyRec.RESET;
                 PropertyRec.SETRANGE(PropertyRec.Property,PropNo);
                 IF PropertyRec.FINDFIRST() THEN BEGIN
                  WaterFrom := DMY2DATE(1, PropertyRec.WaterYearFrom, DATE2DMY(TODAY,3));
                  WaterTo := CALCDATE('<1Y-1D>',WaterFrom);
                  END;
                 IF (EndDate < TODAY) AND (EndDate <> 0D) THEN
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

