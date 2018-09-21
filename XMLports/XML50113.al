xmlport 50113 "SVA Import NoS"
{

    schema
    {
        textelement(root)
        {
            tableelement("No. Series Line";"No. Series Line")
            {
                XmlName = 'Table';
                fieldattribute(f1;"No. Series Line"."Series Code")
                {
                }
                fieldattribute(F2;"No. Series Line"."Line No.")
                {
                }
                fieldattribute(F3;"No. Series Line"."Starting Date")
                {
                }
                fieldattribute(F4;"No. Series Line"."Starting No.")
                {
                }
                fieldattribute(F5;"No. Series Line"."Ending No.")
                {
                }
                fieldattribute(F6;"No. Series Line"."Warning No.")
                {
                }
                fieldattribute(F7;"No. Series Line"."Increment-by No.")
                {
                }
                fieldattribute(F8;"No. Series Line"."Last No. Used")
                {
                }
                fieldattribute(F9;"No. Series Line".Open)
                {
                }
                fieldattribute(F10;"No. Series Line"."Last Date Used")
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

