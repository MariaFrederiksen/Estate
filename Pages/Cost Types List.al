page 50002 "SVA Cost Type Estate List"
//Tooltip created
{
    Caption = 'List of Cost types';
    PageType = List;
    SourceTable = "SVA Cost Type";
    UsageCategory = Administration;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Costtype; Rec.Costtype)
                {
                    ApplicationArea = All;
                    ToolTip = 'Name on costtype';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Description of costtype. Will appear on invoces and creditmemos';
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    ToolTip = 'Costtype. Is used so different acconts can be used for the same purpose (ex. with or without Vat';
                }
                field(Account; Rec.Account)
                {
                    ApplicationArea = All;
                    ToolTip = 'Ledaccount for accounting';
                }
                field(ProductPostingGroup; Rec.ProductPostingGroup)
                {
                    ApplicationArea = All;
                    ToolTip = 'Gen. prod.postinggroup. Mandatory field.';
                }
                field(VatGroup; Rec.VatGroup)
                {
                    ApplicationArea = All;
                    ToolTip = 'Vatprod.posting group. Mandatory field.';
                }
                field(Order; Rec.Order)
                {
                    ApplicationArea = All;
                    ToolTip = 'In wich order will costtypes be shown on invoices.';
                }
                field(Reminder; Rec.Reminder)
                {
                    ApplicationArea = All;
                    ToolTip = 'Is the costtype a mandatory payment?';
                }
                field(Indeks; Rec.Indeks)
                {
                    ApplicationArea = all;
                    ToolTip = 'When regulating rent, this will be regulatet too';
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
    }

    var

}
