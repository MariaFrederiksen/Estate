codeunit 50002 "SVA Retrieve"
// Opsamler brugere i et givet regnskab i NAV Ejendom
// Sender den første post med det samme til web service
{
    trigger OnRun();
    begin
        LicensTable.Reset;
        LicensTable.DeleteAll;
        Companyinfo.Reset;
        If Companyinfo.FindFirst then
            RegNo := Companyinfo."VAT Registration No.";
        Users.RESET;
        Users.SETRANGE(State, 0);
        IF Users.FIND('-') THEN begin
            REPEAT
                URL := 'https://licsvane01.itoperators.dk/v3/?companyname=' + COMPANYNAME + '&license=' + RegNo + ' ' + FORMAT(Users."License Type") + '&user=' + Users."User Name";
                TempCount += 1;
                LicensTable.Key1 := TempCount;
                LicensTable.Url := URL;
                LicensTable.INSERT(true);
            UNTIL Users.NEXT = 0;
        end;
        LicensTable.Reset;
        if LicensTable.Find('-') then begin
            RequestMessage.SetRequestUri(LicensTable.Url);
            RequestMessage.Method('POST');
            Content.GetHeaders(Headers);
            Content.WriteFrom(LicensTable.Url);
            RequestMessage.Content := Content;
            MyHTTPClient.send(RequestMessage, ResponseMessage);
            LicensTable.Delete;
        end;
    end;

    var
        URL: Text[250];
        Users: Record User;
        MyHttpClient: HttpClient;
        RequestMessage: HttpRequestMessage;
        ResponseMessage: HttpResponseMessage;
        Headers: HttpHeaders;
        Content: HttpContent;
        LicensTable: Record "SVA License";
        Companyinfo: Record "Company Information";
        TempCount: Integer;
        RegNo: Text[12];

}