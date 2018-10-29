page 61100 "Bookkeeper ESTATE Activities"
{
    // version NAVW110.00,NAVDK10.00

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
                    DrillDownPageID = "SVA Occupant List";
                    Image = Person;
                }
                field("Tenancies";"SVA Tenancy")
                {
                    Caption='Tenancies';
                    DrillDownPageID = "SVA Tenancy List";
                    Image = "Key";
                }
                field("Properties";"SVA Property")
                {
                    Caption='Properties';
                    DrillDownPageID = "SVA Property List";
                    Image = Library;
                }
                field("Vacant tenancies";"SVA Empty Tenancy")
                {
                    ApplicationArea = Basic,Suite;
                    Caption='Vacant tenancies';
                    DrillDownPageID = "SVA Tenancy List";
                    Image = "None";
                    
                }
            }
            cuegroup("Gæld")
            {
                Caption='Payables';
                field("Purchase Documents Due Today";"Purchase Documents Due Today")
                {
                    ApplicationArea = Basic,Suite;
                    Caption='Purchase Documents Due Today';
                    DrillDownPageID = "Vendor Ledger Entries";
                    Image = Stack;
                }
                field("Vendors - Payment on Hold";"Vendors - Payment on Hold")
                {
                    ApplicationArea = Basic,Suite;
                    DrillDownPageID = "Vendor List";
                    Image = Stack;
                }

                actions
                {
                    action("Rediger udbetalingskladde")
                    {
                        ApplicationArea = Basic,Suite;
                        Caption='Edit Payment Journal';
                        RunObject = Page "Payment Journal";
                        
                    }
                }
            }
            cuegroup(Tilgodehavender)
            {
                Caption='Receivables';
                field("Overdue Sales Documents";"Overdue Sales Documents")
                {
                    ApplicationArea = Basic,Suite;
                    Caption='Overdue Sales Documents';
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

