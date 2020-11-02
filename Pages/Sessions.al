page 50025 "SVA Sessions"
{
    PageType = List;
    SourceTable = "Active Session";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {

                field("User ID"; "User ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'User ID';
                }
                field("Login Datetime"; "Login Datetime")
                {
                    ApplicationArea = All;
                    ToolTip = 'Login date and time.';
                }
                field("Database Name"; "Database Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Database name';
                }
                field("Server Instance Name"; "Server Instance Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Server Instance Name';
                }


            }
        }
    }
}