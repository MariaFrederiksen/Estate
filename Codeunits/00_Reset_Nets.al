codeunit 60510 "SVA Reset NETS"
{
trigger OnRun();
    begin
        IF DATE2DMY(TODAY,2) = 12 THEN BEGIN
          FromDate := DMY2DATE(1, DATE2DMY(TODAY,2)+1, DATE2DMY(TODAY,3)+1);
          END;
        IF DATE2DMY(TODAY,2) < 12 THEN BEGIN
          FromDate := DMY2DATE(1, DATE2DMY(TODAY,2)+1, DATE2DMY(TODAY,3));
          END;
        ToDate := DMY2DATE(1, DATE2DMY(TODAY,2)+1+1, DATE2DMY(TODAY,3));
        ToDate := ToDate - 1;
        
        Salesheader.reset;
        Salesheader.SETRANGE("Due Date",FromDate,ToDate);
        Salesheader.SetRange("Payment Method Code",'NETS');
        IF SalesHeader.Find('-') then begin
            repeat
            SalesHeader."SVA Send" := false;
            SalesHeader.Modify;
            until SalesHeader.Next = 0;
            end;
    end;

    var
        FromDate : Date;
        ToDate : Date;
        SalesHeader : Record "Sales Invoice Header";
}