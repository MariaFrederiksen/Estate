table 50014 "SVA Import Buffer"
{
    DataClassification = CustomerContent;
    Permissions = TableData 50014 = rimd;

    fields
    {
        field(10;"Entry No.";Integer)
        {
            DataClassification = CustomerContent;
        }
        field(20;"Entry line";Text[128])
        {
            DataClassification = CustomerContent;
        }
        field(30;Identifier;Text[20])
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1;"Entry No.")
        {
        }
    }

    fieldgroups
    {
    }
}

