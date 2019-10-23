page 50017 "SVA Setup Estate Card"
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
                    Tooltip = 'Company name';
                    ApplicationArea = all;
                }
                field(Address; Address)
                {
                    Tooltip = 'Company address';
                    ApplicationArea = all;
                }
                field("Post code"; "Post code")
                {
                    Tooltip = 'Company postcode';
                    ApplicationArea = all;
                }
                field(City; City)
                {
                    Tooltip = 'Company city';
                    ApplicationArea = all;
                }
                field("VAT Registration No."; "VAT Registration No.")
                {
                    Tooltip = 'Company branch number';
                    ApplicationArea = all;
                }
                field("Bank Name"; "Bank Name")
                {
                    ToolTip = 'Bank name';
                    ApplicationArea = all;
                }
                field("Bank Branch No"; "Bank Branch No")
                {
                    Tooltip = 'Bank branch number.';
                    ApplicationArea = all;
                }
                field("Bank Account No."; "Bank Account No.")
                {
                    Tooltip = 'Bank account number';
                    ApplicationArea = all;
                }
                field(BS_Ledgeraccount; BS_Ledgeraccount)
                {
                    Tooltip = 'Ledgeraccount';
                    ApplicationArea = all;
                }
            }
            group("Setup Estate")
            {
                Caption = 'Setup NETS';
                field(BS_AftaleNo; BS_AftaleNo)
                {
                    Tooltip = 'Agreement number';
                    ApplicationArea = all;
                }
                field(BS_Dataprovider; BS_Dataprovider)
                {
                    Tooltip = 'Dataprovider. Not necessarily companys branch number';
                    ApplicationArea = all;
                }
                field(BS_Delsystem; BS_Delsystem)
                {
                    Tooltip = 'Partsystem for NETS agreement';
                    ApplicationArea = all;
                }
                field(BS_DebGrp; BS_DebGrp)
                {
                    Tooltip = 'NETS customer group';
                    ApplicationArea = all;
                }
                field(BS_WorkSheetType; BS_WorkSheetType)
                {
                    Lookup = true;
                    ToolTip = 'Journaltype for incomming payments from NETS';
                    ApplicationArea = all;
                }
                field(BS_WorkSheet; BS_WorkSheet)
                {
                    Lookup = true;
                    ToolTip = 'Journal for incomming payments from NETS';
                    ApplicationArea = all;
                }
                field(BS_Advis; BS_Advis)
                {
                    Tooltip = 'Headline on customers collection';
                    ApplicationArea = all;
                }
                field(BS_ImportText; BS_ImportText)
                {
                    Tooltip = 'Text/description on journals/aacounts after accounting payments from NETS';
                    ApplicationArea = all;
                }
            }
            group("Other setup")
            {
                Caption = 'Other setup';
                field(ReminderFeeRes; ReminderFeeRes)
                {
                    Tooltip = 'Reminderfee for residens. Must be changed every year wiht the new rate provided by law.';
                    ApplicationArea = all;
                }
                field(ReminderFeeProf; ReminderFeeProf)
                {
                    Tooltip = 'Reminderfee for professions. Must be changed every year wiht the new rate provided by law.';
                    ApplicationArea = all;
                }
                field(IntMaintenance; IntMaintenance)
                {
                    Tooltip = 'Fee for internal maintenance (§22). Must be changed every year wiht the new rate provided by law.';
                    ApplicationArea = all;
                }
                field(Numberserie; Numberserie)
                {
                    Tooltip = 'Numberserie for new leasecontracts.';
                    ApplicationArea = all;
                }
                Field(Splitcalc; Splitcalc)
                {
                    Tooltip = 'Contracts calculate days? Default is 0.5 month';
                    ApplicationArea = all;
                }
                field(Dim1; Dim1)
                {
                    ToolTip = 'Dimension for property';
                    ApplicationArea = all;
                }
                field(Dim2; Dim2)
                {
                    ToolTip = 'Dimension for tenancy';
                    ApplicationArea = all;
                }
                field(Dim3; Dim3)
                {
                    ToolTip = 'Dimension for occupant';
                    ApplicationArea = all;
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
            
                Caption = 'Import properties';
                ToolTip = 'Import properties according to instructions';
                Promoted = true;
                Image = Apply;
                trigger OnAction();
                begin
                    Xmlport.run(Xmlport::"SVA Import Properties",false,true)//"SVA Import Properties"
                end;
            }
            action("Import Tenancies")
            {
                Caption = 'Import Tenancies';
                ToolTip = 'Import tenancies according to instructions';
                Image = Apply;
                trigger OnAction();
                begin
                    Xmlport.run(xmlport::"SVA Import Tenancies",false,true)//"SVA Import Tenancies"
                end;
                
            }
            action("Import Costtype")
            {
                Caption = 'Import Costtype';
                ToolTip = 'Import costtypes according to instructions';
                Image = Apply;
                trigger OnAction();
                begin
                    Xmlport.run(Xmlport::"SVA Import Estate Cost Type",false,true)//"SVA Import Estate Cost Type";
                end;
            }
            action("Import Occupants")
            {
                Caption = 'Import Occupants';
                ToolTip = 'Import occupants according to instructions';
                Image = Apply;
                trigger OnAction();
                begin
                    Xmlport.run(Xmlport::"SVA Import Occupants",false,true)//"SVA Import Occupants"
                end;
               
            }
            action("Import Collections")
            {
                Caption = 'Import Collections';
                ToolTip = 'Import collections according to instructions';
                Image = Apply;
                trigger OnAction();
                begin
                    Xmlport.run(xmlport::"SVA Import Collections",false,true)//"SVA Import Collecions"
                end;
            }

            action("Arch Transactions")
            {
                Caption = 'Import transactions';
                ToolTip = 'Import old transactions according to instructions';
                Image = Apply;
                trigger OnAction();
                begin
                    Xmlport.run(xmlport::"SVA Import Occupant Trans",false,true)//"SVA Import Occupant Trans"
                end;
            }
        }

    }
}

