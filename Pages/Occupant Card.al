page 50009 "SVA Occupant Card"

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
                field("Customer No"; Rec."Customer No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Costumer no. from customer table.';
                }
                field(TenancyNo; Rec.TenancyNo)
                {
                    ApplicationArea = All;
                    ToolTip = 'The tenancy, the customer rents';
                }
                field(startdate; Rec.StartDate)
                {
                    ApplicationArea = All;
                    ToolTip = 'Startdate of the contract.';
                }
                field("Collection Month"; Rec."Collection Month")
                {
                    ApplicationArea = All;
                    ToolTip = 'Collection month. Importen when the collecion period is quarter, halfyear or year';
                }
                field(FirstNets; Rec.FirstNets)
                {
                    ApplicationArea = All;
                    ToolTip = 'First time to NETS or first time to be invoiced after moving in invoice.';
                }
                field(Name1; Rec.Name1)
                {
                    ApplicationArea = All;
                    ToolTip = 'Tenants full name';
                }
                field(Name2; Rec.Name2)
                {
                    ApplicationArea = All;
                    ToolTip = 'Second tenants name';
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                    ToolTip = 'Invoice address';
                }
                field(Address2; Rec.Address2)
                {
                    ApplicationArea = All;
                    ToolTip = 'Invoice address 2';
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Invoice post code';
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                    ToolTip = 'Invoice city';
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Invoice Country code';
                }
                field(Email1; Rec.Email1)
                {
                    ApplicationArea = All;
                    ToolTip = 'Tenants email';
                    ExtendedDatatype = EMail;
                }
                field(Email2; Rec.Email2)
                {
                    ApplicationArea = All;
                    ToolTip = 'Second email';
                }
                field(Phone; Rec.Phone)
                {
                    ApplicationArea = All;
                    ToolTip = 'Tenants phone no.';
                }
                field(CellPhone1; Rec.CellPhone1)
                {
                    ApplicationArea = All;
                    ToolTip = 'Tenants cellphone no.';
                }
                field(CellPhone2; Rec.CellPhone2)
                {
                    ApplicationArea = All;
                    ToolTip = 'Tenants cellphone no.';
                }
                field(CPRno1; Rec.CPRno1)
                {
                    ApplicationArea = All;
                    ToolTip = 'Tenants security no.';
                }
                field(CPRno2; Rec.CPRno2)
                {
                    ApplicationArea = All;
                    ToolTip = 'Second Tenants social security no.';
                }
                field(EndDate; Rec.EndDate)
                {
                    ApplicationArea = All;
                    ToolTip = 'The date this contract expire';
                }

                field(ConsumptionAccountNo; Rec.ConsumptionAccountNo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Tenants consumption account no.';
                }
                field(Bankname; Rec.Bankname)
                {
                    ApplicationArea = all;
                    ToolTip = 'Tenants bankinformation';
                }
                field("Bankreg-no"; Rec."Bankreg-no")
                {
                    ApplicationArea = all;
                    ToolTip = 'Tenants bankinformation';
                }
                field(BankAccount; Rec.BankAccount)
                {
                    ApplicationArea = all;
                    ToolTip = 'Tenants bankinformation';
                }
                field(TransferNETS; Rec.TransferNETS)
                {
                    ApplicationArea = all;
                    ToolTip = 'Status for NETS agreement';
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = All;
                    ToolTip = 'Blocked date';
                }

            }
            group("Div. oplysniger")
            {
                Caption = 'Mis. information';
                field(ChairmanOfTheBoard; Rec.ChairmanOfTheBoard)
                {
                    ApplicationArea = All;
                    ToolTip = 'Is tenant chairman of the board? Not relevant if the tenancy is rented';
                }
                field(BoardMember; Rec.BoardMember)
                {
                    ApplicationArea = All;
                    ToolTip = 'Is tenant member of the board? Not relevant if the tenancy is rented';
                }
                field(BoardAccountent; Rec.BoardAccountent)
                {
                    ApplicationArea = All;
                    ToolTip = 'Is tenant accountant of the board? Not relevant if the tenancy is rented';
                }
                field(ResidentRepresentative; Rec.ResidentRepresentative)
                {
                    ApplicationArea = All;
                    ToolTip = 'Is tenant Residents representative? Only relevant if the tenancy is rented';
                }
            }

            part("Subscription lines"; "SVA Subscription lines subform")
            {
                Caption = 'Subscription lines';
                ApplicationArea = All;
                SubPageLink = Tenancies = FIELD(TenancyNo);
                SubPageView = SORTING(Tenancies, Order, "Date from")
                              ORDER(Descending);

            }
            part("SVAOccupant transactions"; "SVA Occupant Trans Subform")
            {
                Caption = 'Occupant Trans';
                ApplicationArea = All;
                SubPageLink = Occupant = FIELD(Number);
                SubPageView = SORTING(Occupant, Date, "Cost type Estate", "Invoice No") order(descending);
            }

        }
        area(factboxes)
        {
            part("Document Attachment Factbox"; "Document Attachment Factbox")
            {
                Caption = 'Attachments';
                ApplicationArea = all;
                SubPageLink = "Table ID" = Const(50003), "No." = field(Number);
                Visible = not IsOfficeAddin;
            }
            systempart(Links; Links)
            {
                ApplicationArea = RecordLinks;
            }
            systempart(Notes; Notes)
            {
                ApplicationArea = Notes;
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
                    Caption = 'Leasecontract Type A, 10. edistion';
                    Tooltip = 'Go to leasecontract type A, 10. edition for filling';
                    Image = MakeAgreement;
                    trigger OnAction()
                    var
                        SVALeaseContractA10: Record "SVA LeaseContract_A9";
                    begin
                        if (rec.Number <> '') then
                            Codeunit.Run(Codeunit::"SVA Create Contract A10", Rec);
                        Clear(SVALeaseContractA10);
                        SVALeaseContractA10.SetRange(Number, Rec.Number);
                        if SVALeaseContractA10.FindFirst() then
                            Page.Run(Page::"SVA Leasecontract_A9", SVALeaseContractA10);
                    end;
                }
                action(LeasContractGarage)
                {
                    ApplicationArea = All;
                    Caption = 'Leasecontract for garage';
                    Tooltip = 'Go to leasecontract for garage for filling';
                    Image = MakeAgreement;
                    trigger OnAction()
                    var
                        SVALeaseContractA9: Record "SVA LeaseContract_A9";
                    begin
                        if (rec.Number <> '') then
                            Codeunit.Run(Codeunit::"SVA Create Contract A9", Rec);
                        Clear(SVALeaseContractA9);
                        SVALeaseContractA9.SetRange(Number, Rec.Number);
                        if SVALeaseContractA9.FindFirst() then
                            Page.Run(Page::"SVA Leasecontract_Garage", SVALeaseContractA9);
                    end;

                }
                action(LeaseBusiness)
                {
                    ApplicationArea = All;
                    Caption = 'Lease Business';
                    Tooltip = 'Go to lease business for invoicing of moving in costs';
                    Image = MakeAgreement;
                    trigger OnAction()
                    var
                        SVALeaseContractA9: Record "SVA LeaseContract_A9";
                    begin
                        if (rec.Number <> '') then
                            Codeunit.Run(Codeunit::"SVA Create Contract A9", Rec);
                        Clear(SVALeaseContractA9);
                        SVALeaseContractA9.SetRange(Number, Rec.Number);
                        if SVALeaseContractA9.FindFirst() then
                            Page.Run(Page::"SVA Lease Business", SVALeaseContractA9);
                    end;
                }
            }
            group(Regulations)
            {
                Caption = 'Regulations';
                action(Regulation)
                {
                    ApplicationArea = All;
                    Caption = 'Agreed regulation of rent and repayments';
                    Tooltip = 'Contract conditions for regulations and agreed repayments';
                    Image = MakeAgreement;
                    trigger OnAction()
                    var
                        SVAContractregulations: record "SVA Contract regulations";
                    begin
                        if (rec.Number <> '') then
                            Codeunit.Run(Codeunit::"SVA Create Occupant regulation", Rec);
                        Clear(SVAContractregulations);
                        SVAContractregulations.SetRange(SVAContractregulations.Number, Rec.Number);
                        if SVAContractregulations.FindFirst() then
                            Page.Run(Page::"SVA Subscription regulations", SVAContractregulations);
                    end;
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
                    RunPageLink = Occupant = FIELD(Number);
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
                    RunPageLink = Occupant = FIELD(Number);
                    RunPageMode = Edit;
                }
                action(MovingOutJournal)
                {
                    ApplicationArea = All;
                    Caption = 'Journal for moving out invoice';
                    ToolTip = 'Journal for moving out invoice. Use before making an invoice.';
                    Image = Report;

                    trigger OnAction();
                    var
                        SVAOccupant: Record "SVA Occupant";
                        SVAMovingoutJournal: Report "SVA Moving out Journal";
                    begin
                        CLEAR(SVAOccupant);
                        SVAOccupant.SETRANGE(Number, Rec.Number);
                        CLEAR(SVAMovingOutJournal);
                        SVAMovingOutJournal.SETTABLEVIEW(SVAOccupant);
                        SVAMovingOutJournal.RunModal();
                    end;
                }
                action(MovingOutInvoice)
                {
                    ApplicationArea = All;
                    Caption = 'Invoice Moving out';
                    Tooltip = 'Make a moving out invoice based on transactions and subscription lines.';
                    Image = SalesInvoice;
                    RunObject = Page "SVA Move Out Invoice";
                    RunPageLink = Number = FIELD(Number);
                    RunPageMode = Edit;

                    trigger OnAction();
                    var
                        SVAOccupant: Record "SVA Occupant";
                    begin
                        CLEAR(SVAOccupant);
                        SVAOccupant.SETRANGE(Number, Rec.Number);
                        IF SVAOccupant.FindFirst() then
                            Codeunit.run(Codeunit::"SVA Move Out Invoice", SVAOccupant);
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
                    var
                        SVATenancy: Record "SVA Tenancy";
                        SVAOccupant: Record "SVA Occupant";
                        SVADemandNoticeResidence: Report "SVA DemandNoticeResidence";
                        SVADemandNoticeProf: Report "SVA DemandNoticeProf";
                    begin
                        Clear(SVATenancy);
                        SVATenancy.SetRange(number, Rec.TenancyNo);
                        IF SVATenancy.FindFirst() then begin
                            IF SVATenancy.Type = 0 then begin //bolig
                                CLEAR(SVAOccupant);
                                SVAOccupant.SETRANGE(Number, Rec.Number);
                                CLEAR(SVADemandNoticeResidence);
                                SVADemandNoticeResidence.SETTABLEVIEW(SVAOccupant);
                                SVADemandNoticeResidence.Run();
                            END;
                            IF SVATenancy.Type = 1 then begin //erhverv
                                CLEAR(SVAOccupant);
                                SVAOccupant.SETRANGE(Number, Rec.Number);
                                CLEAR(SVADemandNoticeProf);
                                SVADemandNoticeProf.SETTABLEVIEW(SVAOccupant);
                                SVADemandNoticeProf.Run();
                            END;
                        end;
                    end;
                }
                action(Repeal)
                {
                    ApplicationArea = All;
                    Caption = 'Repeal';
                    Tooltip = 'Letter for repeal the tenant';
                    Image = Report;

                    trigger OnAction();
                    var
                        SVATenancy: Record "SVA Tenancy";
                        SVAOccupant: Record "SVA Occupant";
                        SVARepealProf: report "SVA Repeal Prof";
                        SVARepealRes: report "SVA Repeal Res";
                    begin
                        Clear(SVATenancy);
                        SVATenancy.SetRange(number, Rec.TenancyNo);
                        if SVATenancy.FindFirst() then begin
                            IF SVATenancy.Type = 0 then begin //bolig
                                CLEAR(SVAOccupant);
                                SVAOccupant.SETRANGE(Number, Rec.Number);
                                CLEAR(SVARepealRes);
                                SVARepealRes.SETTABLEVIEW(SVAOccupant);
                                SVARepealRes.RunModal();
                            END;
                            IF SVATenancy.Type = 1 then begin //erhverv
                                CLEAR(SVAOccupant);
                                SVAOccupant.SETRANGE(Number, Rec.Number);
                                CLEAR(SVARepealProf);
                                SVARepealProf.SETTABLEVIEW(SVAOccupant);
                                SVARepealProf.RunModal();
                            END;
                        end;
                    end;

                }
                action(Mail)
                {
                    ApplicationArea = All;
                    Caption = 'Send email';
                    Tooltip = 'Send email to the occupant';
                    Image = SendMail;

                    Trigger OnAction()
                    var
                        SVAOccupant: Record "SVA Occupant";
                    begin
                        SVAOccupant.SendEmailToOccupant(Rec);
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
                RunPageLink = "Table ID" = CONST(50003),
                                  "No." = FIELD(Number);
                ShortCutKey = 'Shift+Ctrl+D';
                ToolTip = 'View or edits dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';
            }
            action(Customer)
            {
                ApplicationArea = All;
                Caption = 'Customer';
                Image = Customer;
                RunObject = Page "Customer Card";
                RunPageLink = "No." = field("Customer No");
                ToolTip = 'Customer card';
            }
        }

    }
    trigger OnOpenPage()
    var

        OfficeManagement: Codeunit "Office Management";

    begin
        IsOfficeAddin := Officemanagement.IsAvailable();

    end;

    trigger OnNewRecord(BelowxRec: Boolean);
    var
        SVAParameters: Record "SVA Parameters";
        SVAOccupant: Record "SVA Occupant";
        NoSeriesManagement: Codeunit "NoSeriesManagement";
    begin
        SVAOccupant.Init();
        SVAParameters.Reset();
        IF SVAParameters.FindFirst() then
            Rec.Number := NoSeriesManagement.GetNextNo(SVAParameters.Numberserie, WorkDate(), TRUE);

        IF Rec.Number = '' then
            Error('Nummerserie er ikke opsat. Kørslen afbrydes');

    end;

    trigger OnDeleteRecord(): Boolean;
    var
        SVAOccupantTrans: Record "SVA Occupant Trans";
    begin
        SVAOccupantTrans.Reset();
        SVAOccupantTrans.SetRange(SVAOccupantTrans.Occupant, rec.Number);
        if not SVAOccupantTrans.IsEmpty then
            Error('Kontrakten kan ikke slettes, da der er posteringer.')
    end;

    trigger OnClosePage();
    begin
        Codeunit.Run(Codeunit::"SVA Send");
    end;


    var
        IsOfficeAddin: Boolean;
}

