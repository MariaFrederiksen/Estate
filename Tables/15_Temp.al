table 50015 "SVA Export Temp"
//Collecting data for print/making files for Brunata, Varmekontrol ec.
//Only temporary
{
    DataClassification = CustomerContent;
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
        field(40;"Output Line 128";Text[128])
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