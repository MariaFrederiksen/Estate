xmlport 50103 "Import Tenancies"
{
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = WINDOWS;

    schema
    {
        textelement(Root)
        {
            tableelement("SVA Tenancy";"SVA Tenancy")
            {
                XmlName = 'Tenancies';
                fieldattribute(Property;"SVA Tenancy".PropertyNo)
                {
                }
                fieldattribute(Number;"SVA Tenancy".Number)
                {
                }
                fieldattribute(Name;"SVA Tenancy".Name)
                {
                }
                fieldattribute(Address1;"SVA Tenancy".Address1)
                {
                }
                fieldattribute(Address2;"SVA Tenancy".Address2)
                {
                }
                fieldattribute(Postcode;"SVA Tenancy"."Post Code")
                {
                }
                fieldattribute(City;"SVA Tenancy".City)
                {
                }
                fieldattribute(Type;"SVA Tenancy".Type)
                {
                }
                fieldattribute(Period;"SVA Tenancy".PeriodYear)
                {
                }
                fieldattribute("AreaTotal";"SVA Tenancy".AreaTotal)
                {
                }
                fieldattribute(Rooms;"SVA Tenancy".Rooms)
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

