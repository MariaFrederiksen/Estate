xmlport 50102 "SVA Import Properties"
{
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = WINDOWS;

    schema
    {
        textelement(Root)
        {
            tableelement("SVA Property";"SVA Property")
            {
                XmlName = 'Property';
                fieldattribute(Number;"SVA Property".Property)
                {
                }
                fieldattribute(Name;"SVA Property".Name)
                {
                }
                fieldattribute(Address1;"SVA Property".Address1)
                {
                }
                fieldattribute(Address2;"SVA Property".Address2)
                {
                }
                fieldattribute(Postcode;"SVA Property"."Post Code")
                {
                }
                fieldattribute(City;"SVA Property".City)
                {
                }
                fieldattribute(CVR;"SVA Property".CompanyRegNo)
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

