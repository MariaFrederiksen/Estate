xmlport 50067 "SVA Import Occupant Trans"
{
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = WINDOWS;
    
    schema
    {
        textelement(Root)
        {
            tableelement("SVA Occupant Trans";"SVA Occupant Trans")
            {
                XmlName = 'Transaktioner';
                fieldattribute(Occupant;"SVA Occupant Trans".Occupant)
                {
                }
                fieldattribute(Date;"SVA Occupant Trans".Date)
                {
                }
                fieldattribute(Costtype;"SVA Occupant Trans"."Cost type Estate")
                {
                }
                fieldattribute(Description;"SVA Occupant Trans".Description)
                {
                }
                fieldattribute(Qty;"SVA Occupant Trans".Qty)
                {
                }
                fieldattribute(Price;"SVA Occupant Trans".Price)
                {
                }
                fieldattribute(Amount;"SVA Occupant Trans".Amount)
                {
                }
                fieldattribute(InvoiceNo;"SVA Occupant Trans"."Invoice No")
                {
                }
                fieldattribute(Type;"SVA Occupant Trans".Type)
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
        Message('Posteringer er indlæst');
    end;
    
}

