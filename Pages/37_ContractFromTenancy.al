page 50037 "SVA Contract From Tenancy"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "SVA Occupant";

    layout
    {
        area(Content)
        {
            group(Tenant)
            {
                field(Number; Rec.Number)
                {
                    ApplicationArea = all;
                    ToolTip = 'Contract number';

                }
                field(PropertyNo; Rec.PropertyNo)
                {
                    ApplicationArea = all;
                    ToolTip = 'Property number';
                }
                field(TenancyNo; Rec.TenancyNo)
                {
                    ApplicationArea = all;
                    ToolTip = 'Tenancy Number';

                }
                field(startdate; Rec.StartDate)
                {
                    ApplicationArea = All;
                    ToolTip = 'Startdate of the contract.';
                    /* trigger OnValidate()
                    var
                        SVASubscriptionLines: Record "SVA Subscription Lines";
                    begin
                        Rec.SetPeriods();
                        if Rec.Rent = 0 then begin
                            SVASubscriptionLines.Reset();
                            SVASubscriptionLines.SetRange(Tenancies, Rec.TenancyNo);
                            SVASubscriptionLines.SetRange(Type, SVASubscriptionLines.Type::Rent);
                            if SVASubscriptionLines.FindSet() then
                                repeat
                                    if (SVASubscriptionLines."Date To" = 0D) or (SVASubscriptionLines."Date To" > Rec.StartDate) then
                                        Rec.Rent := SVASubscriptionLines."Amount Year" / Rec.SetPeriods();
                                until SVASubscriptionLines.Next() = 0;

                        end;
                        if Rec.Heat = 0 then begin
                            SVASubscriptionLines.Reset();
                            SVASubscriptionLines.SetRange(Tenancies, Rec.TenancyNo);
                            SVASubscriptionLines.SetRange(Type, SVASubscriptionLines.Type::ACheat);
                            if SVASubscriptionLines.FindSet() then
                                repeat
                                    if (SVASubscriptionLines."Date To" = 0D) or (SVASubscriptionLines."Date To" > Rec.StartDate) then
                                        Rec.Heat := SVASubscriptionLines."Amount Year" / Rec.SetPeriods();
                                until SVASubscriptionLines.Next() = 0;

                        end;
                        if Rec.Water = 0 then begin
                            SVASubscriptionLines.Reset();
                            SVASubscriptionLines.SetRange(Tenancies, Rec.TenancyNo);
                            SVASubscriptionLines.SetRange(Type, SVASubscriptionLines.Type::ACwater);
                            if SVASubscriptionLines.FindSet() then
                                repeat
                                    if (SVASubscriptionLines."Date To" = 0D) or (SVASubscriptionLines."Date To" > Rec.StartDate) then
                                        Rec.Water := SVASubscriptionLines."Amount Year" / Rec.SetPeriods();
                                until SVASubscriptionLines.Next() = 0;

                        end;
                        if Rec.BebRep = 0 then begin
                            SVASubscriptionLines.Reset();
                            SVASubscriptionLines.SetRange(Tenancies, Rec.TenancyNo);
                            SVASubscriptionLines.SetRange(Type, SVASubscriptionLines.Type::OccGroup);
                            if SVASubscriptionLines.FindSet() then
                                repeat
                                    if (SVASubscriptionLines."Date To" = 0D) or (SVASubscriptionLines."Date To" > Rec.StartDate) then
                                        Rec.BebRep := SVASubscriptionLines."Amount Year" / Rec.SetPeriods();
                                until SVASubscriptionLines.Next() = 0;
                        end;
                    end;
 */
                }


                field(Name1; Rec.Name1)
                {
                    ApplicationArea = All;
                    ToolTip = 'Tenants full name';
                }
                field(Name2; Rec.Name2)
                {
                    ApplicationArea = All;
                    ToolTip = 'Second tenants name';
                }
                field(CustomerAdress1; Rec.CustomerAdress1)
                {
                    ApplicationArea = all;
                    ToolTip = 'Current adress';
                }
                field(CustomerCity; Rec.CustomerCity)
                {
                    ApplicationArea = all;
                    ToolTip = 'Current city';
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = all;
                    ToolTip = 'Current Post Code';
                }
                field(Email1; Rec.Email1)
                {
                    ApplicationArea = all;
                    ToolTip = 'E-mail';
                }
                field(Email2; Rec.Email2)
                {
                    ApplicationArea = all;
                    ToolTip = 'E-mail 2';
                }
                field(CustomerSocNo; Rec.CustomerSocNo)
                {
                    ApplicationArea = all;
                    ToolTip = 'Social Security No.';
                }
                field(CustomerSocNo2; Rec.CustomerSocNo2)
                {
                    ApplicationArea = all;
                    ToolTip = 'Social Security No.';
                }
                field(Bankname; Rec.Bankname)
                {
                    ApplicationArea = all;
                    ToolTip = 'Bankname, tenant';
                }
                field("Bankreg-no"; Rec."Bankreg-no")
                {
                    ApplicationArea = all;
                    ToolTip = 'Bank branch number';
                }
                field(BankAccount; Rec.BankAccount)
                {
                    ApplicationArea = all;
                    ToolTip = 'Bank account number';
                }

            }
            group(Payments)
            {
                field(Rent; Rec.Rent)
                {
                    ApplicationArea = all;
                    ToolTip = 'Rent per period';
                }
                field(Heat; Rec.Heat)
                {
                    ApplicationArea = all;
                    ToolTip = 'A conto heat per month';
                }
                field(Water; Rec.Water)
                {
                    ApplicationArea = all;
                    ToolTip = 'A conto water per month';
                }
                field(BebRep; Rec.BebRep)
                {
                    ApplicationArea = all;
                    ToolTip = 'If there is Resident Representative, you have to pay.';
                    Editable = false;
                }
                field(DepositAmount; Rec.DepositAmount)
                {
                    ApplicationArea = all;
                    ToolTip = 'Deposit amount, max. 3 month of rent';
                }
                field(PrepaidRentAmount; Rec.PrepaidRentAmount)
                {
                    ApplicationArea = all;
                    ToolTip = 'Prepaid rent amount, max. 3 month of rent';
                }
            }
        }
    }
}