xmlport 50111 "SVA Import Occupants"
{
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = WINDOWS;

    schema
    {
        textelement(Root)
        {
            tableelement(Customer;Customer)
            {
                XmlName = 'Customer';
                fieldattribute(Number;Customer."No.")
                {
                }
                fieldattribute(Name;Customer.Name)
                {
                }
                fieldattribute(Address;Customer.Address)
                {
                }
                fieldattribute(Address2;Customer."Address 2")
                {
                }
                fieldattribute(Postcode;Customer."Post Code")
                {
                }
                fieldattribute(City;Customer.City)
                {
                }

                trigger OnBeforeInsertRecord();
                var
                    T001 : Label 'Netto';
                    T002 : Label 'DK';
                    T003 : Label 'Lejer';
                    T004 : Label 'Danmark';
                    T005 : Label 'NETS';
                    T006 : Label 'DAN';
                begin
                    Customer."Payment Terms Code" := T001;
                    Customer."Country/Region Code" := T002;
                    Customer."Customer Posting Group" := T003;
                    Customer."Application Method" := 1;
                    Customer."VAT Bus. Posting Group" := T004;
                    Customer."Gen. Bus. Posting Group" := T004;
                    Customer."Payment Method Code" := T005;
                    Customer."Language Code" := T006;
                end;
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

