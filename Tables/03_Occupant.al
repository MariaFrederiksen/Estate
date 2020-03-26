table 50003 "SVA Occupant"
{
    // Tabel 50003, Occupants
    // Tabel til håndtering af stamdata pr. beboeraftale.

    Caption = 'Occupant';
    DataClassification = CustomerContent;
    Permissions = TableData 50003 = rimd;
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
                    OccupantTrans.Reset();
                    OccupantTrans.SetRange(Occupant,Number);
                    if OccupantTrans.FindFirst() then
                        error('Der er posteringer på aftalen. Der kan ikke skiftes lejemål.');
                end;
                //Get tennacy info
                Tenancy.RESET;
                Tenancy.SETRANGE(Tenancy.Number, TenancyNo);
                IF Tenancy.FINDFIRST() THEN BEGIN
                    Address := Tenancy.Address1;
                    Address2 := Tenancy.Address2;
                    "Post Code" := Tenancy."Post Code";
                    City := Tenancy.City;
                    "Country/Region Code" := Tenancy."Country/Region Code";
                    PropertyNo := Tenancy.PropertyNo;
                    //Sæt forbrugskontonummer.
                    Lbno := 2;
                    ConsumptionAccountNo := TenancyNo + '0' + FORMAT(Lbno);
                    if STRPOS(ConsumptionAccountNo, '-') > 0 then begin
                        ConsumptionAccountNo := DELSTR(ConsumptionAccountNo, STRPOS(ConsumptionAccountNo, '-'), 1);
                    end;
                    //Check for om nummeret eksisterer.
                    OccupantList.RESET;
                    OccupantList.SETRANGE(ConsumptionAccountNo, ConsumptionAccountNo);
                    IF OccupantList.FIND('-') THEN BEGIN
                        REPEAT
                            Lbno += 2;
                            ConsumptionAccountNo := TenancyNo + '0' + FORMAT(Lbno);
                            if STRPOS(ConsumptionAccountNo, '-') > 0 then begin
                                ConsumptionAccountNo := DELSTR(ConsumptionAccountNo, STRPOS(ConsumptionAccountNo, '-'), 1);
                            end;
                        UNTIL OccupantList.NEXT = 0
                    END;
                end;
                //dimensionen lejemål på beboer. Skal ligge her, da den har kørt Insert-triggeren.
                Parameters.Reset;
                IF Parameters.Find('-') then begin
                    DefaultDim.Reset;
                    DefaultDim.SetRange("Table ID", 50003);
                    DefaultDim.SetRange("No.", Number);
                    DefaultDim.SetRange("Dimension Code", Parameters.Dim2);
                    IF DefaultDim.FindFirst then begin
                        DefaultDim."Dimension Value Code" := TenancyNo;
                        DefaultDim.Modify(true);
                    end else begin
                        DefaultDim."Table ID" := 50003;
                        DefaultDim."No." := Number;
                        DefaultDim."Dimension Code" := Parameters.Dim2;
                        DefaultDim."Dimension Value Code" := TenancyNo;
                        DefaultDim."Value Posting" := 1;
                        DefaultDim."Table Caption" := 'Lejemål på beboer';
                        DefaultDim.Insert(true);
                    end;
                end;
                //dimension Ejendom på beboer.Skal ligge her, da den har kørt Insert-triggeren.
                Parameters.Reset;
                IF Parameters.Find('-') then begin
                    DefaultDim.Reset;
                    DefaultDim.SetRange("Table ID", 50003);
                    DefaultDim.SetRange("No.", Number);
                    DefaultDim.SetRange("Dimension Code", Parameters.Dim1);
                    IF DefaultDim.FindFirst then begin
                        DefaultDim."Dimension Value Code" := PropertyNo;
                        DefaultDim.Modify(true);
                    end else begin
                        DefaultDim."Table ID" := 50003;
                        DefaultDim."No." := Number;
                        DefaultDim."Dimension Code" := Parameters.Dim1;
                        DefaultDim."Dimension Value Code" := PropertyNo;
                        DefaultDim."Value Posting" := 1;
                        DefaultDim."Table Caption" := 'Ejendom på beboer';
                        DefaultDim.Insert(true);
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
                    OccupantTrans.Reset();
                    OccupantTrans.SetRange(Occupant,Number);
                    if OccupantTrans.FindFirst() then
                        error('Der er posteringer på aftalen. Der kan ikke skiftes debitor.');
                end;
                Custcard.RESET;
                Custcard.SETRANGE(Custcard."No.", "Customer No");
                IF Custcard.FINDFIRST() THEN BEGIN
                    Name1 := Custcard.Name;
                    Name2 := Custcard."Name 2";
                    Email1 := Custcard."E-Mail";
                    Phone := Custcard."Phone No.";
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
                TenancyLocal.reset;
                if TenancyLocal.FindSet then
                    repeat
                        OccupantLocal.reset;
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
                    Until TenancyLocal.Next = 0;
                //Check for om lejemålet er ledigt i den givne periode
                ok := false;
                TenancyCard.RESET;
                TenancyCard.SETRANGE(TenancyCard.Number, TenancyNo);
                if TenancyCard.FINDFIRST() then begin
                    OccupantLocal.reset;
                    OccupantLocal.SetRange(TenancyNo, TenancyCard.Number);
                    if OccupantLocal.FindSet then
                        repeat
                            if OccupantLocal.Number <> Number then begin
                                if (OccupantLocal.EndDate < Start) and (OccupantLocal.EndDate <> 0D) then
                                    ok := true; //den fundne kontrakt er udløbet.
                                if (OccupantLocal.StartDate > Stop) and (Stop > 0D) then
                                    ok := true; //den fundne kontrakt starter efter.
                                QtyOcc += 1
                            end;
                        until OccupantLocal.Next = 0;
                    if (ok = true) or (qtyocc = 0) then begin
                        TenancyCard.Vacant := FALSE;
                        TenancyCard.vacantDate := 0D;
                        TenancyCard.MODIFY(TRUE);
                        ok := true;
                    end;
                end;

                if ok = false then begin
                    TenancyCard.RESET;
                    TenancyCard.SETRANGE(TenancyCard.Number, TenancyNo);
                    IF TenancyCard.FINDFIRST() THEN BEGIN
                        //Ingen opsagt dato på lejemålet
                        IF TenancyCard.vacantDate <= StartDate THEN
                            IF (TenancyCard.vacantDate = 0D) AND (TenancyCard.Vacant = FALSE) THEN BEGIN
                                MESSAGE('lejemålet er ikke ledigt.');
                                Startdate := 0D;
                            END;
                        //Opsagt dato efter nye startdato
                        IF TenancyCard.vacantDate > StartDate THEN BEGIN
                            MESSAGE('Lejemålet er ikke ledigt før ' + FORMAT(TenancyCard.vacantDate));
                            StartDate := 0D;
                        END;
                        //Lejemålet er ledigt
                        IF TenancyCard.vacantDate <= StartDate THEN BEGIN //Ledigt lejemål
                            IF TenancyCard.vacantDate <> 0D THEN BEGIN
                                TenancyCard.Vacant := FALSE;
                                TenancyCard.vacantDate := 0D;
                                TenancyCard.MODIFY(TRUE);
                                //MESSAGE('lejemål opdateret');
                            END;
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
                    TenancyCard.RESET;
                    TenancyCard.SETRANGE(TenancyCard.Number, TenancyNo);
                    IF TenancyCard.FINDFIRST() THEN BEGIN
                        TenancyCard.Vacant := TRUE;
                        TenancyCard.vacantDate := EndDate + 1;
                        TenancyCard.MODIFY;
                    END;
                END;
                IF EndDate = 0D THEN BEGIN //Empty Date => Not vacant
                    TenancyCard.RESET;
                    TenancyCard.SETRANGE(TenancyCard.Number, TenancyNo);
                    IF TenancyCard.FINDFIRST THEN BEGIN
                        TenancyCard.Vacant := FALSE;
                        TenancyCard.vacantDate := 0D;
                        TenancyCard.MODIFY;
                    END;
                END;
                ConReg.Reset;
                Conreg.SetRange(Number, Number);
                if ConReg.FindFirst then begin
                    ConReg.EndDate := EndDate;
                    ConReg.Modify;
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
        Postcode: Record "Post Code";
        COUNTRY: Text;
        TenancyCard: Record "SVA Tenancy";
        Tenancy: Record "SVA Tenancy";
        Custcard: Record "Customer";
        OccupantList: Record "SVA Occupant";
        Lbno: Integer;
        Occupant: Record "SVA Occupant";
        TypeA9: Record "SVA LeaseContract_A9";
        DimensionValue: Record "Dimension Value";
        DefaultDim: Record "Default Dimension";
        Parameters: Record "SVA Parameters";
        Dimmgt: Codeunit "DimensionManagement";
        OccupantTrans: Record "SVA Occupant Trans";
        ConReg: record "SVA Contract regulations";
        PaymentMethod: Text[20];
        PaymentTerms: Text[20];

    trigger OnDelete();
    begin
        OccupantTrans.Reset;
        OccupantTrans.SetRange(Occupant, Number);
        if OccupantTrans.FindFirst then begin
            Error('Der findes posteringer på beboeraftalen.')
        end;

        //Tenancy is vacant
        TenancyCard.Reset;
        TenancyCard.SetRange(Number, Occupant.TenancyNo);
        if TenancyCard.FindFirst then begin
            TenancyCard.Vacant := true;

            Occupant.Reset;
            Occupant.SetRange(TenancyNo, Rec.TenancyNo);
            IF Occupant.Find('-') then begin
                repeat
                    TenancyCard.vacantDate := Occupant.EndDate;
                until Occupant.Next = 0;
            end;
            IF TenancyCard.vacantDate = 0D then begin
                TenancyCard.vacant := false;
            end;
            TenancyCard.Modify(true);
        end; //Search tenancycard
        //Delete Contracts
        TypeA9.Reset;
        TypeA9.SetRange(TypeA9.Number, Occupant.Number);
        IF TypeA9.FindFirst() then begin
            TypeA9.Delete;
        end;
    end;

    trigger OnModify();
    begin
        Parameters.Reset;
        if Parameters.FindFirst() then begin
            PaymentMethod := Parameters.PaymentMethodForNets;
            PaymentTerms := Parameters.PaymentTerms;
        end;

        //Paymentcode on customer
        Custcard.Reset;
        Custcard.SetRange("No.", Occupant."Customer No");
        if Custcard.FindFirst then begin
            Custcard."Payment Method Code" := PaymentMethod;
            Custcard."Payment Terms Code" := PaymentTerms;
            Custcard.Modify;
        end;
    end;

    trigger OnInsert();
    begin
        Parameters.Reset;
        IF Parameters.FindFirst() then begin
            PaymentMethod := Parameters.PaymentMethodForNets;
            PaymentTerms := Parameters.PaymentTerms;
            IF (Parameters.Dim1 = '') OR (Parameters.Dim2 = '') OR (Parameters.Dim3 = '') then begin
                Error('Dimensioner mangler opsætning. Kørslen afbrydes');
            end;
        end;
        //Paymentcode on customer
        Custcard.Reset;
        Custcard.SetRange("No.", Occupant."Customer No");
        if Custcard.FindFirst then begin
            Custcard."Payment Method Code" := PaymentMethod;
            Custcard."Payment Terms Code" := PaymentTerms;
            Custcard.Modify;
        end;

        //Dimension beboer på beboer
        Parameters.Reset;
        IF Parameters.FindFirst then begin
            DefaultDim.SetRange("Table ID", 50003);
            DefaultDim.SetRange("Dimension Code", Parameters.Dim3);
            DefaultDim.SetRange("No.", Number);
            IF DefaultDim.FindFirst then begin
                DefaultDim."Dimension Code" := Parameters.Dim3;
                DefaultDim."Dimension Value Code" := Number;
                DefaultDim.Modify(true);
            end else begin
                DefaultDim."Table ID" := 50003;
                DefaultDim."No." := Number;
                DefaultDim."Dimension Code" := Parameters.Dim3;
                DefaultDim."Dimension Value Code" := Number;
                DefaultDim."Value Posting" := 1;
                DefaultDim."Table Caption" := 'Beboeraftale på beboer';
                DefaultDim.Insert(true);
            end;
        end;
        //Dimensionsæværdi beboer
        DimensionValue.Reset;
        DimensionValue.SetRange("Dimension Code", Parameters.Dim3);
        DimensionValue.SetRange(Code, Number);
        if DimensionValue.FindFirst then begin
            DimensionValue.Code := Number;
            DimensionValue.Modify(true);
        end else begin
            DimensionValue.Init;
            DimensionValue."Dimension Code" := Parameters.Dim3;
            DimensionValue.Code := Number;
            DimensionValue.Name := 'Beboer ' + Name1;
            DimensionValue."Dimension Value Type" := 0;
            DimensionValue.Id := CreateGuid;
            DimensionValue."Last Modified Date Time" := CurrentDateTime;
            DimensionValue.Insert(true);
        end;

    end;

    procedure CreateDim(Type1: Integer; No1: Code[20]; Type2: Integer; No2: Code[20]; Type3: Integer; No3: Code[20]);
    var
        SourceCodeSetup: Record "Source Code Setup";
        TableID: array[10] of Integer;
        No: array[10] of Code[20];
        OldDimSetID: Integer;
    begin
        SourceCodeSetup.GET;
        TableID[1] := Type1;
        No[1] := No1;
        TableID[2] := Type2;
        No[2] := No2;
        TableID[3] := Type3;
        No[3] := No3;
        //OnAfterCreateDimTableIDs(Rec,CurrFieldNo,TableID,No);

        "Shortcut Dimension 1 Code" := '';
        "Shortcut Dimension 2 Code" := '';
        OldDimSetID := "Dimension Set ID";
        "Dimension Set ID" := DimMgt.GetRecDefaultDimID(Rec, CurrFieldNo, TableID, No, SourceCodeSetup.Sales, "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code", 0, 0);
    end;

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20]);
    var
        OldDimSetID: Integer;
    begin
        OldDimSetID := "Dimension Set ID";
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
        IF Number <> '' THEN
            MODIFY;

        IF OldDimSetID <> "Dimension Set ID" THEN BEGIN
            MODIFY;
        END;
    end;

}


