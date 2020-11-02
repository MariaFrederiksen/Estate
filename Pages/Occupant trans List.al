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
                    Caption = 'Name';
                }
                field(Lejemål; Tenancy)
                {
                    ApplicationArea = all;
                    Caption = 'Tenancy';
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
                        SVACosttype.Reset();
                        SVACosttype.SETRANGE(Costtype, "Cost type Estate");
                        IF FINDFIRST() THEN BEGIN
                            Type := SVACosttype.Type;
                            Description := SVACosttype.Description;
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

            systempart(links; Links)
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
        area(reporting)
        {
            action("Report")
            {
                ApplicationArea = All;
                Caption = 'Translist report';
                Image = Report2;
                RunObject = Report "SVA Occupant Trans";
            }
        }
    }


    Var
        SVACosttype: Record "SVA Cost type";
        SVAOccupant: record "SVA Occupant";
        Name: Text[50];
        Tenancy: Text[10];

    trigger OnDeleteRecord(): Boolean;
    begin
        //Error('Du kan ikke slette poster. Kontakt evt. din forhandler');
        //Delete;
    end;


    trigger OnAfterGetRecord();
    begin
        SVAOccupant.Reset();
        SVAOccupant.SetRange(Number, Occupant);
        if SVAOccupant.FindFirst() then begin
            Name := SVAOccupant.Name1;
            Tenancy := SVAOccupant.TenancyNo;
        end;

    end;

}


