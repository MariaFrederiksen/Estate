codeunit 50009 "SVA Reset NETS"
{
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

        Salesheader.reset;
        Salesheader.SETRANGE("Due Date", FromDate, ToDate);
        Salesheader.SetRange("Payment Method Code", 'NETS');
        IF SalesHeader.Find('-') then
            repeat
                SalesHeader."SVA Send" := false;
                SalesHeader.Modify;
            until SalesHeader.Next = 0;
    end;

    var
        FromDate: Date;
        ToDate: Date;
        SalesHeader: Record "Sales Invoice Header";
}