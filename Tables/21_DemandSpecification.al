table 50021 "SVA Demand Specification"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; Rownumber; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'RowNumber';
        }
        field(10; DocNo; Text[20])
        {
            DataClassification = CustomerContent;
            Caption = 'DocNo';
        }
        field(11; Description; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
        field(12; Amount; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Amount';
        }
    }

    keys
    {
        key(Key1; Rownumber)
        {
            Clustered = true;
        }
    }


}