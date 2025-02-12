page 50027 "SVA Move Out Invoice"
{
    PageType = Card;
    SourceTable = "SVA MoveOut Invoice Header";
    Caption = 'Moveout Invoice';

    layout
    {
        area(Content)
        {
            group(Customer)
            {
                Caption = 'Customer';
                field(Number; Rec.Number)
                {
                    ApplicationArea = All;
                    Tooltip = 'Agreement number';
                }
                field("Customer No"; Rec."Customer No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Costumer no. from customer table.';
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
                field(startdate; Rec.StartDate)
                {
                    ApplicationArea = All;
                    ToolTip = 'Startdate of the contract.';
                }
                field(EndDate; Rec.EndDate)
                {
                    ApplicationArea = All;
                    ToolTip = 'The date this contract expire';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Bogføringsdato for fraflytningsfaktura';
                }
                field(DueDate; Rec.DueDate)
                {
                    ApplicationArea = All;
                    ToolTip = 'Forfaldsdato for fraflytningsfaktura';
                }
            }
            part("SVA Moveout Invoice Line"; "SVA Moveout Invoice Line")
            {
                Caption = 'Invoice lines';
                ApplicationArea = All;
                SubPageLink = "Line Number" = FIELD(Number);
                SubPageView = sorting("Line Number", "Line No.");
                UpdatePropagation = Both;
            }
        }


    }


    actions
    {
        area(Processing)
        {
            action(Posting)
            {
                Caption = 'Posting';
                ToolTip = 'Posting invoice/Cr.Memo';
                ApplicationArea = All;
                Image = Invoice;

                trigger OnAction()
                var
                    SVAMoveOutInvoiceHeader: Record "SVA MoveOut Invoice Header";
                begin
                    SVAMoveOutInvoiceHeader.CreatePosting(Rec."Customer No",Rec.Number, false);
                end;
            }
            action(PostingAndSend)
            {
                Caption = 'Post and send';
                ToolTip = 'Posting and send invoice/Cr.Memo';
                ApplicationArea = All;
                Image = "Invoicing-Send";

                trigger OnAction()
                var
                    SVAMoveOutInvoiceHeader: Record "SVA MoveOut Invoice Header";
                begin
                    SVAMoveOutInvoiceHeader.CreatePosting(Rec."Customer No", Rec.Number, true);
                end;
            }
        }
    }
}