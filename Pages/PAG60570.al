page 60570 "Occupant Trans Subform"
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
                }
                field("Cost type Estate";"Cost type Estate")
                {
                }
                field(Description;Description)
                {
                }
                field(Qty;Qty)
                {
                }
                field(Price;Price)
                {
                }
                field(Amount;Amount)
                {
                }
                field("Invoice No";"Invoice No")
                {
                }
                field(Occupant;Occupant)
                {
                }
                field(Type;Type)
                {
                }
            }
        }
    }

    actions
    {
    }
}

