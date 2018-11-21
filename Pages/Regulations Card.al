page 60620 "SVA Regulations"
//
{
    Caption='Regulations';
    PageType = List;
    SourceTable = "SVA Occupant";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Number;Number)
                {
                    ToolTip='Occupant';
                }
                field(TenancyNo;TenancyNo)
                {
                    ToolTip='Tenancy number';
                }
                field(Name1;Name1)
                {
                    ToolTip='Name';
                }
                field("Cost Types";Sublines."Cost Types")
                {
                    Caption='Konteringsart';
                    ToolTip='Costtype to be regulated';
                }
                field("Amount Year";SubLines."Amount Year")
                {
                    Caption='Amount year';
                    ToolTip='Applicable amount year ';
                }
                field(IndeksDateOld;IndeksOld.IndeksDate)
                {
                    caption='Date';
                    ToolTip='Indeksdate (old)';
                }
                field(IndeksrateOld;IndeksOld.Indeksrate)
                {
                    caption='Rate';
                    ToolTip='Indeksrate (old)';
                }
                field(IndeksDateNew;IndeksNew.IndeksDate)
                {
                   caption='Date';
                   ToolTip='Indeksdate (new)';
                }
                field(IndeksrateNew;IndeksNew.Indeksrate)
                {
                    caption='Rate';
                    ToolTip='Indeksrate (new)';
                }
                field(I_RegDate;Contract.I_RegDate)
                {
                   Caption='Reg.date'; 
                   ToolTip='Reg.date';
                }
                field(AmountNew;AmountNew)
                {
                    Caption='Amount new';
                    ToolTip='Amount year (new)';
                }
                field(Regulation;Regulation)
                {
                    Caption='Regulation';
                    ToolTip='The regulation is representing.';
                }
            }
        }
        area(factboxes)
        {
            systempart(Links;Links)
            {
            }
        }
    }

    actions
    {
        area(reporting)
        {
            action(Letters)
            {
                Caption='Letters';
                Image = "report";

                trigger OnAction();
                begin
                    MESSAGE('Der udskrives breve og beregningen opdateres.');
                    EXIT;
                end;
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        SubLines.RESET;
        SubLines.SETRANGE(PriceIndeks,TRUE);
        SubLines.SETRANGE(Sublines.Tenancies,TenancyNo);
        AmountNew := 0;
        IF SubLines.FINDFIRST() THEN BEGIN
          Contract.RESET;
          Contract.SETRANGE(Number,Number);
          IF Contract.FINDFIRST() THEN  BEGIN
            END;

          IF Contract.I_RegIndeksDate > 0D THEN BEGIN
            IndeksOld.RESET;
            IndeksOld.SETRANGE(IndeksDate,Contract.I_RegIndeksDate);
          IF IndeksOld.FINDFIRST() THEN BEGIN
            END;

            IndeksNew.RESET;
            IndeksNew.SETRANGE(IndeksDate,CALCDATE('<1y>',Contract.I_RegIndeksDate));
            IF IndeksNew.FINDFIRST() THEN BEGIN
              END;
            END;

          IF IndeksOld.Indeksrate <> 0 THEN
            AmountNew := SubLines."Amount Year"/IndeksOld.Indeksrate*IndeksNew.Indeksrate;
            Regulation := AmountNew-SubLines."Amount Year";
          END;
    end;

    var
        SubLines : Record "SVA Subscription Lines";
        IndeksOld : Record "SVA PriceIndeks";
        IndeksNew : Record "SVA PriceIndeks";
        AmountNew : Decimal;
        Regulation : Decimal;
        Contract : Record "SVA LeaseContract_A9";
}

