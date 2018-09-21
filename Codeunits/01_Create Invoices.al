codeunit 60500 "SVA Create Invoice Estate"
{
    // Opsamling af opkrævningslinjer til ordre og automatisk fakturering.
    // Hver lejeaftale opkræves med hver sin faktura.
    // Der må kun være en NETS-aftale pr. regnskab.
    // Nul-faktura ikke tilladt.
    // 
    // Mangler:
    // Check for tidligere faktura på samme datoer
    // Læg den fakturerede ordre tilbage på beboeraftalen.


    trigger OnRun();
    begin
        IF DATE2DMY(TODAY,2) = 12 THEN
          InvoiceDate := DMY2DATE(1, 1, DATE2DMY(TODAY,3)+1)
         ELSE
          InvoiceDate := DMY2DATE(1, DATE2DMY(TODAY,2)+1, DATE2DMY(TODAY,3));
        MESSAGE('Der dannes faktura pr. '+FORMAT(InvoiceDate));

        //Test om alt er ok.
        //Kontrakter uden slutdato
        Occupants.RESET;
        Occupants.SETRANGE(Occupants.StartDate,InvoiceDate-20000,InvoiceDate); //startdate before today
        Occupants.SETRANGE(Occupants.EndDate,0D);
        IF Occupants.FIND('-') THEN BEGIN
           REPEAT
           Ready := 0;
           Subscription.RESET;
           Subscription.SETRANGE(Subscription.Tenancies,Occupants.TenancyNo);
           IF Subscription.FIND('-') THEN BEGIN
            Ready := 1
            END;
           IF Ready = 0 THEN BEGIN
            MESSAGE(Occupants.Number+' mangler opkrævningslinjer. Kørslen afbrydes.');
            EXIT;
            END;
          UNTIL Occupants.NEXT = 0;
        END;
        //Åbne, men opsagte kontrakter
        Occupants.RESET;
        Occupants.SETRANGE(Occupants.StartDate,InvoiceDate-10000,InvoiceDate); //startdate before today
        Occupants.SETRANGE(Occupants.EndDate,InvoiceDate+1,InvoiceDate+10000);
        IF Occupants.FIND('-') THEN BEGIN
           REPEAT
           Ready := 0;
           Subscription.RESET;
           Subscription.SETRANGE(Subscription.Tenancies,Occupants.TenancyNo);
           IF Subscription.FIND('-') THEN BEGIN
            Ready := 1
            END;
           IF Ready = 0 THEN BEGIN
            MESSAGE(Occupants.Number+' mangler opkrævningslinjer. Kørslen afbrydes.');
            EXIT;
            END;
          UNTIL Occupants.NEXT = 0;
        END;

        //selve faktureringen
        MonthCollection();
        QtYrCollection();
        HalfYrCollection();
        YrCollection();

        MESSAGE('Finish');
    end;

    var
        Occupants : Record "SVA Occupant";
        InvoiceDate : Date;
        Subscription : Record "SVA Subscription Lines";
        SalesHeader : Record "Sales Header";
        SalesLine : Record "Sales Line";
        LineNo : Integer;
        CostTypeAccounts : Record "SVA Cost type Estate";
        Ledaccount : Record "G/L Account";
        PostingCodeunitID : Integer;
        Invoice : Record "Sales Invoice Header";
        InvoiceLine : Record "Sales Invoice Line";
        OcTrans : Record "SVA Occupant trans";
        Tenancy : Record "SVA Tenancy";
        NumberMth : Integer;
        Cust : Record "Customer";
        Ready : Integer;
        OcNumber : Text[10];

    local procedure MakeInvoice(Month : Integer);
    begin
        //Kontrol om der er faktureret på denne dato for denne kontrakt.
        Invoice.RESET;
        Invoice.SETRANGE(Invoice."Posting Date",InvoiceDate);
        Invoice.SETRANGE(Invoice."SVA Occupant",OcNumber);
        IF Invoice.FINDFIRST THEN
          EXIT;
        //Kontrol slut

          Subscription.RESET;
          Subscription.SETRANGE(Subscription.Tenancies,Occupants.TenancyNo);
          IF Subscription.FIND('-') THEN BEGIN
            //Dan ordrehoved
            SalesHeader.INIT;
            SalesHeader.VALIDATE("Document Type",SalesHeader."Document Type"::Invoice);
            SalesHeader."No.":='';
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
            Cust.SETRANGE("Bill-to Customer No.",Occupants."Customer No");
              IF Cust.FINDFIRST() THEN BEGIN
                SalesHeader."Payment Terms Code" := Cust."Payment Terms Code";
                SalesHeader."Currency Code" := Cust."Currency Code";
                SalesHeader."Customer Posting Group" := Cust."Customer Posting Group";
                END;
            SalesHeader.INSERT(TRUE);
            END;
            LineNo := 0;
            //Dan ordrelinjer
            REPEAT
            SalesLine.INIT;
            SalesLine.VALIDATE(SalesLine."Document Type",SalesHeader."Document Type"::Invoice);
            SalesLine."Line No." := LineNo + 1;
            LineNo := LineNo + 1;
            SalesLine.Type := 1;
            SalesLine."Document No." := SalesHeader."No.";

            CostTypeAccounts.RESET;
            CostTypeAccounts.SETRANGE(CostTypeAccounts.Costtype,Subscription."Cost Types");
            IF CostTypeAccounts.FINDFIRST() THEN
              SalesLine."No." := CostTypeAccounts.Account;
            SalesLine.Description := Subscription.Description;
            IF SalesLine.Description = '' THEN
              SalesLine.Description := CostTypeAccounts.Description;
            IF CostTypeAccounts.Order <> 0 THEN
              SalesLine."Line No." := CostTypeAccounts.Order;

            SalesLine.Quantity := 1;
            SalesLine."Qty. to Ship" := 1;
            SalesLine."Qty. to Invoice" := 1;
            SalesLine."Unit Price" := Subscription."Amount Period";
            SalesLine.Amount := Subscription."Amount Period"*SalesLine.Quantity;
            SalesLine."Unit of Measure" := 'STK';
            SalesLine."SVA Costtype" := Subscription."Cost Types";
            SalesLine."VAT Prod. Posting Group" := Subscription.VatGroup;
            Ledaccount.RESET;
            Ledaccount.SETRANGE(Ledaccount."No.",CostTypeAccounts.Account);
            IF Ledaccount.FINDFIRST THEN
              SalesLine."Gen. Bus. Posting Group" := Ledaccount."Gen. Bus. Posting Group";
              SalesLine."Gen. Prod. Posting Group" := Ledaccount."Gen. Prod. Posting Group";
              //SalesLine."VAT Bus. Posting Group" := Ledaccount."VAT Bus. Posting Group";
              //SalesLine."VAT Prod. Posting Group" := Ledaccount."VAT Prod. Posting Group";

            IF SalesLine.Amount <> 0 THEN
                SalesLine.INSERT();
            UNTIL Subscription.NEXT = 0;
            //Posting
            CODEUNIT.RUN(CODEUNIT::"Sales-Post",SalesHeader);

            // Opret linjerne på beboer posteringer
            Invoice.RESET;
            Invoice.SETRANGE(Invoice."Posting Date",InvoiceDate);
            Invoice.SETRANGE(Invoice."Pre-Assigned No.",SalesHeader."No.");
            Invoice.SETRANGE(Invoice."SVA Occupant",SalesHeader."SVA Occupant");
            IF Invoice.FINDFIRST THEN
              InvoiceLine.RESET;
              InvoiceLine.SETRANGE(InvoiceLine."Document No.",Invoice."No.");
              IF InvoiceLine.FIND('-') THEN
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
                  CostTypeAccounts.SETRANGE(Costtype,OcTrans."Cost type Estate");
                  IF CostTypeAccounts.FINDFIRST() THEN
                    OcTrans.Type := CostTypeAccounts.Type;
                  OcTrans.INSERT();
                UNTIL InvoiceLine.NEXT = 0;
    end;

    local procedure MonthCollection();
    begin
        //Month
        Tenancy.RESET;
        Tenancy.SETRANGE(Tenancy.PeriodYear,0);
        IF Tenancy.FIND('-') THEN
           REPEAT
            Occupants.RESET;
            Occupants.SETRANGE(Occupants.TenancyNo,Tenancy.Number);
            Occupants.SETRANGE(Occupants.StartDate, InvoiceDate-20000,InvoiceDate);
            Occupants.SETRANGE(Blocked,0D);
            IF Occupants.FIND('-') THEN
              OcNumber := Occupants.Number;
              REPEAT
                IF Occupants.EndDate = 0D THEN  //empty enddate
                  MakeInvoice(1);
                IF Occupants.EndDate > InvoiceDate THEN
                  MakeInvoice(1);
              UNTIL Occupants.NEXT = 0;

          UNTIL Tenancy.NEXT = 0;
    end;

    local procedure HalfYrCollection();
    begin
        //Half year
         Tenancy.RESET;
         Tenancy.SETRANGE(Tenancy.PeriodYear,2);
         IF Tenancy.FIND('-') THEN
          REPEAT
            Occupants.RESET;
            Occupants.SETRANGE(Occupants.TenancyNo,Tenancy.Number);
            Occupants.SETRANGE(Occupants.StartDate,InvoiceDate-20000,InvoiceDate);
            Occupants.SETRANGE(Occupants."Collection Month",DATE2DMY(InvoiceDate,2)-1);//collection mth = invoice mth.
            Occupants.SETRANGE(Blocked,0D);
            IF Occupants.FIND('-') THEN
              OcNumber := Occupants.Number;
              REPEAT
                IF Occupants.EndDate = 0D THEN  //empty enddate
                  MakeInvoice(1);
                IF Occupants.EndDate > InvoiceDate THEN
                  MakeInvoice(1);
              UNTIL Occupants.NEXT = 0;
            Occupants.RESET;
            Occupants.SETRANGE(Occupants.TenancyNo,Tenancy.Number);
            Occupants.SETRANGE(Occupants.StartDate,InvoiceDate-10000,InvoiceDate);
            Occupants.SETRANGE(Occupants."Collection Month",DATE2DMY(InvoiceDate,2)-7);//collecion mth = invoice mth - 6.
            IF Occupants.FIND('-') THEN
              OcNumber := Occupants.Number;
              REPEAT
                IF Occupants.EndDate = 0D THEN  //empty enddate
                   MakeInvoice(1);
                IF Occupants.EndDate > InvoiceDate THEN
                   MakeInvoice(1);
              UNTIL Occupants.NEXT = 0;

            Occupants.RESET;
            Occupants.SETRANGE(Occupants.TenancyNo,Tenancy.Number);
            Occupants.SETRANGE(Occupants.StartDate,InvoiceDate-20000,InvoiceDate);
            Occupants.SETRANGE(Occupants."Collection Month",DATE2DMY(InvoiceDate,2)+7);//collecion mth = invoice mth + 6.
            IF Occupants.FIND('-') THEN
              OcNumber := Occupants.Number;
              REPEAT
                IF Occupants.EndDate = 0D THEN  //empty enddate
                   MakeInvoice(1);
                IF Occupants.EndDate > InvoiceDate THEN
                   MakeInvoice(1);
              UNTIL Occupants.NEXT = 0;
          UNTIL Tenancy.NEXT = 0
    end;

    local procedure QtYrCollection();
    begin
        //Quarter
         Tenancy.RESET;
         Tenancy.SETRANGE(Tenancy.PeriodYear,1);
         IF Tenancy.FIND('-') THEN
          REPEAT
            Occupants.RESET;
            Occupants.SETRANGE(Occupants.TenancyNo,Tenancy.Number);
            Occupants.SETRANGE(Occupants.StartDate,InvoiceDate-20000,InvoiceDate);
            Occupants.SETRANGE(Occupants."Collection Month",DATE2DMY(InvoiceDate,2)-1);//collecion mth = invoice mth.
            Occupants.SETRANGE(Blocked,0D);
            IF Occupants.FIND('-') THEN
              OcNumber := Occupants.Number;
              REPEAT
                IF Occupants.EndDate = 0D THEN  //empty enddate
                  MakeInvoice(1);
                IF Occupants.EndDate > InvoiceDate THEN
                  MakeInvoice(1);
              UNTIL Occupants.NEXT = 0;

            Occupants.RESET;
            Occupants.SETRANGE(Occupants.TenancyNo,Tenancy.Number);
            Occupants.SETRANGE(Occupants.StartDate,InvoiceDate-10000,InvoiceDate);
            Occupants.SETRANGE(Occupants."Collection Month",DATE2DMY(InvoiceDate,2)-4);//collecion mth = invoice mth - 3.
            IF Occupants.FIND('-') THEN
              REPEAT
                IF Occupants.EndDate = 0D THEN  //empty enddate
                   MakeInvoice(1);
                IF Occupants.EndDate > InvoiceDate THEN
                   MakeInvoice(1);
              UNTIL Occupants.NEXT = 0;

            Occupants.RESET;
            Occupants.SETRANGE(Occupants.TenancyNo,Tenancy.Number);
            Occupants.SETRANGE(Occupants.StartDate,InvoiceDate-10000,InvoiceDate);
            Occupants.SETRANGE(Occupants."Collection Month",DATE2DMY(InvoiceDate,2)-7);//collecion mth = invoice mth - 6.
            IF Occupants.FIND('-') THEN
              OcNumber := Occupants.Number;
              REPEAT
                IF Occupants.EndDate = 0D THEN  //empty enddate
                   MakeInvoice(1);
                IF Occupants.EndDate > InvoiceDate THEN
                   MakeInvoice(1);
              UNTIL Occupants.NEXT = 0;

            Occupants.RESET;
            Occupants.SETRANGE(Occupants.TenancyNo,Tenancy.Number);
            Occupants.SETRANGE(Occupants.StartDate,InvoiceDate-20000,InvoiceDate);
            Occupants.SETRANGE(Occupants."Collection Month",DATE2DMY(InvoiceDate,2)-10);//collecion mth = invoice mth - 9.
            IF Occupants.FIND('-') THEN
              OcNumber := Occupants.Number;
              REPEAT
                IF Occupants.EndDate = 0D THEN  //empty enddate
                   MakeInvoice(1);
                IF Occupants.EndDate > InvoiceDate THEN
                   MakeInvoice(1);
              UNTIL Occupants.NEXT = 0;

            Occupants.RESET;
            Occupants.SETRANGE(Occupants.TenancyNo,Tenancy.Number);
            Occupants.SETRANGE(Occupants.StartDate,InvoiceDate-20000,InvoiceDate);
            Occupants.SETRANGE(Occupants."Collection Month",DATE2DMY(InvoiceDate,2)+2);//collecion mth = invoice mth + 3.
            IF Occupants.FIND('-') THEN
              REPEAT
                OcNumber := Occupants.Number;
                IF Occupants.EndDate = 0D THEN  //empty enddate
                   MakeInvoice(1);
                IF Occupants.EndDate > InvoiceDate THEN
                   MakeInvoice(1);
              UNTIL Occupants.NEXT = 0;

            Occupants.RESET;
            Occupants.SETRANGE(Occupants.TenancyNo,Tenancy.Number);
            Occupants.SETRANGE(Occupants.StartDate,InvoiceDate-20000,InvoiceDate);
            Occupants.SETRANGE(Occupants."Collection Month",DATE2DMY(InvoiceDate,2)+5);//collecion mth = invoice mth - 6.
            IF Occupants.FIND('-') THEN
              OcNumber := Occupants.Number;
              REPEAT
                IF Occupants.EndDate = 0D THEN  //empty enddate
                   MakeInvoice(1);
                IF Occupants.EndDate > InvoiceDate THEN
                   MakeInvoice(1);
              UNTIL Occupants.NEXT = 0;

            Occupants.RESET;
            Occupants.SETRANGE(Occupants.TenancyNo,Tenancy.Number);
            Occupants.SETRANGE(Occupants.StartDate,InvoiceDate-20000,InvoiceDate);
            Occupants.SETRANGE(Occupants."Collection Month",DATE2DMY(InvoiceDate,2)+8);//collecion mth = invoice mth - 6.
            IF Occupants.FIND('-') THEN
              OcNumber := Occupants.Number;
              REPEAT
                IF Occupants.EndDate = 0D THEN  //empty enddate
                   MakeInvoice(1);
                IF Occupants.EndDate > InvoiceDate THEN
                   MakeInvoice(1);
              UNTIL Occupants.NEXT = 0;
          UNTIL Tenancy.NEXT = 0
    end;

    local procedure YrCollection();
    begin
        //Year
        Tenancy.RESET;
        Tenancy.SETRANGE(Tenancy.PeriodYear,3);
         IF Tenancy.FIND('-') THEN
          REPEAT
            Occupants.RESET;
            Occupants.SETRANGE(Occupants.TenancyNo,Tenancy.Number);
            Occupants.SETRANGE(Occupants.StartDate,InvoiceDate-20000,InvoiceDate);
            Occupants.SETRANGE(Occupants."Collection Month",DATE2DMY(InvoiceDate,2)-1);//collecion mth = invoice mth.
            Occupants.SETRANGE(Blocked,0D);
            IF Occupants.FIND('-') THEN
              OcNumber := Occupants.Number;
              REPEAT
                IF Occupants.EndDate = 0D THEN  //empty enddate
                  MakeInvoice(1);
                IF Occupants.EndDate > InvoiceDate THEN
                  MakeInvoice(1);
              UNTIL Occupants.NEXT = 0;
          UNTIL Tenancy.NEXT = 0
    end;
}

