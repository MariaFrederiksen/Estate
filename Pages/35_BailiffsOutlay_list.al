page 50035 "SVA Bailiffs Outlay"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "SVA Bailiff's Outlay";
    CardPageId = "SVA Bailiffs Outlay Card";


    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Occupant; Rec.Occupant)
                {
                    ApplicationArea = All;
                    ToolTip = 'Lease contract no.';
                }
                field(OccupantName; Rec.OccupantName)
                {
                    ApplicationArea = all;
                    ToolTip = 'Occupant name';
                }
                field(LawyerName; Rec.LawyerName)
                {
                    ApplicationArea = all;
                    ToolTip = 'Lawyer name';
                }
                field("Letter recieved"; Rec."Letter recieved")
                {
                    ApplicationArea = all;
                    ToolTip = 'Letter recieved date';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = all;
                    ToolTip = 'Outlay amount';
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
                Visible = true;
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