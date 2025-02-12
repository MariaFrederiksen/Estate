xmlport 50006 "SVA Import Occupants"
{
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = WINDOWS;

    schema
    {
        textelement(Root)
        {
            tableelement("SVA Occupant"; "SVA Occupant")
            {
                XmlName = 'Occupant';
                fieldattribute(Number; "SVA Occupant".Number)
                {
                    FieldValidate = Yes;
                }
                fieldattribute(Account; "SVA Occupant"."Customer No")
                {
                    FieldValidate = Yes;
                }
                fieldattribute(Name; "SVA Occupant".Name1)
                {
                }
                fieldattribute(Address1; "SVA Occupant".Address)
                {
                }
                fieldattribute(Address2; "SVA Occupant".Address2)
                {
                }
                fieldattribute(Postcode; "SVA Occupant"."Post Code")
                {
                }
                fieldattribute(City; "SVA Occupant".City)
                {
                }
                fieldattribute(Phone; "SVA Occupant".Phone)
                {

                }
                fieldattribute(CPR1; "SVA Occupant".CPRno1)
                {

                }
                fieldattribute(Email; "SVA Occupant".Email1)
                {

                }
                fieldattribute(EndDate; "SVA Occupant".EndDate)
                {

                }
                fieldattribute(TenancyNo; "SVA Occupant".TenancyNo)
                {

                }
                fieldattribute(CollectionMth; "SVA Occupant"."Collection Month")
                {

                }
                fieldattribute(CPR2; "SVA Occupant".CPRno2)
                {

                }
                fieldattribute(Startdate; "SVA Occupant".StartDate)
                {
                    //FieldValidate = Yes;
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
        Message('Beboeraftaler er indlæst');
    end;

}

