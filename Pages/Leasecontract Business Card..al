page 50005 "SVA Lease Business"
//Tooltip created
{
    // Page er oprettet for at kunne fakturere et erhvervslejemål korrekt. En del informationer findes i andre tabeller, og
    // udfyldes (se tabllen), når man går ind på kontrakten første gang. Senere ændringer overskrives ikke.
    //Tooltip created.

    Caption = 'Lease Business';
    PageType = Card;
    SourceTable = "SVA LeaseContract_A9";

    layout
    {
        area(content)
        {
            group(Lejeaftale)
            {
                Caption = 'Leasecontract';
                field(Number; Number)
                {
                    ApplicationArea = All;
                    ToolTip = 'Number on leasecontract';
                }
                field(TypeA9_1_Address; TypeA9_1_Address)
                {
                    ApplicationArea = All;
                    ToolTip = 'Tenancy address';
                }
                field(TypeA9_1_City; TypeA9_1_City)
                {
                    ApplicationArea = All;
                    ToolTip = 'Tenancy city';
                }
                field(TypeA9_1_Landlord; TypeA9_1_Landlord)
                {
                    ApplicationArea = All;
                    ToolTip = 'Landlord name';
                }
                field(TypeA9_1_LandlordCVR; TypeA9_1_LandlordCVR)
                {
                    ApplicationArea = All;
                    ToolTip = 'Landlord ESRno.';
                }
                field(TypeA9_1_LandlordAddress; TypeA9_1_LandlordAddress)
                {
                    ApplicationArea = All;
                    ToolTip = 'Landlord address';
                }
                field(TypeA9_1_TenentName; TypeA9_1_TenentName)
                {
                    ApplicationArea = All;
                    ToolTip = 'Tenant name(s)';
                }
                field(TypeA9_1_TenentAddress; TypeA9_1_TenentAddress)
                {
                    ApplicationArea = All;
                    ToolTip = 'Tenant invoice address';
                }
                field(TypeA9_1_TenantCPR; TypeA9_1_TenantCPR)
                {
                    ApplicationArea = All;
                    ToolTip = 'Tenant social security number';
                }
                field(TypeA9_1_GarageNo; TypeA9_1_GarageNo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Garage no. or letter';
                }
                field(TypeA9_2_Startdate; TypeA9_2_Startdate)
                {
                    ApplicationArea = All;
                    ToolTip = 'Startdate leaseperiod';
                }
                field(TypeA9_3_RentPerPeriode; TypeA9_3_RentPerPeriode)
                {
                    ApplicationArea = All;
                    ToolTip = 'Rent per period (month, quarter, halfyear or year).';
                }
                field(TypeA9_3_RentPerYear; TypeA9_3_RentPerYear)
                {
                    ApplicationArea = All;
                    ToolTip = 'Rent per year';
                }
                field(TypeA9_4_DepMth; TypeA9_4_DepMth)
                {
                    ApplicationArea = All;
                    ToolTip = 'Deposit qty month';
                }
                field(TypeA9_4_DepAmount; TypeA9_4_DepAmount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Deposit amount. If deposit month is blank, amount can be filled out';
                }
                field(TypeA9_4_PrepaidRentMth; TypeA9_4_PrepaidRentMth)
                {
                    ApplicationArea = All;
                    ToolTip = 'Prepaid rent qty month';
                }
                field(TypeA9_4_PrepaidRent; TypeA9_4_PrepaidRent)
                {
                    ApplicationArea = All;
                    ToolTip = 'Prepaid rent amount';
                }
                field(TypeA9_4_Rentetc; TypeA9_4_Rentetc)
                {
                    ApplicationArea = All;
                    ToolTip = 'Rent first period';
                }
                field(TypeA9_4_RentFrom; TypeA9_4_RentFrom)
                {
                    ApplicationArea = All;
                    ToolTip = 'Rent first period startdate';
                }
                field(TypeA9_4_RentTo; TypeA9_4_RentTo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Rent first period enddate';
                }
                field(TypeA9_4_TotalAmount; TypeA9_4_TotalAmount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Total amount to be paid at commissioning';
                }
                field(TypeA9_4_DueDate; TypeA9_4_DueDate)
                {
                    ApplicationArea = All;
                    ToolTip = 'Duedate for moving in costs';
                }
                field(TypeA9_4_RentFirstTime; TypeA9_4_RentFirstTime)
                {
                    ApplicationArea = All;
                    ToolTip = 'Rent first time then';
                }
                field(TypeA9_3_Bankname; TypeA9_3_Bankname)
                {
                    ApplicationArea = All;
                    ToolTip = 'Landlords bankname';
                }
                field(TypeA9_3_BankRegNo; TypeA9_3_BankRegNo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Landlord bank branch no';
                }
                field(TypeA9_3_BankAccount; TypeA9_3_BankAccount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Landlord bank account no.';
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
        area(Processing)
        {

            action(MoveInJournal)
            {
                ApplicationArea = all;
                Caption = 'Move in journal';
                ToolTip = 'Making a journal for moving in costs';
                Image = Report;

                trigger Onaction();
                begin
                    CLEAR(Contract);
                    Contract.SETRANGE(Number, Rec.Number);
                    IF Contract.FindFirst() THEN begin
                        CLEAR(MoveInJournal);
                        MoveInJournal.SETTABLEVIEW(Contract);
                        MoveInJournal.RunModal;
                    END;
                end;
            }
            action(MoveInInvoice)
            {
                ApplicationArea = all;
                Caption = 'Make Invoice moving in';
                ToolTip = 'Make invoice to customer for moving in costs';
                Image = Report;

                trigger OnAction();
                begin
                    CLEAR(Contract);
                    Contract.SETRANGE(Number, Rec.Number);
                    IF Contract.FindFirst() then
                        Codeunit.run(Codeunit::"SVA Move In Invoice", Contract);
                end;
            }

        }
    }

    trigger OnAfterGetCurrRecord();
    begin
        CurrPage.UPDATE;
    end;

    var
        Contract: Record "SVA LeaseContract_A9";
        MoveInJournal: Report "SVA Moving in Journal";
}


