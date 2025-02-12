xmlport 50010 "SVA Eksport Property"
{
    Direction = Export;
    Format = VariableText;
    FormatEvaluate = Legacy;
    TextEncoding = WINDOWS;
    Caption = 'Export Data';
    DefaultFieldsValidation = false;
    FieldSeparator = ';';
    UseRequestPage = false;

    schema
    {
        textelement(Root)
        {
            tableelement(SVAProperty; "SVA Property")
            {
                fieldattribute(Property; SVAProperty.Property)
                {
                }
                fieldattribute(Address; SVAProperty.Address1)
                {
                }
            }
        }
    }
}