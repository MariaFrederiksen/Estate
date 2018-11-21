page 60540 "SVA Cost Type Estate List"
//Tooltip created
{
    Caption='Cost types';
    PageType = List;
    SourceTable = "SVA Cost Type";
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Costtype;Costtype)
                {
                    ToolTip='Name on costtype';
                }
                field(Description;Description)
                {
                    ToolTip = 'Description of costtype. Will appear on invoces and creditmemos';
                }
                field(Type;Type)
                {
                    ToolTip = 'Costtype. Is used so different acconts can be used for the same purpose (ex. with or without Vat';
                }
                field(Account;Account)
                {
                    ToolTip = 'Ledaccount for accounting';
                }
                field(VatGroup;VatGroup)
                {
                    ToolTip = 'Vatgroup. Mandatory field';
                }
                field(Order;Order)
                {
                    ToolTip = 'In wich order will costtypes be shown on invoices.';
                }
                field(Reminder;Reminder)
                {
                    ToolTip = 'Is the costtype a mandatory payment?';
                }
            }
        }
        area(factboxes)
        {
            systempart(Links;Links)
            {
            }
            systempart(Notes;Notes)
            {
            }
        }
    }

    actions
    {
    }

   var
        Ledaccount : Record "G/L Account";
    }
