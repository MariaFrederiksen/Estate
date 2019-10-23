page 50010 "SVA Occupant Trans List"
{
    Caption = 'List of Occupant Trans';
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = all;
    SourceTable = "SVA Occupant Trans";
 
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Occupant; Occupant)
                {
                    ApplicationArea = all;
                }
                field(Navn; Name)
                {
                    ApplicationArea = all;
                }
                field(Lejemål; Tenancy)
                {
                    ApplicationArea = all;
                }
                field(Date; Date)
                {
                    ApplicationArea = all;
                }
                field("Cost type Estate"; "Cost type Estate")
                {
                    ApplicationArea = all;
                    trigger OnValidate();
                    begin
                        CosttypeEstateRec.RESET;
                        CosttypeEstateRec.SETRANGE(Costtype, "Cost type Estate");
                        IF FINDFIRST() THEN BEGIN
                            Type := CosttypeEstateRec.Type;
                            Description := CosttypeEstateRec.Description;
                            qty := 1;
                        END;
                    end;
                }
                field(Description; Description)
                {
                    ApplicationArea = all;
                }
                field(Qty; Qty)
                {
                    ApplicationArea = all;
                }
                field(Price; Price)
                {
                    ApplicationArea = all;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = all;
                }
                field("Invoice No"; "Invoice No")
                {
                    ApplicationArea = all;
                }
                field(Type; Type)
                {
                    ApplicationArea = all;
                }

            }
        }
        area(factboxes)
        {
            systempart(NOTES; Notes)
            {
            }
            systempart(links; Links)
            {
            }
        }
    }

    Var
        CosttypeEstateRec: Record "SVA Cost type";
        Occupants: record "SVA Occupant";
        Name: Text[50];
        Tenancy: Text[10];

    trigger OnModifyRecord(): Boolean;
    begin
        // IF "Invoice No" <> '1' then
        //     Error('Posteringen er automatisk dannet og kan ikke rettes.');
        Modify;
    end;

    trigger OnDeleteRecord(): Boolean;
    begin
        Error('Du kan ikke slette poster. Kontakt evt. din forhandler');
        //Delete;
    end;


    trigger OnAfterGetRecord();
    begin
        Occupants.Reset;
        Occupants.SetRange(Number, Occupant);
        if Occupants.FindFirst then begin
            Name := Occupants.Name1;
            Tenancy := Occupants.TenancyNo;
        end;

    end;

}


