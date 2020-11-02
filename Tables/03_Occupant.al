table 50003 "SVA Occupant"
{
    Caption = 'Occupant';
    DataClassification = CustomerContent;
    DrillDownPageID = "SVA Occupant List";
    LookupPageID = "SVA Occupant List";

    fields
    {
        field(1; Number; Code[10])
        {
            Caption = 'Occupant';
            NotBlank = True;
        }
        field(2; PropertyNo; Code[10])
        {
            Caption = 'Property';
            TableRelation = "SVA Tenancy".PropertyNo;
            NotBlank = true;
        }
        field(3; TenancyNo; Code[10])
        {
            Caption = 'Tenancy';
            TableRelation = "SVA Tenancy".Number;

            trigger OnValidate();
            begin
                IF (TenancyNo <> xRec.TenancyNo) AND (xRec.TenancyNo <> '') then begin
                    SVAOccupantTrans.Reset();
                    SVAOccupantTrans.SetRange(Occupant, Number);
                    if SVAOccupantTrans.FindFirst() then
                        error('Der er posteringer på aftalen. Der kan ikke skiftes lejemål.');
                end;
                //Get tennacy info
                SVATenancy.Reset();
                SVATenancy.SETRANGE(SVATenancy.Number, TenancyNo);
                IF SVATenancy.FINDFIRST() THEN BEGIN
                    Address := SVATenancy.Address1;
                    Address2 := SVATenancy.Address2;
                    "Post Code" := SVATenancy."Post Code";
                    City := SVATenancy.City;
                    "Country/Region Code" := SVATenancy."Country/Region Code";
                    PropertyNo := SVATenancy.PropertyNo;
                    //Sæt forbrugskontonummer.
                    Lbno := 2;
                    ConsumptionAccountNo := TenancyNo + '0' + FORMAT(Lbno);
                    if STRPOS(ConsumptionAccountNo, '-') > 0 then
                        ConsumptionAccountNo := DELSTR(ConsumptionAccountNo, STRPOS(ConsumptionAccountNo, '-'), 1);

                    //Check for om nummeret eksisterer.
                    ListSVAOccupant.Reset();
                    ListSVAOccupant.SETRANGE(ConsumptionAccountNo, ConsumptionAccountNo);
                    IF ListSVAOccupant.Findset() THEN
                        REPEAT
                            Lbno += 2;
                            ConsumptionAccountNo := TenancyNo + '0' + FORMAT(Lbno);
                            if STRPOS(ConsumptionAccountNo, '-') > 0 then
                                ConsumptionAccountNo := DELSTR(ConsumptionAccountNo, STRPOS(ConsumptionAccountNo, '-'), 1);
                        UNTIL ListSVAOccupant.NEXT() = 0

                end;
                //dimensionen lejemål på beboer. Skal ligge her, da den har kørt Insert-triggeren.
                SVAParameters.Reset();
                IF SVAParameters.Findset() then begin
                    DefaultDimension.Reset();
                    DefaultDimension.SetRange("Table ID", 50003);
                    DefaultDimension.SetRange("No.", Number);
                    DefaultDimension.SetRange("Dimension Code", SVAParameters.Dim2);
                    IF DefaultDimension.FindFirst() then begin
                        DefaultDimension."Dimension Value Code" := TenancyNo;
                        DefaultDimension.Modify(true);
                    end else begin
                        DefaultDimension.Init();
                        DefaultDimension."Table ID" := 50003;
                        DefaultDimension."No." := Number;
                        DefaultDimension."Dimension Code" := SVAParameters.Dim2;
                        DefaultDimension."Dimension Value Code" := TenancyNo;
                        DefaultDimension."Value Posting" := 1;
                        DefaultDimension."Table Caption" := 'Lejemål på beboer';
                        DefaultDimension.Insert(true);
                    end;
                end;
                //dimension Ejendom på beboer.Skal ligge her, da den har kørt Insert-triggeren.
                SVAParameters.Reset();
                IF SVAParameters.Findset() then begin
                    DefaultDimension.Reset();
                    DefaultDimension.SetRange("Table ID", 50003);
                    DefaultDimension.SetRange("No.", Number);
                    DefaultDimension.SetRange("Dimension Code", SVAParameters.Dim1);
                    IF DefaultDimension.FindFirst() then begin
                        DefaultDimension."Dimension Value Code" := PropertyNo;
                        DefaultDimension.Modify(true);
                    end else begin
                        DefaultDimension."Table ID" := 50003;
                        DefaultDimension."No." := Number;
                        DefaultDimension."Dimension Code" := SVAParameters.Dim1;
                        DefaultDimension."Dimension Value Code" := PropertyNo;
                        DefaultDimension."Value Posting" := 1;
                        DefaultDimension."Table Caption" := 'Ejendom på beboer';
                        DefaultDimension.Insert(true);
                    end;
                end;
                //Insert har kørt før vi har ejendom og lejemål, så den skal ligge her.
                CreateDim(
                Database::"SVA Property", PropertyNo,
                Database::"SVA Tenancy", TenancyNo,
                Database::"SVA Occupant", Number);
            end;
        }
        field(4; "Customer No"; Code[10])
        {
            Caption = 'Customer No.';
            TableRelation = Customer."No.";

            trigger OnValidate();
            begin
                IF ("Customer No" <> xRec."Customer No") AND (xRec."Customer No" <> '') then begin
                    SVAOccupantTrans.Reset();
                    SVAOccupantTrans.SetRange(Occupant, Number);
                    if SVAOccupantTrans.FindFirst() then
                        error('Der er posteringer på aftalen. Der kan ikke skiftes debitor.');
                end;
                Customer.Reset();
                Customer.SETRANGE(Customer."No.", "Customer No");
                IF Customer.FINDFIRST() THEN BEGIN
                    Name1 := Customer.Name;
                    Name2 := Customer."Name 2";
                    Email1 := Customer."E-Mail";
                    Phone := Customer."Phone No.";
                END;
            end;
        }
        field(5; Name1; Text[50])
        {
            Caption = 'Name';
        }
        field(6; Name2; Text[50])
        {
            Caption = 'Name 2';
        }
        field(10; Address; Text[50])
        {
            Caption = 'Address';
        }
        field(11; Address2; Text[50])
        {
            Caption = 'Address 2';
        }
        field(12; "Post Code"; Code[10])
        {
            Caption = 'Post code';
            TableRelation = "Post Code";

            trigger OnValidate();
            begin
                Postcode.ValidatePostCode(City, "Post Code", COUNTRY, "Country/Region Code", (CurrFieldNo <> 0) AND GUIALLOWED);
            end;
        }
        field(13; City; Text[50])
        {
            Caption = 'City';
            TableRelation = IF ("Country/Region Code" = CONST()) "Post Code".City
            ELSE
            IF ("Country/Region Code" = FILTER(<> '')) "Post Code".City WHERE("Country/Region Code" = FIELD("Country/Region Code"));

            trigger OnValidate();
            begin
                Postcode.ValidateCity(City, "Post Code", COUNTRY, "Country/Region Code", (CurrFieldNo <> 0) AND GUIALLOWED);
            end;
        }
        field(14; "Country/Region Code"; Code[10])
        {
            Caption = 'Country';
            TableRelation = "Country/Region";
        }
        field(16; CPRno1; Text[10])
        {
            Caption = 'Social Securety No (1. tenant)';
        }
        field(17; CPRno2; Text[10])
        {
            Caption = 'Social Securety No (2. tenant)';
        }
        field(20; Phone; Text[20])
        {
            Caption = 'Phone';
            ExtendedDatatype = PhoneNo;
        }
        field(22; CellPhone1; Text[20])
        {
            Caption = 'Cellphone';
            ExtendedDatatype = PhoneNo;
        }
        field(23; CellPhone2; Text[20])
        {
            Caption = 'Cellphone 2';
            ExtendedDatatype = PhoneNo;
        }
        field(24; Email1; Text[80])
        {
            Caption = 'E-mail';
            ExtendedDatatype = EMail;
        }
        field(25; Email2; Text[80])
        {
            Caption = 'E-mail 2';
            ExtendedDatatype = EMail;
        }
        field(26; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(27; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(28; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
                                                          Blocked = CONST(false));

            trigger OnValidate();
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(29; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
                                                          Blocked = CONST(false));

            trigger OnValidate();
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }

        field(30; StartDate; Date)
        {
            Caption = 'Startdate';
            NotBlank = true;

            trigger OnValidate();
            var
                OccupantLocal: Record "SVA Occupant";
                TenancyLocal: Record "SVA Tenancy";
                Start: Date;
                Stop: Date;
                OK: Boolean;
                QtyOcc: Integer;
            begin
                Start := Startdate;
                Stop := EndDate;
                //Check for korrekt ledig dato på alle lejemål. Kan være for langsom ved mange poster
                TenancyLocal.Reset();
                if TenancyLocal.FindSet() then
                    repeat
                        OccupantLocal.Reset();
                        OccupantLocal.SetRange(TenancyNo, TenancyLocal.Number);
                        TenancyLocal.Vacant := true;
                        TenancyLocal.vacantDate := DMY2Date(1, 1, 1960);
                        IF OccupantLocal.FindLast() then begin
                            IF OccupantLocal.EndDate > 0D then
                                TenancyLocal.vacantDate := calcdate('<1D>', OccupantLocal.EndDate);
                            IF OccupantLocal.EndDate = 0D THEN begin
                                TenancyLocal.VacantDate := 0D;
                                TenancyLocal.Vacant := false;
                            end;
                        end;
                        TenancyLocal.Modify(true);
                    Until TenancyLocal.NEXT() = 0;
                //Check for om lejemålet er ledigt i den givne periode
                ok := false;
                SVATenancy.Reset();
                SVATenancy.SETRANGE(SVATenancy.Number, TenancyNo);
                if SVATenancy.FINDFIRST() then begin
                    OccupantLocal.Reset();
                    OccupantLocal.SetRange(TenancyNo, SVATenancy.Number);
                    if OccupantLocal.FindSet() then
                        repeat
                            if OccupantLocal.Number <> Number then begin
                                if (OccupantLocal.EndDate < Start) and (OccupantLocal.EndDate <> 0D) then
                                    ok := true; //den fundne kontrakt er udløbet.
                                if (OccupantLocal.StartDate > Stop) and (Stop > 0D) then
                                    ok := true; //den fundne kontrakt starter efter.
                                QtyOcc += 1
                            end;
                        until OccupantLocal.NEXT() = 0;
                    if (ok = true) or (qtyocc = 0) then begin
                        SVATenancy.Vacant := FALSE;
                        SVATenancy.vacantDate := 0D;
                        SVATenancy.MODIFY(TRUE);
                        ok := true;
                    end;
                end;

                if ok = false then begin
                    SVATenancy.Reset();
                    SVATenancy.SETRANGE(SVATenancy.Number, TenancyNo);
                    IF SVATenancy.FINDFIRST() THEN BEGIN
                        //Ingen opsagt dato på lejemålet
                        IF SVATenancy.vacantDate <= StartDate THEN
                            IF (SVATenancy.vacantDate = 0D) AND (SVATenancy.Vacant = FALSE) THEN BEGIN
                                MESSAGE('lejemålet er ikke ledigt.');
                                Startdate := 0D;
                            END;
                        //Opsagt dato efter nye startdato
                        IF SVATenancy.vacantDate > StartDate THEN BEGIN
                            MESSAGE('Lejemålet er ikke ledigt før ' + FORMAT(SVATenancy.vacantDate));
                            StartDate := 0D;
                        END;
                        //Lejemålet er ledigt
                        IF SVATenancy.vacantDate <= StartDate THEN  //Ledigt lejemål
                            IF SVATenancy.vacantDate <> 0D THEN BEGIN
                                SVATenancy.Vacant := FALSE;
                                SVATenancy.vacantDate := 0D;
                                SVATenancy.MODIFY(TRUE);
                                //MESSAGE('lejemål opdateret');
                            END;
                    END;
                END;
                if StartDate < Today then
                    FirstNets := CalcDate('<1M>', StartDate);
            end;
        }
        field(31; EndDate; Date)
        {
            Caption = 'Enddate';

            trigger OnValidate();
            begin
                IF EndDate > 0D THEN BEGIN
                    SVATenancy.Reset();
                    SVATenancy.SETRANGE(SVATenancy.Number, TenancyNo);
                    IF SVATenancy.FINDFIRST() THEN BEGIN
                        SVATenancy.Vacant := TRUE;
                        SVATenancy.vacantDate := EndDate + 1;
                        SVATenancy.Modify();
                    END;
                END;
                IF EndDate = 0D THEN BEGIN //Empty Date => Not vacant
                    SVATenancy.Reset();
                    SVATenancy.SETRANGE(SVATenancy.Number, TenancyNo);
                    IF SVATenancy.FindFirst() THEN BEGIN
                        SVATenancy.Vacant := FALSE;
                        SVATenancy.vacantDate := 0D;
                        SVATenancy.Modify();
                    END;
                END;
                SVACOntractregulations.Reset();
                SVACOntractregulations.SetRange(Number, Number);
                if SVACOntractregulations.FindFirst() then begin
                    SVACOntractregulations.EndDate := EndDate;
                    SVACOntractregulations.Modify();
                end;



            end;
        }
        field(32; FirstNets; Date)
        {
            Caption = 'First time for NETS';

        }
        field(33; Blocked; Date)
        {
            Caption = 'Blocked';
        }
        field(34; Bankname; Text[30])
        {
            Caption = 'Bankname';
        }
        field(35; "Bankreg-no"; Text[30])
        {
            Caption = 'Bank branch no';
        }
        field(36; BankAccount; Text[30])
        {
            Caption = 'Bankaccount';
        }
        field(37; "Collection Month"; Option)
        {
            Caption = 'Collection Month';
            OptionCaption = 'Jan,Feb,Mar,Apr,May,Jun,Jul,Aug,Sep,Oct,Nov,Dec';
            OptionMembers = jan,feb,mar,apr,may,jun,jul,aug,sep,oct,nov,dec;
        }
        field(40; ChairmanOfTheBoard; Boolean)
        {
            Caption = 'Chairmann of the Board';
        }
        field(41; BoardMember; Boolean)
        {
            Caption = 'Board member';
        }
        field(42; BoardAccountent; Boolean)
        {
            Caption = 'Board accountent';
        }
        field(43; ResidentRepresentative; Boolean)
        {
            Caption = 'ResidentRepresentative';
        }
        field(44; Type_1; Boolean)
        {
            Caption = 'Member type 1';
        }
        field(45; Type_2; Boolean)
        {
            Caption = 'Member type 2';
        }
        field(46; TypeT1; Text[10])
        {
            Caption = 'Member type 1 Description';
        }
        field(47; Type_T2; text[10])
        {
            Caption = 'Member type 2 Description';
        }

        field(50; ConsumptionAccountNo; Text[30])
        {
            Caption = 'ConsumptionAccountNo';
        }
        field(480; "Dimension Set Id"; Integer)
        {
            Caption = 'Dimension set Id';
        }
    }

    keys
    {
        key(Key1; Number)
        {
        }
        key(key2; TenancyNo)
        {
        }
        key(key3; PropertyNo, TenancyNo)
        {

        }
    }

    fieldgroups
    {
    }

    var
        PostCode: Record "Post Code";
        SVATenancy: Record "SVA Tenancy";
        Customer: Record "Customer";
        ListSVAOccupant: Record "SVA Occupant";
        SVAOccupant: Record "SVA Occupant";
        SVALeaseContractA9: Record "SVA LeaseContract_A9";
        DimensionValue: Record "Dimension Value";
        DefaultDimension: Record "Default Dimension";
        SVAParameters: Record "SVA Parameters";
        SVAOccupantTrans: Record "SVA Occupant Trans";
        SVAContractregulations: record "SVA Contract regulations";
        DimensionManagement: Codeunit "DimensionManagement";
        PaymentMethod: Text[20];
        PaymentTerms: Text[20];
        COUNTRY: Text;
        Lbno: Integer;

    trigger OnDelete();
    begin
        SVAOccupantTrans.Reset();
        SVAOccupantTrans.SetRange(Occupant, Number);
        if SVAOccupantTrans.FindFirst() then
            Error('Der findes posteringer på beboeraftalen.');


        //Tenancy is vacant
        SVATenancy.Reset();
        SVATenancy.SetRange(Number, SVAOccupant.TenancyNo);
        if SVATenancy.FindFirst() then begin
            SVATenancy.Vacant := true;

            SVAOccupant.Reset();
            SVAOccupant.SetRange(TenancyNo, Rec.TenancyNo);
            IF SVAOccupant.Findset() then
                repeat
                    SVATenancy.vacantDate := SVAOccupant.EndDate;
                until SVAOccupant.NEXT() = 0;

            IF SVATenancy.vacantDate = 0D then
                SVATenancy.vacant := false;

            SVATenancy.Modify(true);
        end; //Search SVATenancy
        //Delete Contracts
        SVALeaseContractA9.Reset();
        SVALeaseContractA9.SetRange(SVALeaseContractA9.Number, SVAOccupant.Number);
        IF SVALeaseContractA9.FindFirst() then
            SVALeaseContractA9.Delete();

    end;

    trigger OnModify();
    begin
        SVAParameters.Reset();
        if SVAParameters.FindFirst() then begin
            PaymentMethod := SVAParameters.PaymentMethodForNets;
            PaymentTerms := SVAParameters.PaymentTerms;
        end;

        //Paymentcode on customer
        Customer.Reset();
        Customer.SetRange("No.", SVAOccupant."Customer No");
        if Customer.FindFirst() then begin
            Customer."Payment Method Code" := PaymentMethod;
            Customer."Payment Terms Code" := PaymentTerms;
            Customer.Modify();
        end;
    end;

    trigger OnInsert();
    begin
        SVAParameters.Reset();
        IF SVAParameters.FindFirst() then begin
            PaymentMethod := SVAParameters.PaymentMethodForNets;
            PaymentTerms := SVAParameters.PaymentTerms;
            IF (SVAParameters.Dim1 = '') OR (SVAParameters.Dim2 = '') OR (SVAParameters.Dim3 = '') then
                Error('Dimensioner mangler opsætning. Kørslen afbrydes');

        end;
        //Paymentcode on customer
        Customer.Reset();
        Customer.SetRange("No.", SVAOccupant."Customer No");
        if Customer.FindFirst() then begin
            Customer."Payment Method Code" := PaymentMethod;
            Customer."Payment Terms Code" := PaymentTerms;
            Customer.Modify();
        end;

        //Dimension beboer på beboer
        SVAParameters.Reset();
        IF SVAParameters.FindFirst() then begin
            DefaultDimension.SetRange("Table ID", 50003);
            DefaultDimension.SetRange("Dimension Code", SVAParameters.Dim3);
            DefaultDimension.SetRange("No.", Number);
            IF DefaultDimension.FindFirst() then begin
                DefaultDimension."Dimension Code" := SVAParameters.Dim3;
                DefaultDimension."Dimension Value Code" := Number;
                DefaultDimension.Modify(true);
            end else begin
                DefaultDimension."Table ID" := 50003;
                DefaultDimension."No." := Number;
                DefaultDimension."Dimension Code" := SVAParameters.Dim3;
                DefaultDimension."Dimension Value Code" := Number;
                DefaultDimension."Value Posting" := 1;
                DefaultDimension."Table Caption" := 'Beboeraftale på beboer';
                DefaultDimension.Insert(true);
            end;
        end;
        //Dimensionsæværdi beboer
        DimensionValue.Reset();
        DimensionValue.SetRange("Dimension Code", SVAParameters.Dim3);
        DimensionValue.SetRange(Code, Number);
        if DimensionValue.FindFirst() then begin
            DimensionValue.Code := Number;
            DimensionValue.Modify(true);
        end else begin
            DimensionValue.Init();
            DimensionValue."Dimension Code" := SVAParameters.Dim3;
            DimensionValue.Code := Number;
            DimensionValue.Name := 'Beboer ' + Name1;
            DimensionValue."Dimension Value Type" := 0;
            DimensionValue.Id := CreateGuid();
            DimensionValue."Last Modified Date Time" := CurrentDateTime;
            DimensionValue.Insert(true);
        end;
    end;

    procedure CreateDim(Type1: Integer; No1: Code[20]; Type2: Integer; No2: Code[20]; Type3: Integer; No3: Code[20]);
    var
        SourceCodeSetup: Record "Source Code Setup";
        TableID: array[10] of Integer;
        No: array[10] of Code[20];
    begin
        SourceCodeSetup.GET();
        TableID[1] := Type1;
        No[1] := No1;
        TableID[2] := Type2;
        No[2] := No2;
        TableID[3] := Type3;
        No[3] := No3;
        //OnAfterCreateDimTableIDs(Rec,CurrFieldNo,TableID,No);

        "Shortcut Dimension 1 Code" := '';
        "Shortcut Dimension 2 Code" := '';
        "Dimension Set ID" := DimensionManagement.GetRecDefaultDimID(Rec, CurrFieldNo, TableID, No, SourceCodeSetup.Sales, "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code", 0, 0);
    end;

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20]);
    var
        OldDimSetID: Integer;
    begin
        OldDimSetID := 0;
        DimensionManagement.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
        IF Number <> '' THEN
            Modify();

        IF OldDimSetID <> "Dimension Set ID" THEN
            Modify();

    end;

}


