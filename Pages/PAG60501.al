page 60501 "SVA Setup Estate List"
{
    Caption = 'Setup Estate';
    CardPageID = "SVA Setup Estate Card";
    PageType = List;
    SourceTable = "SVA Parameters";

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
                }
                field("Bank Name";"Bank Name")
                {
                }
                field(BS_AftaleNo;BS_AftaleNo)
                {
                }
                field(BS_Dataprovider;BS_Dataprovider)
                {
                }
                field(BS_Delsystem;BS_Delsystem)
                {
                }
                field(BS_DebGrp;BS_DebGrp)
                {
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

