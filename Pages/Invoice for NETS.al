page 50003 "SVA Sales Invoice NETS"
//Tooltip created.
{
    Caption = 'List of invoices for NETS';
    Permissions = tabledata 112 = rm;
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    UsageCategory = Tasks;
    ApplicationArea = All;
    SourceTable = "Sales Invoice Header";
    SourceTableView = SORTING("No.")
                WHERE(Closed = CONST(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; "No.")
                {
                    Editable = false;
                    ToolTip = 'Invoicenumber. No change posible';
                    ApplicationArea = all;
                }
                field("Bill-to Customer No."; "Bill-to Customer No.")
                {
                    Editable = false;
                    ToolTip = 'Customer Number. No change posible';
                    ApplicationArea = all;
                }
                field("Bill-to Name"; "Bill-to Name")
                {
                    Editable = false;
                    ToolTip = 'Customer name. No change posible';
                    ApplicationArea = all;
                }
                field("Posting Date"; "Posting Date")
                {
                    Editable = false;
                    ToolTip = 'Posting date. No change posible';
                    ApplicationArea = all;
                }
                field("Due Date"; "Due Date")
                {
                    Editable = false;
                    ToolTip = 'Duedate. No change posible';
                    ApplicationArea = all;
                }
                field("Amount Including VAT"; "Amount Including VAT")
                {
                    Editable = false;
                    ToolTip = 'Amount including VAT. No change posible';
                    ApplicationArea = all;
                }
                field("SVA Included"; "SVA Included")
                {
                    ToolTip = 'This invoice will be included in the file for NETS';
                    ApplicationArea = all;
                }
                field("SVA Send"; "SVA Send")
                {
                    ToolTip = 'This invoice has been added to the file for NETS';
                    ApplicationArea = all;
                }
                field("SVA Send date"; "SVA Send date")
                {
                    Editable = false;
                    ToolTip = 'This invoice has been added to the file for NETS at this date.';
                    ApplicationArea = all;
                }
                field("SVA Occupant"; "SVA Occupant")
                {
                    Editable = false;
                    ToolTip = 'Occupant. No change posible';
                    ApplicationArea = all;
                }
            }
        }
        area(factboxes)
        {
            systempart(Notes; Notes)
            {
                ApplicationArea = All;
            }
            systempart(Links; Links)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Nets)
            {
                Caption = 'File for NETS';
                ToolTip = 'Make a file for NETS.';
                Image = PostDocument;
                ApplicationArea = all;

                trigger OnAction();
                begin

                    CODEUNIT.RUN(Codeunit::"SVA NETS BS 0601");
                    COMMIT;
                    XMLPORT.RUN(xmlport::"SVA File for NETS", false);
                end;
            }
            action(Reset)
            {
                Caption = 'Reset';
                ToolTip = 'Reset. It will then be possible to create a new file for NETS';
                Image = PostDocument;
                ApplicationArea = all;

                trigger OnAction();
                begin
                    Codeunit.run(Codeunit::"SVA Reset NETS");
                END;
            }


        }
    }

    trigger OnInit();
    begin
        IF DATE2DMY(WorkDate, 2) = 12 THEN BEGIN
            FromDate := DMY2DATE(1, DATE2DMY(WorkDate, 2) - 11, DATE2DMY(WorkDate, 3) + 1); //01-01-Next year
        END;
        IF DATE2DMY(WorkDate, 2) < 12 THEN BEGIN
            FromDate := DMY2DATE(1, DATE2DMY(WorkDate, 2) + 1, DATE2DMY(WorkDate, 3)); //01-next month
        end;
        ToDate := CalcDate('<1M>-1D', FromDate);
    end;

    trigger OnOpenPage();
    begin
        Parameters.Reset();
        if Parameters.FindFirst() then
            PaymentMethodForNets := Parameters.PaymentMethodForNets;

        SETRANGE("Due Date", FromDate, ToDate);
        SetRange("Payment Method Code", PaymentMethodForNets);
    end;

    var
        FromDate: Date;
        ToDate: Date;
        Parameters: Record "SVA Parameters";
        PaymentMethodForNets: Text[20];


}

