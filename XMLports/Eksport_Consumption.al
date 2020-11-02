xmlport 50002 "SVA File for Consumption"
{
    Direction = Export;
    Format = FixedText;
    FormatEvaluate = Legacy;
    TextEncoding = WINDOWS;

    schema
    {
        textelement(Root)
        {
            tableelement("SVA Export Temp"; "SVA Export Temp")
            {
                XmlName = 'Table';
                fieldattribute(Tekst; "SVA Export Temp"."Output Line")
                {
                    Width = 256;
                }
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
    trigger OninitXmlPort();
    begin
        SVAExportTemp.Reset();
        SVAExportTemp.SetRange("Line no.", 1);
        if SVAExportTemp.FindFirst() then
            currXMLport.Filename := SVAExportTemp.Name + '.txt';
    end;

    var
        SVAExportTemp: Record "SVA Export Temp";

}

