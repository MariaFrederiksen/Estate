page 60500 "SVA Setup Estate Card"
//tooltip created
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
                    Tooltip='Company name';
                }
                field(Address; Address)
                {
                    Tooltip='Company address';
                }
                field("Post code"; "Post code")
                {
                    Tooltip='Company postcode';
                }
                field(City; City)
                {
                    Tooltip='Company city';
                }
                field("VAT Registration No."; "VAT Registration No.")
                {
                    Tooltip='Company branch number';
                }
                field("Bank Name"; "Bank Name")
                {
                    ToolTip='Bank name';
                }
                field("Bank Branch No"; "Bank Branch No")
                {
                    Tooltip='Bank branch number.';
                }
                field("Bank Account No."; "Bank Account No.")
                {
                    Tooltip='Bank account number';
                }
                field(BS_Ledgeraccount; BS_Ledgeraccount)
                {
                    Tooltip='Ledgeraccount';
                }
            }
            group("Setup Estate")
            {
                Caption = 'Setup NETS';
                field(BS_AftaleNo; BS_AftaleNo)
                {
                    Tooltip='Agreement number';
                }
                field(BS_Dataprovider; BS_Dataprovider)
                {
                    Tooltip='Dataprovider. Not necessarily companys branch number';
                }
                field(BS_Delsystem; BS_Delsystem)
                {
                    Tooltip='Partsystem for NETS agreement';
                }
                field(BS_DebGrp; BS_DebGrp)
                {
                    Tooltip='NETS customer group';
                }
                field(BS_WorkSheet; BS_WorkSheet)
                {
                    Lookup = true;
                    ToolTip='Journal for incomming payments from NETS';
                }
                field(BS_Advis; BS_Advis)
                {
                    Tooltip='Headline on customers collection';
                }
                field(BS_ImportText; BS_ImportText)
                {
                    Tooltip='Text/description on journals/aacounts after accounting payments from NETS';
                }
            }
            group("Other setup")
            {
                Caption = 'Other setup';
                field(ReminderFeeRes; ReminderFeeRes)
                {
                    Tooltip='Reminderfee for residens. Must be changed every year wiht the new rate provided by law.';
                }
                field(ReminderFeeProf; ReminderFeeProf)
                {
                    Tooltip='Reminderfee for professions. Must be changed every year wiht the new rate provided by law.';
                }
                field(IntMaintenance; IntMaintenance)
                {
                    Tooltip='Fee for internal maintenance (§22). Must be changed every year wiht the new rate provided by law.';
                }
                field(Numberserie;Numberserie)
                {
                    Tooltip='Numberserie for new leasecontracts.';
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
        area(processing)
        {
            action("SVA Import properties")
            {
                Caption='Import properties';
                ToolTip='Import properties according to instructions';   
                Image = Apply;
                RunObject = XMLport "SVA Import Properties";
            }
             action("Import Tenancies")
            {
                Caption='Import Tenancies';    
                ToolTip='Import tenancies according to instructions';
                Image = Apply;
                RunObject = XMLport "SVA Import Tenancies";
            }
             action("Import Costtype")
            {
                Caption='Import Costtype'; 
                ToolTip='Import costtypes according to instructions';   
                Image = Apply;
                RunObject = XMLport "SVA Import Estate Cost Type";
            }
            action("Import Occupants")
            {
                Caption='Import Occupants';  
                ToolTip='Import occupants according to instructions';  
                Image = Apply;
                RunObject = XMLport "SVA Import Occupants";
            }
            action("Import Collections")
            {
                Caption='Import Collections';    
                ToolTip='Import collections according to instructions';
                Image = Apply;
                RunObject = XMLport "SVA Import Collections";
            }
            action("Transactions")
            {
                Caption='Manual transactions';    
                ToolTip='Enter manualy transactions from other systems. E.g. AC Heat, deposit, prepaid rent etc.';
                Image = Apply;
                RunObject = page "SVA Occupant trans";
            }
            // action("Maria")
            // {
            //     Image = Apply;
            //     RunObject = page "SVA sub Lines";
            // }


        }
    }
}

