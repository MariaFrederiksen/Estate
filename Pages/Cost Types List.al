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
                    ToolTip = 'Beskrivlese af konteringsarten. Det er denne tekst, der vil fremgå af opkrævningen.';
                }
                field(Type;Type)
                {
                    ToolTip = 'Konteringartens type. Anvendes til håndtering af deposita, forudbetalt leje samt acontobeløb.';
                }
                field(Account;Account)
                {
                    ToolTip = 'Her angives den finanskonto, konteringarten skal bogføres på.';
                }
                field(VatGroup;VatGroup)
                {
                }
                field(Order;Order)
                {
                    ToolTip = 'Rækkefølge for udskrivning af linjerne på faktura';
                }
                field(Reminder;Reminder)
                {
                    ToolTip = 'Er konteringsarten en æligtig pengeydelse?';
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
