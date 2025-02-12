page 50030 "SVA Setup Card"
{
    Caption = 'Setup Estate';
    PageType = Card;
    SourceTable = "SVA Parameters";
    UsageCategory = Administration;
    ApplicationArea = All;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(Name; Rec.Name)
                {
                    ToolTip = 'Company Name';
                    ApplicationArea = all;
                }
                field(Address; Rec.Address)
                {
                    Tooltip = 'Company address';
                    ApplicationArea = all;
                }
                field("Post code"; Rec."Post code")
                {
                    Tooltip = 'Company postcode';
                    ApplicationArea = all;
                }
                field(City; Rec.City)
                {
                    Tooltip = 'Company city';
                    ApplicationArea = all;
                }
                field("VAT Registration No."; Rec."VAT Registration No.")
                {
                    Tooltip = 'Company branch number';
                    ApplicationArea = all;
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    ToolTip = 'Bank name';
                    ApplicationArea = all;
                }
                field("Bank Branch No"; Rec."Bank Branch No")
                {
                    Tooltip = 'Bank branch number.';
                    ApplicationArea = all;
                }
                field("Bank Account No."; Rec."Bank Account No.")
                {
                    Tooltip = 'Bank account number';
                    ApplicationArea = all;
                }
                field(BS_Ledgeraccount; Rec.BS_Ledgeraccount)
                {
                    Tooltip = 'Ledgeraccount for bankaccount.';
                    ApplicationArea = all;
                }
            }
            group("Setup Estate")
            {
                Caption = 'Setup NETS';
                field(BS_AftaleNo; Rec.BS_AftaleNo)
                {
                    Tooltip = 'Agreement number';
                    ApplicationArea = all;
                }
                field(BS_Dataprovider; Rec.BS_Dataprovider)
                {
                    Tooltip = 'Dataprovider. Not necessarily companys branch number';
                    ApplicationArea = all;
                }
                field(BS_Delsystem; Rec.BS_Delsystem)
                {
                    Tooltip = 'Partsystem for NETS agreement';
                    ApplicationArea = all;
                }
                field(BS_DebGrp; Rec.BS_DebGrp)
                {
                    Tooltip = 'NETS customer group';
                    ApplicationArea = all;
                }
                field(BS_WorkSheetType; Rec.BS_WorkSheetType)
                {
                    Lookup = true;
                    ToolTip = 'Journaltype for incomming payments from NETS';
                    ApplicationArea = all;
                }
                field(BS_WorkSheet; Rec.BS_WorkSheet)
                {
                    Lookup = true;
                    ToolTip = 'Journal for incomming payments from NETS';
                    ApplicationArea = all;
                }
                field(BS_Advis; Rec.BS_Advis)
                {
                    Tooltip = 'Headline on customers collection';
                    ApplicationArea = all;
                }
                field(BS_ImportText; Rec.BS_ImportText)
                {
                    ApplicationArea = all;
                    Tooltip = 'Text on entries from NETS';
                }
            }
            group("Setup IM postings") //Inside Maintance postings
            {
                Caption = 'Inside maintenance';
                field(IntMaintenance; Rec.IntMaintenance)
                {
                    Tooltip = 'Rate for internal maintenance. Must be changed every year wiht the new rate provided by law.';
                    ApplicationArea = all;
                }
                field(IM_Autoposting; Rec.IM_Autoposting)
                {
                    ToolTip = 'Do you want the postings in the journal to be posted automatic? Else you have to do it manually';
                    ApplicationArea = all;
                }
                field(IM_WorkSheetType; Rec.IM_WorkSheetType)
                {
                    ToolTip = 'Journaltype for posting §22 transactions';
                    ApplicationArea = all;
                }
                field(IM_WorkSheet; Rec.IM_WorkSheet)
                {
                    ToolTip = 'Journal for posting §22 transactions';
                    ApplicationArea = all;
                }
                field(IM_Account; Rec.IM_Costtype)
                {
                    ToolTip = 'Wich costtype for posting §22?';
                    ApplicationArea = all;
                }

            }

            group("Other setup")
            {
                Caption = 'Other setup';
                field(ReminderFeeRes; Rec.ReminderFeeRes)
                {
                    Tooltip = 'Reminderfee for residens. Must be changed every year wiht the new rate provided by law.';
                    ApplicationArea = all;
                }
                field(ReminderFeeProf; Rec.ReminderFeeProf)
                {
                    Tooltip = 'Reminderfee for professions. Must be changed every year wiht the new rate provided by law.';
                    ApplicationArea = all;
                }
                Field(Splitcalc; Rec.Splitcalc)
                {
                    Tooltip = 'Contracts calculate days? Default is 0.5 month';
                    ApplicationArea = all;
                }
                field(CustomerArrears; Rec.CustomerArrears)
                {
                    ToolTip = 'Skal restancer på debitor medtages på opkrævningerne til NETS?';
                    ApplicationArea = all;
                }
                field(Numberserie; Rec.Numberserie)
                {
                    Tooltip = 'Numberserie for new leasecontracts.';
                    ApplicationArea = all;
                }
                field(PaymentMethodForNets; Rec.PaymentMethodForNets)
                {
                    ToolTip = 'Betalingsmetode bør være NETS. Anvendes til filtrering af faktura til NETS';
                    ApplicationArea = all;
                }
                field(PaymentTerms; Rec.PaymentTerms)
                {
                    ToolTip = 'Betalingsbetingelse for periodiske faktura.';
                    ApplicationArea = all;
                }
                field(Dim1; Rec.Dim1)
                {
                    ToolTip = 'Dimension for property';
                    ApplicationArea = all;
                }
                field(Dim2; Rec.Dim2)
                {
                    ToolTip = 'Dimension for tenancy';
                    ApplicationArea = all;
                }
                field(Dim3; Rec.Dim3)
                {
                    ToolTip = 'Dimension for occupant';
                    ApplicationArea = all;
                }
            }
        }
        area(factboxes)
        {
            part("Attached Documents"; 1174)
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(50003),
                              "No." = FIELD(Number);
                Visible = NOT IsOfficeAddin;
            }

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
        area(processing)
        {
            action("SVA Setup")
            {
                Caption = 'Setup Estate';
                ToolTip = 'Create paymentmethod, numberseries and dimensions if it dont exists.';
                Image = Apply;
                ApplicationArea = all;
                trigger OnAction()
                begin
                    Codeunit.Run(Codeunit::"SVA Setup Estate");
                end;

            }
            action("SVA Import properties")
            {

                Caption = 'Import properties';
                ToolTip = 'Import properties according to instructions';
                Image = Apply;
                ApplicationArea = All;
                trigger OnAction();
                begin
                    Xmlport.run(Xmlport::"SVA Import Properties", false, true)//"SVA Import Properties"
                end;
            }
            action("Import Tenancies")
            {
                Caption = 'Import Tenancies';
                ToolTip = 'Import tenancies according to instructions';
                Image = Apply;
                ApplicationArea = All;
                trigger OnAction();
                begin
                    Xmlport.run(xmlport::"SVA Import Tenancies", false, true)//"SVA Import Tenancies"
                end;

            }
            action("Import Costtype")
            {
                Caption = 'Import Costtype';
                ToolTip = 'Import costtypes according to instructions';
                Image = Apply;
                ApplicationArea = All;
                trigger OnAction();
                begin
                    Xmlport.run(Xmlport::"SVA Import Estate Cost Type", false, true)//"SVA Import Estate Cost Type";
                end;
            }
            action("Import Occupants")
            {
                Caption = 'Import Occupants';
                ToolTip = 'Import occupants according to instructions';
                Image = Apply;
                ApplicationArea = All;
                trigger OnAction();
                begin
                    Xmlport.run(Xmlport::"SVA Import Occupants", false, true)//"SVA Import Occupants"
                end;

            }
            action("Import Collections")
            {
                Caption = 'Import Collections';
                ToolTip = 'Import collections according to instructions';
                Image = Apply;
                ApplicationArea = All;
                trigger OnAction();
                begin
                    Xmlport.run(xmlport::"SVA Import Collections", false, true)//"SVA Import Collecions"
                end;
            }

            action("Arch Transactions")
            {
                Caption = 'Import transactions';
                ToolTip = 'Import old transactions according to instructions';
                Image = Apply;
                ApplicationArea = All;
                trigger OnAction();
                begin
                    Xmlport.run(xmlport::"SVA Import Occupant Trans", false, true) //"SVA Import Occupant Trans"
                end;
            }
            action(MissingData)
            {
                Caption = 'Import missing Post Codes';
                Tooltip = 'Import missing Post Codes to table Post Codes';
                Image = Apply;
                ApplicationArea = All;

                trigger OnAction();
                var
                    SVAPostCode: Record "SVA PostCode";
                    PostCode: Record "Post Code";
                begin
                    Commit();
                    SVAPostCode.DeleteAll();
                    Xmlport.run(Xmlport::"SVA Import Post Code", false, true);
                    SVAPostCode.Reset();
                    if SVAPostCode.FindSet() then
                        repeat
                            PostCode.Init();
                            PostCode.Code := SVAPostCode.PostCode;
                            PostCode."Country/Region Code" := SVAPostCode.Country;
                            PostCode.City := SVAPostCode.City;
                            if not PostCode.Insert() then
                                PostCode.Modify();
                        until SVAPostCode.Next() = 0;
                    SVAPostCode.DeleteAll();
                end;
            }
            action(sessions)
            {
                Caption = 'Session';
                ApplicationArea = All;
                RunObject = page "SVA Sessions";
                ToolTip = 'Active sessions';
            }


        }
    }

    trigger OnOpenPage()
    var
        CompanyInformation: Record "Company Information";
        SVAParameters: Record "SVA Parameters";
        OfficeManagement: Codeunit "Office Management";
    begin
        CompanyInformation.Get();
        if CompanyInformation.Address <> SVAParameters.Address then begin
            SVAParameters.Address := CompanyInformation.Address;
            SVAParameters."Post code" := CompanyInformation."Post Code";
            SVAParameters.City := CompanyInformation.City;
        end;


        IsOfficeAddin := Officemanagement.IsAvailable()
    end;

    var
        IsOfficeAddin: Boolean;
}

