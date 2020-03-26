report 50003 "SVA Collection Journal"
{
    // Collectionjournal for occupants with an active contract.
    // Field Collections month is a option. January is 0, February is 1.....

    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Collections.rdlc';
    UsageCategory = ReportsAndAnalysis;

    Caption = 'Collection Journal';

    dataset
    {
        dataitem(CompanyInfo; "Company Information")
        {
            column(CompanyName; Name)
            {
            }
            column(CompanyAddress; Address)
            {
            }
            column(CompanyPostCode; "Post Code")
            {
            }
            column(CompanyCity; City)
            {
            }
            column(CompanyVAT_Registration_No_; "VAT Registration No.")
            {
            }
            column(CompanyGetVATRegistrationNumberLbl; GetVATRegistrationNumberLbl)
            {
            }
            column(CompanyPhone_No_; "Phone No.")
            {
            }
            column(COmpanyPicture; Picture)
            {
            }
            column(CompanyBankBranchNo; Companyinfo."Bank Branch No.")
            {
            }
            column(CompanyBanAccountNo; Companyinfo."Bank Branch No.")
            {
            }
            column(CompanyBankName; Companyinfo."Bank Name")
            {
            }
            column(CompanyE_Mail; "E-Mail")
            {
            }
            column(CompanyHome_Page; "Home Page")
            {
            }
            column(CompanyFax_No_; "Fax No.")
            {
            }
            column(PrDate; PrDate)
            {
            }
            trigger OnAfterGetRecord()
            begin
                IF DATE2DMY(WorkDate, 2) = 12 THEN
                    PrDate := DMY2DATE(1, 1, DATE2DMY(WorkDate, 3) + 1)
                ELSE
                    PrDate := DMY2DATE(1, DATE2DMY(WorkDate, 2) + 1, DATE2DMY(WorkDate, 3));

            end;


        }
        dataitem("Tenancy"; "SVA Tenancy")
        {
            column(TNumber; Tenancy.Number)
            {
            }
            dataitem("Occupant"; "SVA Occupant")
            {
                DataItemLink = TenancyNo = FIELD(Number);

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
                    DataItemLink = Tenancies = FIELD(TenancyNo);
                    DataItemTableView = SORTING(Tenancies, Order, "Cost Types", "Date From", "Date To", KeyNumber)
                                    ORDER(Ascending)
                                    WHERE(Type = FILTER(<> 13));
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

                    column(Vatrate; Vatrate)
                    {
                    }
                    column(AmountInclVat; AmountInclVat)
                    {

                    }

                    trigger OnAfterGetRecord(); //Costtype
                    begin
                        IF ("Date To" < PrDate) AND ("Date To" <> 0D) THEN
                            CurrReport.SKIP;
                        IF ("Date From" > PrDate) then
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
                        if (Factor <> 1) and (Factor <> 0) then begin
                            "Amount Period" := "Amount Period" * Factor;
                            AmountInclVat := AmountInclVat * Factor;
                        end;
                    end;
                }

                trigger OnAfterGetRecord(); //Occupant

                begin

                    Vatrate := 1;
                    IF (EndDate < PrDate) AND (EndDate <> 0D) THEN
                        CurrReport.SKIP;
                    IF (StartDate > PrDate) THEN
                        CurrReport.SKIP;
                    IF Blocked <> 0D THEN
                        CurrReport.SKIP;
                    if FirstNets > PrDate then //FirstNets before or at invoicedate    
                        CurrReport.Skip;
                    //START enddate in the middle of invoice period mth
                    Factor := 1;
                    TenancyCard.Reset;
                    TenancyCard.SetRange(Number, TenancyNo);
                    TenancyCard.SetRange(PeriodYear, 0);
                    if TenancyCard.FindFirst then begin  //monthly subscription
                        if (Occupant.EndDate > PrDate) And (Occupant.EndDate < CalcDate('<1M-1D', PrDate)) then begin
                            SetupEstate.Reset();
                            IF SetupEstate.FindFirst() then begin
                                if SetupEstate.Splitcalc = false then
                                    Factor := 1 / 2;
                                if SetupEstate.Splitcalc = true then begin
                                    Days := CalcDate('<1M-1D>', PrDate) - PrDate + 1;
                                    Factor := Date2DMY(Occupant.EndDate, 1) / Days;
                                end;
                            end;
                        end;
                    end;
                    //END enddate in the middle of invoice period
                    TenancyCard.Reset;
                    TenancyCard.SetRange(Number, TenancyNo);
                    TenancyCard.SetRange(PeriodYear, 1, 3);
                    if TenancyCard.FindFirst then begin  //not monthly subscription
                        if TenancyCard.PeriodYear = 1 then begin //Kvartal
                            //START enddate in the middle of invoice period
                            Factor := 1;
                            if (Occupant.EndDate > PrDate) and (Occupant.EndDate < CalcDate('<3M-1D>', PrDate)) then begin
                                SetupEstate.Reset;
                                if SetupEstate.FindFirst() then begin
                                    if SetupEstate.Splitcalc = false then begin
                                        Days := (PrDate - Occupant.EndDate + 1); //qty of days paing for rent
                                        if (Days > 1) and (Days < 18) then
                                            Factor := 1 / 6;
                                        if (Days > 17) and (Days < 32) then
                                            Factor := 1 / 3;
                                        if (Days > 31) and (Days < 50) then
                                            Factor := 1 / 2;
                                        if (Days > 49) and (Days < 65) then
                                            Factor := 2 / 3;
                                        if (Days > 64) and (Days < 80) then
                                            Factor := 5 / 6;
                                        if (Days > 79) then
                                            Factor := 1
                                    end;
                                    if SetupEstate.Splitcalc = true then begin
                                        Days := CalcDate('<3M-1D>', PrDate) - PrDate + 1;
                                        Factor := (Date2DMY(Occupant.Enddate, 1) / Days);
                                    end;
                                end;
                            end;
                            //END enddate in the middle of invoice period
                            //jan,apr,jul,oct
                            if (DATE2DMY(PrDate, 2) = 1) OR (DATE2DMY(PrDate, 2) = 4) OR (DATE2DMY(PrDate, 2) = 7) OR (DATE2DMY(PrDate, 2) = 10) then begin
                                if ("Collection Month" = 1) OR ("Collection Month" = 2) OR
                                    ("Collection Month" = 4) OR ("Collection Month" = 5) OR
                                    ("Collection Month" = 7) OR ("Collection Month" = 8) OR
                                    ("Collection Month" = 10) OR ("Collection Month" = 11) then
                                    CurrReport.Skip;
                            end;

                            //feb,may,aug,nov
                            if (DATE2DMY(PrDate, 2) = 2) OR (DATE2DMY(PrDate, 2) = 5) OR (DATE2DMY(PrDate, 2) = 8) OR (DATE2DMY(PrDate, 2) = 11) then begin
                                if ("Collection Month" = 0) OR ("Collection Month" = 2) OR
                                   ("Collection Month" = 3) OR ("Collection Month" = 5) OR
                                   ("Collection Month" = 6) OR ("Collection Month" = 8) OR
                                   ("Collection Month" = 9) OR ("Collection Month" = 11) then
                                    CurrReport.Skip;
                            end;

                            //Mar,jun,sep,dec                                          
                            if (DATE2DMY(PrDate, 2) = 3) OR (DATE2DMY(PrDate, 2) = 6) OR (DATE2DMY(PrDate, 2) = 9) OR (DATE2DMY(PrDate, 2) = 12) then begin
                                if ("Collection Month" = 0) OR ("Collection Month" = 1) OR
                                   ("Collection Month" = 3) OR ("Collection Month" = 4) OR
                                   ("Collection Month" = 6) OR ("Collection Month" = 7) OR
                                   ("Collection Month" = 9) OR ("Collection Month" = 10) then
                                    CurrReport.Skip;
                            end;
                        end; //kvartal
                        if TenancyCard.PeriodYear = 2 then begin //halvår
                            if (DATE2DMY(PrDate, 2) = 1) OR (DATE2DMY(PrDate, 2) = 7) then begin
                                if ("Collection Month" = 1) OR ("Collection Month" = 2) OR
                                   ("Collection Month" = 3) OR ("Collection Month" = 4) OR
                                   ("Collection Month" = 5) OR ("Collection Month" = 7) OR
                                   ("Collection Month" = 8) OR ("Collection Month" = 9) OR
                                   ("Collection Month" = 10) OR ("Collection Month" = 11) then
                                    CurrReport.Skip;
                            end;
                            if (DATE2DMY(PrDate, 2) = 2) OR (DATE2DMY(PrDate, 2) = 8) then begin
                                if ("Collection Month" = 0) OR ("Collection Month" = 2) OR
                                   ("Collection Month" = 3) OR ("Collection Month" = 4) OR
                                   ("Collection Month" = 5) OR ("Collection Month" = 6) OR
                                   ("Collection Month" = 8) OR ("Collection Month" = 9) OR
                                   ("Collection Month" = 10) OR ("Collection Month" = 11) then
                                    CurrReport.Skip;
                            end;
                            if (DATE2DMY(PrDate, 2) = 3) OR (DATE2DMY(PrDate, 2) = 9) then begin //mar and sep
                                if ("Collection Month" = 0) OR ("Collection Month" = 1) OR //jan feb
                                   ("Collection Month" = 3) OR ("Collection Month" = 4) OR //apr may
                                   ("Collection Month" = 5) OR ("Collection Month" = 6) OR //jun jul
                                   ("Collection Month" = 7) OR ("Collection Month" = 9) OR //aug okt
                                   ("Collection Month" = 10) OR ("Collection Month" = 11) then //nov dec
                                    CurrReport.Skip;
                            end;
                            if (DATE2DMY(PrDate, 2) = 4) OR (DATE2DMY(PrDate, 2) = 10) then begin //apr okt
                                if ("Collection Month" = 0) OR ("Collection Month" = 1) OR //jan feb
                                   ("Collection Month" = 2) OR ("Collection Month" = 4) OR //mar may
                                   ("Collection Month" = 5) OR ("Collection Month" = 6) OR //jun jul
                                   ("Collection Month" = 7) OR ("Collection Month" = 8) OR //aug sep
                                   ("Collection Month" = 10) OR ("Collection Month" = 11) then //nov dec
                                    CurrReport.Skip;
                            end;
                            if (DATE2DMY(PrDate, 2) = 5) OR (DATE2DMY(PrDate, 2) = 11) then begin //may nov
                                if ("Collection Month" = 0) OR ("Collection Month" = 1) OR //jan feb
                                   ("Collection Month" = 2) OR ("Collection Month" = 3) OR //mar apr
                                   ("Collection Month" = 5) OR ("Collection Month" = 6) OR //jun jul
                                   ("Collection Month" = 7) OR ("Collection Month" = 8) OR //aug sep
                                   ("Collection Month" = 9) OR ("Collection Month" = 11) then //okt nov
                                    CurrReport.Skip;
                            end;
                            if (DATE2DMY(PrDate, 2) = 6) OR (DATE2DMY(PrDate, 2) = 12) then begin //jun dec
                                if ("Collection Month" = 0) OR ("Collection Month" = 1) OR //jan feb
                                   ("Collection Month" = 2) OR ("Collection Month" = 3) OR //mar apr
                                   ("Collection Month" = 4) OR ("Collection Month" = 6) OR //maj jul
                                   ("Collection Month" = 7) OR ("Collection Month" = 8) OR //aug sep
                                   ("Collection Month" = 9) OR ("Collection Month" = 10) then //okt nov
                                    CurrReport.Skip;
                            end;
                        end; //halvår
                        if TenancyCard.PeriodYear = 3 then begin //year
                            if (DATE2DMY(PrDate, 2)) + 1 <> "Collection Month" then
                                CurrReport.Skip;
                        end; //Year        
                    end; //Tenancy with collectionperiod <> mth
                         //Enddate in invoice period

                end;
            }
            trigger OnAfterGetRecord();
            begin
                if Tenancy.Number = '' then
                    CurrReport.skip;
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
    trigger OnPreReport()
    begin
        CompanyInfo.get;
    end;

    var
        PrDate: Date;
        Vatrate: Decimal;
        AmountInclVat: Decimal;
        Vatpostinggroup: Record "VAT Posting Setup";
        Customer: Record Customer;
        TenancyCard: record "SVA Tenancy";
        Factor: Decimal;
        SetupEstate: Record "SVA Parameters";
        Days: Integer;

}

