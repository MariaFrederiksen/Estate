xmlport 50012 "SVA Import NETS 0603"
{
    Caption = 'Import NETS';
    FileName = 'D*.*';
    Direction = Import;
    Format = FixedText;
    FormatEvaluate = Legacy;
    TextEncoding = WINDOWS;
    PreserveWhiteSpace = true;

    schema
    {
        textelement(Root)
        {
            tableelement("CSV Buffer"; "CSV Buffer")
            {
                XmlName = 'SVA_NETS_BUFFER';
                fieldelement(Line; "CSV Buffer".Value)
                {
                    Width = 128;
                }

                trigger OnBeforeInsertRecord();
                begin
                    I += 1;
                    "CSV Buffer"."Line No." := I;
                    "CSV Buffer"."Field No." := I;
                end;
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    trigger OnInitXmlPort();
    begin
        I := 0;
        "CSV Buffer".DeleteAll();
        Commit();
    end;

    trigger OnPostXmlPort();
    begin
        Commit();
        Report.Run(Report::"SVA Import NETS 0603");
        Commit();
        Codeunit.Run(Codeunit::"SVA BS NETS 0603");
    end;

    var
        I: Integer;
}

