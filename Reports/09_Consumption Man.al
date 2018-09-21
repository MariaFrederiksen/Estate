report 50440 "SVA Consumption Man"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Consumption Man.rdlc';
    Caption='AC man';

    dataset
    {
        dataitem(DataItem1000000000;"SVA Occupant")
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
            dataitem(DataItem1000000004;"SVA Occupant Trans")
            {
                DataItemLink = Occupant=FIELD(Number);
                DataItemTableView = SORTING(Occupant,Date,"Cost type Estate","Invoice No")
                                    WHERE(Type=CONST(ACCooling));
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
                    SETRANGE(Date,ManFrom,ManTo);
                    SETRANGE(Type,5);
                end;
            }

            trigger OnAfterGetRecord();
            begin
                 PropNo := PropertyNo;
                 PropertyRec.RESET;
                 PropertyRec.SETRANGE(PropertyRec.Property,PropNo);
                 IF PropertyRec.FINDFIRST() THEN BEGIN
                  ManFrom := DMY2DATE(1, PropertyRec.ManYearFrom, DATE2DMY(TODAY,3));
                  ManTo := CALCDATE('<1Y-1D>',ManFrom);
                  END;
                 IF (EndDate < TODAY) AND (EndDate <> 0D) THEN
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

