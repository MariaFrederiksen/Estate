page 61100 "SVA Bookkeeper Activities"
{
    // version NAVW110.00,NAVDK10.00
    //Tooltip created.

    Caption='Activities';
    PageType = CardPart;
    RefreshOnActivate = true;
    SourceTable = "Finance Cue";

    layout
    {
        area(content)
        {
            cuegroup(Stamdata)
            {
                Caption='Basic data';
                
                field("Occpupants";"SVA Occupant")
                {
                    Caption='Occupants';
                    ToolTip = 'Liste over beboeraftaler for alle ejendomme';
                    DrillDownPageID = "SVA Occupant List";
                    Image = Person;
                }
                field("Tenancies";"SVA Tenancy")
                {
                    Caption='Tenancies';
                    ToolTip = 'Liste over alle lejemål';
                    DrillDownPageID = "SVA Tenancy List";
                    Image = "Key";
                }
                field("Properties";"SVA Property")
                {
                    Caption='Properties';
                    ToolTip = 'Liste over ejendomme i virksomheden';
                    DrillDownPageID = "SVA Property List";
                    Image = Library;
                }
                field("Vacant tenancies";"SVA Empty Tenancy")
                {
                    ApplicationArea = Basic,Suite;
                    Caption='Vacant tenancies';
                    ToolTip = 'Liste over ledige lejemål for alle ejendomme';
                    DrillDownPageID = "SVA Tenancy List";
                    Image = "None";
                    
                }
            }
            cuegroup(Tilgodehavender)
            {
                Caption='Receivables';
                field("Overdue Sales Documents";"Overdue Sales Documents")
                {
                    ApplicationArea = Basic,Suite;
                    Caption='Overdue Sales Documents';
                    ToolTip='Liste over forfaldne opkrævninger';
                    DrillDownPageID = "Customer Ledger Entries";
                    Image = Stack;
                }

                actions
                {
                    action("Rediger indbetalingskladde")
                    {
                        ApplicationArea = Basic,Suite;
                        Caption='Edit Cash Receipt Journal';
                        RunObject = Page "Cash Receipt Journal";
                        ToolTip='Register received payments in a cash receipt journal that may already contain journal lines.';
                    }
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage();
    begin
        RESET;
        IF NOT GET THEN BEGIN
          INIT;
          INSERT;
        END;

        SETFILTER("Due Date Filter",'<=%1',WORKDATE);
        SETFILTER("Overdue Date Filter",'<%1',WORKDATE);
        SETFILTER("User ID Filter",USERID);
        SETFILTER("SVA Date Filter",'');
    end;

    var
        EmptyDate : Date;
}

