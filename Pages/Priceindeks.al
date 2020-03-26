page 50013 "SVA Priceindeks"
{
    // Indlæser indeksværdier fra 1.1.2017 til 1.6.2018.
    // Redigeret aug. 2018
    // Tooltips created

    Caption = 'Priceindeks';
    PageType = List;
    SourceTable = "SVA PriceIndeks";
    UsageCategory = Administration;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(IndeksNo; IndeksNo)
                {
                    ToolTip = 'Indeks number.';
                    ApplicationArea = All;
                }
                field(IndeksDate; IndeksDate)
                {
                    ToolTip = 'Indeks per date';
                    ApplicationArea = All;
                }
                field(Indeksrate; Indeksrate)
                {
                    ToolTip = 'Indeks rate.';
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            systempart(Links; Links)
            {
                ApplicationArea = All;
            }
            systempart(Notes; Notes)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Read old indeks")
            {
                ApplicationArea = all;
                Caption = 'Read indeks from 2017';
                ToolTip = 'Load old indekses from january 2017';
                Image = Add;

                trigger OnAction();
                begin
                    IndeksNo := 'NETTO';
                    IndeksDate := DMY2DATE(1, 1, 2017);
                    Indeksrate := 100.5;
                    INSERT;
                    IndeksNo := 'NETTO';
                    IndeksDate := DMY2DATE(1, 2, 2017);
                    Indeksrate := 101.4;
                    INSERT;
                    IndeksNo := 'NETTO';
                    IndeksDate := DMY2DATE(1, 3, 2017);
                    Indeksrate := 101.4;
                    INSERT;
                    IndeksNo := 'NETTO';
                    IndeksDate := DMY2DATE(1, 4, 2017);
                    Indeksrate := 101.8;
                    INSERT;
                    IndeksNo := 'NETTO';
                    IndeksDate := DMY2DATE(1, 5, 2017);
                    Indeksrate := 101.6;
                    INSERT;
                    IndeksNo := 'NETTO';
                    IndeksDate := DMY2DATE(1, 6, 2017);
                    Indeksrate := 101.5;
                    INSERT;
                    IndeksNo := 'NETTO';
                    IndeksDate := DMY2DATE(1, 7, 2017);
                    Indeksrate := 102.5;
                    INSERT;
                    IndeksNo := 'NETTO';
                    IndeksDate := DMY2DATE(1, 8, 2017);
                    Indeksrate := 102.2;
                    INSERT;
                    IndeksNo := 'NETTO';
                    IndeksDate := DMY2DATE(1, 9, 2017);
                    Indeksrate := 102.1;
                    INSERT;
                    IndeksNo := 'NETTO';
                    IndeksDate := DMY2DATE(1, 10, 2017);
                    Indeksrate := 102.3;
                    INSERT;
                    IndeksNo := 'NETTO';
                    IndeksDate := DMY2DATE(1, 11, 2017);
                    Indeksrate := 101.9;
                    INSERT;
                    IndeksNo := 'NETTO';
                    IndeksDate := DMY2DATE(1, 12, 2017);
                    Indeksrate := 101.6;
                    INSERT;
                    IndeksNo := 'NETTO';
                    IndeksDate := DMY2DATE(1, 1, 2018);
                    Indeksrate := 101.3;
                    INSERT;
                    IndeksNo := 'NETTO';
                    IndeksDate := DMY2DATE(1, 2, 2018);
                    Indeksrate := 102.1;
                    INSERT;
                    IndeksNo := 'NETTO';
                    IndeksDate := DMY2DATE(1, 3, 2018);
                    Indeksrate := 102.1;
                    INSERT;
                    IndeksNo := 'NETTO';
                    IndeksDate := DMY2DATE(1, 4, 2018);
                    Indeksrate := 102.6;
                    INSERT;
                    IndeksNo := 'NETTO';
                    IndeksDate := DMY2DATE(1, 5, 2018);
                    Indeksrate := 102.7;
                    INSERT;
                    IndeksNo := 'NETTO';
                    IndeksDate := DMY2DATE(1, 6, 2018);
                    Indeksrate := 102.7;
                    IndeksNo := 'NETTO';
                    INSERT;
                    IndeksNo := 'NETTO';
                    IndeksDate := DMY2DATE(1, 7, 2018);
                    Indeksrate := 103.6;
                    IndeksNo := 'NETTO';
                    INSERT;
                    IndeksNo := 'NETTO';
                    IndeksDate := DMY2DATE(1, 8, 2018);
                    Indeksrate := 103.1;
                    IndeksNo := 'NETTO';
                    Insert;
                    IndeksDate := DMY2DATE(1, 9, 2018);
                    Indeksrate := 102.8;
                    IndeksNo := 'NETTO';
                    Insert;
                    IndeksDate := DMY2DATE(1, 10, 2018);
                    Indeksrate := 103.1;
                    IndeksNo := 'NETTO';
                    Insert;
                    IndeksDate := DMY2DATE(1, 11, 2018);
                    Indeksrate := 102.8;
                    IndeksNo := 'NETTO';
                    IndeksDate := DMY2DATE(1, 12, 2018);
                    Indeksrate := 102.4;
                    IndeksNo := 'NETTO';
                    Insert;
                    IndeksDate := DMY2DATE(1, 1, 2019);
                    Indeksrate := 102.6;
                    IndeksNo := 'NETTO';
                    Insert;
                    IndeksDate := DMY2DATE(1, 2, 2019);
                    Indeksrate := 103.3;
                    IndeksNo := 'NETTO';
                    Insert;
                    IndeksDate := DMY2DATE(1, 3, 2019);
                    Indeksrate := 103.4;
                    IndeksNo := 'NETTO';
                    Insert;
                    IndeksDate := DMY2DATE(1, 4, 2019);
                    Indeksrate := 103.7;
                    IndeksNo := 'NETTO';
                    Insert;
                    IndeksDate := DMY2DATE(1, 5, 2019);
                    Indeksrate := 103.6;
                    IndeksNo := 'NETTO';
                    Insert;
                    IndeksDate := DMY2DATE(1, 6, 2019);
                    Indeksrate := 103.4;
                    IndeksNo := 'NETTO';
                    Insert;
                    IndeksDate := DMY2DATE(1, 7, 2019);
                    Indeksrate := 104.1;
                    IndeksNo := 'NETTO';
                    Insert;
                    IndeksDate := DMY2DATE(1, 8, 2019);
                    Indeksrate := 103.7;
                    IndeksNo := 'NETTO';
                    Insert;
                    IndeksDate := DMY2DATE(1, 9, 2019);
                    Indeksrate := 103.4;
                    IndeksNo := 'NETTO';
                    Insert;
                    IndeksDate := DMY2DATE(1, 10, 2019);
                    Indeksrate := 103.8;
                    IndeksNo := 'NETTO';
                    Insert;
                    IndeksDate := DMY2DATE(1, 11, 2019);
                    Indeksrate := 103.6;
                    IndeksNo := 'NETTO';
                    Insert;
                end;
            }
        }
    }
}

