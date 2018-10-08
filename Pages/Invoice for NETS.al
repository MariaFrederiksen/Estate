page 60630 "Sales Invoice NETS"
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
                }
                field("Bill-to Customer No.";"Bill-to Customer No.")
                {
                    Editable = false;
                }
                field("Bill-to Name";"Bill-to Name")
                {
                    Editable = false;
                }
                field("Posting Date";"Posting Date")
                {
                    Editable = false;
                }
                field("Due Date";"Due Date")
                {
                    Editable = false;
                }
                field("Amount Including VAT";"Amount Including VAT")
                {
                    Editable = false;
                }
                field("SVA Included";"SVA Included")
                {
                }
                field("SVA Send";"SVA Send")
                {
                }
                field("SVA Send date";"SVA Send date")
                {
                    Editable = false;
                }
                field("SVA Occupant";"SVA Occupant")
                {
                    Editable = false;
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
          FromDate := DMY2DATE(1, DATE2DMY(TODAY,2)+1, DATE2DMY(TODAY,3)+1);
          END;
        IF DATE2DMY(TODAY,2) < 12 THEN BEGIN
          FromDate := DMY2DATE(1, DATE2DMY(TODAY,2)+1, DATE2DMY(TODAY,3));
          END;
        ToDate := DMY2DATE(1, DATE2DMY(TODAY,2)+1+1, DATE2DMY(TODAY,3));
        ToDate := ToDate - 1;
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

