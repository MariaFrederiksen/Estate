report 50430 "SVA Consumption Electricity"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Consumption Electricity.rdlc';
    Caption='AC Electricity';

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
                    SETRANGE(Date,ElFrom,ElTo);
                end;
            }

            trigger OnAfterGetRecord();
            begin
                 PropNo := PropertyNo;
                 PropertyRec.RESET;
                 PropertyRec.SETRANGE(PropertyRec.Property,PropNo);
                 IF PropertyRec.FINDFIRST() THEN BEGIN
                  ElFrom := DMY2DATE(1, PropertyRec.ElectricYearFrom, DATE2DMY(TODAY,3));
                  ElTo := CALCDATE('<1Y-1D>',ElFrom);
                  END;
                 IF (EndDate < TODAY) AND (EndDate <> 0D) THEN
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

