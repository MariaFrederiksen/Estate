codeunit 50002 "SVA Retrieve"
// Opsamler brugere i et givet regnskab i NAV Ejendom
// Sender den første post med det samme til web service
{
    trigger OnRun();
    begin
        SVALicense.Reset();
        SVALicense.DeleteAll();
        CompanyInformation.Reset();
        If CompanyInformation.FindFirst() then
            //RegNo := CompanyInformation."VAT Registration No.";
            RegNo := TenantId();

        User.Reset();
        User.SETRANGE(State, 0);
        IF User.Findset() THEN
            REPEAT
                SVALicense.Init();
                URL := 'https://' + 'licsvane01.itoperators.dk/v3/?companyname=' + COMPANYNAME + '&license=' + RegNo + ' ' + FORMAT(User."License Type") + '&user=' + User."User Name";
                TempCount += 1;
                SVALicense.Key1 := TempCount;
                SVALicense.Url := URL;
                SVALicense.INSERT(true);
            UNTIL User.NEXT() = 0;


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

        User: Record User;
        SVALicense: Record "SVA License";
        CompanyInformation: Record "Company Information";
        MyHttpClient: HttpClient;
        HttpRequestMessage: HttpRequestMessage;
        HttpResponseMessage: HttpResponseMessage;
        HttpHeaders: HttpHeaders;
        HttpContent: HttpContent;
        TempCount: Integer;
        RegNo: Text[40];
        URL: Text[250];

}