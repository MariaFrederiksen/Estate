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
                field(IndeksNo; Rec.IndeksNo)
                {
                    ToolTip = 'Indeks number.';
                    ApplicationArea = All;
                }
                field(IndeksDate; Rec.IndeksDate)
                {
                    ToolTip = 'Indeks per date';
                    ApplicationArea = All;
                }
                field(Indeksrate; Rec.Indeksrate)
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
            action("Import Indeks")
            {
                Caption = 'Import Indeks';
                ToolTip = 'Import Indeks';
                Image = Apply;
                ApplicationArea = All;
                trigger OnAction();
                begin
                    Codeunit.Run(Codeunit::"SVA Import Priceindeks");
                end;
            }
        }
    }
}

