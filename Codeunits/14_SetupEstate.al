codeunit 50014 "SVA Setup Estate"
{
    trigger OnRun()
    var
        Noseries: Record "No. Series";
        NoSeriesLine: Record "No. Series Line";
        SVAParameters: Record "SVA Parameters";
        PaymentMethod: Record "Payment Method";
        Dimension: Record Dimension;
    begin
        Noseries.Reset();
        Noseries.Setrange(Code, OccupantNoSerieCodeLbl);
        if Noseries.IsEmpty then begin
            Noseries.Init();
            Noseries.Code := OccupantNoSerieCodeLbl;
            Noseries.Description := OccupantNoSerieDescriptionLbl;
            Noseries."Default Nos." := true;
            Noseries."Manual Nos." := false;
            Noseries."Date Order" := false;
            Noseries.Insert(true);
            NoSeriesLine.Init();
            NoSeriesLine.Reset();
            NoSeriesLine."Series Code" := OccupantNoSerieCodeLbl;
            NoSeriesLine."Line No." := 10000;
            NoSeriesLine."Starting Date" := DMY2Date(1, 1, 2020);
            NoSeriesLine."Starting No." := '80000';
            NoSeriesLine."Ending No." := '89999';
            NoSeriesLine."Increment-by No." := 1;
            NoSeriesLine.Open := true;
            NoSeriesLine.Insert();
        end;
        SVAParameters.Init();
        if SVAParameters.IsEmpty then begin
            SVAParameters.Number := '';
            SVAParameters.Insert();
        end;
        PaymentMethod.Reset();
        PaymentMethod.Setrange(Code, 'NETS');
        if PaymentMethod.IsEmpty then begin
            //Create paymentMethod
            PaymentMethod.Init();
            PaymentMethod.Code := 'NETS';
            PaymentMethod.Description := 'Nets betaling';
            PaymentMethod.Insert()
        end;
        Dimension.Reset();
        Dimension.SetRange(Code, 'Afdeling');
        if Dimension.IsEmpty then begin
            Dimension.Code := 'Afdeling';
            Dimension."Code Caption" := 'Afdeling Kode';
            Dimension."Filter Caption" := 'Afdeling Filter';
            Dimension.Name := 'Afdeling';
            Dimension.Insert();
        end;
        Dimension.Reset();
        Dimension.SetRange(Code, 'Beboer');
        if Dimension.IsEmpty then begin
            Dimension.Code := 'Beboer';
            Dimension."Code Caption" := 'Beboer Kode';
            Dimension."Filter Caption" := 'Beboer Filter';
            Dimension.Name := 'Beboer';
            Dimension.Insert();
        end;
        Dimension.Reset();
        Dimension.SetRange(Code, 'Lejemål');
        if Dimension.IsEmpty then begin
            Dimension.Code := 'Lejemål';
            Dimension."Code Caption" := 'Lejemål Kode';
            Dimension."Filter Caption" := 'Lejemål Filter';
            Dimension.Name := 'Lejemål';
            Dimension.Insert();
        end;
    end;

    var
        OccupantNoSerieCodeLbl: Label 'Beboeraftale';
        OccupantNoSerieDescriptionLbl: Label 'Beboeraftaler';

}