Pageextension 50013 "SVA Business Mangager Act Ext." extends "O365 Activities"
//Extend page 9037 activites, belong to RoleCenter 9027
{

    Caption = 'Activities';
    layout
    {
        addbefore("Ongoing Sales")
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
        }
    }

    actions
    {
    }

    trigger OnOpenPage();
    begin
        Rec.Reset();
        IF NOT Rec.GET() THEN BEGIN
            Rec.INIT();
            Rec.Insert();
        END;
        Rec.SETFILTER("SVA Date Filter", '');
    end;

    var

}
