page 50001 "SVA Bookkeeper Activities"
{

    Caption = 'Activities';
    PageType = CardPart;
    RefreshOnActivate = true;
    SourceTable = "Finance Cue";


    layout
    {
        area(content)
        {
            cuegroup(Stamdata)
            {
                Caption = 'Basic data';

                field("Occpupants"; Rec."SVA Occupant")
                {
                    Caption = 'Occupants';
                    ToolTip = 'Liste over beboeraftaler for alle ejendomme';
                    DrillDownPageID = "SVA Occupant List";
                    Image = Person;
                    ApplicationArea = all;
                }
                field("Tenancies"; Rec."SVA Tenancy")
                {
                    Caption = 'Tenancies';
                    ToolTip = 'Liste over alle lejemål';
                    DrillDownPageID = "SVA Tenancy List";
                    Image = "Key";
                    ApplicationArea = all;
                }
                field("Properties"; Rec."SVA Property")
                {
                    Caption = 'Properties';
                    ToolTip = 'Liste over ejendomme i virksomheden';
                    DrillDownPageID = "SVA Property List";
                    Image = Library;
                    ApplicationArea = all;
                }
                field("Vacant tenancies"; Rec."SVA Empty Tenancy")
                {
                    ApplicationArea = all;
                    Caption = 'Vacant tenancies';
                    ToolTip = 'Liste over ledige lejemål for alle ejendomme';
                    DrillDownPageID = "SVA Tenancy List";

                    //Image = Capacities;
                }
            }
            cuegroup(Tilgodehavender)
            {
                Caption = 'Receivables';
                field("Overdue Sales Documents"; Rec."Overdue Sales Documents")
                {
                    ApplicationArea = all;
                    Caption = 'Overdue Sales Documents';
                    ToolTip = 'Liste over forfaldne opkrævninger';
                    DrillDownPageID = "Customer Ledger Entries";
                    Image = Document;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage();
    begin
        Rec.Reset();
        IF NOT Rec.Get() THEN BEGIN
            Rec.Init();
            Rec.Insert();
        END;

        Rec.SETFILTER("Due Date Filter", '<=%1', WORKDATE());
        Rec.SETFILTER("Overdue Date Filter", '<%1', WORKDATE());
        //SETFILTER("User ID Filter", USERID);
        Rec.SETFILTER("SVA Date Filter", '');
    end;

    var
}

