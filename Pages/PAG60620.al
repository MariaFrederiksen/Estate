page 60620 Regulations
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
                }
                field(TenancyNo;TenancyNo)
                {
                }
                field(Name1;Name1)
                {
                }
                field("Cost Types";Sublines."Cost Types")
                {
                    Caption='Costtype';
                }
                field("Amount Year";SubLines."Amount Year")
                {
                    Caption='Amount year';
                }
                field(IndeksDateOld;IndeksOld.IndeksDate)
                {
                    Caption='Rate';
                }
                field(IndeksrateOld;IndeksOld.Indeksrate)
                {
                    Caption='Rate';
                }
                field(IndeksDateNew;IndeksNew.IndeksDate)
                {
                    Caption='Date';
                }
                field(IndeksrateNew;IndeksNew.Indeksrate)
                {
                    Caption='Rate';
                }
                field(I_RegDate;Contract.I_RegDate)
                {
                    Caption='Reg.date';
                }
                field(AmountNew;AmountNew)
                {
                    Caption='Amount new';
                }
                field(Regulation;Regulation)
                {
                    Caption='Regulation';
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

