report 50043 "SVA Theoretical Equivalent"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    Caption = 'Theoretical Equovalent';
    WordLayout = './layouts/ExpectedIncome.docx';
    DefaultLayout = Word;


    dataset
    {
        dataitem("SVA Tenancy"; "SVA Tenancy")
        {
            column(PropertyNo; PropertyNo)
            {

            }
            column(Number; Number)
            {
            }
            column(RentAmount; RentAmount)
            {
            }
            column(HeatAmount; HeatAmount)
            {

            }
            column(WaterAmount; WaterAmount)
            {

            }
            column(Occgroup; Occgroup)
            {

            }

            trigger OnAfterGetRecord()
            var
                SVASubscriptionLines: Record "SVA Subscription Lines";
                SVACostType: Record "SVA Cost type";
            begin
                SVACostType.Reset();
                if SVACostType.FindSet() then
                    if SVACostType.Account <> '' then
                        repeat
                            //if Confirm('Findset') = true then;
                            //Rent
                            IF SVACostType.Type = SVACostType.Type::Rent then begin
                                RentAmount := 0;
                                SVASubscriptionLines.Reset();
                                SVASubscriptionLines.SetRange(Type, SVACostType.Type);
                                SVASubscriptionLines.SetRange(Tenancies, Number);
                                SVASubscriptionLines.SetRange("Date To", 0D);
                                if SVASubscriptionLines.FindSet() then
                                    repeat
                                        RentAmount += SVASubscriptionLines."Amount Year";
                                    until SVASubscriptionLines.Next() = 0;
                                SVASubscriptionLines.Reset();
                                SVASubscriptionLines.SetRange(Tenancies, Number);
                                SVASubscriptionLines.SetRange(Type, SVACostType.Type);
                                SVASubscriptionLines.SetFilter(SVASubscriptionLines."Date To", '>', WorkDate());
                                if SVASubscriptionLines.FindSet() then
                                    repeat
                                        RentAmount += SVASubscriptionLines."Amount Year";
                                    until SVASubscriptionLines.Next() = 0;
                            end;
                            //Heat
                            IF SVACostType.Type = SVACostType.Type::ACheat then begin
                                HeatAmount := 0;
                                SVASubscriptionLines.Reset();
                                SVASubscriptionLines.SetRange(Type, SVACostType.Type);
                                SVASubscriptionLines.SetRange(Tenancies, Number);
                                SVASubscriptionLines.SetRange("Date To", 0D);
                                if SVASubscriptionLines.FindSet() then
                                    repeat
                                        HeatAmount += SVASubscriptionLines."Amount Year";
                                    until SVASubscriptionLines.Next() = 0;
                                SVASubscriptionLines.Reset();
                                SVASubscriptionLines.SetRange(Tenancies, Number);
                                SVASubscriptionLines.SetRange(Type, SVACostType.Type);
                                SVASubscriptionLines.SetFilter(SVASubscriptionLines."Date To", '>', WorkDate());
                                if SVASubscriptionLines.FindSet() then
                                    repeat
                                        HeatAmount += SVASubscriptionLines."Amount Year";
                                    until SVASubscriptionLines.Next() = 0;
                            end;
                            //Water
                            IF SVACostType.Type = SVACostType.Type::ACwater then begin
                                WaterAmount := 0;
                                SVASubscriptionLines.Reset();
                                SVASubscriptionLines.SetRange(Type, SVACostType.Type);
                                SVASubscriptionLines.SetRange(Tenancies, Number);
                                SVASubscriptionLines.SetRange("Date To", 0D);
                                if SVASubscriptionLines.FindSet() then
                                    repeat
                                        WaterAmount += SVASubscriptionLines."Amount Year";
                                    until SVASubscriptionLines.Next() = 0;
                                SVASubscriptionLines.Reset();
                                SVASubscriptionLines.SetRange(Tenancies, Number);
                                SVASubscriptionLines.SetRange(Type, SVACostType.Type);
                                SVASubscriptionLines.SetFilter(SVASubscriptionLines."Date To", '>', WorkDate());
                                if SVASubscriptionLines.FindSet() then
                                    repeat
                                        WaterAmount += SVASubscriptionLines."Amount Year";
                                    until SVASubscriptionLines.Next() = 0;
                            end;
                            IF SVACostType.Type <> SVACostType.Type::OccGroup then begin
                                Occgroup := 0;
                                SVASubscriptionLines.Reset();
                                SVASubscriptionLines.SetRange(Type, SVACostType.Type);
                                SVASubscriptionLines.SetRange(Tenancies, Number);
                                SVASubscriptionLines.SetRange("Date To", 0D);
                                if SVASubscriptionLines.FindSet() then
                                    repeat
                                        Occgroup += SVASubscriptionLines."Amount Year";
                                    until SVASubscriptionLines.Next() = 0;
                                SVASubscriptionLines.Reset();
                                SVASubscriptionLines.SetRange(Tenancies, Number);
                                SVASubscriptionLines.SetRange(Type, SVACostType.Type);
                                SVASubscriptionLines.SetFilter(SVASubscriptionLines."Date To", '>', WorkDate());
                                if SVASubscriptionLines.FindSet() then
                                    repeat
                                        Occgroup += SVASubscriptionLines."Amount Year";
                                    until SVASubscriptionLines.Next() = 0;
                            end;
                        //Other    

                        until SVACostType.Next() = 0;
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field(PropertyNo; "SVA Tenancy".PropertyNo)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Property number';

                    }
                }
            }
        }


    }


    var
        RentAmount: Decimal;
        HeatAmount: Decimal;
        WaterAmount: Decimal;
        Occgroup: Decimal;




}