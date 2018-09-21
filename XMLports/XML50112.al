xmlport 50112 "SVA Import No. series 1"
{

    schema
    {
        textelement(root)
        {
            tableelement("No. Series";"No. Series")
            {
                XmlName = 'Table';
                fieldattribute(F1;"No. Series".Code)
                {
                }
                fieldattribute(f2;"No. Series".Description)
                {
                }
                fieldattribute(f3;"No. Series"."Default Nos.")
                {
                }
                fieldattribute(f4;"No. Series"."Manual Nos.")
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
}

