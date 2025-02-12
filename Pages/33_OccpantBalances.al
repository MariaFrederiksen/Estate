page 50033 "SVA Occupant Balances"
{
    Caption = 'Occupant balances';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "SVA Occupant";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(PropertyNo; Rec.PropertyNo)
                {
                    ApplicationArea = all;
                    ToolTip = 'Property number';
                }
                field(TenancyNo; Rec.TenancyNo)
                {
                    ApplicationArea = all;
                    ToolTip = 'Tenancy number';
                }
                field(Number; Rec.Number)
                {
                    ApplicationArea = all;
                    ToolTip = 'Occupant';
                }
                field(Name1; Rec.Name1)
                {
                    ApplicationArea = all;
                    ToolTip = 'Occupant name';
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = all;
                    ToolTip = 'Address';
                }
                field(StartDate; REc.StartDate)
                {
                    ApplicationArea = all;
                    ToolTip = 'Startdate of the contract.';
                }
                field(EndDate; Rec.EndDate)
                {
                    ApplicationArea = all;
                    ToolTip = 'Enddate of the contract.';
                }
                field(RentMth; RentMth)
                {
                    ApplicationArea = all;
                    Caption = 'Månedsleje';
                    ToolTip = 'Rent per month regardless periods.';
                }
                field(PrepaidRent; PrepaidRent)
                {
                    ApplicationArea = all;
                    Caption = 'Prepaid Rent';
                    ToolTip = 'Prepaid rent. Actual paid.';
                }
                field(Deposit; Deposit)
                {
                    ApplicationArea = all;
                    Caption = 'Deposit';
                    ToolTip = 'Deposit. Actual paid.';
                }
                field(CalcDeposit; CalcDeposit)
                {
                    ApplicationArea = all;
                    Caption = '3 month rent';
                    ToolTip = '3 months rent';
                }
            }
        }
    }
    var
        CalcDeposit: Decimal;
        Deposit: Decimal;
        RentMth: Decimal;
        PrepaidRent: Decimal;


    trigger OnAfterGetRecord()
    var
        SVAOccupantTrans: Record "SVA Occupant Trans";
        SVASubscriptionLines: Record "SVA Subscription Lines";
    begin
        Deposit := 0;
        PrepaidRent := 0;
        SVAOccupantTrans.Reset();
        SVAOccupantTrans.SetRange(Occupant, Rec.Number);
        SVAOccupantTrans.SetRange(Type, 10);
        if SVAOccupantTrans.FindSet() then
            repeat
                Deposit := Deposit + SVAOccupantTrans.Amount;
            until SVAOccupantTrans.Next() = 0;
        SVAOccupantTrans.Reset();
        SVAOccupantTrans.SetRange(Occupant, Rec.Number);
        SVAOccupantTrans.SetRange(Type, 11);
        if SVAOccupantTrans.FindSet() then
            repeat
                PrepaidRent := PrepaidRent + SVAOccupantTrans.Amount;
            until SVAOccupantTrans.Next() = 0;
        SVASubscriptionLines.Reset();
        SVASubscriptionLines.SetRange(Tenancies, Rec.TenancyNo);
        SVASubscriptionLines.SetRange(Type, SVAOccupantTrans.Costtype::Rent);
        if SVASubscriptionLines.FindFirst() then
            if (SVASubscriptionLines."Date To" > Today) OR (SVASubscriptionLines."Date To" = 0D) then
                RentMth := SVASubscriptionLines."Amount Year" / 12;
        CalcDeposit := RentMth * 3;
    end;

}