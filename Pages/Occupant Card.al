page 60534 "Occupant Card"
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
                }
                field(TenancyNo; TenancyNo)
                {
                }
                field(startdate; StartDate)
                {
                }
                field("Collection Month"; "Collection Month")
                {
                    OptionCaption = 'Jan,Feb,Mar,Apr,May,Jun,Jul,Aug,Sep,Oct,Nov,Dec';
                }
                field(FirstNets; FirstNets)
                {
                }
                field(Name1; Name1)
                {
                }
                field(Name2; Name2)
                {
                }
                field(Address2; Address2)
                {
                }
                field("Post Code"; "Post Code")
                {
                }
                field(City; City)
                {
                }
                field("Country/Region Code"; "Country/Region Code")
                {
                }
                field(Email1; Email1)
                {
                }
                field(Email2; Email2)
                {
                }
                field(Phone; Phone)
                {
                }
                field(CellPhone1; CellPhone1)
                {
                }
                field(CellPhone2; CellPhone2)
                {
                }
                field(CPRno1; CPRno1)
                {
                }
                field(CPRno2; CPRno2)
                {
                }
                field(EndDate; EndDate)
                {
                }
                field(Blocked; Blocked)
                {
                }
                field(ConsumptionAccountNo; ConsumptionAccountNo)
                {
                }
            }
            group("Div. oplysniger")
            {
                Caption = 'Mis. information';
                field(ChairmanOfTheBoard; ChairmanOfTheBoard)
                {
                    Caption = 'Chairman of the Board';
                }
                field(BoardMember; BoardMember)
                {
                    Caption = 'Member of the Board';
                }
                field(BoardAccountent; BoardAccountent)
                {
                    Caption = 'Accountant';
                }
                field(ResidentRepresentative; ResidentRepresentative)
                {
                    Caption = 'Residents representative';
                }
            }
            part("Opkrævningslinjer"; 60560)
            {
                Caption = 'Subscription Lines';
                SubPageLink = Tenancies = FIELD (TenancyNo);
                SubPageView = SORTING (Tenancies, "Cost Types", "Date From", "Date To")
                              ORDER(Ascending);
            }
            part("Opkrævningsposter"; 60570)
            {
                Caption = 'Occupant Trans';
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
                Caption = 'Contract';
                action(LeasContractA9)
                {
                    Caption = 'Leasecontract A9';
                    Image = MakeAgreement;
                    RunObject = Page 60580;
                    RunPageLink = Number = FIELD (Number);
                    RunPageMode = Edit;
                    RunPageOnRec = false;
                }
                action(LeasContractGarage)
                {
                    Caption = 'LeaseContractGarage';
                    Image = MakeAgreement;
                    RunObject = Page 60590;
                    RunPageLink = Number = FIELD (Number);
                    RunPageMode = Edit;
                }
                action(Regulations)
                {
                    Caption = 'Regulation of rent';
                    Image = MakeAgreement;
                    RunObject = Page 60600;
                    RunPageLink = Number = FIELD (Number);
                }
            }
            group(Rapporter)
            {
                Caption = 'Reports';
                action(Moving)
                {
                    Caption = 'Moving in status';
                    Image = MakeAgreement;
                    Promoted = true;
                    PromotedCategory = Report;
                    RunObject = Page 50110;
                    RunPageLink = Occupant = FIELD (Number);
                    RunPageMode = Edit;
                }
                action(OccupancyReportIn)
                {
                    Caption = 'Occupancy Report (in)';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = Report;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = "Report";

                    trigger OnAction();
                    begin
                        CLEAR(Occupant);
                        Occupant.SETRANGE(Number, Rec.Number);
                        CLEAR(MoveIn);
                        MoveIn.SETTABLEVIEW(Occupant);
                        MoveIn.RUNMODAL;
                    end;
                }
                action(OccupacyReportOut)
                {
                    Caption = 'Occupancy Report (out)';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = Report;

                    trigger OnAction();
                    begin
                        CLEAR(Occupant);
                        Occupant.SETRANGE(Number, Rec.Number);
                        CLEAR(MoveOut);
                        MoveOut.SETTABLEVIEW(Occupant);
                        MoveOut.RUNMODAL;
                    end;
                }
            }
            group(Letters)
            {
                Caption = 'Letters';
                action(DemandNotice)
                {
                    Caption = 'Demand Notice';
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
                    Image = Report2;

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
                    Image = "report";

                    trigger OnAction();
                    begin
                        CLEAR(Occupant);
                        Occupant.SETRANGE(Number, Rec.Number);
                        CLEAR(InvoiceJournal);
                        InvoiceJournal.SETTABLEVIEW(Occupant);
                        InvoiceJournal.RUNMODAL;
                    end;
                }
                action(MovingOutInvoice)
                {
                    Caption = 'Invoice Moving out';
                    Image = "report";

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
                                    OcTrans.SETRANGE(Type, 9);
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
                            MESSAGE('kreditnota');
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
                                    OcTrans.SETRANGE(Type, 9);
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
                                            CostTypeEstate.SETRANGE(Type, 9);
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

                                    //Forudbetalt leje
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
                                            CostTypeEstate.SETRANGE(Type, 10);
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
        Occupant.INIT;
        Number := NoSeriesMgt.GetNextNo('LEJEAFTALE', WORKDATE, TRUE);
    end;

    var
        TenancyCard: Record "SVA Tenancy";
        Custcard: Record "Customer";
        Property: Record "SVA Property";
        Occupant: Record "SVA Occupant";
        PageTypeA9: Record "SVA LeaseContract_A9";
        MoveIn: Report "SVA Occupant Report (in)";
        MoveOut: Report "SVA Occupant Report (out)";
        NoSeriesMgt: Codeunit "NoSeriesManagement";
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
        InvoiceJournal: Report "SVA Moving out Journal";
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

