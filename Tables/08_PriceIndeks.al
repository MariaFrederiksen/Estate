table 50008 "SVA PriceIndeks"
{
    Caption='Netto price indeks';
    
    fields
    {
        field(1;IndeksNo;Code[10])
        {
            Caption='Indeks Number';
            trigger OnValidate();
            begin
                IndeksNo := 'NETTO';
            end;
        }
        field(2;IndeksDate;Date)
        {
            Caption='Indeks at';

            trigger OnValidate();
            begin
                IndeksNo := 'NETTO'
            end;
        }
        field(3;Indeksrate;Decimal)
        {
            Caption='Indeks rate';
        }
    }

    keys
    {
        key(PK;IndeksNo,Indeksdate)
        {
            Clustered = true;
        }
    }
}
