page 50015 "SVA Property List"
//Tooltip created
{
    Caption = 'List of SVAProperty';
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
                field(Property; Property)
                {
                    ApplicationArea = All;
                    ToolTip = 'Property number';
                }
                field(Name; Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Possibly property name';
                }
                field(Address1; Address1)
                {
                    ApplicationArea = All;
                    ToolTip = 'Property address';
                }
                field("Post Code"; "Post Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Property post code';
                }
                field(City; City)
                {
                    ApplicationArea = All;
                    ToolTip = 'Property city';
                }
            }
        }
        area(factboxes)
        {

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
                Image = AlternativeAddress;
                RunObject = Page "SVA Tenancy List";
                RunPageLink = PropertyNo = FIELD(Property);

            }
            action(Residens)
            {
                ApplicationArea = All;
                Caption = 'Occupants';
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
                    Image = Report2;
                    RunObject = Report "SVA Property Data sheet";
                }
                action("Vacant tenancies")
                {
                    ApplicationArea = All;
                    Caption = 'Vacant tenancies';
                    Image = Report2;
                    RunObject = Report "SVA Vacant Tenancies";
                }
                action("RegulationList")
                {
                    ApplicationArea = All;
                    Caption = 'List of regulations';
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
                    Image = Report2;
                    RunObject = Report "SVA Collection Journal";
                }
                action(JournalShortReport)
                {
                    ApplicationArea = All;
                    Caption = 'Collection journal (only balances)';
                    Image = Report2;
                    RunObject = Report "SVA Collection Journal Short";
                }
            }
            group(Proces)
            {
                Caption = 'Processing';

                action(Invoicing)
                {
                    ApplicationArea = All;
                    Caption = 'Subscription invoicing';
                    Image = SalesInvoice;
                    RunObject = codeunit "SVA Create Invoice Estate";

                }
                action(Nets)
                {
                    ApplicationArea = All;
                    Caption = 'File for NETS type 0601';
                    Image = SalesInvoice;
                    RunObject = Page "SVA Sales Invoice NETS";
                }
                action(NetsIn)
                {
                    ApplicationArea = All;
                    Caption = 'File from NETS type 0602';
                    Image = Payment;
                    Trigger OnAction();
                    begin
                        Xmlport.run(Xmlport::"SVA Import NETS", false, true)
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
                    Caption = 'Rent regulations (indeks)';
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
    begin
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
    begin
        Codeunit.Run(Codeunit::"SVA Send");
    end;
}

