codeunit 50001 "SVA Install Estate"
//Create numberserie for subscription contracts
{
    Subtype = Install;
    trigger OnInstallAppPerCompany()
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
        if Noseries.IsEmpty then begin
            //Create paymentMethod
            PaymentMethod.Init();
            PaymentMethod.Code := 'NETS';
            PaymentMethod.Description := 'Nets betaling';
            PaymentMethod.Insert()
        end;

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Company-Initialize", 'OnCompanyInitialize', '', false, false)]
    local procedure CompanyInitialize()
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
        if Noseries.IsEmpty then begin
            //Create paymentMethod
            PaymentMethod.Init();
            PaymentMethod.Code := 'NETS';
            PaymentMethod.Description := 'Nets betaling';
            PaymentMethod.Insert()
        end;
    end;


    var
        NoSeries: Record "No. Series";
        NoSeriesLine: Record "No. Series Line";
        SVAParameters: Record "SVA Parameters";
        PaymentMethod: Record "Payment Method";
        OccupantNoSerieCodeLbl: Label 'Beboeraftale';
        OccupantNoSerieDescriptionLbl: Label 'Beboeraftaler';






}