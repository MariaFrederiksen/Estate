xmlport 50001 "SVA Import Estate Cost Type"
{
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = WINDOWS;

    schema
    {
        textelement(Root)
        {
            tableelement("SVA Cost type Estate"; "SVA Cost type")
            {
                XmlName = 'Konteringsart';
                fieldattribute(Costtype; "SVA Cost type Estate".Costtype)//A
                {
                }
                fieldattribute(Description; "SVA Cost type Estate".Description)//B
                {
                }
                fieldattribute(Type; "SVA Cost type Estate".Type)//C
                {
                }
                fieldattribute(Account; "SVA Cost type Estate".Account)//D
                {
                }
                fieldattribute(Vatgrp; "SVA Cost type Estate".ProductPostingGroup)//E
                {
                }
                fieldattribute(Rkf; "SVA Cost type Estate".Order)//F
                {
                }
                fieldattribute(ReminderAllowed; "SVA Cost type Estate".Reminder)//G
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
        Message('Konteringsarter er indlæst');
    end;
}

