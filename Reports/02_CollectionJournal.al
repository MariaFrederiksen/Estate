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
            column(Headline; Headline)
            {
            }
            column(PageCaption; STRSUBSTNO(PageLbl, ''))
            {
            }
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
            column(CompanyGetVATRegistrationNumberLbl; GetVATRegistrationNumberLbl())
            {
            }
            column(CompanyPhone_No_; "Phone No.")
            {
            }
            column(COmpanyPicture; Picture)
            {
            }
            column(CompanyBankBranchNo; CompanyInformation."Bank Branch No.")
            {
            }
            column(CompanyBanAccountNo; CompanyInformation."Bank Branch No.")
            {
            }
            column(CompanyBankName; CompanyInformation."Bank Name")
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
                Headline := HeadlineLbl;
                IF DATE2DMY(WorkDate(), 2) = 12 THEN
                    PrDate := DMY2DATE(1, 1, DATE2DMY(WorkDate(), 3) + 1)
                ELSE
                    PrDate := DMY2DATE(1, DATE2DMY(WorkDate(), 2) + 1, DATE2DMY(WorkDate(), 3));
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
                            CurrReport.Skip();
                        IF ("Date From" > PrDate) then
                            CurrReport.Skip();
                        IF Type = 13 THEN //Fraflytninger
                            CurrReport.Skip();

                        Customer.Reset();
                        Customer.SetRange("No.", Occupant."Customer No");
                        if Customer.FindFirst() then begin
                            VATPostingSetup.Reset();
                            VATPostingSetup.SetRange("Vat Prod. Posting Group", "Subscription Lines".VatGroup);
                            VATPostingSetup.SetRange("VAT Bus. Posting Group", Customer."VAT Bus. Posting Group");
                            IF VATPostingSetup.FindFirst() then
                                Vatrate := 1 + (VATPostingSetup."VAT %" / 100);
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
                        CurrReport.Skip();
                    IF (StartDate > PrDate) THEN
                        CurrReport.Skip();
                    IF Blocked <> 0D THEN
                        CurrReport.Skip();
                    if FirstNets > PrDate then //FirstNets before or at invoicedate    
                        CurrReport.Skip();
                    //START enddate in the middle of invoice period mth
                    Factor := 1;
                    SVATenancy.Reset();
                    SVATenancy.SetRange(Number, TenancyNo);
                    SVATenancy.SetRange(PeriodYear, 0);
                    if SVATenancy.FindFirst() then  //monthly subscription
                        if (Occupant.EndDate > PrDate) And (Occupant.EndDate < CalcDate('<1M-1D>', PrDate)) then begin
                            SVAParameters.Reset();
                            IF SVAParameters.FindFirst() then begin
                                if SVAParameters.Splitcalc = false then
                                    Factor := 1 / 2;
                                if SVAParameters.Splitcalc = true then begin
                                    Days := CalcDate('<1M-1D>', PrDate) - PrDate + 1;
                                    Factor := Date2DMY(Occupant.EndDate, 1) / Days;
                                end;
                            end;

                        end;
                    //END enddate in the middle of invoice period
                    SVATenancy.Reset();
                    SVATenancy.SetRange(Number, TenancyNo);
                    SVATenancy.SetRange(PeriodYear, 1, 3);
                    if SVATenancy.FindFirst() then begin  //not monthly subscription
                        if SVATenancy.PeriodYear = 1 then begin //Kvartal
                            //START enddate in the middle of invoice period
                            Factor := 1;
                            if (Occupant.EndDate > PrDate) and (Occupant.EndDate < CalcDate('<3M-1D>', PrDate)) then begin
                                SVAParameters.Reset();
                                if SVAParameters.FindFirst() then begin
                                    if SVAParameters.Splitcalc = false then begin
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
                                    if SVAParameters.Splitcalc = true then begin
                                        Days := CalcDate('<3M-1D>', PrDate) - PrDate + 1;
                                        Factor := (Date2DMY(Occupant.Enddate, 1) / Days);
                                    end;
                                end;
                            end;
                            //END enddate in the middle of invoice period
                            //jan,apr,jul,oct
                            if (DATE2DMY(PrDate, 2) = 1) OR (DATE2DMY(PrDate, 2) = 4) OR (DATE2DMY(PrDate, 2) = 7) OR (DATE2DMY(PrDate, 2) = 10) then
                                if ("Collection Month" = 1) OR ("Collection Month" = 2) OR
                                    ("Collection Month" = 4) OR ("Collection Month" = 5) OR
                                    ("Collection Month" = 7) OR ("Collection Month" = 8) OR
                                    ("Collection Month" = 10) OR ("Collection Month" = 11) then
                                    CurrReport.Skip();


                            //feb,may,aug,nov
                            if (DATE2DMY(PrDate, 2) = 2) OR (DATE2DMY(PrDate, 2) = 5) OR (DATE2DMY(PrDate, 2) = 8) OR (DATE2DMY(PrDate, 2) = 11) then
                                if ("Collection Month" = 0) OR ("Collection Month" = 2) OR
                                   ("Collection Month" = 3) OR ("Collection Month" = 5) OR
                                   ("Collection Month" = 6) OR ("Collection Month" = 8) OR
                                   ("Collection Month" = 9) OR ("Collection Month" = 11) then
                                    CurrReport.Skip();


                            //Mar,jun,sep,dec                                          
                            if (DATE2DMY(PrDate, 2) = 3) OR (DATE2DMY(PrDate, 2) = 6) OR (DATE2DMY(PrDate, 2) = 9) OR (DATE2DMY(PrDate, 2) = 12) then
                                if ("Collection Month" = 0) OR ("Collection Month" = 1) OR
                                   ("Collection Month" = 3) OR ("Collection Month" = 4) OR
                                   ("Collection Month" = 6) OR ("Collection Month" = 7) OR
                                   ("Collection Month" = 9) OR ("Collection Month" = 10) then
                                    CurrReport.Skip();

                        end; //kvartal

                        if SVATenancy.PeriodYear = 2 then //halvår
                            if (DATE2DMY(PrDate, 2) = 1) OR (DATE2DMY(PrDate, 2) = 7) then
                                if ("Collection Month" = 1) OR ("Collection Month" = 2) OR
                                   ("Collection Month" = 3) OR ("Collection Month" = 4) OR
                                   ("Collection Month" = 5) OR ("Collection Month" = 7) OR
                                   ("Collection Month" = 8) OR ("Collection Month" = 9) OR
                                   ("Collection Month" = 10) OR ("Collection Month" = 11) then
                                    CurrReport.Skip();

                        if (DATE2DMY(PrDate, 2) = 2) OR (DATE2DMY(PrDate, 2) = 8) then
                            if ("Collection Month" = 0) OR ("Collection Month" = 2) OR
                               ("Collection Month" = 3) OR ("Collection Month" = 4) OR
                               ("Collection Month" = 5) OR ("Collection Month" = 6) OR
                               ("Collection Month" = 8) OR ("Collection Month" = 9) OR
                               ("Collection Month" = 10) OR ("Collection Month" = 11) then
                                CurrReport.Skip();

                        if (DATE2DMY(PrDate, 2) = 3) OR (DATE2DMY(PrDate, 2) = 9) then  //mar and sep
                            if ("Collection Month" = 0) OR ("Collection Month" = 1) OR //jan feb
                               ("Collection Month" = 3) OR ("Collection Month" = 4) OR //apr may
                               ("Collection Month" = 5) OR ("Collection Month" = 6) OR //jun jul
                               ("Collection Month" = 7) OR ("Collection Month" = 9) OR //aug okt
                               ("Collection Month" = 10) OR ("Collection Month" = 11) then //nov dec
                                CurrReport.Skip();

                        if (DATE2DMY(PrDate, 2) = 4) OR (DATE2DMY(PrDate, 2) = 10) then  //apr okt
                            if ("Collection Month" = 0) OR ("Collection Month" = 1) OR //jan feb
                               ("Collection Month" = 2) OR ("Collection Month" = 4) OR //mar may
                               ("Collection Month" = 5) OR ("Collection Month" = 6) OR //jun jul
                               ("Collection Month" = 7) OR ("Collection Month" = 8) OR //aug sep
                               ("Collection Month" = 10) OR ("Collection Month" = 11) then //nov dec
                                CurrReport.Skip();

                        if (DATE2DMY(PrDate, 2) = 5) OR (DATE2DMY(PrDate, 2) = 11) then //may nov
                            if ("Collection Month" = 0) OR ("Collection Month" = 1) OR //jan feb
                               ("Collection Month" = 2) OR ("Collection Month" = 3) OR //mar apr
                               ("Collection Month" = 5) OR ("Collection Month" = 6) OR //jun jul
                               ("Collection Month" = 7) OR ("Collection Month" = 8) OR //aug sep
                               ("Collection Month" = 9) OR ("Collection Month" = 11) then //okt nov
                                CurrReport.Skip();

                        if (DATE2DMY(PrDate, 2) = 6) OR (DATE2DMY(PrDate, 2) = 12) then //jun dec
                            if ("Collection Month" = 0) OR ("Collection Month" = 1) OR //jan feb
                               ("Collection Month" = 2) OR ("Collection Month" = 3) OR //mar apr
                               ("Collection Month" = 4) OR ("Collection Month" = 6) OR //maj jul
                               ("Collection Month" = 7) OR ("Collection Month" = 8) OR //aug sep
                               ("Collection Month" = 9) OR ("Collection Month" = 10) then //okt nov
                                CurrReport.Skip();

                        //halvår
                        if SVATenancy.PeriodYear = 3 then  //year
                            if (DATE2DMY(PrDate, 2)) - 1 <> "Collection Month" then
                                CurrReport.Skip();
                        //Year        
                    end; //Tenancy with collectionperiod <> mth
                         //Enddate in invoice period

                end;
            }
            trigger OnAfterGetRecord();
            begin
                if Tenancy.Number = '' then
                    CurrReport.Skip();
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
        CompanyInformation.GET();
    end;

    var
        VATPostingSetup: Record "VAT Posting Setup";
        CompanyInformation: Record "Company Information";
        Customer: Record Customer;
        SVATenancy: record "SVA Tenancy";
        SVAParameters: Record "SVA Parameters";
        Days: Integer;
        HeadlineLbl: Label 'Collection Journal';
        PageLbl: Label 'Page %1', Comment = '%1 = pagenumber';
        Headline: Text[30];
        PrDate: Date;
        Vatrate: Decimal;
        AmountInclVat: Decimal;
        Factor: Decimal;

}

