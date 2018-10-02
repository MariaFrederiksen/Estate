page 60540 "Cost Type Estate List"
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
                }
                field(Description;Description)
                {
                }
                field(Type;Type)
                {
                }
                field(Account;Account)
                {
                }
                field(VatGroup;VatGroup)
                {
                }
                field(Order;Order)
                {
                }
                field(Reminder;Reminder)
                {
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
