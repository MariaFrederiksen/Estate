page 50009 "SVA Occupant Card"
//Tooltip created
{
    Caption = 'SVAOccupants';
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
                    ToolTip = 'First time to NETS or first time to be invoiced after moving in invoice.';
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
                SubPageLink = Tenancies = FIELD(TenancyNo);
                SubPageView = SORTING(Tenancies, "Date To")
                              ORDER(Ascending);
            }
            part("SVAOccupant transactions"; "SVA Occupant Trans Subform")
            {
                Caption = 'SVAOccupant Trans';
                Tooltip = 'SVAOccupant trans for this contract.';
                ApplicationArea = All;
                SubPageLink = Occupant = FIELD(Number);
                SubPageView = SORTING(Occupant, Date, "Cost type Estate", "Invoice No");
            }
        }
        area(factboxes)
        {
            part("Attached Documents"; 1174)
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(50003),
                              "No." = FIELD(Number);
                Visible = NOT IsOfficeAddin;
            }

            systempart(Links; Links)
            {
                ApplicationArea = All;
            }
            systempart(Notes; Notes)
            {
                ApplicationArea = All;
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
                    RunPageLink = Number = FIELD(Number);
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
                    RunPageLink = Number = FIELD(Number);
                    RunPageMode = Edit;
                }
                action(LeaseBusiness)
                {
                    ApplicationArea = All;
                    Caption = 'Lease Business';
                    Tooltip = 'Go to lease business for invoicing of moving in costs';
                    Image = MakeAgreement;
                    RunObject = Page "SVA Lease Business";
                    RunPageLink = Number = FIELD(Number);
                    RunPageMode = Edit;
                }
            }
            group(reguleringer)
            {
                Caption = 'Regulations';
                action(Regulations)
                {
                    ApplicationArea = All;
                    Caption = 'Agreed regulation of rent and repayments';
                    Tooltip = 'Contract conditions for regulations and agreed repayments';
                    Image = MakeAgreement;
                    RunObject = Page "SVA Subscription regulations";
                    RunPageLink = Number = FIELD(Number);
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

                    trigger OnAction();
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
                    begin
                        Clear(SVATenancy);
                        SVATenancy.SetRange(number, Rec.TenancyNo);
                        IF SVATenancy.FindFirst() then begin
                            IF SVATenancy.Type = 0 then begin //bolig
                                CLEAR(SVAOccupant);
                                SVAOccupant.SETRANGE(Number, Rec.Number);
                                CLEAR(SVADemandNoticeResidence);
                                SVADemandNoticeResidence.SETTABLEVIEW(SVAOccupant);
                                SVADemandNoticeResidence.RunModal();
                            END;
                            IF SVATenancy.Type = 1 then begin //erhverv
                                CLEAR(SVAOccupant);
                                SVAOccupant.SETRANGE(Number, Rec.Number);
                                CLEAR(SVADemandNoticeProf);
                                SVADemandNoticeProf.SETTABLEVIEW(SVAOccupant);
                                SVADemandNoticeProf.RunModal();
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
        }

    }
    trigger OnOpenPage()
    var
        OfficeManagement: Codeunit "Office Management";
    begin
        IsOfficeAddin := Officemanagement.IsAvailable()
    end;

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        SVAOccupant.Init();
        SVAParameters.Reset();
        IF SVAParameters.FindFirst() then
            Number := NoSeriesManagement.GetNextNo(SVAParameters.Numberserie, WorkDate(), TRUE);

        IF Number = '' then
            Error('Nummerserie er ikke opsat. Kørslen afbrydes');

    end;

    trigger OnDeleteRecord(): Boolean;
    begin
        SVAOccupantTrans.Reset();
        SVAOccupantTrans.SetRange(SVAOccupantTrans.Occupant, rec.Number);
        IF SVAOccupantTrans.FindFirst() then
            Error('Kontrakten kan ikke slettes, da der er posteringer.')

    end;

    trigger OnClosePage();
    begin
        Codeunit.Run(Codeunit::"SVA Send");
    end;

    var
        SVATenancy: Record "SVA Tenancy";
        SVAOccupant: Record "SVA Occupant";
        SVAParameters: Record "SVA Parameters";
        SVAOccupantTrans: Record "SVA Occupant Trans";
        SVADemandNoticeResidence: Report "SVA DemandNoticeResidence";
        SVAMovingoutJournal: Report "SVA Moving out Journal";
        SVADemandNoticeProf: Report "SVA DemandNoticeProf";
        SVARepealProf: report "SVA Repeal Prof";
        SVARepealRes: report "SVA Repeal Res";
        NoSeriesManagement: Codeunit "NoSeriesManagement";
        IsOfficeAddin: Boolean;
}

