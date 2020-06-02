page 50018 "SVA Setup Estate List"
{
    Caption = 'Setup Estate';
    CardPageID = "SVA Setup Estate Card";
    PageType = List;
    SourceTable = "SVA Parameters";
    UsageCategory = Administration;
    ApplicationArea = All;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                Caption = 'General';
                field(Name; Name)
                {
                    ApplicationArea = All;
                    Tooltip = 'Company name';
                }
                field("VAT Registration No."; "VAT Registration No.")
                {
                    ApplicationArea = All;
                    Tooltip = 'Company branch number';
                }
                field("Bank Name"; "Bank Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Bank name';
                }
                field(BS_AftaleNo; BS_AftaleNo)
                {
                    ApplicationArea = All;
                    Tooltip = 'Agreement number';
                }
                field(BS_Dataprovider; BS_Dataprovider)
                {
                    ApplicationArea = All;
                    Tooltip = 'Dataprovider. Not necessarily companys branch number';
                }
                field(BS_Delsystem; BS_Delsystem)
                {
                    ApplicationArea = All;
                    Tooltip = 'Partsystem for NETS agreement';
                }
                field(BS_DebGrp; BS_DebGrp)
                {
                    ApplicationArea = All;
                    Tooltip = 'NETS customer group';
                }
            }
        }
        area(factboxes)
        {
            systempart(Links; Links)
            {
                ApplicationArea = All;
            }
            systempart(Notes; Notes)
            {
                ApplicationArea = All;
            }

        }
    }

    actions
    {
    }
}

