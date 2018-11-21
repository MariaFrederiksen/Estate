page 60575 "SVA Occupant Trans"
{
    AutoSplitKey = true;
    Caption = 'Occupant Trans';
    DelayedInsert = false;
    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = true;
    LinksAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "SVA Occupant Trans";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Occupant; Occupant)
                {
                }
                field(Date; Date)
                {
                }
                field("Cost type Estate"; "Cost type Estate")
                {
                    trigger OnValidate();
                    begin
                        Costtype.Reset;
                        Costtype.SetRange(Costtype,"Cost type Estate");
                        IF Costtype.FindFirst() then begin
                            Type := Costtype.Type;
                            Description := Costtype.Description;
                            qty := 1;
                            end;
                    end;    
                }
                field(Description; Description)
                {
                }
                field(Qty; Qty)
                {
                }
                field(Price; Price)
                {
                }
                field(Amount; Amount)
                {
                }
                field("Invoice No"; "Invoice No")
                {
                }
                field(Type; Type)
                {
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
    var
        Costtype : Record "SVA Cost type";
}


