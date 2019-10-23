xmlport 50063 "SVA File for NETS"
{
    Direction = Export;
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
                    Width = 128;
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
    trigger OnInitXmlPort();
    begin
        Companyinfo.GET;
        VatNo := DelChr(Companyinfo."VAT Registration No.",'=');
        currxmlport.Filename := 'NETS 0601 '+VatNo+'.txt';
    end;
        
    var
       Companyinfo : Record "Company Information";
       VatNo :Text[8];

}

