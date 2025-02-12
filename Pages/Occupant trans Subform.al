page 50011 "SVA Occupant Trans Subform"
//Tooltip created
{
    AutoSplitKey = true;
    Caption = 'Occupant Trans';
    DelayedInsert = false;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    LinksAllowed = false;
    ModifyAllowed = false;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "SVA Occupant Trans";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                    ToolTip = 'Posting date.';
                }
                field("Cost type Estate"; Rec."Cost type Estate")
                {
                    ApplicationArea = All;
                    ToolTip = 'Costype';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Description as shown on invioce.';
                }
                field(Qty; Rec.Qty)
                {
                    ApplicationArea = All;
                    ToolTip = 'Quantiy';
                }
                field(Price; Rec.Price)
                {
                    ApplicationArea = All;
                    ToolTip = 'Pris per quantity';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Lineamount';
                }
                field("Invoice No"; Rec."Invoice No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Invoice number';
                }
                field(Occupant; Rec.Occupant)
                {
                    ApplicationArea = All;
                    ToolTip = 'Contract number';
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    ToolTip = 'Type of costtype.';
                }
            }
        }
    }

    actions
    {
    }
}

