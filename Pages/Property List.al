page 50015 "SVA Property List"
//Tooltip created
{
    Caption = 'List of Properties';
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
            action("MoveInOut")
            {
                ApplicationArea = All;
                Caption = 'Moving in and out';
                Image = Report;
                RunObject = Report "SVA MoveInOutList";
            }
            action("RegulationList")
            {
                ApplicationArea = All;
                Caption = 'List of regulations';
                Image = Report;
                RunObject = Report "SVA Occupants regulations";
            }
            action(JournalShortReport)
            {
                ApplicationArea = All;
                Caption = 'Collection journal (only balances)';
                Image = Report2;
                RunObject = Report "SVA Collection Journal Short";
            }

        }
        area(processing)
        {
            action(Journal)
            {
                ApplicationArea = All;
                Caption = 'Collection journal';
                Image = Report2;
                RunObject = Report "SVA Collection Journal";
            }

            action(Invoicing)
            {
                ApplicationArea = All;
                Caption = 'Subscription invoicing';
                Image = SalesInvoice;
                trigger OnAction()
                begin
                    // Message('Før kald');
                    Codeunit.Run(Codeunit::"SVA Create Invoice Estate");
                    // Message('Efter kald');
                end;

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
            group(Lejereguleringer)
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
                action(Regulations)
                {
                    ApplicationArea = all;
                    Caption = 'Rent regulations (indeks)';
                    ToolTip = 'List of rent regulations for futher processing.';
                    Image = Report;
                    RunObject = Page "SVA Regulations";
                }
            }

        }

    }
    trigger OnOpenPage()
    var
        Properties: Record "SVA Property";
        Tenancies: Record "SVA Tenancy";
    begin
        Properties.Reset;
        if Properties.FindSet() then
            repeat
                Properties.SquareMetersLiv := 0;
                Properties.SquareMetersProf := 0;
                Properties.SquareMetersTotal := 0;
                Tenancies.RESET;
                Tenancies.SETRANGE(PropertyNo, Properties.Property);
                if Tenancies.FindSet() then
                    repeat
                        Properties.SquareMetersLiv += Tenancies.AreaLiv;
                        Properties.SquareMetersProf += Tenancies.AreaPro;
                        Properties.SquareMetersTotal := Properties.SquareMetersLiv + Properties.SquareMetersProf;
                    until Tenancies.NEXT = 0;

                Properties.Modify();
            until Properties.Next = 0;
    end;

    trigger OnClosePage();
    begin
        Codeunit.Run(Codeunit::"SVA Send");
    end;
}

