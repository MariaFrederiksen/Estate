codeunit 50003 "SVA Send"
// Sender den første post fundne post til web service
// Ligger på ejendom og beboeraftale
// Kan ikke sende flere lige efter hinanden.
{
    trigger OnRun();
    begin
        SVALicense.Reset();
        if SVALicense.Findset() then begin
            HttpRequestMessage.SetRequestUri(SVALicense.Url);
            HttpRequestMessage.Method('POST');
            HttpContent.GetHeaders(HttpHeaders);
            HttpContent.WriteFrom(SVALicense.Url);
            HttpRequestMessage.Content := HttpContent;
            MyHTTPClient.send(HttpRequestMessage, HttpResponseMessage);
            SVALicense.Delete();
        end;
    end;

    var
        SVALicense: Record "SVA License";
        MyHttpClient: HttpClient;
        HttpRequestMessage: HttpRequestMessage;
        HttpResponseMessage: HttpResponseMessage;
        HttpHeaders: HttpHeaders;
        HttpContent: HttpContent;

}