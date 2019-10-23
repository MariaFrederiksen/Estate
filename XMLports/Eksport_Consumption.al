xmlport 50062 "SVA File for Consumption"
{
    Direction = Export;
    Format = FixedText;
    FormatEvaluate = Legacy;
    TextEncoding = WINDOWS;
   
    schema
    {
        textelement(Root)
        {
            tableelement("SVA Export Temp";"SVA Export Temp")
            {
                XmlName = 'Table';
                fieldattribute(Tekst;"SVA Export Temp"."Output Line")
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
            ExportTemp.Reset;
            ExportTemp.SetRange("Line no.",1);
            if ExportTemp.FindFirst then
                currXMLport.Filename := ExportTemp.Name+'.txt';
    end;
  
    var
    ExportTemp : Record "SVA Export Temp";

}

