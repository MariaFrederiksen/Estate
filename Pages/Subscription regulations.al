page 60600 "Subscription regulations"
{
    Caption='Subscription regulations';
    PageType = Card;
    SourceTable = "SVA LeaseContract_A9";
    
    layout
    {
        area(content)
        {
            group(General)
            {
                field(Number;Number)
                {
                }
                field(TypeA9_4_DepMth;TypeA9_4_DepMth)
                {
                }
                field(TypeA9_4_Depositum;TypeA9_4_Depositum)
                {
                }
                field(TypeA9_4_PrepaidRentMth;TypeA9_4_PrepaidRentMth)
                {
                }
                field(TypeA9_4_PrepaidRent;TypeA9_4_PrepaidRent)
                {
                }
                field(I_Minregulation;I_Minregulation)
                {
                }
                field(I_MaxRegulation;I_MaxRegulation)
                {
                }
                field(I_FixedRegulation;I_FixedRegulation)
                {
                }
                field(I_RegDate;I_RegDate)
                {
                }
                field(I_RegIndeksDate;I_RegIndeksDate)
                {
                }
                field(I_LastRegulation;I_LastRegulation)
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord();
    begin
        CurrPage.UPDATE;
    end;
}

