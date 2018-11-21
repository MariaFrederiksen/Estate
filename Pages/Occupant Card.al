page 60534 "SVA Occupant Card"
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
                    ToolTip='Costumer no. from customer table.';
                }
                field(TenancyNo; TenancyNo)
                {
                    ToolTip='The tenancy, the customer rents';
                }
                field(startdate; StartDate)
                {
                    ToolTip='Startdate of the contract.';
                }
                field("Collection Month"; "Collection Month")
                {
                    ToolTip='Collection month. Importen when the collecion period is quarter, halfyear or year';
                }
                field(FirstNets; FirstNets)
                {
                    ToolTip='First time to NETS. Can be left blank';
                }
                field(Name1; Name1)
                {
                    ToolTip='Tenants full name';
                }
                field(Name2; Name2)
                {
                    ToolTip='Second tenants name';
                }
                field(Address; Address)
                {
                    
                    ToolTip='Invoice address';
                }
                field(Address2; Address2)
                {
                    ToolTip='Invoice address 2';
                }
                field("Post Code"; "Post Code")
                {
                    
                    ToolTip='Invoice post code';
                }
                field(City; City)
                {
                    
                    ToolTip='Invoice city';
                }
                field("Country/Region Code"; "Country/Region Code")
                {
                    
                    ToolTip='Invoice Country code';
                }
                field(Email1; Email1)
                {
                    
                    ToolTip='Tenants email';
                }
                field(Email2; Email2)
                {
                    
                    ToolTip='Second email';
                }
                field(Phone; Phone)
                {
                    
                    ToolTip='Tenants phone no.';
                }
                field(CellPhone1; CellPhone1)
                {
                    
                    ToolTip='Tenants cellphone no.';
                }
                field(CellPhone2; CellPhone2)
                {
                    
                    ToolTip='Tenants cellphone no.';
                }
                field(CPRno1; CPRno1)
                {
                    ToolTip='Tenants security no.';
                }
                field(CPRno2; CPRno2)
                {
                    
                    ToolTip='Second Tenants social security no.';
                }
                field(EndDate; EndDate)
                {
                    
                    ToolTip='The date this contract expire';
                }
                field(Blocked; Blocked)
                {
                    
                    ToolTip='Blocked date';
                }
                field(ConsumptionAccountNo; ConsumptionAccountNo)
                {
                    
                    ToolTip='Tenants consumption account no.';
                }
            }
            group("Div. oplysniger")
            {
                Caption = 'Mis. information';
                field(ChairmanOfTheBoard; ChairmanOfTheBoard)
                {
                    
                    ToolTip='Is tenant chairman of the board? Not relevant if the tenancy is rented';
                }
                field(BoardMember; BoardMember)
                {
                    
                    ToolTip='Is tenant member of the board? Not relevant if the tenancy is rented';
                }
                field(BoardAccountent; BoardAccountent)
                {
                    
                    ToolTip='Is tenant accountant of the board? Not relevant if the tenancy is rented';
                }
                field(ResidentRepresentative; ResidentRepresentative)
                {
                    
                    ToolTip='Is tenant Residents representative? Only relevant if the tenancy is rented';
                }
            }
            part("Subscription lines"; 60560)
            {
                Caption='Subscription lines';
                Tooltip='Subscription lines for this contract.';
                SubPageLink = Tenancies = FIELD (TenancyNo);
                SubPageView = SORTING (Tenancies, "Cost Types", "Date From", "Date To")
                              ORDER(Ascending);
            }
            part("Occupant transactions"; 60570)
            {
                Caption = 'Occupant Trans';
                Tooltip='Occupant trans for this contract.';
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
                    Caption = 'Leasecontract Type A, 9. edistion';
                    Tooltip='Go to leasecontract type A, 9. edition for filling';
                    Image = MakeAgreement;
                    RunObject = Page 60580;
                    RunPageLink = Number = FIELD (Number);
                    RunPageMode = Edit;
                    RunPageOnRec = false;
                }
                action(LeasContractGarage)
                {
                    Caption = 'Leasecontract for garage';
                    Tooltip='Go to leasecontract for garage for filling';
                    Image = MakeAgreement;
                    RunObject = Page 60590;
                    RunPageLink = Number = FIELD (Number);
                    RunPageMode = Edit;
                }
                action(Regulations)
                {
                    Caption = 'Agreed regulation of rent';
                    Tooltip='Contract conditions for regulations';
                    Image = MakeAgreement;
                    RunObject = Page 60600;
                    RunPageLink = Number = FIELD (Number);
                }
            }
            group(Reports)
            {
                Caption = 'Process';
                action(MovingIn)
                {
                    Caption = 'Moving in inspection';
                    Tooltip='Go to moving in status for filling';
                    Image = MakeAgreement;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 50110;
                    RunPageLink = Occupant = FIELD (Number);
                    RunPageMode = Edit;
                }
                action(MovingOut)
                {
                    Caption = 'Moving out inspection';
                    Tooltip='Go to moving out status for filling';
                    Image = MakeAgreement;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 50120;
                    RunPageLink = Occupant = FIELD (Number);
                    RunPageMode = Edit;
                }
            }

            group(Letters)
            {
                Caption = 'Letters';
                action(DemandNotice)
                {
                    Caption = 'Demand Notice';
                    Tooltip='The formal demand notice';
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
                    Caption = 'Repeal';
                    Tooltip='Letter for repeal the tenant';
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
            group(Journals)
            {
                Caption = 'Journals';
                action(MovingOutJournal)
                {
                    Caption = 'Journal for moving out invoice';
                    ToolTip='Journal for moving out invoice. Use before making an invoice.';
                    Image = report;

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
                    Caption = 'Invoice Moving out';
                    Tooltip='Make a moving out invoice based on transactions and subscription lines.';
                    Image = report;

                    trigger OnAction();
                    begin
                        OccNo := Rec.Number;
                        InvoiceCreditnota;
                        //Invoice
                        IF InvoiceCreditmemo = TRUE THEN BEGIN

                            CLEAR(OccupantInvoice);
                            OccupantInvoice.SETRANGE(Number, Rec.Number);
                            IF OccupantInvoice.FINDFIRST() THEN BEGIN
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
                                    Salesheader."Payment Terms Code" := Cust."Payment Terms Code";
                                    Salesheader."Currency Code" := Cust."Currency Code";
                                    SalesHeader."SVA Occupant" := OccupantInvoice.Number;
                                    Salesheader."Due Date" := CALCDATE('<+14D>', TODAY);
                                    Salesheader."Customer Posting Group" := Custcard."Customer Posting Group";
                                    //Forfaldsdato?
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
                                        IF OcTrans.Occupant = SalesHeader."SVA Occupant" THEN BEGIN
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
                                            CostTypeEstate.RESET;
                                            CostTypeEstate.SETRANGE(Type, 9);
                                            IF CostTypeEstate.FINDFIRST() THEN BEGIN
                                                SalesLine."No." := CostTypeEstate.Account;
                                                SalesLine.Description := CostTypeEstate.Description;
                                                SalesLine."VAT Prod. Posting Group" := CostTypeEstate.VatGroup;
                                                SalesLine."SVA CostType" := CostTypeEstate.Costtype;
                                            END;
                                            Ledaccount.RESET;
                                            Ledaccount.SETRANGE(Ledaccount."No.", CostTypeEstate.Account);
                                            IF Ledaccount.FINDFIRST THEN BEGIN
                                                SalesLine."Gen. Bus. Posting Group" := Ledaccount."Gen. Bus. Posting Group";
                                                SalesLine."Gen. Prod. Posting Group" := Ledaccount."Gen. Prod. Posting Group";
                                            END;
                                            SalesLine.INSERT(TRUE);
                                        END;
                                        UNTIL OcTrans.NEXT = 0
                                    END;//Deposita

                                    //Forudbetalt leje
                                    CLEAR(OcTrans);
                                    OcTrans.RESET;
                                    OcTrans.SETRANGE(Occupant, SalesHeader."SVA Occupant");
                                    OcTrans.SETRANGE(Type, 11);
                                    IF FINDSET THEN BEGIN
                                        REPEAT
                                        IF OcTrans.Occupant = SalesHeader."SVA Occupant" THEN BEGIN
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
                                            CostTypeEstate.RESET;
                                            CostTypeEstate.SETRANGE(Type, 10);
                                            IF CostTypeEstate.FINDFIRST() THEN BEGIN
                                                SalesLine."No." := CostTypeEstate.Account;
                                                SalesLine.Description := CostTypeEstate.Description;
                                                SalesLine."VAT Prod. Posting Group" := CostTypeEstate.VatGroup;
                                                SalesLine."SVA Costtype" := CostTypeEstate.Costtype;
                                            END;
                                            Ledaccount.RESET;
                                            Ledaccount.SETRANGE(Ledaccount."No.", CostTypeEstate.Account);
                                            IF Ledaccount.FINDFIRST THEN BEGIN
                                                SalesLine."Gen. Bus. Posting Group" := Ledaccount."Gen. Bus. Posting Group";
                                                SalesLine."Gen. Prod. Posting Group" := Ledaccount."Gen. Prod. Posting Group";
                                            END;
                                            SalesLine.INSERT(TRUE);
                                        END;
                                        UNTIL OcTrans.NEXT = 0
                                    END; //Forudbetalt leje

                                    //Flytteomkostninger
                                    CLEAR(CostTypeEstate);
                                    CostTypeEstate.RESET;
                                    CostTypeEstate.SETRANGE(Type, 12); //Flytteomkostninger
                                    IF CostTypeEstate.FINDFIRST() THEN BEGIN
                                        CLEAR(SubLines);
                                        SubLines.RESET;
                                        SubLines.SETRANGE(Tenancies, Tenancy);
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
                                            SalesLine."SVA Costtype" := CostTypeEstate.Costtype;
                                            Ledaccount.RESET;
                                            Ledaccount.SETRANGE(Ledaccount."No.", CostTypeEstate.Account);
                                            IF Ledaccount.FINDFIRST THEN BEGIN
                                                SalesLine."Gen. Bus. Posting Group" := Ledaccount."Gen. Bus. Posting Group";
                                                SalesLine."Gen. Prod. Posting Group" := Ledaccount."Gen. Prod. Posting Group";
                                            END;
                                            IF SalesLine.Amount <> 0 THEN
                                                SalesLine.INSERT(TRUE);
                                            UNTIL SubLines.NEXT = 0
                                        END;
                                    END; //Flytteomkostninger
                                END;
                            END;
                        END; //Invoice

                        //Kreditnota
                        IF InvoiceCreditmemo = FALSE THEN BEGIN
                            CLEAR(OccupantInvoice);
                            OccupantInvoice.SETRANGE(Number, OccNo);
                            IF OccupantInvoice.FINDFIRST() THEN BEGIN
                                Tenancy := TenancyNo;
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
                                    Salesheader."Payment Terms Code" := Cust."Payment Terms Code";
                                    Salesheader."Currency Code" := Cust."Currency Code";
                                    SalesHeader."SVA Occupant" := OccupantInvoice.Number;
                                    Salesheader."Due Date" := CALCDATE('<+14D>', TODAY);
                                    Salesheader."Customer Posting Group" := Custcard."Customer Posting Group";
                                    //Forfaldsdato?
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
                                        IF OcTrans.Occupant = SalesHeader."SVA Occupant" THEN BEGIN
                                            SalesLine.INIT;
                                            SalesLine.VALIDATE(SalesLine."Document Type", Salesheader."Document Type"::"Credit Memo");
                                            SalesLine."Line No." := LineNo;
                                            LineNo := LineNo + 1;
                                            SalesLine.Type := 1;
                                            SalesLine."Document No." := Salesheader."No.";
                                            SalesLine.Quantity := OcTrans.Qty;
                                            //SalesLine."Qty. to Ship" := SalesLine.Quantity;
                                            SalesLine."Qty. to Invoice" := SalesLine.Quantity;
                                            SalesLine."Return Qty. to Receive" := SalesLine.Quantity;
                                            SalesLine."Unit Price" := OcTrans.Price;
                                            SalesLine."Line Amount" := SalesLine.Quantity * SalesLine."Unit Price";
                                            SalesLine.Amount := SalesLine.Quantity * SalesLine."Unit Price";
                                            CostTypeEstate.RESET;
                                            CostTypeEstate.SETRANGE(Type, 10); //Deposit
                                            IF CostTypeEstate.FINDFIRST() THEN BEGIN
                                                SalesLine."No." := CostTypeEstate.Account;
                                                SalesLine.Description := CostTypeEstate.Description;
                                                SalesLine."VAT Prod. Posting Group" := CostTypeEstate.VatGroup;
                                                SalesLine."SVA Costtype" := CostTypeEstate.Costtype;
                                            END;
                                            Ledaccount.RESET;
                                            Ledaccount.SETRANGE(Ledaccount."No.", CostTypeEstate.Account);
                                            IF Ledaccount.FINDFIRST THEN BEGIN
                                                SalesLine."Gen. Bus. Posting Group" := Ledaccount."Gen. Bus. Posting Group";
                                                SalesLine."Gen. Prod. Posting Group" := Ledaccount."Gen. Prod. Posting Group";
                                            END;
                                            IF SalesLine.Amount <> 0 THEN
                                                SalesLine.INSERT(TRUE);
                                        END;
                                        UNTIL OcTrans.NEXT = 0
                                    END;//Deposita

                                    //Prepaid rent
                                    CLEAR(OcTrans);
                                    OcTrans.RESET;
                                    OcTrans.SETRANGE(Occupant, SalesHeader."SVA Occupant");
                                    OcTrans.SETRANGE(Type, 10);
                                    IF FINDSET THEN BEGIN
                                        REPEAT
                                        IF OcTrans.Occupant = SalesHeader."SVA Occupant" THEN BEGIN
                                            SalesLine.INIT;
                                            SalesLine.VALIDATE(SalesLine."Document Type", Salesheader."Document Type"::"Credit Memo");
                                            SalesLine."Line No." := LineNo;
                                            LineNo := LineNo + 1;
                                            SalesLine.Type := 1;
                                            SalesLine."Document No." := Salesheader."No.";
                                            SalesLine.Quantity := OcTrans.Qty;
                                            SalesLine."Return Qty. to Receive" := SalesLine.Quantity;
                                            SalesLine."Unit Price" := OcTrans.Price;
                                            SalesLine."Line Amount" := SalesLine.Quantity * SalesLine."Unit Price";
                                            SalesLine.Amount := SalesLine.Quantity * SalesLine."Unit Price";
                                            CostTypeEstate.RESET;
                                            CostTypeEstate.SETRANGE(Type, 11); //Prepaid rent
                                            IF CostTypeEstate.FINDFIRST() THEN BEGIN
                                                SalesLine."No." := CostTypeEstate.Account;
                                                SalesLine.Description := CostTypeEstate.Description;
                                                SalesLine."VAT Prod. Posting Group" := CostTypeEstate.VatGroup;
                                                SalesLine."SVA CostType" := CostTypeEstate.Costtype;
                                            END;
                                            Ledaccount.RESET;
                                            Ledaccount.SETRANGE(Ledaccount."No.", CostTypeEstate.Account);
                                            IF Ledaccount.FINDFIRST THEN BEGIN
                                                SalesLine."Gen. Bus. Posting Group" := Ledaccount."Gen. Bus. Posting Group";
                                                SalesLine."Gen. Prod. Posting Group" := Ledaccount."Gen. Prod. Posting Group";
                                            END;
                                            IF SalesLine."Amount Including VAT" <> 0 THEN
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
                                    CostTypeEstate.SETRANGE(Type, 12); //Flytteomkostninger
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
                                            SalesLine."Qty. to Invoice" := SalesLine.Quantity;
                                            SalesLine."Return Qty. to Receive" := SalesLine.Quantity;
                                            SalesLine."Outstanding Quantity" := SalesLine.Quantity;
                                            SalesLine."Unit Price" := SubLines."Amount Period";
                                            SalesLine."Line Amount" := SalesLine.Quantity * SalesLine."Unit Price" * -1;
                                            SalesLine.Amount := SalesLine.Quantity * SalesLine."Unit Price";
                                            SalesLine."No." := CostTypeEstate.Account;
                                            SalesLine.Description := SubLines.Description;
                                            SalesLine."VAT Prod. Posting Group" := CostTypeEstate.VatGroup;
                                            SalesLine."SVA CostType" := CostTypeEstate.Costtype;
                                            Ledaccount.RESET;
                                            Ledaccount.SETRANGE(Ledaccount."No.", CostTypeEstate.Account);
                                            IF Ledaccount.FINDFIRST THEN BEGIN
                                                SalesLine."Gen. Bus. Posting Group" := Ledaccount."Gen. Bus. Posting Group";
                                                SalesLine."Gen. Prod. Posting Group" := Ledaccount."Gen. Prod. Posting Group";
                                            END;
                                            IF SalesLine.Amount <> 0 THEN
                                                SalesLine.INSERT(TRUE);
                                            UNTIL SubLines.NEXT = 0
                                        END;
                                    END; //Flytteomkostninger
                                END;
                            END;
                            //Kreditnota slut
                            //Posting
                            CODEUNIT.RUN(CODEUNIT::"Sales-Post", Salesheader);

                            // Opret linjerne på beboer posteringer
                            Invoice.RESET;
                            Invoice.SETRANGE(Invoice."Posting Date", TODAY);
                            Invoice.SETRANGE(Invoice."Pre-Assigned No.", Salesheader."No.");
                            Invoice.SETRANGE(Invoice."SVA Occupant", SalesHeader."SVA Occupant");
                            IF Invoice.FINDFIRST THEN
                                InvoiceLine.RESET;
                            InvoiceLine.SETRANGE(InvoiceLine."Document No.", Invoice."No.");
                            IF InvoiceLine.FIND('-') THEN
                                REPEAT
                                  OcTrans.Occupant := Invoice."SVA Occupant";
                                OcTrans.Date := Invoice."Posting Date";
                                OcTrans."Cost type Estate" := InvoiceLine."SVA CostType";
                                OcTrans."Invoice No" := InvoiceLine."Document No.";
                                OcTrans.Description := InvoiceLine.Description;
                                OcTrans.Qty := InvoiceLine.Quantity;
                                OcTrans.Price := InvoiceLine."Unit Price";
                                OcTrans.Amount := InvoiceLine.Amount;
                                CLEAR(CostTypeEstate);
                                CostTypeEstate.RESET;
                                CostTypeEstate.SETRANGE(Costtype, OcTrans."Cost type Estate");
                                IF CostTypeEstate.FINDFIRST() THEN
                                    OcTrans.Type := CostTypeEstate.Type;
                                OcTrans.INSERT();
                                UNTIL InvoiceLine.NEXT = 0;
                        END; //Creditmemo
                    end;
                }
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
            Message('Nummerserie er ikke opsat. Kørslen afbrydes');
            exit;
        end;
    end;

    trigger OnDeleteRecord(): Boolean;
    begin
        OCtrans.Reset;
        OcTrans.SetRange(Octrans.Occupant, rec.Number);
        IF OcTrans.FindFirst() then begin
            Message('Kontrakten kan ikke slettes, da der er posteringer.')
        end;
        exit;
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
        Cust: Record Customer;
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
        CreditHeader: Record "Sales Cr.Memo Header";
        CreditLine: Record "Sales Cr.Memo Line";
        OccNo: Code[10];
        DemandNoticeProf: Report "SVA DemandNoticeProf";
        RepealP: report "SVA Repeal Prof";
        RepealR: report "SVA Repeal Res";

    local procedure InvoiceCreditnota();
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
            OcTrans.SETRANGE(Type, 9);
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
            END; //Forudbetalt leje

            //Flytteomkostninger
            CLEAR(CostTypeEstate);
            CostTypeEstate.RESET;
            CostTypeEstate.SETRANGE(Type, 12); //Flytteomkostninger
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
        IF InvAmount > 0 THEN
            InvoiceCreditmemo := TRUE;
        IF InvAmount > 0 THEN
            InvoiceCreditmemo := FALSE;
    end;
}

