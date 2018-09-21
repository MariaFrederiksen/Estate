xmlport 50101 "SVA Import Accounts"
{
    FieldSeparator = ';';
    Format = VariableText;
    FormatEvaluate = Legacy;
    TextEncoding = WINDOWS;

    schema
    {
        textelement(root)
        {
            tableelement("G/L Account";"G/L Account")
            {
                XmlName = 'Konto';
                fieldattribute(Kontofelt;"G/L Account"."No.")
                {
                }
                fieldattribute(Navn;"G/L Account".Name)
                {
                }
                fieldattribute(Type;"G/L Account"."Account Type")
                {
                }
                fieldattribute(Type2;"G/L Account"."Income/Balance")
                {
                }
                fieldattribute(Posting;"G/L Account"."Gen. Posting Type")
                {
                }
                fieldattribute(Virk;"G/L Account"."Gen. Bus. Posting Group")
                {
                }
                fieldattribute(Prod;"G/L Account"."Gen. Prod. Posting Group")
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

