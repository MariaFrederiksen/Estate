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
            tableelement("SVA Export Temp"; "SVA Export Temp")
            {
                XmlName = 'Table';
                fieldattribute(Tekst; "SVA Export Temp"."Output Line 128")
                {
                    Width = 128;
                    trigger OnBeforePassField();
                    begin
                        if "SVA Export Temp".Name <> 'BS0601' then
                            currXMLport.Skip;
                    end;
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
        VatNo := DelChr(Companyinfo."VAT Registration No.", '=');
        currxmlport.Filename := 'NETS 0601 ' + VatNo + '.txt';
    end;

    var
        CompanyInfo: Record "Company Information";

        VatNo: Text[8];

}

