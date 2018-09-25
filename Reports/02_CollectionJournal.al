report 50200 "SVA Collection Journal"
{
    // Opkrævningsjournal for kontrakter, der skal have opkrævet husleje.
    // Omfatter kontrakter, der ikke tidligere er opkrævet for perioden, og som er aktive.
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Collections.rdlc';

    Caption='Collection Journal';

    dataset
    {
        dataitem(DataItem1000000000;"SVA Occupant")
        {
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
            dataitem(DataItem1000000008;"SVA Subscription Lines")
            {
                DataItemLink = Tenancies=FIELD(TenancyNo);
                DataItemTableView = SORTING(Tenancies,"Cost Types","Date From","Date To",KeyNumber)
                                    ORDER(Ascending)
                                    WHERE(Type=FILTER(<>MoveOut));
                column(STenancy;Tenancies)
                {
                }
                column(SCosttype;"Cost Types")
                {
                }
                column(SDateFrom;"Date From")
                {
                }
                column(SDateTo;"Date To")
                {
                }
                column(SAmountPer;"Amount Period")
                {
                }
                column(SVatGroup;VatGroup)
                {
                }
                column(PrDate;PrDate)
                {
                }

                trigger OnAfterGetRecord();
                begin
                    IF ("Date To" < PrDate) AND ("Date To" <> 0D) THEN
                      CurrReport.SKIP;
                    IF Type = 12 THEN //Fraflytninger
                      CurrReport.SKIP;
                end;
            }

            trigger OnAfterGetRecord();
            begin
                PrDate := DMY2DATE(1, DATE2DMY(TODAY,2)+1, DATE2DMY(TODAY,3));
                IF (EndDate < TODAY) AND (EndDate <> 0D) THEN
                  CurrReport.SKIP;
                IF (StartDate > PrDate) THEN
                  CurrReport.SKIP;
                IF Blocked <> 0D THEN
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
        PrDate : Date;
        CostTypeEstate : Record "SVA Cost type";
}

