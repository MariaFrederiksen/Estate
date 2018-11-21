codeunit 60500 "SVA Create Invoice Estate"
{
    // Opsamling af opkrævningslinjer til ordre og automatisk fakturering.
    // Hver lejeaftale opkræves med hver sin faktura.
    // Der må kun være en NETS-aftale pr. regnskab.
    // Nul-faktura ikke tilladt.

    trigger OnRun();
    begin
        Company := COMPANYNAME;
        Users.RESET;
        Users.SETRANGE(State, 0);
        IF Users.FIND('-') THEN BEGIN
            REPEAT
          //HYPERLINK('https://licsvane01.itoperators.dk/v3/?companyname='+Company+'&license='+FORMAT(Users."License Type")+'&user='+Users."Full Name");
          UNTIL Users.NEXT = 0;
        END;
        IF DATE2DMY(TODAY, 2) = 12 THEN
            InvoiceDate := DMY2DATE(1, 1, DATE2DMY(TODAY, 3) + 1)
        ELSE
            InvoiceDate := DMY2DATE(1, DATE2DMY(TODAY, 2) + 1, DATE2DMY(TODAY, 3));
        MESSAGE('Der dannes faktura pr. ' + FORMAT(InvoiceDate));

        //Test. Is there active subscriptionlines for contracts without enddate
        Ready := 0;
        Occupants.RESET;
        Occupants.SETRANGE(Occupants.StartDate, InvoiceDate - 20000, InvoiceDate); //startdate before today
        Occupants.SETRANGE(Occupants.EndDate, 0D); //No enddate
        IF Occupants.FIND('-') THEN BEGIN
            REPEAT
            Subscription.RESET;
            Subscription.SETRANGE(Subscription.Tenancies, Occupants.TenancyNo);
            IF Subscription.FIND('-') THEN BEGIN
                IF(Subscription."Date To" = 0D) OR (Subscription."Date To" > InvoiceDate) then begin
                    Ready := 1;
                end;
            end;
            UNTIL Occupants.NEXT = 0;
            IF Ready = 0 THEN BEGIN
                MESSAGE(Occupants.Number + ' mangler opkrævningslinjer. Kørslen afbrydes.');
                EXIT;
                end;  
            end;    

        //Active contracts with an enddate.
        Ready := 0;
        Occupants.RESET;
        Occupants.SETRANGE(Occupants.StartDate, InvoiceDate - 10000, InvoiceDate); //startdate before today
        Occupants.SETRANGE(Occupants.EndDate, InvoiceDate + 1, InvoiceDate + 10000);
        IF Occupants.FIND('-') THEN BEGIN
            REPEAT
            Subscription.RESET;
            Subscription.SETRANGE(Subscription.Tenancies, Occupants.TenancyNo);
            Subscription.SetRange("Date From", InvoiceDate - 20000, InvoiceDate);
            IF Subscription.FIND('-') THEN BEGIN
                IF(Subscription."Date To" = 0D) OR(Subscription."Date To" > InvoiceDate) then begin
                    Ready := 1
                    end;
                end;
            
            UNTIL Occupants.NEXT = 0;
            IF Ready = 0 THEN BEGIN
                MESSAGE(Occupants.Number + ' mangler opkrævningslinjer. Kørslen afbrydes.');
                EXIT;
                end;
            end;    
        //selve faktureringen
        MonthCollection();
        QtYrCollection();
        HalfYrCollection();
        YrCollection();

        MESSAGE('Faktureringen er afsluttet.');
    end;

    var
        Occupants: Record "SVA Occupant";
        InvoiceDate: Date;
        Subscription: Record "SVA Subscription Lines";
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        LineNo: Integer;
        CostTypeAccounts: Record "SVA Cost type";
        Ledaccount: Record "G/L Account";
        PostingCodeunitID: Integer;
        Invoice: Record "Sales Invoice Header";
        InvoiceLine: Record "Sales Invoice Line";
        OcTrans: Record "SVA Occupant trans";
        Tenancy: Record "SVA Tenancy";
        NumberMth: Integer;
        Cust: Record "Customer";
        Ready: Integer;
        OcNumber: Text[10];
        Company: Text[50];
        Users: Record "User";
        DoInvoice: Boolean;

    local procedure MakeInvoice(Month: Integer);
    begin
        //Kontrol om der er faktureret på denne dato for denne kontrakt.
        DoInvoice := true;
        Invoice.RESET;
        Invoice.SETRANGE(Invoice."Posting Date", InvoiceDate);
        Invoice.SETRANGE(Invoice."SVA Occupant", OcNumber);
        IF Invoice.FINDFIRST THEN
            DoInvoice := false;
        //Kontrol slut
        IF DoInvoice = true then begin
            //Dan ordrehoved
            SalesHeader.INIT;
            SalesHeader.VALIDATE("Document Type", SalesHeader."Document Type"::Invoice);
            SalesHeader."No." := '';
            SalesHeader."Bill-to Customer No." := Occupants."Customer No";
            SalesHeader."Bill-to Name" := Occupants.Name1;
            SalesHeader."Bill-to Address" := Occupants.Address;
            SalesHeader."Bill-to Address 2" := Occupants.Address2;
            SalesHeader."Bill-to Post Code" := Occupants."Post Code";
            SalesHeader."Bill-to City" := Occupants.City;
            SalesHeader."Bill-to Country/Region Code" := Occupants."Country/Region Code";
            SalesHeader."Sell-to Customer No." := Occupants."Customer No";
            SalesHeader."Sell-to Customer Name" := Occupants.Name1;
            SalesHeader."Sell-to Address" := Occupants.Address;
            SalesHeader."Sell-to Address 2" := Occupants.Address2;
            SalesHeader."Sell-to Post Code" := Occupants."Post Code";
            SalesHeader."Sell-to City" := Occupants.City;
            SalesHeader."Sell-to Country/Region Code" := Occupants."Country/Region Code";
            SalesHeader."Due Date" := InvoiceDate;
            SalesHeader."Posting Date" := InvoiceDate;
            SalesHeader."SVA Included" := TRUE;
            SalesHeader."SVA Occupant" := Occupants.Number;
   
            Cust.RESET;
            Cust.SETRANGE(cust."No.",Occupants."Customer No");
            IF Cust.FINDFIRST() THEN BEGIN
                SalesHeader."Payment Terms Code" := Cust."Payment Terms Code";
                SalesHeader."Currency Code" := Cust."Currency Code";
                SalesHeader."Customer Posting Group" := Cust."Customer Posting Group";
                SalesHeader."Gen. Bus. Posting Group" := Cust."Gen. Bus. Posting Group";
                SalesHeader."Payment Method Code" := Cust."Payment Method Code";
                SalesHeader."VAT Bus. Posting Group" := Cust."VAT Bus. Posting Group";
                end; //Customer

            SalesHeader.INSERT(TRUE);
        
            LineNo := 0;
            //Dan ordrelinjer
            Subscription.RESET;
            Subscription.SETRANGE(Subscription.Tenancies, Occupants.TenancyNo);
            Subscription.SetRange("Date From", InvoiceDate - 20000, InvoiceDate);
            IF Subscription.FIND('-') THEN BEGIN
                repeat
                IF(Subscription."Date To" = 0D) OR (Subscription."Date To" > InvoiceDate) then begin
                    SalesLine.INIT;
                    SalesLine.VALIDATE(SalesLine."Document Type", SalesHeader."Document Type"::Invoice);
                    SalesLine."Line No." := LineNo + 1;
                    LineNo := LineNo + 1;
                    SalesLine.Type := 1;
                    SalesLine."Document No." := SalesHeader."No.";
                    SalesLine.Quantity := 1;
                    SalesLine.Validate(Quantity);
                    SalesLine."Qty. to Ship" := 1;
                    SalesLine."Qty. to Invoice" := 1;
                    SalesLine."Unit Price" := Subscription."Amount Period";
                    SalesLine.Amount := Subscription."Amount Period" * SalesLine.Quantity;
                    SalesLine."VAT Base Amount" := Salesline.Amount;
                    SalesLine."Line Amount" := SalesLine.Amount;
                    SalesLine."Unit of Measure" := 'STK';
                    SalesLine."SVA Costtype" := Subscription."Cost Types";
                    SalesLine."VAT Prod. Posting Group" := Subscription.VatGroup;
                    SalesLine.Validate(SalesLine."VAT Prod. Posting Group");
                    SalesLine."VAT Bus. Posting Group" := SalesHeader."VAT Bus. Posting Group";
                    SalesLine.Validate(SalesLine."VAT Bus. Posting Group");
                    SalesLine."Gen. Bus. Posting Group" := SalesHeader."Gen. Bus. Posting Group";
                    SalesLine.Description := Subscription.Description;             
                                
                    CostTypeAccounts.RESET;
                    CostTypeAccounts.SETRANGE(CostTypeAccounts.Costtype, Subscription."Cost Types");
                    IF CostTypeAccounts.FINDFIRST() THEN begin
                        SalesLine."No." := CostTypeAccounts.Account;
                        SalesLine.Description := Subscription.Description;
                        IF SalesLine.Description = '' THEN
                            SalesLine.Description := CostTypeAccounts.Description;
                        end;
                    Ledaccount.RESET;
                    Ledaccount.SETRANGE(Ledaccount."No.", CostTypeAccounts.Account);
                    IF Ledaccount.FINDFIRST THEN begin
                        SalesLine."Gen. Prod. Posting Group" := Ledaccount."Gen. Prod. Posting Group";
                        end;                        
                
                    IF SalesLine.Amount <> 0 THEN
                        SalesLine.INSERT();
                    end;
                    UNTIL Subscription.NEXT = 0;

                end; //Subscription find    
 

           //Posting
           CODEUNIT.RUN(CODEUNIT::"Sales-Post", SalesHeader);

           // Opret linjerne på beboer posteringer
           Invoice.RESET;
           Invoice.SETRANGE(Invoice."Posting Date", InvoiceDate);
           Invoice.SETRANGE(Invoice."Pre-Assigned No.", SalesHeader."No.");
           Invoice.SETRANGE(Invoice."SVA Occupant", SalesHeader."SVA Occupant");
           IF Invoice.FINDFIRST THEN begin
                InvoiceLine.RESET;
                InvoiceLine.SETRANGE(InvoiceLine."Document No.", Invoice."No.");

                IF InvoiceLine.FIND('-') THEN begin 
                    REPEAT
                    OcTrans.Occupant := Invoice."SVA Occupant";
                    OcTrans.Date := Invoice."Posting Date";
                    OcTrans."Cost Type Estate" := InvoiceLine."SVA CostType";
                    OcTrans."Invoice No" := InvoiceLine."Document No.";
                    OcTrans.Description := InvoiceLine.Description;
                    OcTrans.Qty := InvoiceLine.Quantity;
                    OcTrans.Price := InvoiceLine."Unit Price";
                    OcTrans.Amount := InvoiceLine.Amount;
                    CostTypeAccounts.RESET;
                    CostTypeAccounts.SETRANGE(Costtype, OcTrans."Cost type Estate");
                    IF CostTypeAccounts.FINDFIRST() THEN
                        OcTrans.Type := CostTypeAccounts.Type;
                    OcTrans.INSERT();
                    UNTIL InvoiceLine.NEXT = 0;
                    end;
              end;
        end; //DoInvoice
    end;

    local procedure MonthCollection();
    begin
        //Month
        Tenancy.RESET;
        Tenancy.SETRANGE(Tenancy.PeriodYear, 0);
        IF Tenancy.FIND('-') THEN begin
            REPEAT
            Occupants.RESET;
            Occupants.SETRANGE(Occupants.TenancyNo, Tenancy.Number);
            Occupants.SETRANGE(Occupants.StartDate, InvoiceDate - 20000, InvoiceDate);
            Occupants.SETRANGE(Blocked, 0D);
            IF Occupants.FIND('-') THEN begin
                REPEAT
                IF Occupants.EndDate = 0D THEN begin //empty enddate
                    OcNumber := Occupants.Number;
                    MakeInvoice(1);
                end;
                IF Occupants.EndDate > InvoiceDate THEN begin
                    OcNumber := Occupants.Number;
                    MakeInvoice(1);
                end;
                UNTIL Occupants.NEXT = 0; //Occupants
            end;
            UNTIL Tenancy.NEXT = 0; //Tenancies
        end;
    end;

    local procedure QtYrCollection();
    begin
        //Quarter
        Tenancy.RESET;
        Tenancy.SETRANGE(Tenancy.PeriodYear, 1);
        IF Tenancy.FIND('-') THEN begin
            REPEAT
            Occupants.RESET;
            Occupants.SETRANGE(Occupants.TenancyNo, Tenancy.Number);
            Occupants.SETRANGE(Occupants.StartDate, InvoiceDate - 20000, InvoiceDate);
            Occupants.SETRANGE(Occupants."Collection Month", DATE2DMY(InvoiceDate, 2) - 1);//collecion mth = invoice mth.
            Occupants.SETRANGE(Blocked, 0D);
            IF Occupants.FIND('-') THEN begin
                REPEAT
                IF Occupants.EndDate = 0D THEN begin  //empty enddate
                    OcNumber := Occupants.Number;
                    MakeInvoice(1);
                end;
                IF Occupants.EndDate > InvoiceDate THEN begin
                    OcNumber := Occupants.Number;
                    MakeInvoice(1);
                end;
                UNTIL Occupants.NEXT = 0; //Occupants this month
            end;

            Occupants.RESET;
            Occupants.SETRANGE(Occupants.TenancyNo, Tenancy.Number);
            Occupants.SETRANGE(Occupants.StartDate, InvoiceDate - 10000, InvoiceDate);
            Occupants.SETRANGE(Occupants."Collection Month", DATE2DMY(InvoiceDate, 2) - 4);//collecion mth = invoice mth - 3.
            IF Occupants.FIND('-') THEN begin
                REPEAT
                IF Occupants.EndDate = 0D THEN begin //empty enddate
                    OcNumber := Occupants.Number;
                    MakeInvoice(1);
                end;
                IF Occupants.EndDate > InvoiceDate THEN begin
                    OcNumber := Occupants.Number;
                    MakeInvoice(1);
                end;
                UNTIL Occupants.NEXT = 0; //Occupants invoicemonth - 3
            end;

            Occupants.RESET;
            Occupants.SETRANGE(Occupants.TenancyNo, Tenancy.Number);
            Occupants.SETRANGE(Occupants.StartDate, InvoiceDate - 10000, InvoiceDate);
            Occupants.SETRANGE(Occupants."Collection Month", DATE2DMY(InvoiceDate, 2) - 7);//collecion mth = invoice mth - 6.
            IF Occupants.FIND('-') THEN begin
                REPEAT
                IF Occupants.EndDate = 0D THEN begin //empty enddate
                    OcNumber := Occupants.Number;
                    MakeInvoice(1);
                end;
                IF Occupants.EndDate > InvoiceDate THEN begin
                    OcNumber := Occupants.Number;
                    MakeInvoice(1);
                end;
                UNTIL Occupants.NEXT = 0; //Occupants invoicemonth - 6
            end;

            Occupants.RESET;
            Occupants.SETRANGE(Occupants.TenancyNo, Tenancy.Number);
            Occupants.SETRANGE(Occupants.StartDate, InvoiceDate - 20000, InvoiceDate);
            Occupants.SETRANGE(Occupants."Collection Month", DATE2DMY(InvoiceDate, 2) - 10);//collecion mth = invoice mth - 9.
            IF Occupants.FIND('-') THEN begin
                REPEAT
                IF Occupants.EndDate = 0D THEN begin //empty enddate
                    OcNumber := Occupants.Number;
                    MakeInvoice(1);
                end;
                IF Occupants.EndDate > InvoiceDate then begin
                    OcNumber := Occupants.Number;
                    MakeInvoice(1);
                end;
                UNTIL Occupants.NEXT = 0; //Occupants invoicemonth - 9
            end;

            Occupants.RESET;
            Occupants.SETRANGE(Occupants.TenancyNo, Tenancy.Number);
            Occupants.SETRANGE(Occupants.StartDate, InvoiceDate - 20000, InvoiceDate);
            Occupants.SETRANGE(Occupants."Collection Month", DATE2DMY(InvoiceDate, 2) + 2);//collecion mth = invoice mth + 3.
            IF Occupants.FIND('-') THEN begin
                REPEAT
                IF Occupants.EndDate = 0D THEN begin //empty enddate
                    OcNumber := Occupants.Number;
                    MakeInvoice(1);
                end;
                IF Occupants.EndDate > InvoiceDate then begin
                    OcNumber := Occupants.Number;
                    MakeInvoice(1);
                end;
                UNTIL Occupants.NEXT = 0; //Occupants invoicemonth + 3
            end;

            Occupants.RESET;
            Occupants.SETRANGE(Occupants.TenancyNo, Tenancy.Number);
            Occupants.SETRANGE(Occupants.StartDate, InvoiceDate - 20000, InvoiceDate);
            Occupants.SETRANGE(Occupants."Collection Month", DATE2DMY(InvoiceDate, 2) + 5);//collecion mth = invoice mth - 6.
            IF Occupants.FIND('-') THEN begin
                REPEAT
                IF Occupants.EndDate = 0D THEN begin //empty enddate
                    OcNumber := Occupants.Number;
                    MakeInvoice(1);
                end;
                IF Occupants.EndDate > InvoiceDate then begin
                    OcNumber := Occupants.Number;
                    MakeInvoice(1);
                end;
                UNTIL Occupants.NEXT = 0; //Occupants invoicemonth + 6
            end;

            Occupants.RESET;
            Occupants.SETRANGE(Occupants.TenancyNo, Tenancy.Number);
            Occupants.SETRANGE(Occupants.StartDate, InvoiceDate - 20000, InvoiceDate);
            Occupants.SETRANGE(Occupants."Collection Month", DATE2DMY(InvoiceDate, 2) + 8);//collecion mth = invoice mth - 6.
            IF Occupants.FIND('-') THEN begin
                REPEAT
                IF Occupants.EndDate = 0D THEN begin //empty enddate
                    OcNumber := Occupants.Number;
                    MakeInvoice(1);
                end;
                IF Occupants.EndDate > InvoiceDate then begin
                    OcNumber := Occupants.Number;
                    MakeInvoice(1);
                end;
                UNTIL Occupants.NEXT = 0; //Occupants invoicemonth + 9
            end;
            UNTIL Tenancy.NEXT = 0 //Quarter
        end;
    end;

    local procedure HalfYrCollection();
    begin
        //Half year
        Tenancy.RESET;
        Tenancy.SETRANGE(Tenancy.PeriodYear, 2);
        IF Tenancy.FIND('-') THEN begin
            REPEAT
            Occupants.RESET;
            Occupants.SETRANGE(Occupants.TenancyNo, Tenancy.Number);
            Occupants.SETRANGE(Occupants.StartDate, InvoiceDate - 20000, InvoiceDate);
            Occupants.SETRANGE(Occupants."Collection Month", DATE2DMY(InvoiceDate, 2) - 1);//collection mth = invoice mth.
            Occupants.SETRANGE(Blocked, 0D);
            IF Occupants.FIND('-') THEN begin
                REPEAT
                IF Occupants.EndDate = 0D THEN begin //empty enddate
                    OcNumber := Occupants.Number;
                    MakeInvoice(1);
                end;
                IF Occupants.EndDate > InvoiceDate THEN begin
                    OcNumber := Occupants.Number;
                    MakeInvoice(1);
                end;
                UNTIL Occupants.NEXT = 0;
            end;

            Occupants.RESET;
            Occupants.SETRANGE(Occupants.TenancyNo, Tenancy.Number);
            Occupants.SETRANGE(Occupants.StartDate, InvoiceDate - 10000, InvoiceDate);
            Occupants.SETRANGE(Occupants."Collection Month", DATE2DMY(InvoiceDate, 2) - 7);//collecion mth = invoice mth - 6.
            IF Occupants.FIND('-') THEN begin
                REPEAT
                IF Occupants.EndDate = 0D THEN begin  //empty enddate
                    OcNumber := Occupants.Number;
                    MakeInvoice(1);
                end;
                IF Occupants.EndDate > InvoiceDate THEN begin
                    OcNumber := Occupants.Number;
                    MakeInvoice(1);
                end;
                UNTIL Occupants.NEXT = 0;
            end;

            Occupants.RESET;
            Occupants.SETRANGE(Occupants.TenancyNo, Tenancy.Number);
            Occupants.SETRANGE(Occupants.StartDate, InvoiceDate - 20000, InvoiceDate);
            Occupants.SETRANGE(Occupants."Collection Month", DATE2DMY(InvoiceDate, 2) + 7);//collecion mth = invoice mth + 6.
            IF Occupants.FIND('-') THEN begin
                REPEAT
                IF Occupants.EndDate = 0D THEN begin //empty enddate
                    OcNumber := Occupants.Number;
                    MakeInvoice(1);
                end;
                IF Occupants.EndDate > InvoiceDate THEN begin
                    OcNumber := Occupants.Number;
                    MakeInvoice(1);
                end;
                UNTIL Occupants.NEXT = 0;
            end;
            UNTIL Tenancy.NEXT = 0
        end; //half-year  
    end; //procedure

    local procedure YrCollection();
    begin
        //Year
        Tenancy.RESET;
        Tenancy.SETRANGE(Tenancy.PeriodYear, 3);
        IF Tenancy.FIND('-') THEN begin
            REPEAT
            Occupants.RESET;
            Occupants.SETRANGE(Occupants.TenancyNo, Tenancy.Number);
            Occupants.SETRANGE(Occupants.StartDate, InvoiceDate - 20000, InvoiceDate);
            Occupants.SETRANGE(Occupants."Collection Month", DATE2DMY(InvoiceDate, 2) - 1);//collecion mth = invoice mth.
            Occupants.SETRANGE(Blocked, 0D);
            IF Occupants.FIND('-') THEN begin
                REPEAT
                IF Occupants.EndDate = 0D THEN begin //empty enddate
                    OcNumber := Occupants.Number;
                    MakeInvoice(1);
                end;
                IF Occupants.EndDate > InvoiceDate THEN begin
                    OcNumber := Occupants.Number;
                    MakeInvoice(1);
                end;
                UNTIL Occupants.NEXT = 0; //Occupants
            end;
            UNTIL Tenancy.NEXT = 0 //tenancies
        end; //year  
    end; //procedure
}

