report 50200 "SVA Collection Journal"
{
    // Opkrævningsjournal for kontrakter, der skal have opkrævet husleje.
    // Omfatter kontrakter, der ikke tidligere er opkrævet for perioden, og som er aktive.
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Collections.rdlc';

    Caption = 'Collection Journal';

    dataset
    {
        dataitem("Occupant"; "SVA Occupant")
        {
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
            dataitem("Subscription Lines"; "SVA Subscription Lines")
            {
                DataItemLink = Tenancies = FIELD (TenancyNo);
                DataItemTableView = SORTING (Tenancies, "Cost Types", "Date From", "Date To", KeyNumber)
                                    ORDER(Ascending)
                                    WHERE (Type = FILTER (<> MoveOut));
                column(STenancy; Tenancies)
                {
                }
                column(SCosttype; "Cost Types")
                {
                }
                column(SDateFrom; "Date From")
                {
                }
                column(SDateTo; "Date To")
                {
                }
                column(SAmountPer; "Amount Period")
                {
                }
                column(SVatGroup; VatGroup)
                {
                }
                column(PrDate; PrDate)
                {
                }
                column(Vatrate; Vatrate)
                {
                }
                column(AmountInclVat; AmountInclVat)
                {

                }

                trigger OnAfterGetRecord();
                begin
                    IF("Date To" < PrDate) AND("Date To" <> 0D) THEN
                        CurrReport.SKIP;
                    IF Type = 12 THEN //Fraflytninger
                        CurrReport.SKIP;
                    Vatpostinggroup.Reset;
                    Vatpostinggroup.SetRange("Vat Prod. Posting Group", "Subscription Lines".VatGroup);
                    IF Vatpostinggroup.FindFirst() then
                        Vatrate := 1+(Vatpostinggroup."VAT %"/100);
                    IF Vatrate = 0 then 
                        Vatrate := 1;
                    AmountInclVat := "Subscription Lines"."Amount Period"*Vatrate;                        
                end;
            }

            trigger OnAfterGetRecord();

            begin
                PrDate := DMY2DATE(1, DATE2DMY(TODAY, 2) + 1, DATE2DMY(TODAY, 3));
                Vatrate := 1;
                IF(EndDate < TODAY) AND(EndDate <> 0D) THEN
                    CurrReport.SKIP;
                IF(StartDate > PrDate) THEN
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
        PrDate: Date;
        Vatrate: Decimal;
        AmountInclVat: Decimal;
        CostTypeEstate: Record "SVA Cost type";
        Vatpostinggroup: Record "VAT Posting Setup";
}

