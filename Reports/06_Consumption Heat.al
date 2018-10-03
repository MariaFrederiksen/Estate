report 50410 "SVA Consumption Heat"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Consumption Heat.rdlc';
    Caption='AC heat';

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
                   SETRANGE(Date,HeatFrom,HeatTo);
                   SETRANGE(Type,2);
                end;
            }

            trigger OnAfterGetRecord();
            begin
                 PropNo := PropertyNo;
                 PropertyRec.RESET;
                 PropertyRec.SETRANGE(PropertyRec.Property,PropNo);
                 IF PropertyRec.FINDFIRST() THEN BEGIN
                  IF PropertyRec.HeatingYearFrom > 0 THEN BEGIN
                    HeatFrom := DMY2DATE(1, PropertyRec.HeatingYearFrom, DATE2DMY(TODAY,3));
                    HeatTo := CALCDATE('<1Y-1D>',HeatFrom);
                    END;
                  END;
                 IF (EndDate < TODAY) AND (EndDate <> 0D) THEN
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

