xmlport 50004 "SVA Import Post Code"
{
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = WINDOWS;

    schema
    {
        textelement(Root)
        {
            tableelement("SVA PostCode"; "SVA PostCode")
            {
                XmlName = 'PostcodeDK';
                fieldattribute(Code;"SVA PostCode".PostCode)
                {
                }
                fieldattribute(Country;"SVA PostCode".Country)
                {
                }
                fieldattribute(City;"SVA PostCode".City)
                {
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

    trigger OnPostXmlPort();
    begin
        Message('Alle postnumre er indlæst');
    end;
}

