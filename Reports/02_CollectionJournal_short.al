report 50002 "SVA Collection Journal Short"
{
    // Opkrævningsjournal for kontrakter, der skal have opkrævet husleje.
    // Omfatter kontrakter, der ikke tidligere er opkrævet for perioden, og som er aktive.
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Collections_Short.rdlc';
    UsageCategory=ReportsAndAnalysis;

    Caption = 'Collection Journal short';

    dataset
    {
        dataitem("Tenancy"; "SVA Tenancy")
        {
            column(CompanyName;COMPANYPROPERTY.DISPLAYNAME)
            {
            }
            column(TNumber; Tenancy.Number)
            {

            }
            dataitem("Occupant"; "SVA Occupant")
            {
                DataItemLink = TenancyNo=FIELD(Number);

                column(ONo; Number)
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
                    DataItemTableView = SORTING (Tenancies, Order, "Cost Types", "Date From", "Date To", KeyNumber)
                                    ORDER(Ascending)
                                    WHERE (Type = FILTER (<> 13));
                    column(STenancy; Tenancies)
                    {
                    }
                    column(SCosttype; Description)
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

                    trigger OnAfterGetRecord(); //Costtype
                    begin
                        IF("Date To" < PrDate) AND ("Date To" <> 0D) THEN
                            CurrReport.SKIP;
                        IF("Date From" > PrDate) then
                            CurrReport.Skip;
                        IF Type = 13 THEN //Fraflytninger
                            CurrReport.SKIP;

                        Customer.Reset;
                        Customer.SetRange("No.", Occupant."Customer No");
                        if Customer.FindFirst then begin
                            Vatpostinggroup.Reset;
                            Vatpostinggroup.SetRange("Vat Prod. Posting Group", "Subscription Lines".VatGroup);
                            Vatpostinggroup.SetRange("VAT Bus. Posting Group", Customer."VAT Bus. Posting Group");
                            IF Vatpostinggroup.FindFirst() then
                                Vatrate := 1 + (Vatpostinggroup."VAT %" / 100);
                            IF Vatrate = 0 then
                                Vatrate := 1;
                            AmountInclVat := "Subscription Lines"."Amount Period" * Vatrate;
                        end;
                    end;
                }

                trigger OnAfterGetRecord(); //Occupant

                begin
                    IF DATE2DMY(TODAY, 2) = 12 THEN
                        PrDate := DMY2DATE(1, 1, DATE2DMY(TODAY, 3) + 1)
                    ELSE
                        PrDate := DMY2DATE(1, DATE2DMY(TODAY, 2) + 1, DATE2DMY(TODAY, 3));
                    
                    Vatrate := 1;
                    IF (EndDate < PrDate) AND (EndDate <> 0D) THEN
                        CurrReport.SKIP;
                    IF (StartDate > PrDate) THEN
                        CurrReport.SKIP;
                    IF Blocked <> 0D THEN
                        CurrReport.SKIP;
                    if FirstNets > PrDate then //FirstNets before or at invoicedate    
                        CurrReport.Skip;

                    TenancyCard.Reset;
                    TenancyCard.SetRange(Number,TenancyNo);
                    TenancyCard.SetRange(PeriodYear,1,3);
                    if TenancyCard.FindFirst then begin  //not monthly subscription
                        if TenancyCard.PeriodYear = 1 then begin //Kvartal
                            //jan,apr,jul,oct
                            if (DATE2DMY(PrDate, 2) - 1 = 1) OR (DATE2DMY(PrDate, 2) - 1 = 4) OR (DATE2DMY(PrDate, 2) - 1 = 7) OR (DATE2DMY(PrDate, 2) - 1 = 10) then
                                if ("Collection Month" = 2) OR ("Collection Month" = 3) OR 
                                   ("Collection Month" = 5) OR ("Collection Month" = 6) OR 
                                   ("Collection Month" = 8) OR ("Collection Month" = 9) OR 
                                   ("Collection Month" = 11) OR ("Collection Month" = 12) then
                                   CurrReport.Skip;
                            //feb,may,aug,nov
                            if (DATE2DMY(PrDate, 2) - 1 = 2) OR (DATE2DMY(PrDate, 2) - 1 = 5) OR (DATE2DMY(PrDate, 2) - 1 = 8) OR (DATE2DMY(PrDate, 2) - 1 = 11) then
                                if ("Collection Month" = 1) OR ("Collection Month" = 3) OR 
                                   ("Collection Month" = 4) OR ("Collection Month" = 6) OR 
                                   ("Collection Month" = 7) OR ("Collection Month" = 9) OR 
                                   ("Collection Month" = 10) OR ("Collection Month" = 12) then
                                   CurrReport.Skip;
                            //Mar,jun,sep,dec                                          
                            if (DATE2DMY(PrDate, 2) - 1 = 3) OR (DATE2DMY(PrDate, 2) - 1 = 6) OR (DATE2DMY(PrDate, 2) - 1 = 9) OR (DATE2DMY(PrDate, 2) - 1 = 12) then
                                if ("Collection Month" = 1) OR ("Collection Month" = 2) OR 
                                   ("Collection Month" = 4) OR ("Collection Month" = 5) OR 
                                   ("Collection Month" = 7) OR ("Collection Month" = 8) OR 
                                   ("Collection Month" = 10) OR ("Collection Month" = 11) then
                                   CurrReport.Skip;                                   
                        end;
                        if TenancyCard.PeriodYear = 2 then begin //halvår
                            if (DATE2DMY(PrDate, 2) - 1 = 1) OR (DATE2DMY(PrDate, 2) - 1 = 7) then
                                if ("Collection Month" = 2) OR ("Collection Month" = 3) OR    
                                   ("Collection Month" = 4) OR ("Collection Month" = 5) OR                                   
                                   ("Collection Month" = 6) OR ("Collection Month" = 8) OR                                   
                                   ("Collection Month" = 9) OR ("Collection Month" = 10) OR                                   
                                   ("Collection Month" = 11) OR ("Collection Month" = 12) then
                                   CurrReport.Skip;
                            if (DATE2DMY(PrDate, 2) - 1 = 2) OR (DATE2DMY(PrDate, 2) - 1 = 8) then
                                if ("Collection Month" = 1) OR ("Collection Month" = 3) OR    
                                   ("Collection Month" = 4) OR ("Collection Month" = 5) OR                                   
                                   ("Collection Month" = 6) OR ("Collection Month" = 7) OR                                   
                                   ("Collection Month" = 9) OR ("Collection Month" = 10) OR                                   
                                   ("Collection Month" = 11) OR ("Collection Month" = 12) then
                                   CurrReport.Skip;
                            if (DATE2DMY(PrDate, 2) - 1 = 3) OR (DATE2DMY(PrDate, 2) - 1 = 9) then
                                if ("Collection Month" = 1) OR ("Collection Month" = 2) OR    
                                   ("Collection Month" = 4) OR ("Collection Month" = 5) OR                                   
                                   ("Collection Month" = 6) OR ("Collection Month" = 7) OR                                   
                                   ("Collection Month" = 8) OR ("Collection Month" = 10) OR                                   
                                   ("Collection Month" = 11) OR ("Collection Month" = 12) then
                                   CurrReport.Skip;
                            if (DATE2DMY(PrDate, 2) - 1 = 4) OR (DATE2DMY(PrDate, 2) - 1 = 10) then
                                if ("Collection Month" = 1) OR ("Collection Month" = 2) OR    
                                   ("Collection Month" = 3) OR ("Collection Month" = 5) OR                                   
                                   ("Collection Month" = 6) OR ("Collection Month" = 7) OR                                   
                                   ("Collection Month" = 8) OR ("Collection Month" = 9) OR                                   
                                   ("Collection Month" = 11) OR ("Collection Month" = 12) then
                                   CurrReport.Skip;
                            if (DATE2DMY(PrDate, 2) - 1 = 5) OR (DATE2DMY(PrDate, 2) - 1 = 11) then
                                if ("Collection Month" = 1) OR ("Collection Month" = 2) OR    
                                   ("Collection Month" = 3) OR ("Collection Month" = 4) OR                                   
                                   ("Collection Month" = 6) OR ("Collection Month" = 7) OR                                   
                                   ("Collection Month" = 8) OR ("Collection Month" = 9) OR                                   
                                   ("Collection Month" = 10) OR ("Collection Month" = 12) then
                                   CurrReport.Skip;
                            if (DATE2DMY(PrDate, 2) - 1 = 6) OR (DATE2DMY(PrDate, 2) - 1 = 12) then
                                if ("Collection Month" = 1) OR ("Collection Month" = 2) OR    
                                   ("Collection Month" = 3) OR ("Collection Month" = 4) OR                                   
                                   ("Collection Month" = 5) OR ("Collection Month" = 7) OR                                   
                                   ("Collection Month" = 8) OR ("Collection Month" = 9) OR                                   
                                   ("Collection Month" = 10) OR ("Collection Month" = 11) then
                                   CurrReport.Skip;                                                                                                                                                                                                                                                                                                                                 
                        end; //halvår
                        if TenancyCard.PeriodYear = 3 then begin //year
                            if (DATE2DMY(PrDate, 2) - 1) <> "Collection Month" then
                                CurrReport.Skip;
                        end; //Year        
                    end; //Tenancy with collectionperiod <> mth
                end;    
            }
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
        Customer: Record Customer;
        TenancyCard: record "SVA Tenancy";
}

