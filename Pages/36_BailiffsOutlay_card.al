page 50036 "SVA Bailiffs Outlay Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "SVA Bailiff's Outlay";

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field(LawyerCaseNo; Rec.LawyerCaseNo)
                {
                    ApplicationArea = all;
                    ToolTip = 'Lawyer case no.';
                }
                field(LawyerName; Rec.LawyerName)
                {
                    ApplicationArea = all;
                    ToolTip = 'Lawyers companyname';
                }
                field(LawyerAddress; Rec.LawyerAddress)
                {
                    ApplicationArea = all;
                    ToolTip = 'Lawyers companyadress';
                }
                field(City; Rec.City)
                {
                    ApplicationArea = all;
                    ToolTip = 'Lawyers company city';
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Lawyers company post code';
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Lawyers countrycode';
                }
                field(LawyerPhone; Rec.LawyerPhone)
                {
                    ApplicationArea = all;
                    ToolTip = 'Lawyers phonenumber';
                }
                field(LawyerEmail; Rec.LawyerEmail)
                {
                    ApplicationArea = all;
                    ToolTip = 'Lawyers email';
                }
                field("VAT registration No."; Rec."VAT registration No.")
                {
                    ApplicationArea = all;
                    ToolTip = 'Lawyers VAT registration Number';
                }
                field("Contact name"; Rec."Contact name")
                {
                    ApplicationArea = all;
                    ToolTip = 'Contact name at lawyer';
                }
                field("Judgment date"; Rec."Judgment date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Judgment date';
                }
                field("Letter recieved"; Rec."Letter recieved")
                {
                    ApplicationArea = all;
                    ToolTip = 'Letter from lawyer recived at';
                }
                field(Bankname; Rec.Bankname)
                {
                    ApplicationArea = all;
                    ToolTip = 'Lawyer bankname';
                }
                field(BankBranchNo; Rec.BankBranchNo)
                {
                    ApplicationArea = all;
                    ToolTip = 'Lawyer bank branch no.';
                }
                field(BankAccountNo; Rec.BankAccountNo)
                {
                    ApplicationArea = all;
                    ToolTip = 'Lawyer bank account no.';
                }

                field(Occupant; Rec.Occupant)
                {
                    ApplicationArea = all;
                    ToolTip = 'Occupant number';
                }
                field(OccupantName; Rec.OccupantName)
                {
                    ApplicationArea = all;
                    ToolTip = 'Occupant name';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = all;
                    ToolTip = 'The amount of the outlay';
                }
            }
        }
            area(Factboxes)
        {
            part("Document Attachment Factbox"; "Document Attachment Factbox")
            {
                Caption = 'Attachments';
                ApplicationArea = all;
                SubPageLink = "Table ID" = Const(50035), "No." = field(LawyerCaseNo);
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
}