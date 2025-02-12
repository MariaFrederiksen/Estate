page 50006 "SVA Leasecontract_Garage"
//Tooltip created
{
    // Page er oprettet for at kunne udfylde Lejekontrakt for garage korrekt. En del informationer findes i andre tabeller, og
    // udfyldes (se tabllen), når man går ind på kontrakten første gang. Senere ændringer overskrives ikke.
    //Tooltip created.

    Caption = 'Leasecontract Garage';
    PageType = Card;
    SourceTable = "SVA LeaseContract_A9";

    layout
    {
        area(content)
        {
            group(Lejeaftale)
            {
                Caption = 'Leasecontract';
                field(Number; Rec.Number)
                {
                    ApplicationArea = All;
                    ToolTip = 'Number on leasecontract';
                }
                field(TypeA9_1_Address; Rec.TypeA9_1_Address)
                {
                    ApplicationArea = All;
                    ToolTip = 'Tenancy address';
                }
                field(TypeA9_1_City; Rec.TypeA9_1_City)
                {
                    ApplicationArea = All;
                    ToolTip = 'Tenancy city';
                }
                field(TypeA9_1_Landlord; Rec.TypeA9_1_Landlord)
                {
                    ApplicationArea = All;
                    ToolTip = 'Landlord name';
                }
                field(TypeA9_1_LandlordCVR; Rec.TypeA9_1_LandlordCVR)
                {
                    ApplicationArea = All;
                    ToolTip = 'Landlord ESRno.';
                }
                field(TypeA9_1_LandlordAddress; Rec.TypeA9_1_LandlordAddress)
                {
                    ApplicationArea = All;
                    ToolTip = 'Landlord address';
                }
                field(TypeA9_1_TenentName; Rec.TypeA9_1_TenentName)
                {
                    ApplicationArea = All;
                    ToolTip = 'Tenant name(s)';
                }
                field(TypeA9_1_TenentAddress; Rec.TypeA9_1_TenentAddress)
                {
                    ApplicationArea = All;
                    ToolTip = 'Tenant invoice address';
                }
                field(TypeA9_1_TenantCPR; Rec.TypeA9_1_TenantCPR)
                {
                    ApplicationArea = All;
                    ToolTip = 'Tenant social security number';
                }
                field(TypeA9_1_GarageNo; Rec.TypeA9_1_GarageNo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Garage no. or letter';
                }
                field(TypeA9_2_Startdate; Rec.TypeA9_2_Startdate)
                {
                    ApplicationArea = All;
                    ToolTip = 'Startdate leaseperiod';
                }
                field(TypeA9_3_RentPerPeriode; Rec.TypeA9_3_RentPerPeriode)
                {
                    ApplicationArea = All;
                    ToolTip = 'Rent per period (month, quarter, halfyear or year).';
                }
                field(TypeA9_3_RentPerYear; Rec.TypeA9_3_RentPerYear)
                {
                    ApplicationArea = All;
                    ToolTip = 'Rent per year';
                }
                field(TypeA9_4_DepMth; Rec.TypeA9_4_DepMth)
                {
                    ApplicationArea = All;
                    ToolTip = 'Deposit qty month';
                }
                field(TypeA9_4_DepAmount; Rec.TypeA9_4_DepAmount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Deposit amount. If deposit month is blank, amount can be filled out';
                }
                field(TypeA9_4_PrepaidRentMth; Rec.TypeA9_4_PrepaidRentMth)
                {
                    ApplicationArea = All;
                    ToolTip = 'Prepaid rent qty month';
                }
                field(TypeA9_4_PrepaidRent; Rec.TypeA9_4_PrepaidRent)
                {
                    ApplicationArea = All;
                    ToolTip = 'Prepaid rent amount';
                }
                field(TypeA9_4_Rentetc; Rec.TypeA9_4_Rentetc)
                {
                    ApplicationArea = All;
                    ToolTip = 'Rent first period';
                }
                field(TypeA9_4_RentFrom; Rec.TypeA9_4_RentFrom)
                {
                    ApplicationArea = All;
                    ToolTip = 'Rent first period startdate';
                }
                field(TypeA9_4_RentTo; Rec.TypeA9_4_RentTo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Rent first period enddate';
                }
                field(TypeA9_4_TotalAmount; Rec.TypeA9_4_TotalAmount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Total amount to be paid at commissioning';
                }
                field(TypeA9_4_DueDate; Rec.TypeA9_4_DueDate)
                {
                    ApplicationArea = All;
                    ToolTip = 'Duedate for moving in costs';
                }
                field(TypeA9_4_RentFirstTime; Rec.TypeA9_4_RentFirstTime)
                {
                    ApplicationArea = All;
                    ToolTip = 'Rent first time then';
                }
                field(TypeA9_3_Bankname; Rec.TypeA9_3_Bankname)
                {
                    ApplicationArea = All;
                    ToolTip = 'Landlords bankname';
                }
                field(TypeA9_3_BankRegNo; Rec.TypeA9_3_BankRegNo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Landlord bank branch no';
                }
                field(TypeA9_3_BankAccount; Rec.TypeA9_3_BankAccount)
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
            action(LeaseContract)
            {
                ApplicationArea = all;
                Caption = 'Leasecontract';
                ToolTip = 'Print leasecontract for garage';
                Image = Report;

                trigger OnAction();
                begin
                    CLEAR(SVALeaseContractA9);
                    SVALeaseContractA9.SETRANGE(Number, Rec.Number);
                    IF SVALeaseContractA9.FindFirst() THEN begin
                        CLEAR(SVAContractGarage);
                        SVAContractGarage.SETTABLEVIEW(SVALeaseContractA9);
                        SVAContractGarage.RunModal();
                    END;
                end;
            }
            action(SVAMovinginJ)
            {
                ApplicationArea = all;
                Caption = 'Move in journal';
                ToolTip = 'Making a journal for moving in costs';
                Image = Report;

                trigger Onaction();
                begin
                    CLEAR(SVALeaseContractA9);
                    SVALeaseContractA9.SETRANGE(Number, Rec.Number);
                    IF SVALeaseContractA9.FindFirst() THEN begin
                        CLEAR(SVAMovinginJournal);
                        SVAMovinginJournal.SETTABLEVIEW(SVALeaseContractA9);
                        SVAMovinginJournal.RunModal();
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
                    CLEAR(SVALeaseContractA9);
                    SVALeaseContractA9.SETRANGE(Number, Rec.Number);
                    IF SVALeaseContractA9.FindFirst() then
                        Codeunit.run(Codeunit::"SVA Move In Invoice", SVALeaseContractA9);
                end;

            }


        }
    }

    trigger OnAfterGetCurrRecord();
    begin
        CurrPage.UPDATE();
    end;

    var
        SVALeaseContractA9: Record "SVA LeaseContract_A9";
        SVAContractGarage: report "SVA Contract Garage";
        SVAMovinginJournal: Report "SVA Moving in Journal";
}


