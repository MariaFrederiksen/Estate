page 60570 "SVA Occupant Trans Subform"
//Tooltip created
{
    AutoSplitKey = true;
    Caption='Occupant Trans';
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
                field(Date;Date)
                {
                    ToolTip='Posting date.';
                }
                field("Cost type Estate";"Cost type Estate")
                {
                    ToolTip='Costype';
                }
                field(Description;Description)
                {
                    ToolTip='Description as shown on invioce.';
                }
                field(Qty;Qty)
                {
                    ToolTip='Quantiy';
                }
                field(Price;Price)
                {
                    ToolTip='Pris per quantity';
                }
                field(Amount;Amount)
                {
                    ToolTip='Lineamount';
                }
                field("Invoice No";"Invoice No")
                {
                    ToolTip='Invoice number';
                }
                field(Occupant;Occupant)
                {
                    ToolTip='Contract number';
                }
                field(Type;Type)
                {
                    ToolTip='Type of costtype.';
                }
            }
        }
    }

    actions
    {
    }
}

