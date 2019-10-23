table 50015 "SVA Export Temp"
//Opsamling af data til udskrivning
//F.eks. indberetning af a conto tal for vand og varme.
//Der er ingen page, da den alene anvendes som temp kartotek
{
    DataClassification = CustomerContent;
    Permissions = TableData 50015 = rimd;

    fields
    {
        field(10;"Name";Code[10])
        {
        }
        field(20;"Line no.";Integer)
        {
        }
        field(30;"Output Line";Text[250])
        {
        }
    }

    keys
    {
        key(Key1;Name,"Line no.")
        {
        }
    }

    fieldgroups
    {
    }
}