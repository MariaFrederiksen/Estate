codeunit 50009 "SVA Reset NETS"
{
    Permissions = tabledata 112 = rimd;
    trigger OnRun();
    begin
        Codeunit.Run(Codeunit::"SVA Send");
        IF DATE2DMY(TODAY, 2) = 12 THEN
            FromDate := DMY2DATE(1, DATE2DMY(TODAY, 2) - 11, DATE2DMY(TODAY, 3) + 1);

        IF DATE2DMY(TODAY, 2) < 12 THEN
            FromDate := DMY2DATE(1, DATE2DMY(TODAY, 2) + 1, DATE2DMY(TODAY, 3));

        ToDate := CalcDate('<1m-1D>', FromDate);

        //if payment method is wrong, we fix it here
        //SVA Included is set by codeunit Create Invoices
        Customer.Reset();
        if Customer.FindSet() then
            repeat
                SalesInvoiceHeader.Reset();
                SalesInvoiceHeader.SetRange("Sell-to Customer No.", Customer."No.");
                SalesInvoiceHeader.SetRange("Due Date", FromDate, ToDate);
                SalesInvoiceHeader.Setrange("SVA Included", true);
                IF SalesInvoiceHeader.FindSet() then
                    repeat
                        if SalesInvoiceHeader."Payment Method Code" <> Customer."Payment Method Code" then begin
                            SalesInvoiceHeader."Payment Method Code" := Customer."Payment Method Code";
                            SalesInvoiceHeader.Modify();
                        end;
                    until SalesInvoiceHeader.Next() = 0;
            until Customer.Next() = 0;
        //Reset nets field "Send" from true to false
        SVAParameters.Reset();
        if SVAParameters.FindFirst() then
            PaymentMethodForNets := SVAParameters.PaymentMethodForNets;
        SalesInvoiceHeader.Reset();
        SalesInvoiceHeader.SETRANGE("Due Date", FromDate, ToDate);
        SalesInvoiceHeader.SetRange("Payment Method Code", PaymentMethodForNets);
        IF SalesInvoiceHeader.Findset() then
            repeat
                SalesInvoiceHeader."SVA Send" := false;
                SalesInvoiceHeader.Modify();
            until SalesInvoiceHeader.Next() = 0;
    end;


    var

        SalesInvoiceHeader: Record "Sales Invoice Header";
        Customer: Record Customer;
        SVAParameters: Record "SVA Parameters";
        PaymentMethodForNets: Text[20];
        FromDate: Date;
        ToDate: Date;
}