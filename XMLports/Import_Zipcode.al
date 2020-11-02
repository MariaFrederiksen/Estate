xmlport 50004 "SVA Import Post Code"
{
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = WINDOWS;

    schema
    {
        textelement(Root)
        {
            tableelement("Post Code"; "Post Code")
            {
                XmlName = 'PostcodeDK';
                fieldattribute(Zipcode; "Post Code".Code)
                {
                }
                fieldattribute(Zipcode; "Post Code".City)
                {
                }
                fieldattribute(Zipcode; "Post Code"."Country/Region Code")
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

