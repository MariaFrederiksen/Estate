page 60501 "SVA Setup Estate List"
{
    Caption = 'Setup Estate';
    CardPageID = "SVA Setup Estate Card";
    PageType = List;
    SourceTable = "SVA Parameters";
    UsageCategory = Administration;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                Caption='General';
                field(Name;Name)
                {
                }
                field("VAT Registration No.";"VAT Registration No.")
                {
                    Tooltip='Company branch number';
                }
                field("Bank Name";"Bank Name")
                {
                    ToolTip='Bank name';
                }
                field(BS_AftaleNo;BS_AftaleNo)
                {
                    Tooltip='Agreement number';
                }
                field(BS_Dataprovider;BS_Dataprovider)
                {
                    Tooltip='Dataprovider. Not necessarily companys branch number';
                }
                field(BS_Delsystem;BS_Delsystem)
                {
                    Tooltip='Partsystem for NETS agreement';
                }
                field(BS_DebGrp;BS_DebGrp)
                {
                    Tooltip='NETS customer group';
                }
            }
        }
        area(factboxes)
        {
            systempart(Links;Links)
            {
            }   
            systempart(Notes;Notes)
            {
            }
            
        }
    }

    actions
    {
    }
}

