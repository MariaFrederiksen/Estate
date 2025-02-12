page 50015 "SVA Property List"
//Tooltip created
{
    Caption = 'List of Property';
    CardPageID = "SVA Property Card";
    PageType = List;
    SourceTable = "SVA Property";
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Property; Rec.Property)
                {
                    ApplicationArea = All;
                    ToolTip = 'Property number';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Possibly property name';
                }
                field(Address1; Rec.Address1)
                {
                    ApplicationArea = All;
                    ToolTip = 'Property address';
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Property post code';
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                    ToolTip = 'Property city';
                }
            }
        }
        area(factboxes)
        {
            part("Document Attachment Factbox"; "Document Attachment Factbox")
            {
                Caption = 'Attachments';
                ApplicationArea = all;
                SubPageLink = "Table ID" = Const(50001), "No." = field(Property);
                Visible = not IsOfficeAddin;
            }

            systempart(links; Links)
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
        area(navigation)
        {
            action(Tenancies)
            {
                ApplicationArea = All;
                Caption = 'Tenancies';
                ToolTip = 'Open a list of tenancies for this property.';
                Image = AlternativeAddress;
                RunObject = Page "SVA Tenancy List";
                RunPageLink = PropertyNo = FIELD(Property);

            }
            action(Residens)
            {
                ApplicationArea = All;
                Caption = 'Occupants';
                ToolTip = 'Open a list of occupants for this property.';
                Image = Customer;
                RunObject = Page "SVA Occupant List";
                RunPageLink = PropertyNo = FIELD(Property);

            }
        }
        area(reporting)
        {
            group(Overwiev)
            {

                Caption = 'Overwiew';
                action("Basic data report")
                {
                    ApplicationArea = All;
                    Caption = 'Data sheet report';
                    ToolTip = 'Report for all properties in this company.';
                    Image = Report2;
                    RunObject = Report "SVA Property Data sheet";
                }
                action("Rent_Deposit_PrepaidRent")
                {
                    ApplicationArea = all;
                    Caption = 'Overview Rent, deposit and prepaid rent.';
                    ToolTip = 'Overview Rent, deposit and prepaid rent for each occupant.';
                    Image = PeriodStatus;
                    RunObject = page "SVA Occupant Balances";
                }
                action("Vacant tenancies")
                {
                    ApplicationArea = All;
                    Caption = 'Vacant tenancies';
                    ToolTip = 'List of vacant tenancies for all properties.';
                    Image = Report2;
                    RunObject = Report "SVA Vacant Tenancies";
                }
                action("RegulationList")
                {
                    ApplicationArea = All;
                    Caption = 'List of regulations';
                    ToolTip = 'List of regulations';
                    Image = Report;
                    RunObject = Report "SVA Occupants regulations";
                }
            }
            group(Deposita)
            {
                Caption = 'Generel';

                action("Deposit")
                {
                    ApplicationArea = All;
                    Caption = 'Deposit';
                    ToolTip = 'A list of deposit per occupant.';
                    Image = "Report";
                    RunObject = Report "SVA Deposit all";
                }
                action("Prepaid rent")
                {
                    ApplicationArea = All;
                    Caption = 'Prepaid rent';
                    ToolTip = 'A list of prepaid rent per occupant.';
                    Image = "Report";
                    RunObject = report "SVA Prepaid Rent All";
                }


                action("MoveInOut")
                {
                    ApplicationArea = All;
                    Caption = 'Moving in and out';
                    ToolTip = 'Report with upcomming moving in og moving out';
                    Image = Report;
                    RunObject = Report "SVA MoveInOutList";
                }

            }

        }
        area(processing)
        {
            group(Reports)
            {
                Caption = 'Journals';

                action(Journal)
                {
                    ApplicationArea = All;
                    Caption = 'Collection journal';
                    ToolTip = 'Collection journal, specified pr. occupant.';
                    Image = Report2;
                    RunObject = Report "SVA Collection Journal";
                }
                action(JournalShortReport)
                {
                    ApplicationArea = All;
                    Caption = 'Collection journal (only balances)';
                    ToolTip = 'Collection journal, only with balance per occupant';
                    Image = Report2;
                    RunObject = Report "SVA Collection Journal Short";
                }
                action(TheoreticalEquivalent)
                {
                    ApplicationArea = all;
                    Caption = 'Rent per tenant';
                    ToolTip = 'Rent, AC heat, AC Water, Occgroup and other income per yaer per tenant';
                    Image = Report;
                    RunObject = report "SVA Theoretical Equivalent";
                }
            }


            group(Proces)
            {
                Caption = 'Processing';

                action(Invoicing)
                {
                    ApplicationArea = All;
                    Caption = 'Subscription invoicing';
                    ToolTip = 'Subscription invoicing. Batch invoicing.';
                    Image = SalesInvoice;
                    RunObject = codeunit "SVA Create Invoice Estate";

                }
                action(Nets)
                {
                    ApplicationArea = All;
                    Caption = 'File for NETS type 0601';
                    ToolTip = 'Create file to NETS type 0601 based on invoices with duedate next month and paymentmethod NETS';
                    Image = SalesInvoice;
                    RunObject = Page "SVA Sales Invoice NETS";
                }
                action(NetsIn)
                {
                    ApplicationArea = All;
                    Caption = 'File from NETS type 0602';
                    ToolTip = 'Read file from NETS type 0602 into worksheet';
                    Image = Payment;
                    Trigger OnAction();
                    begin
                        Xmlport.run(Xmlport::"SVA Import NETS", false, true)
                    end;
                }
                action(NetsMandates)
                {
                    ApplicationArea = All;
                    Caption = 'File from NETS type 0603';
                    ToolTip = 'Read file from NETS type 0603 wtih registrate mandates';
                    Image = Payment;
                    Trigger OnAction();
                    begin
                        Xmlport.run(Xmlport::"SVA Import NETS 0603", false, true)
                    end;
                }
                action(NetsStatus)
                {
                    ApplicationArea = All;
                    Caption = 'File to NETS type 0605';
                    ToolTip = 'Send file to NETS with registration of tenants.';
                    Image = Payment;
                    trigger OnAction();
                    begin
                        CODEUNIT.RUN(Codeunit::"SVA NETS BS 0605");
                    end;
                }
            }
            group(Mail)
            {
                action("SendEmailToSomeOccupants")
                {
                    ApplicationArea = All;
                    Caption = 'Email to some occupants';
                    ToolTip = 'Forms an email to some occupants in this property. The field AddToEmail has to be set to true.';
                    Image = Email;
                    trigger OnAction();
                    var
                        SVAProperty: Record "SVA Property";
                    begin
                        SVAProperty.SendEmailToSomeOccupants();
                    end;
                }
                action("ResetSendEmailToSomeOccupants")
                {
                    ApplicationArea = All;
                    Caption = 'Reset AddToEmail';
                    ToolTip = 'Reset field AddToEmail on occupants';
                    Image = Email;
                    trigger OnAction();
                    var
                        SVAProperty: Record "SVA Property";
                    begin
                        SVAProperty.ResetAddToEmail(Rec);
                    end;
                }
            }
            group(Regulations)
            {
                Caption = 'Regulations';
                action(MakeRegulations)
                {
                    ApplicationArea = all;
                    Caption = 'Make rent regulations.';
                    ToolTip = 'Making basic data for rent regulations.';
                    Image = Recalculate;
                    RunObject = Codeunit "SVA Create Regulations";
                }
                action(Regulation)
                {
                    ApplicationArea = all;
                    Caption = 'Rent regulations';
                    ToolTip = 'List of rent regulations for futher processing.';
                    Image = PriceAdjustment;
                    RunObject = Page "SVA Regulations";
                }
            }
        }
    }
    trigger OnOpenPage()
    var
        SVAProperty: Record "SVA Property";
        SVATenancy: Record "SVA Tenancy";
        OfficeManagement: Codeunit "Office Management";
    begin
        IsOfficeAddin := Officemanagement.IsAvailable();
        SVAProperty.Reset();
        if SVAProperty.FindSet() then
            repeat
                SVAProperty.SquareMetersLiv := 0;
                SVAProperty.SquareMetersProf := 0;
                SVAProperty.SquareMetersTotal := 0;
                SVATenancy.Reset();
                SVATenancy.SETRANGE(PropertyNo, SVAProperty.Property);
                if SVATenancy.FindSet() then
                    repeat
                        SVAProperty.SquareMetersLiv += SVATenancy.AreaLiv;
                        SVAProperty.SquareMetersProf += SVATenancy.AreaPro;
                        SVAProperty.SquareMetersTotal := SVAProperty.SquareMetersLiv + SVAProperty.SquareMetersProf;
                    until SVATenancy.NEXT() = 0;

                SVAProperty.Modify();
            until SVAProperty.NEXT() = 0;
    end;

    trigger OnClosePage();
    var
    begin
        Codeunit.Run(Codeunit::"SVA Send");
    end;

    var
        IsOfficeAddin: Boolean;
}

