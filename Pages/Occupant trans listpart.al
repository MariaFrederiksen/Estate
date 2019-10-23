page 50011 "SVA Occupant Trans Subform"
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
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Date;Date)
                {                    
                    ApplicationArea = All;
                    ToolTip='Posting date.';
                }
                field("Cost type Estate";"Cost type Estate")
                {                    
                    ApplicationArea = All;
                    ToolTip='Costype';
                }
                field(Description;Description)
                {                    
                    ApplicationArea = All;
                    ToolTip='Description as shown on invioce.';
                }
                field(Qty;Qty)
                {                    
                    ApplicationArea = All;
                    ToolTip='Quantiy';
                }
                field(Price;Price)
                {                    
                    ApplicationArea = All;
                    ToolTip='Pris per quantity';
                }
                field(Amount;Amount)
                {                    
                    ApplicationArea = All;
                    ToolTip='Lineamount';
                }
                field("Invoice No";"Invoice No")
                {                    
                    ApplicationArea = All;
                    ToolTip='Invoice number';
                }
                field(Occupant;Occupant)
                {                    
                    ApplicationArea = All;
                    ToolTip='Contract number';
                }
                field(Type;Type)
                {                    
                    ApplicationArea = All;
                    ToolTip='Type of costtype.';
                }
            }
        }
    }

    actions
    {
    }
}

