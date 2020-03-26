codeunit 50009 "SVA Reset NETS"
{
    Permissions = tabledata 112 = rimd;
    trigger OnRun();
    begin
        Codeunit.Run(Codeunit::"SVA Send");
        IF DATE2DMY(TODAY, 2) = 12 THEN BEGIN
            FromDate := DMY2DATE(1, DATE2DMY(TODAY, 2) - 11, DATE2DMY(TODAY, 3) + 1);
        END;
        IF DATE2DMY(TODAY, 2) < 12 THEN BEGIN
            FromDate := DMY2DATE(1, DATE2DMY(TODAY, 2) + 1, DATE2DMY(TODAY, 3));
        END;
        ToDate := CalcDate('<1m>-1D', FromDate);

        //if payment method is wrong, we fix it here
        //SVA Included is set by codeunit Create Invoices
        Customer.Reset();
        if Customer.FindSet() then
            repeat
                Salesheader.reset;
                SalesHeader.SetRange("Sell-to Customer No.", Customer."No.");
                Salesheader.SetRange("Due Date", FromDate, ToDate);
                SalesHeader.Setrange("SVA Included", true);
                IF SalesHeader.FindSet() then
                    repeat
                        if SalesHeader."Payment Method Code" <> Customer."Payment Method Code" then begin
                            SalesHeader."Payment Method Code" := Customer."Payment Method Code";
                            SalesHeader.Modify;
                        end;
                    until SalesHeader.Next = 0;
            until Customer.Next = 0;
        //Reset nets field "Send" from true to false
        Parameters.Reset();
        if Parameters.FindFirst() then
            PaymentMethodForNets := Parameters.PaymentMethodForNets;
        Salesheader.reset;
        Salesheader.SETRANGE("Due Date", FromDate, ToDate);
        Salesheader.SetRange("Payment Method Code", PaymentMethodForNets);
        IF SalesHeader.Findset() then
            repeat
                SalesHeader."SVA Send" := false;
                SalesHeader.Modify;
            until SalesHeader.Next = 0;
    end;

    var
        FromDate: Date;
        ToDate: Date;
        SalesHeader: Record "Sales Invoice Header";
        Customer: Record Customer;
        Parameters: Record "SVA Parameters";
        PaymentMethodForNets: Text[20];
        SalesHeader2: Record "Sales Invoice Header";
}