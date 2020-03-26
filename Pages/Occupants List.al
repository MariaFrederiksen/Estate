page 50012 "SVA Occupant List"
//Tooltips created
{
    Caption = 'List of Occupants';
    CardPageID = "SVA Occupant Card";
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "SVA Occupant";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Number; Number)
                {                    
                    ApplicationArea = All;
                    Tooltip = 'Agreement number';
                }
                field(TenancyNo; TenancyNo)
                {                    
                    ApplicationArea = All;
                    Tooltip = 'Tenancy number';
                }
                field(Name1; Name1)
                {                    
                    ApplicationArea = All;
                    Tooltip = 'Tenant name';
                }
                field(Name2; Name2)
                {                    
                    ApplicationArea = All;
                    Tooltip = 'Second tenant name';
                }
                field(Address; Address)
                {                    
                    ApplicationArea = All;
                    Tooltip = 'Invoice address';
                }
                field(City; City)
                {                    
                    ApplicationArea = All;
                    Tooltip = 'Invoice city';
                }
                field(Phone; Phone)
                {                    
                    ApplicationArea = All;
                    Tooltip = 'Tenants primary phone number';
                }
                field(Email1; Email1)
                {                    
                    ApplicationArea = All;
                    Tooltip = 'Tenants primary email';
                    ExtendedDatatype = EMail;
                }
                field(StartDate; StartDate)
                {                    
                    ApplicationArea = All;
                    ToolTip = 'Contract startdate';
                }
                field(EndDate; EndDate)
                {                    
                    ApplicationArea = All;
                    ToolTip = 'Contract end date.';
                }
                field(Type_1;Type_1)
                {                    
                    ApplicationArea = All;
                    Tooltip = 'Beboertype 1';
                }
                field(Type_2;Type_2)
                {                    
                    ApplicationArea = All;
                    Tooltip = 'Beboertype 2';
                }
            }
        }
        area(factboxes)
        {
            systempart(Links; Links)
            {
                ApplicationArea = All;
            }
            systempart(Notat; Notes)
            {
                ApplicationArea = All;
            }
            
        }
    }
}

