page 50009 "SVA Occupant Card"
//Tooltip created
{
    Caption = 'Occupants';
    PageType = Card;
    SourceTable = "SVA Occupant";

    layout
    {
        area(content)
        {
            group(Generelt)
            {
                Caption = 'General';
                field("Customer No"; "Customer No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Costumer no. from customer table.';
                }
                field(TenancyNo; TenancyNo)
                {
                    ApplicationArea = All;
                    ToolTip = 'The tenancy, the customer rents';
                }
                field(startdate; StartDate)
                {
                    ApplicationArea = All;
                    ToolTip = 'Startdate of the contract.';
                }
                field("Collection Month"; "Collection Month")
                {
                    ApplicationArea = All;
                    ToolTip = 'Collection month. Importen when the collecion period is quarter, halfyear or year';
                }
                field(FirstNets; FirstNets)
                {
                    ApplicationArea = All;
                    ToolTip = 'First time to NETS. Can be left blank';
                }
                field(Name1; Name1)
                {
                    ApplicationArea = All;
                    ToolTip = 'Tenants full name';
                }
                field(Name2; Name2)
                {
                    ApplicationArea = All;
                    ToolTip = 'Second tenants name';
                }
                field(Address; Address)
                {
                    ApplicationArea = All;
                    ToolTip = 'Invoice address';
                }
                field(Address2; Address2)
                {
                    ApplicationArea = All;
                    ToolTip = 'Invoice address 2';
                }
                field("Post Code"; "Post Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Invoice post code';
                }
                field(City; City)
                {
                    ApplicationArea = All;
                    ToolTip = 'Invoice city';
                }
                field("Country/Region Code"; "Country/Region Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Invoice Country code';
                }
                field(Email1; Email1)
                {
                    ApplicationArea = All;
                    ToolTip = 'Tenants email';
                }
                field(Email2; Email2)
                {
                    ApplicationArea = All;
                    ToolTip = 'Second email';
                }
                field(Phone; Phone)
                {
                    ApplicationArea = All;
                    ToolTip = 'Tenants phone no.';
                }
                field(CellPhone1; CellPhone1)
                {
                    ApplicationArea = All;
                    ToolTip = 'Tenants cellphone no.';
                }
                field(CellPhone2; CellPhone2)
                {
                    ApplicationArea = All;
                    ToolTip = 'Tenants cellphone no.';
                }
                field(CPRno1; CPRno1)
                {
                    ApplicationArea = All;
                    ToolTip = 'Tenants security no.';
                }
                field(CPRno2; CPRno2)
                {
                    ApplicationArea = All;
                    ToolTip = 'Second Tenants social security no.';
                }
                field(EndDate; EndDate)
                {
                    ApplicationArea = All;
                    ToolTip = 'The date this contract expire';
                }

                field(ConsumptionAccountNo; ConsumptionAccountNo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Tenants consumption account no.';
                }
                field(Blocked; Blocked)
                {
                    ApplicationArea = All;
                    ToolTip = 'Blocked date';
                }
            }
            group("Div. oplysniger")
            {
                Caption = 'Mis. information';
                field(ChairmanOfTheBoard; ChairmanOfTheBoard)
                {
                    ApplicationArea = All;
                    ToolTip = 'Is tenant chairman of the board? Not relevant if the tenancy is rented';
                }
                field(BoardMember; BoardMember)
                {
                    ApplicationArea = All;
                    ToolTip = 'Is tenant member of the board? Not relevant if the tenancy is rented';
                }
                field(BoardAccountent; BoardAccountent)
                {
                    ApplicationArea = All;
                    ToolTip = 'Is tenant accountant of the board? Not relevant if the tenancy is rented';
                }
                field(ResidentRepresentative; ResidentRepresentative)
                {
                    ApplicationArea = All;
                    ToolTip = 'Is tenant Residents representative? Only relevant if the tenancy is rented';
                }
                field(Type_1; Type_1)
                {
                    ApplicationArea = All;
                    Tooltip = 'Is tenant grp 1?';
                }
                field(TypeT1; TypeT1)
                {
                    ApplicationArea = All;
                    Tooltip = 'Description grp. 1';
                }

                field(Type_2; Type_2)
                {
                    ApplicationArea = All;
                    Tooltip = 'Is tenant grp 2?';
                }
                field(Type_T2; Type_T2)
                {
                    ApplicationArea = All;
                    Tooltip = 'Description grp. 2';
                }
            }
            part("Subscription lines"; "SVA Subscription lines subform")
            {
                Caption = 'Subscription lines';
                Tooltip = 'Subscription lines for this contract.';
                ApplicationArea = All;
                SubPageLink = Tenancies = FIELD (TenancyNo);
                SubPageView = SORTING (Tenancies, "Date To")
                              ORDER(Ascending);
            }
            part("Occupant transactions"; "SVA Occupant Trans Subform")
            {
                Caption = 'Occupant Trans';
                Tooltip = 'Occupant trans for this contract.';
                ApplicationArea = All;
                SubPageLink = Occupant = FIELD (Number);
                SubPageView = SORTING (Occupant, Date, "Cost type Estate", "Invoice No");
            }
        }
        area(factboxes)
        {
            systempart(Notes; Notes)
            {
            }
            systempart(Links; Links)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Kontrakter)
            {
                Caption = 'Contracts';
                action(LeasContractA9)
                {
                    ApplicationArea = All;
                    Caption = 'Leasecontract Type A, 9. edistion';
                    Tooltip = 'Go to leasecontract type A, 9. edition for filling';
                    Image = MakeAgreement;
                    RunObject = Page "SVA Leasecontract_A9";
                    RunPageLink = Number = FIELD (Number);
                    RunPageMode = Edit;
                    RunPageOnRec = false;
                }
                action(LeasContractGarage)
                {
                    ApplicationArea = All;
                    Caption = 'Leasecontract for garage';
                    Tooltip = 'Go to leasecontract for garage for filling';
                    Image = MakeAgreement;
                    RunObject = Page "SVA Leasecontract_Garage";
                    RunPageLink = Number = FIELD (Number);
                    RunPageMode = Edit;
                }
                action(LeaseBusiness)
                {
                    ApplicationArea = All;
                    Caption = 'Lease Business';
                    Tooltip = 'Go to lease business for invoicing of moving in costs';
                    Image = MakeAgreement;
                    RunObject = Page "SVA Lease Business";
                    RunPageLink = Number = FIELD (Number);
                    RunPageMode = Edit;
                }
            }
            group(reguleringer)
            {
                Caption = 'Regulations';
                action(Regulations)
                {
                    ApplicationArea = All;
                    Caption = 'Agreed regulation of rent';
                    Tooltip = 'Contract conditions for regulations';
                    Image = MakeAgreement;
                    RunObject = Page "SVA Subscription regulations";
                    RunPageLink = Number = FIELD (Number);
                    RunPageMode = Edit;
                    RunPageOnRec = false;
                }
            }
            group(Moving)
            {
                Caption = 'Moving in or out';
                action(MovingIn)
                {
                    ApplicationArea = All;
                    Caption = 'Moving in inspection';
                    Tooltip = 'Go to moving in status for filling';
                    Image = MakeAgreement;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "SVA MoveIn";
                    RunPageLink = Occupant = FIELD (Number);
                    RunPageMode = Edit;
                }
                action(MovingOut)
                {
                    ApplicationArea = All;
                    Caption = 'Moving out inspection';
                    Tooltip = 'Go to moving out status for filling';
                    Image = MakeAgreement;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "SVA MoveOut";
                    RunPageLink = Occupant = FIELD (Number);
                    RunPageMode = Edit;
                }
                 action(MovingOutJournal)
            {
                ApplicationArea = All;
                Caption = 'Journal for moving out invoice';
                ToolTip = 'Journal for moving out invoice. Use before making an invoice.';
                Image = Report;

                trigger OnAction();
                begin
                    CLEAR(Occupant);
                    Occupant.SETRANGE(Number, Rec.Number);
                    CLEAR(MoveOutJournal);
                    MoveOutJournal.SETTABLEVIEW(Occupant);
                    MoveOutJournal.RUNMODAL;
                end;
            }
            action(MovingOutInvoice)
            {
                ApplicationArea = All;
                Caption = 'Invoice Moving out';
                Tooltip = 'Make a moving out invoice based on transactions and subscription lines.';
                Image = Report;

                trigger OnAction();
                begin
                    OccNo := Rec.Number;
                    CalcInvoiceCredit;
                    If InvoiceCreditmemo = false then
                        MakeCreditmemo;
                    If InvoiceCreditmemo = true then
                        MakeInvoice;
                    Posting;
                end;
            }
            }
            Group(Letters)
            {
                Caption = 'Letters';
            action(DemandNotice)
            {
                ApplicationArea = All;
                Caption = 'Demand Notice';
                Tooltip = 'The formal demand notice';
                Image = Reminder;

                trigger OnAction();
                begin
                    Clear(TenancyCard);
                    TenancyCard.SetRange(number, Rec.TenancyNo);
                    IF TenancyCard.Type = 0 then begin //bolig
                        CLEAR(Occupant);
                        Occupant.SETRANGE(Number, Rec.Number);
                        CLEAR(DemandNoticeResidens);
                        DemandNoticeResidens.SETTABLEVIEW(Occupant);
                        DemandNoticeResidens.RUNMODAL;
                    END;
                    IF TenancyCard.Type = 1 then begin //erhverv
                        CLEAR(Occupant);
                        Occupant.SETRANGE(Number, Rec.Number);
                        CLEAR(DemandNoticeProf);
                        DemandNoticeProf.SETTABLEVIEW(Occupant);
                        DemandNoticeProf.RUNMODAL;
                    END;
                end;
            }
            action(Repeal)
            {
                ApplicationArea = All;
                Caption = 'Repeal';
                Tooltip = 'Letter for repeal the tenant';
                Image = Report;

                trigger OnAction();
                begin
                    Clear(TenancyCard);
                    TenancyCard.SetRange(number, Rec.TenancyNo);
                    IF TenancyCard.Type = 0 then begin //bolig
                        CLEAR(Occupant);
                        Occupant.SETRANGE(Number, Rec.Number);
                        CLEAR(RepealR);
                        RepealR.SETTABLEVIEW(Occupant);
                        RepealR.RUNMODAL;
                    END;
                    IF TenancyCard.Type = 1 then begin //erhverv
                        CLEAR(Occupant);
                        Occupant.SETRANGE(Number, Rec.Number);
                        CLEAR(RepealP);
                        RepealP.SETTABLEVIEW(Occupant);
                        RepealP.RUNMODAL;
                    END;
                end;
            }
            }
           

        }
        area(Navigation)
        {
            action(Dimensioner)
            {
                ApplicationArea = All;
                Caption = 'Dimensions';
                Image = Dimensions;
                RunObject = Page "Default Dimensions";
                RunPageLink = "Table ID" = CONST (50003),
                                  "No." = FIELD (Number);
                ShortCutKey = 'Shift+Ctrl+D';
                ToolTip = 'View or edits dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';
            }
        }

    }
    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        Occupant.Init;
        EstateSetup.Reset;
        IF EstateSetup.FindFirst then begin
            Number := NoSeriesMgt.GetNextNo(EstateSetup.Numberserie, WORKDATE, TRUE);
        end;
        IF Number = '' then begin
            Error('Nummerserie er ikke opsat. Kørslen afbrydes');
        end;
    end;

    trigger OnDeleteRecord(): Boolean;
    begin
        OCtrans.Reset;
        OcTrans.SetRange(Octrans.Occupant, rec.Number);
        IF OcTrans.FindFirst() then begin
            Error('Kontrakten kan ikke slettes, da der er posteringer.')
        end;
    end;

    trigger OnClosePage();
    begin
        Codeunit.Run(Codeunit::"SVA Send");
    end;

    var
        TenancyCard: Record "SVA Tenancy";
        Custcard: Record "Customer";
        Property: Record "SVA Property";
        Occupant: Record "SVA Occupant";
        PageTypeA9: Record "SVA LeaseContract_A9";
        NoSeriesMgt: Codeunit "NoSeriesManagement";
        NoSeries: Record "No. Series";
        EstateSetup: Record "SVA Parameters";
        Occ: Record "SVA Occupant";
        Salesheader: Record "Sales header";
        SalesLine: Record "Sales Line";
        Invoice: Record "Sales Invoice Header";
        InvoiceLine: Record "Sales Invoice Line";
        Contract: Record "SVA LeaseContract_A9";
        LineNo: Integer;
        CostTypeEstate: Record "SVA Cost Type";
        Ledaccount: Record "G/L Account";
        OcTrans: Record "SVA Occupant Trans";
        DemandNoticeResidens: Report "SVA DemandNoticeResidence";
        MoveOutJournal: Report "SVA Moving out Journal";
        SubLines: Record "SVA Subscription Lines";
        OccupantInvoice: Record "SVA Occupant";
        Tenancy: Text[10];
        InvoiceCreditmemo: Boolean;
        InvAmount: Decimal;
        OccNo: Code[10];
        DemandNoticeProf: Report "SVA DemandNoticeProf";
        RepealP: report "SVA Repeal Prof";
        RepealR: report "SVA Repeal Res";
        Custaccount: Text[10];


    local procedure CalcInvoiceCredit();
    begin
        CLEAR(OccupantInvoice);
        OccupantInvoice.SETRANGE(Number, Rec.Number);
        IF OccupantInvoice.FINDFIRST() THEN BEGIN
            Tenancy := TenancyNo;
            //Find poster
            //Deposita
            CLEAR(OcTrans);
            OcTrans.RESET;
            OcTrans.SETRANGE(Occupant, OccupantInvoice.Number);
            OcTrans.SETRANGE(Type, 10);
            IF FINDSET THEN BEGIN
                REPEAT
                IF OcTrans.Occupant = OccupantInvoice.Number THEN BEGIN
                    SalesLine.Quantity := OcTrans.Qty * -1;
                    SalesLine."Unit Price" := OcTrans.Price;
                    SalesLine.Amount := SalesLine.Quantity * SalesLine."Unit Price";
                    InvAmount += SalesLine.Amount;
                END;
                UNTIL OcTrans.NEXT = 0
            END;//Deposita

            //Forudbetalt leje
            CLEAR(OcTrans);
            OcTrans.RESET;
            OcTrans.SETRANGE(Occupant, OccupantInvoice.Number);
            OcTrans.SETRANGE(Type, 11);
            IF FINDSET THEN BEGIN
                REPEAT
                IF OcTrans.Occupant = OccupantInvoice.Number THEN BEGIN
                    SalesLine.Quantity := OcTrans.Qty * -1;
                    SalesLine."Unit Price" := OcTrans.Price;
                    SalesLine.Amount := SalesLine.Quantity * SalesLine."Unit Price";
                    InvAmount += SalesLine.Amount;
                END;
                UNTIL OcTrans.NEXT = 0
            END; //Forudbetalt leje

            //Flytteomkostninger
            CLEAR(CostTypeEstate);
            CostTypeEstate.RESET;
            CostTypeEstate.SETRANGE(Type, 13); //Flytteomkostninger
            IF CostTypeEstate.FINDFIRST() THEN BEGIN
                CLEAR(SubLines);
                SubLines.RESET;
                SubLines.SETRANGE(Tenancies, Tenancy);
                SubLines.SETRANGE("Cost Types", CostTypeEstate.Costtype);
                IF FINDSET THEN BEGIN
                    REPEAT
                    SalesLine.Quantity := 1;
                    SalesLine."Unit Price" := SubLines."Amount Period";
                    SalesLine.Amount := SalesLine.Quantity * SalesLine."Unit Price";
                    InvAmount += SalesLine.Amount;
                    UNTIL SubLines.NEXT = 0
                END;
            END; //Flytteomkostninger
        END;
        IF InvAmount < 0 THEN
            InvoiceCreditmemo := false; //Kreditnota
        IF InvAmount > 0 THEN
            InvoiceCreditmemo := true; //Faktura
    end;

    local procedure MakeCreditmemo();
    begin
        //Kreditnota
        IF InvoiceCreditmemo = FALSE THEN BEGIN
            CLEAR(OccupantInvoice);
            OccupantInvoice.SETRANGE(Number, OccNo);
            IF OccupantInvoice.FINDFIRST() THEN BEGIN
                Tenancy := OccupantInvoice.TenancyNo;
                Custcard.RESET;
                Custcard.SETRANGE(Custcard."No.", OccupantInvoice."Customer No");
                IF Custcard.FINDFIRST() THEN BEGIN
                    Salesheader.INIT;
                    Salesheader.VALIDATE("Document Type", Salesheader."Document Type"::"Credit Memo");
                    Salesheader."No." := '';
                    Salesheader."Bill-to Customer No." := OccupantInvoice."Customer No";
                    Salesheader."Bill-to Name" := OccupantInvoice.Name1;
                    Salesheader."Bill-to Address" := Custcard.Address;
                    Salesheader."Bill-to Address 2" := Custcard."Address 2";
                    Salesheader."Bill-to Post Code" := Custcard."Post Code";
                    Salesheader."Bill-to City" := Custcard.City;
                    Salesheader."Bill-to Country/Region Code" := Custcard."Country/Region Code";
                    Salesheader."Sell-to Customer No." := Custcard."No.";
                    Salesheader."Sell-to Customer Name" := Custcard.Name;
                    Salesheader."Sell-to Address" := Custcard.Address;
                    Salesheader."Sell-to Address 2" := Custcard."Address 2";
                    Salesheader."Sell-to Post Code" := Custcard."Post Code";
                    Salesheader."Sell-to City" := Custcard.City;
                    Salesheader."Sell-to Country/Region Code" := Custcard."Country/Region Code";
                    Salesheader."Posting Date" := TODAY;
                    SalesHeader."SVA Included" := TRUE;
                    Salesheader."Payment Terms Code" := Custcard."Payment Terms Code";
                    Salesheader."Currency Code" := Custcard."Currency Code";
                    SalesHeader."SVA Occupant" := OccupantInvoice.Number;
                    Salesheader."Due Date" := CALCDATE('<+14D>', TODAY);
                    Salesheader."Customer Posting Group" := Custcard."Customer Posting Group";
                    SalesHeader.Validate("Customer Posting Group");
                    SalesHeader."Payment Method Code" := Custcard."Payment Method Code";
                    SalesHeader."VAT Bus. Posting Group" := Custcard."VAT Bus. Posting Group";
                    SalesHeader.Validate("VAT Bus. Posting Group");
                    SalesHeader."Gen. Bus. Posting Group" := Custcard."Gen. Bus. Posting Group";
                    SalesHeader.Validate("Gen. Bus. Posting Group");
                    SalesHeader."Dimension Set ID" := OccupantInvoice."Dimension Set Id";
                    Salesheader.Validate("Dimension Set ID");
                    Salesheader.INSERT(TRUE);

                    //Dan ordrelinjer
                    //Deposita
                    LineNo := 1;
                    CLEAR(OcTrans);
                    OcTrans.RESET;
                    OcTrans.SETRANGE(Occupant, SalesHeader."SVA Occupant");
                    OcTrans.SETRANGE(Type, 10);
                    IF FINDSET THEN BEGIN
                        REPEAT
                        IF OcTrans.Occupant = SalesHeader."SVA Occupant" THEN begin
                            SaleslineInitTransCrMemo(10);
                            SalesLine.INSERT(TRUE);
                        end;
                        UNTIL OcTrans.NEXT = 0
                    END;//Deposita

                    //Prepaid rent
                    CLEAR(OcTrans);
                    OcTrans.RESET;
                    OcTrans.SETRANGE(Occupant, SalesHeader."SVA Occupant");
                    OcTrans.SETRANGE(Type, 11);
                    IF FINDSET THEN BEGIN
                        REPEAT
                        IF OcTrans.Occupant = SalesHeader."SVA Occupant" THEN BEGIN
                            SaleslineInitTransCrMemo(11);
                            SalesLine.INSERT(TRUE);
                        END;
                        UNTIL OcTrans.NEXT = 0
                    END; //Forudbetalt leje

                    //Flytteomkostninger
                    OccupantInvoice.RESET;
                    OccupantInvoice.SETRANGE(Number, OccNo);
                    IF OccupantInvoice.FINDFIRST() THEN BEGIN
                    END;
                    CLEAR(CostTypeEstate);
                    CostTypeEstate.RESET;
                    CostTypeEstate.SETRANGE(Type, 13); //Flytteomkostninger
                    IF CostTypeEstate.FINDFIRST() THEN BEGIN
                        CLEAR(SubLines);
                        SubLines.RESET;
                        SubLines.SETRANGE(Tenancies, OccupantInvoice.TenancyNo);
                        SubLines.SETRANGE("Cost Types", CostTypeEstate.Costtype);
                        IF FINDSET THEN BEGIN
                            REPEAT
                            SalesLine.INIT;
                            SalesLine.VALIDATE(SalesLine."Document Type", Salesheader."Document Type"::"Credit Memo");
                            SalesLine."Line No." := LineNo;
                            LineNo := LineNo + 1;
                            SalesLine.Type := 1;
                            SalesLine."Document No." := Salesheader."No.";
                            SalesLine.Quantity := -1;
                            SalesLine."Quantity (Base)" := SalesLine.Quantity; // felt 5415
                            SalesLine."Qty. to Invoice (Base)" := SalesLine.Quantity; //5417
                            SalesLine."Qty. to Invoice" := SalesLine.Quantity; //felt 17
                            SalesLine."Return Qty. to Receive" := SalesLine.Quantity; // felt 5803
                            Salesline."Return Qty. to Receive (Base)" := SalesLine.Quantity; //felt 5804 
                            SalesLine."Unit Price" := SubLines."Amount Period";
                            SalesLine."Line Amount" := SalesLine.Quantity * SalesLine."Unit Price" * -1;
                            SalesLine.Amount := SalesLine.Quantity * SalesLine."Unit Price";
                            SalesLine."Dimension Set ID" := SalesHeader."Dimension Set ID";
                            Salesline.Validate("Dimension Set ID");
                            SalesLine."Gen. Bus. Posting Group" := SalesHeader."Gen. Bus. Posting Group";
                            Salesline.Validate(SalesLine."Gen. Bus. Posting Group");
                            SalesLine."VAT Bus. Posting Group" := SalesHeader."VAT Bus. Posting Group";
                            SalesLine."No." := CostTypeEstate.Account;
                            SalesLine.Description := SubLines.Description;
                            SalesLine."VAT Prod. Posting Group" := CostTypeEstate.VatGroup;
                            SalesLine."Gen. Prod. Posting Group" := CostTypeEstate.ProductPostingGroup;
                            SalesLine."SVA CostType" := CostTypeEstate.Costtype;
                            if salesline.Amount <> 0 then
                                SalesLine.INSERT(TRUE);
                            UNTIL SubLines.NEXT = 0
                        END;
                    END; //Flytteomkostninger
                END;
            END;
        END;
    end;

    Local procedure MakeInvoice();
    begin
        //Invoice
        IF InvoiceCreditmemo = TRUE THEN BEGIN
            CLEAR(OccupantInvoice);
            OccupantInvoice.SETRANGE(Number, OccNo);
            IF OccupantInvoice.FINDFIRST() THEN BEGIN
                Custaccount := OccupantInvoice."Customer No";
                Tenancy := TenancyNo;
                Custcard.RESET;
                Custcard.SETRANGE(Custcard."No.", OccupantInvoice."Customer No");
                IF Custcard.FINDFIRST() THEN BEGIN
                    Salesheader.INIT;
                    Salesheader.VALIDATE("Document Type", Salesheader."Document Type"::Invoice);
                    Salesheader."No." := '';
                    Salesheader."Bill-to Customer No." := OccupantInvoice."Customer No";
                    Salesheader."Bill-to Name" := OccupantInvoice.Name1;
                    Salesheader."Bill-to Address" := Custcard.Address;
                    Salesheader."Bill-to Address 2" := Custcard."Address 2";
                    Salesheader."Bill-to Post Code" := Custcard."Post Code";
                    Salesheader."Bill-to City" := Custcard.City;
                    Salesheader."Bill-to Country/Region Code" := Custcard."Country/Region Code";
                    Salesheader."Sell-to Customer No." := Custcard."No.";
                    Salesheader."Sell-to Customer Name" := Custcard.Name;
                    Salesheader."Sell-to Address" := Custcard.Address;
                    Salesheader."Sell-to Address 2" := Custcard."Address 2";
                    Salesheader."Sell-to Post Code" := Custcard."Post Code";
                    Salesheader."Sell-to City" := Custcard.City;
                    Salesheader."Sell-to Country/Region Code" := Custcard."Country/Region Code";
                    Salesheader."Posting Date" := TODAY;
                    SalesHeader."SVA Included" := TRUE;
                    Salesheader."Payment Terms Code" := Custcard."Payment Terms Code";
                    Salesheader."Currency Code" := Custcard."Currency Code";
                    SalesHeader."SVA Occupant" := OccupantInvoice.Number;
                    Salesheader."Due Date" := CALCDATE('<+14D>', TODAY);
                    Salesheader."Customer Posting Group" := Custcard."Customer Posting Group";
                    SalesHeader.Validate("Customer Posting Group");
                    SalesHeader."Payment Method Code" := Custcard."Payment Method Code";
                    SalesHeader."VAT Bus. Posting Group" := Custcard."VAT Bus. Posting Group";
                    SalesHeader.Validate("VAT Bus. Posting Group");
                    SalesHeader."Gen. Bus. Posting Group" := Custcard."Gen. Bus. Posting Group";
                    SalesHeader.Validate("Gen. Bus. Posting Group");
                    SalesHeader."Dimension Set ID" := OccupantInvoice."Dimension Set Id";
                    SalesHeader.Validate("Dimension Set ID");
                    Salesheader.INSERT(TRUE);

                    //Make saleslines
                    //Deposit
                    LineNo := 1;
                    CLEAR(OcTrans);
                    OcTrans.RESET;
                    OcTrans.SETRANGE(Occupant, SalesHeader."SVA Occupant");
                    OcTrans.SETRANGE(Type, 10);
                    IF FINDSET THEN BEGIN
                        REPEAT
                        IF OcTrans.Occupant = SalesHeader."SVA Occupant" THEN BEGIN
                            SaleslineInitTransInvoice(10);
                            SalesLine.INSERT(TRUE);
                        END;
                        UNTIL OcTrans.NEXT = 0
                    END;//Deposit

                    //Prepaid rent
                    CLEAR(OcTrans);
                    OcTrans.RESET;
                    OcTrans.SETRANGE(Occupant, SalesHeader."SVA Occupant");
                    OcTrans.SETRANGE(Type, 11);
                    IF FINDSET THEN BEGIN
                        REPEAT
                        IF OcTrans.Occupant = SalesHeader."SVA Occupant" THEN BEGIN
                            SaleslineInitTransInvoice(11);
                            SalesLine.INSERT(TRUE);
                        end;
                        UNTIL OcTrans.NEXT = 0
                    END; //Prepaid rent

                    //Moving out costs
                    CLEAR(CostTypeEstate);
                    CostTypeEstate.RESET;
                    CostTypeEstate.SETRANGE(Type, 13, 14);
                    IF CostTypeEstate.FINDFIRST() THEN BEGIN
                        CLEAR(SubLines);
                        SubLines.RESET;
                        SubLines.SETRANGE(Tenancies, OccupantInvoice.TenancyNo);
                        SubLines.SETRANGE("Cost Types", CostTypeEstate.Costtype);
                        IF FINDSET THEN BEGIN
                            REPEAT
                            SalesLine.INIT;
                            SalesLine.VALIDATE(SalesLine."Document Type", Salesheader."Document Type"::Invoice);
                            SalesLine."Line No." := LineNo;
                            LineNo := LineNo + 1;
                            SalesLine.Type := 1;
                            SalesLine."Document No." := Salesheader."No.";
                            SalesLine.Quantity := 1;
                            SalesLine."Qty. to Ship" := SalesLine.Quantity;
                            SalesLine."Qty. to Invoice" := SalesLine.Quantity;
                            SalesLine."Unit Price" := SubLines."Amount Period";
                            SalesLine."Line Amount" := SalesLine.Quantity * SalesLine."Unit Price";
                            SalesLine.Amount := SalesLine.Quantity * SalesLine."Unit Price";
                            SalesLine."No." := CostTypeEstate.Account;
                            SalesLine.Description := SubLines.Description;
                            SalesLine."VAT Prod. Posting Group" := CostTypeEstate.VatGroup;
                            SalesLine."Gen. Prod. Posting Group" := CostTypeEstate.ProductPostingGroup;
                            SalesLine.Validate(SalesLine."Gen. Bus. Posting Group");
                            SalesLine."Dimension Set ID" := SalesHeader."Dimension Set ID";
                            Salesline.Validate("Dimension Set ID");
                            SalesLine."Gen. Bus. Posting Group" := SalesHeader."Gen. Bus. Posting Group";
                            SalesLine."VAT Bus. Posting Group" := SalesHeader."VAT Bus. Posting Group";
                            SalesLine."SVA Costtype" := CostTypeEstate.Costtype;
                            Salesline.Validate(SalesLine."Gen. Bus. Posting Group");
                            IF SalesLine.Amount <> 0 THEN
                                SalesLine.INSERT(TRUE);
                            UNTIL SubLines.NEXT = 0
                        END;
                    END; //Moving out costs
                END;
            END;
        END;
    end;

    local procedure SaleslineInitTransCrMemo(Costtype: Integer);
    begin
        SalesLine.INIT;
        SalesLine.VALIDATE(SalesLine."Document Type", Salesheader."Document Type"::"Credit Memo");
        SalesLine."Line No." := LineNo;
        LineNo := LineNo + 1;
        SalesLine.Type := 1;
        SalesLine."Document No." := Salesheader."No.";
        SalesLine.Quantity := OcTrans.Qty; //felt 15
        SalesLine."Quantity (Base)" := SalesLine.Quantity; // felt 5415
        SalesLine."Qty. to Invoice (Base)" := SalesLine.Quantity; //5417
        SalesLine."Qty. to Invoice" := SalesLine.Quantity; //felt 17
        SalesLine."Return Qty. to Receive" := SalesLine.Quantity; // felt 5803
        Salesline."Return Qty. to Receive (Base)" := SalesLine.Quantity; //felt 5804 
        SalesLine."Unit Price" := OcTrans.Price;
        SalesLine."Line Amount" := SalesLine.Quantity * SalesLine."Unit Price";
        SalesLine.Amount := SalesLine.Quantity * SalesLine."Unit Price";
        SalesLine."Dimension Set ID" := SalesHeader."Dimension Set ID";
        Salesline.Validate("Dimension Set ID");
        SalesLine."Gen. Bus. Posting Group" := SalesHeader."Gen. Bus. Posting Group";
        SalesLine.Validate(SalesLine."Gen. Bus. Posting Group");
        SalesLine."VAT Bus. Posting Group" := SalesHeader."VAT Bus. Posting Group";
        Salesline.Validate(SalesLine."Gen. Bus. Posting Group");
        CostTypeEstate.RESET;
        CostTypeEstate.SETRANGE(Type, Costtype);
        IF CostTypeEstate.FINDFIRST() THEN BEGIN
            SalesLine."No." := CostTypeEstate.Account;
            SalesLine.Description := CostTypeEstate.Description;
            SalesLine."SVA CostType" := CostTypeEstate.Costtype;
            SalesLine."VAT Prod. Posting Group" := CostTypeEstate.VatGroup;
            SalesLine."Gen. Prod. Posting Group" := CostTypeEstate.ProductPostingGroup;
            SalesLine.Validate("VAT Prod. Posting Group");
            SalesLine.Validate("Gen. Prod. Posting Group");
        END;
    end;

    local procedure SaleslineInitTransInvoice(Costtype: Integer);
    begin
        SalesLine.INIT;
        SalesLine.VALIDATE(SalesLine."Document Type", Salesheader."Document Type"::Invoice);
        SalesLine."Line No." := LineNo;
        LineNo := LineNo + 1;
        SalesLine.Type := 1;
        SalesLine."Document No." := Salesheader."No.";
        SalesLine.Quantity := OcTrans.Qty * -1;
        SalesLine."Qty. to Ship" := SalesLine.Quantity;
        SalesLine."Qty. to Invoice" := SalesLine.Quantity;
        SalesLine."Unit Price" := OcTrans.Price;
        SalesLine."Line Amount" := SalesLine.Quantity * SalesLine."Unit Price";
        SalesLine.Amount := SalesLine.Quantity * SalesLine."Unit Price";
        SalesLine."Dimension Set ID" := SalesHeader."Dimension Set ID";
        Salesline.Validate("Dimension Set ID");
        SalesLine."Gen. Bus. Posting Group" := SalesHeader."Gen. Bus. Posting Group";
        Salesline.Validate(SalesLine."Gen. Bus. Posting Group");
        SalesLine."VAT Bus. Posting Group" := SalesHeader."VAT Bus. Posting Group";
        CostTypeEstate.RESET;
        CostTypeEstate.SETRANGE(Type, Costtype);
        IF CostTypeEstate.FINDFIRST() THEN BEGIN
            SalesLine."No." := CostTypeEstate.Account;
            SalesLine.Description := CostTypeEstate.Description;
            SalesLine."SVA CostType" := CostTypeEstate.Costtype;
            SalesLine."VAT Prod. Posting Group" := CostTypeEstate.VatGroup;
            SalesLine."Gen. Prod. Posting Group" := CostTypeEstate.ProductPostingGroup;
            SalesLine.Validate("VAT Prod. Posting Group");
            SalesLine.Validate("Gen. Prod. Posting Group");
        END;

    end;

    local procedure Posting();
    begin
        //Posting
        //CODEUNIT.RUN(CODEUNIT::"Sales-Post and Send", Salesheader);
        if InvoiceCreditmemo = true then
            Page.Run(page::"Sales Invoice List");
        if InvoiceCreditmemo = false then
            Page.Run(page::"Sales Credit Memos");
    end;
}

