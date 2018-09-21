xmlport 50000 "SVA File for NETS"
{
    Direction = Export;
    FileName = 'NETS 0601.txt';
    Format = FixedText;
    FormatEvaluate = Legacy;
    TextEncoding = WINDOWS;

    schema
    {
        textelement(Root)
        {
            tableelement("CAL Test Line";"CAL Test Line")

            {
                XmlName = 'Table';
                fieldattribute(Tekst;"CAL Test Line".Name)
                {
                    Width = 250;
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
}

