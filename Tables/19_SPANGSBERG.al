table 50019 Spangsberg
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; Lbnr; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(10; PostDato; Date)
        {
            DataClassification = CustomerContent;
        }
        field(11; Bilagsnr; Text[10])
        {
            DataClassification = CustomerContent;
        }
        field(12; Account; Text[10])
        {
            DataClassification = CustomerContent;
        }
        field(13; Descr; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(14; Amount1; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(15; Amount2; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(16; Afd; Text[10])
        {

        }
        field(17; Leje; Text[10])
        {

        }
        field(18; Bebaft; Text[10])
        {

        }

    }

    keys
    {
        key(Key1; Lbnr)
        {
            Clustered = true;
        }
    }





}