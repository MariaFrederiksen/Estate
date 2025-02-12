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
                field(Occupant; Rec.Occupant)
                {
                    ApplicationArea = all;
                    ToolTip = 'Occupant';
                }
                field(Navn; Name)
                {
                    ApplicationArea = all;
                    Caption = 'Name';
                    ToolTip = 'Name of occupant.';
                }
                field(Lejemål; Tenancy)
                {
                    ApplicationArea = all;
                    Caption = 'Tenancy';
                    ToolTip = 'Tenancy';
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = all;
                    ToolTip = 'Postingdate';
                }
                field("Cost type Estate"; Rec."Cost type Estate")
                {
                    ApplicationArea = all;
                    ToolTip = 'Costtype';
                    trigger OnValidate();
                    begin
                        SVACosttype.Reset();
                        SVACosttype.SETRANGE(Costtype, Rec."Cost type Estate");
                        IF SVACosttype.FindFirst() THEN BEGIN
                            Rec.Type := SVACosttype.Type;
                            Rec.Description := SVACosttype.Description;
                            Rec.qty := 1;
                        END;
                    end;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                    ToolTip = 'Invoice description';
                }
                field(Qty; Rec.Qty)
                {
                    ApplicationArea = all;
                    ToolTip = 'Quantity';
                }
                field(Price; Rec.Price)
                {
                    ApplicationArea = all;
                    ToolTip = 'Unit price';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = all;
                    ToolTip = 'Line amount.';
                }
                field("Invoice No"; Rec."Invoice No")
                {
                    ApplicationArea = all;
                    Tooltip = 'Posted invoice';
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = all;
                    ToolTip = 'Type';
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
                ToolTip = 'List of entries, report';
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
        SVAOccupant.SetRange(Number, Rec.Occupant);
        if SVAOccupant.FindFirst() then begin
            Name := SVAOccupant.Name1;
            Tenancy := SVAOccupant.TenancyNo;
        end;

    end;

}


