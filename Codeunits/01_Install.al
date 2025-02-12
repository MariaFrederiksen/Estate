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
        if PaymentMethod.IsEmpty then begin
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
        Codeunit.Run(Codeunit::"SVA Import Priceindeks");
    end;

    [EventSubscriber(ObjectType::Table, 1173, 'OnBeforeSaveAttachment', '', false, false)]
    local procedure AttachDocument1(FileName: Text; var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef; var TempBlob: Codeunit "Temp Blob")
    var
        FieldRef: FieldRef;
        RecNo: Code[20];

    begin

        CASE RecRef.NUMBER OF
            DATABASE::"SVA Occupant":
                BEGIN
                    FieldRef := RecRef.FIELD(1);
                    RecNo := FieldRef.VALUE;
                    DocumentAttachment.Validate("No.", RecNo);
                END;
            DATABASE::"SVA Tenancy":
                BEGIN
                    FieldRef := RecRef.FIELD(2);
                    RecNo := FieldRef.VALUE;
                    DocumentAttachment.Validate("No.", RecNo);
                END;
            Database::"SVA Property":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.Validate("No.", RecNo);
                end;
            Database::"SVA Bailiff's Outlay":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.Validate("No.", RecNo);
                end;
        END;
    end;

    [EventSubscriber(ObjectType::Page, 1174, 'OnBeforeDrillDown', '', false, false)]
    local procedure Attachment1(DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
    Var
        SVAOccupant: Record "SVA Occupant";
        SVATenancy: Record "SVA Tenancy";
        SVAProperty: Record "SVA Property";
        SVABailiffsOutlay: Record "SVA Bailiff's Outlay";

    begin
        CASE DocumentAttachment."Table ID" OF
            DATABASE::"SVA Occupant":
                begin
                    RecRef.OPEN(DATABASE::"SVA Occupant");
                    IF SVAOccupant.GET(DocumentAttachment."No.") then
                        RecRef.GETTABLE(SVAOccupant);
                end;
            DATABASE::"SVA Tenancy":
                begin
                    RecRef.OPEN(DATABASE::"SVA Tenancy");
                    IF SVATenancy.GET(DocumentAttachment."No.") then
                        RecRef.GETTABLE(SVATenancy);
                end;
            DATABASE::"SVA Property":
                begin
                    RecRef.OPEN(DATABASE::"SVA Property");
                    IF SVAProperty.GET(DocumentAttachment."No.") then
                        RecRef.GETTABLE(SVAProperty);
                end;
            DATABASE::"SVA Bailiff's Outlay":
                begin
                    RecRef.OPEN(DATABASE::"SVA Bailiff's Outlay");
                    IF SVABailiffsOutlay.GET(DocumentAttachment."No.") then
                        RecRef.GETTABLE(SVABailiffsOutlay);
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Page, 1173, 'OnAfterOpenForRecRef', '', false, false)]
    local procedure SVA_OpenForRecRef(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef; var FlowFieldsEditable: Boolean)
    var
        FieldRef: FieldRef;
        RecNo: Code[20];
    begin

        case RecRef.Number of
            DATABASE::"SVA Property":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.SetRange("No.", RecNo);
                end;
            Database::"SVA Occupant":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.SetRange("No.", RecNo);
                end;
            Database::"SVA Tenancy":
                begin
                    FieldRef := RecRef.Field(2);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.SetRange("No.", RecNo);
                end;
            Database::"SVA Bailiff's Outlay":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.SetRange("No.", RecNo);
                end;
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