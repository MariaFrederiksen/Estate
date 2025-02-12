codeunit 50015 "SVA Import Priceindeks"
{
    trigger OnRun()
    var
        SVAPriceIndeks: Record "SVA PriceIndeks";
        Content: Text;
        httpclient: HttpClient;
        HttpResponseMessage: HttpResponseMessage;
        MyInStream: InStream;
        Get_UrlLbl: Text;
        UrlLbl: text[150];
        Month_i: Integer;
        Month: Text[2];
        Counter: Integer;
        Startdate: Date;
        ContentPart: Text;
        PriceindeksName: Text[10];
        PriceDate: Date;
        PriceRate: Decimal;
    begin
        //old indekses
        Counter := 18;
        while Counter > 1 do begin
            Startdate := CalcDate('<-' + format(Counter) + 'M>', Today);
            PriceRate := 0;
            Urllbl := format(Date2dmy(Startdate, 3)) + 'M';
            Month_i := Date2dmy(Startdate, 2);
            if Month_i < 10 then
                Month := '0' + Format(Month_i);
            if Month_i >= 10 then
                Month := Format(Month_i);
            UrlLbl := UrlLbl + Month;
            Get_UrlLbl := 'https://api.statbank.dk/v1/data/PRIS116/CSV?TID=' + UrlLbl;

            httpclient.Get(Get_UrlLbl, HttpResponseMessage);
            HttpResponseMessage.Content.ReadAs(MyInStream);
            HttpResponseMessage.Content.ReadAs(Content);
            PriceindeksName := 'Netto';
            PriceDate := DMY2Date(1, Month_i, Date2dmy(Startdate, 3));
            ContentPart := CopyStr(Content, 22, 10);
            Evaluate(PriceRate, ContentPart);
            SVAPriceIndeks.Init();
            SVAPriceIndeks.IndeksNo := PriceindeksName;
            SVAPriceIndeks.IndeksDate := PriceDate;
            SVAPriceIndeks.Indeksrate := PriceRate;
            if SVAPriceIndeks.Indeksrate <> 0 then
                if not SVAPriceIndeks.Insert() then
                    SVAPriceIndeks.Modify();
            Counter -= 1;
        end;
    end;
}