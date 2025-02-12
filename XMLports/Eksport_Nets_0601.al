xmlport 50003 "SVA File for NETS"
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
                            currXMLport.Skip();
                    end;
                }
                trigger OnAfterGetRecord()
                begin
                    if "SVA Export Temp".Name <> 'BS0601' then
                        currXMLport.Skip();
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
    var

    begin
        CompanyInformation.GET();
        VatNo := DelChr(CompanyInformation."VAT Registration No.", '=');
        currxmlport.Filename := 'NETS 0601 ' + VatNo + '.txt';
    end;

    trigger OnPostXmlPort()
    var
        SVAExportTemp: Record "SVA Export Temp";
    begin
        SVAExportTemp.Reset();
        SVAExportTemp.SetRange(Name, 'BS0605');
        if SVAExportTemp.FindSet() then
            SVAExportTemp.DeleteAll();
    end;

    var
        CompanyInformation: Record "Company Information";
        VatNo: Text[8];

}

