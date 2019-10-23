page 50002 "SVA Cost Type Estate List"
//Tooltip created
{
    Caption='List of Cost types';
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
                field(Costtype;Costtype)
                {                    
                    ApplicationArea = All;
                    ToolTip='Name on costtype';
                }
                field(Description;Description)
                {                    
                    ApplicationArea = All;
                    ToolTip = 'Description of costtype. Will appear on invoces and creditmemos';
                }
                field(Type;Type)
                {                    
                    ApplicationArea = All;
                    ToolTip = 'Costtype. Is used so different acconts can be used for the same purpose (ex. with or without Vat';
                }
                field(Account;Account)
                {                    
                    ApplicationArea = All;
                    ToolTip = 'Ledaccount for accounting';
                }
                field(ProductPostingGroup;ProductPostingGroup)
                {                    
                    ApplicationArea = All;
                    ToolTip = 'Gen. prod.postinggroup. Mandatory field.';
                }
                field(VatGroup;VatGroup)
                {                    
                    ApplicationArea = All;
                    ToolTip = 'Vatprod.posting group. Mandatory field.';
                }
                field(Order;Order)
                {                    
                    ApplicationArea = All;
                    ToolTip = 'In wich order will costtypes be shown on invoices.';
                }
                field(Reminder;Reminder)
                {                    
                    ApplicationArea = All;
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
      
    }
