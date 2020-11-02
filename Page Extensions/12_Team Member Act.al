Pageextension 50012 "SVA Team Member Act Ext." extends "Team Member Activities"
//Extend page 9037 activites, belong to RoleCenter 9027
{

    Caption = 'Activities';
    layout
    {
        addbefore("Time Sheets")
        {
            cuegroup(Stamdata)
            {
                Caption = 'Basic data';

                field("Occpupants"; "SVA Occupant")
                {
                    Caption = 'Occupants';
                    ToolTip = 'Liste over beboeraftaler for alle ejendomme';
                    DrillDownPageID = "SVA Occupant List";
                    Image = Person;
                    ApplicationArea = all;
                }
                field("Tenancies"; "SVA Tenancy")
                {
                    Caption = 'Tenancies';
                    ToolTip = 'Liste over alle lejemål';
                    DrillDownPageID = "SVA Tenancy List";
                    Image = "Key";
                    ApplicationArea = all;
                }
                field("Properties"; "SVA Property")
                {
                    Caption = 'Properties';
                    ToolTip = 'Liste over ejendomme i virksomheden';
                    DrillDownPageID = "SVA Property List";
                    Image = Library;
                    ApplicationArea = all;
                }
                field("Vacant tenancies"; "SVA Empty Tenancy")
                {
                    ApplicationArea = all;
                    Caption = 'Vacant tenancies';
                    ToolTip = 'Liste over ledige lejemål for alle ejendomme';
                    DrillDownPageID = "SVA Tenancy List";

                    //Image = Capacities;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage();
    begin
        Reset();
        IF NOT GET() THEN BEGIN
            INIT();
            Insert();
        END;
        SETFILTER("User ID Filter", USERID);
        SETFILTER("SVA Date Filter", '');
    end;

    var

}
