page 60630 "SVA Sales Invoice NETS"
//Tooltip created.
{
    Caption='Invoices for NETS';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Sales Invoice Header";
    SourceTableView = SORTING("No.") 
                WHERE(Closed=CONST(false));
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No.";"No.")
                {
                    Editable = false;
                    ToolTip='Number. No change posible';
                }
                field("Bill-to Customer No.";"Bill-to Customer No.")
                {
                    Editable = false;
                    ToolTip='Customer Number. No change posible';
                }
                field("Bill-to Name";"Bill-to Name")
                {
                    Editable = false;
                    ToolTip='Customer name. No change posible';
                }
                field("Posting Date";"Posting Date")
                {
                    Editable = false;
                    ToolTip='Posting date. No change posible';
                }
                field("Due Date";"Due Date")
                {
                    Editable = false;
                    ToolTip='Duedate. No change posible';
                }
                field("Amount Including VAT";"Amount Including VAT")
                {
                    Editable = false;
                    ToolTip='Amount including VAT. No change posible';
                }
                field("SVA Included";"SVA Included")
                {
                    ToolTip='This invoice will be included in the file for NETS';
                }
                field("SVA Send";"SVA Send")
                {
                    ToolTip='This invoice has been added to the file for NETS';
                }
                field("SVA Send date";"SVA Send date")
                {
                    Editable = false;
                    ToolTip='This invoice has been added to the file for NETS at this date.';
                }
                field("SVA Occupant";"SVA Occupant")
                {
                    Editable = false;
                    ToolTip='Occupant. No change posible';
                }
            }
        }
        area(factboxes)
        {
            systempart(Notes;Notes)
            {
            }
            systempart(Links;Links)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Handlinger)
            {
                Caption='Actions';
                action(Nets)
                {
                    Caption='File for NETS';
                    ToolTip='Make a file for NETS.';
                    Image = PostDocument;

                    trigger OnAction();
                    begin
                        CODEUNIT.RUN(60520);
                        COMMIT;
                        XMLPORT.RUN(50000);
                    end;
                }
                action(Reset)
                {
                    Caption='Reset';
                    ToolTip='Reset. It will then be possible to create a new file for NETS';
                    Image = PostDocument;
                    trigger OnAction();
                    begin
                        Codeunit.run(60510);
                    END;    
                }

            }
        }
    }

    trigger OnInit();
    begin
        IF DATE2DMY(TODAY,2) = 12 THEN BEGIN
          FromDate := DMY2DATE(1, DATE2DMY(TODAY,2)-11, DATE2DMY(TODAY,3)+1); //01-01-Next year
          END;
        IF DATE2DMY(TODAY,2) < 12 THEN BEGIN
          FromDate := DMY2DATE(1, DATE2DMY(TODAY,2)+1, DATE2DMY(TODAY,3)); //01-next month
          end;
        ToDate := CalcDate('<1M>-1D',FromDate);
    end;

    trigger OnOpenPage();
    begin
        SETRANGE("Due Date",FromDate,ToDate);
        SetRange("Payment Method Code",'nets');
    end;

    var
        FromDate : Date;
        ToDate : Date;
        SalesHeader : Record "Sales Invoice Header";
}

