codeunit 50003 "SVA Send"
// Sender den første post fundne post til web service
// Ligger på ejendom og beboeraftale
//Kan ikke sende flere efter hinanden.
{
    trigger OnRun();
    begin
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
        MyHttpClient: HttpClient;
        RequestMessage: HttpRequestMessage;
        ResponseMessage: HttpResponseMessage;
        Headers: HttpHeaders;
        Content: HttpContent;
        LicensTable: Record "SVA License";
}