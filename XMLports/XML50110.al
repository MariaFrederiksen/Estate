xmlport 50110 "SVA Import Estate Cost Type"
{
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = WINDOWS;

    schema
    {
        textelement(Root)
        {
            tableelement("SVA Cost type Estate";"SVA Cost type")
            {
                XmlName = 'Konteringsart';
                fieldattribute(Costtype;"SVA Cost type Estate".Costtype)
                {
                }
                fieldattribute(Description;"SVA Cost type Estate".Description)
                {
                }
                fieldattribute(Account;"SVA Cost type Estate".Account)
                {
                }
                fieldattribute(Type;"SVA Cost type Estate".Type)
                {
                }
                fieldattribute(Rkf;"SVA Cost type Estate".Order)
                {
                }
                fieldattribute(ReminderAllowed;"SVA Cost type Estate".Reminder)
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

