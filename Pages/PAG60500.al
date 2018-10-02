page 60500 "SVA Setup Estate Card"
{
    Caption = 'Setup Estate';
    CardPageID = "SVA Setup Estate Card";
    PageType = Card;
    SourceTable = "SVA Parameters";
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(Name; Name)
                {
                }
                field(Address; Address)
                {
                }
                field("Post code"; "Post code")
                {
                }
                field(City; City)
                {
                }
                field("VAT Registration No."; "VAT Registration No.")
                {
                }
                field("Bank Name"; "Bank Name")
                {
                }
                field("Bank Branch No"; "Bank Branch No")
                {
                }
                field("Bank Account No."; "Bank Account No.")
                {
                }
                field(BS_Ledgeraccount; BS_Ledgeraccount)
                {
                }
            }
            group("Setup Estate")
            {
                Caption = 'Setup Estate';
                field(BS_AftaleNo; BS_AftaleNo)
                {
                }
                field(BS_Dataprovider; BS_Dataprovider)
                {
                }
                field(BS_Delsystem; BS_Delsystem)
                {
                }
                field(BS_DebGrp; BS_DebGrp)
                {
                }
                field(BS_WorkSheet; BS_WorkSheet)
                {
                    Lookup = true;
                }
                field(BS_Advis; BS_Advis)
                {
                }
                field(BS_ImportText; BS_ImportText)
                {
                }
            }
            group("Other setup")
            {
                Caption = 'Other setup';
                field(ReminderFeeRes; ReminderFeeRes)
                {
                }
                field(ReminderFeeProf; ReminderFeeProf)
                {
                }
                field(IntMaintenance; IntMaintenance)
                {
                }
            }
        }
        area(factboxes)
        {
            
            systempart(Links; Links)
            {
            }
            systempart(Notes; Notes)
            {
            }
        }
    }

    actions
    {
    }
}

