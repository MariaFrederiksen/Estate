xmlport 50120 "SVA Import Collections"
{
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = WINDOWS;

    schema
    {
        textelement(Root)
        {
            tableelement("SVA Subscription Lines";"SVA Subscription Lines")
            {
                XmlName = 'Subscriptionlines';
                fieldattribute(Tenancies;"SVA Subscription Lines".Tenancies)
                {
                }
                fieldattribute(Costtype;"SVA Subscription Lines"."Cost Types")
                {
                }
                fieldattribute(Description;"SVA Subscription Lines".Description)
                {
                }
                fieldattribute(FromDate;"SVA Subscription Lines"."Date From")
                {
                }
                fieldattribute(Todate;"SVA Subscription Lines"."Date To")
                {
                }
                fieldattribute(AmountYear;"SVA Subscription Lines"."Amount Year")
                {
                }
                fieldattribute(AmountPer;"SVA Subscription Lines"."Amount Period")
                {
                }
                fieldattribute(Counter;"Sva subscription lines".keynumber)
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

