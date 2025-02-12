page 50012 "SVA Occupant List"
//Tooltips created
{
    Caption = 'List of Occupants';
    CardPageID = "SVA Occupant Card";
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "SVA Occupant";
    DataCaptionFields = Number, Name1;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Number; Rec.Number)
                {
                    ApplicationArea = All;
                    Tooltip = 'Agreement number';
                }
                field(TenancyNo; Rec.TenancyNo)
                {
                    ApplicationArea = All;
                    Tooltip = 'Tenancy number';
                }
                field(Name1; Rec.Name1)
                {
                    ApplicationArea = All;
                    Tooltip = 'Tenant name';
                }
                field(Name2; Rec.Name2)
                {
                    ApplicationArea = All;
                    Tooltip = 'Second tenant name';
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                    Tooltip = 'Invoice address';
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                    Tooltip = 'Invoice city';
                }
                field(Phone; Rec.Phone)
                {
                    ApplicationArea = All;
                    Tooltip = 'Tenants primary phone number';
                }
                field(Email1; Rec.Email1)
                {
                    ApplicationArea = All;
                    Tooltip = 'Tenants primary email';
                    ExtendedDatatype = EMail;
                }
                field(StartDate; Rec.StartDate)
                {
                    ApplicationArea = All;
                    ToolTip = 'Contract startdate';
                }
                field(EndDate; Rec.EndDate)
                {
                    ApplicationArea = All;
                    ToolTip = 'Contract end date.';
                }
                field(AddToMail; Rec.AddToMail)
                {
                    ApplicationArea = All;
                    ToolTip = 'If you need to send email to some of the occupants, but not all, this field has to be set to true.';
                }
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
                ApplicationArea = All;
            }
            systempart(Notat; Notes)
            {
                ApplicationArea = All;
            }
            part(Control1900919607; "Dimension Set Entries FactBox")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "Dimension Set ID" = FIELD("Dimension Set ID");
            }

        }
    }


    actions
    {
        area(Reporting)
        {
            action(Phonelist)
            {

                Caption = 'Occupant phonelist';
                ToolTip = 'Phone list for all active occupants';
                ApplicationArea = All;
                Image = MakeAgreement;
                RunObject = report "SVA Occupant List";
            }
        }
    }
    trigger OnOpenPage()
    var

        OfficeManagement: Codeunit "Office Management";

    begin
        IsOfficeAddin := Officemanagement.IsAvailable();

    end;




    var
        IsOfficeAddin: Boolean;
}
