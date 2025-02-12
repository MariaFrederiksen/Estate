page 50040 "SVA Occupant Heat List"
{
    Caption = 'List ac heat for Occupants';
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = "SVA Occupant";
    DataCaptionFields = Number, Name1;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Number; Rec.Number)
                {
                    ApplicationArea = All;
                    Tooltip = 'Agreement number';
                }
                field(TenancyNo; Rec.TenancyNo)
                {
                    ApplicationArea = All;
                    Tooltip = 'Tenancy number';
                }
                field(Name1; Rec.Name1)
                {
                    ApplicationArea = All;
                    Tooltip = 'Tenant name';
                }
                field(Name2; Rec.Name2)
                {
                    ApplicationArea = All;
                    Tooltip = 'Second tenant name';
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                    Tooltip = 'Invoice address';
                }

                field(StartDate; Rec.StartDate)
                {
                    ApplicationArea = All;
                    ToolTip = 'Contract startdate';
                }
                field(EndDate; Rec.EndDate)
                {
                    ApplicationArea = All;
                    ToolTip = 'Contract end date.';
                }
                field(Heatamount; Heatamount)
                {
                    ApplicationArea = All;
                    Caption = 'Heatamount';
                    ToolTip = 'Heat a conto total';

                }
                field(Wateramount; Wateramount)
                {
                    ApplicationArea = All;
                    Caption = 'Wateramount';
                    ToolTip = 'Water a conto total';
                }
            }
        }
    }


    trigger OnAfterGetCurrRecord()
    var
        SVAProperty: Record "SVA Property";
    begin
        SVAProperty.Reset();
        SVAProperty.SETRANGE(SVAProperty.Property, Rec.PropertyNo);
        IF SVAProperty.FINDFIRST() then
            If ConsumptionTo = 0D then begin
                ConsumptionFrom := DMY2DATE(1, SVAProperty.HeatingYearFrom, DATE2DMY(TODAY, 3));
                ConsumptionTo := CALCDATE('<1Y-1D>', ConsumptionFrom);
                while Today < ConsumptionTo do begin
                    ConsumptionFrom := CalcDate('<-1Y>', ConsumptionFrom);
                    ConsumptionTo := CalcDate('<-1Y>', ConsumptionTo);
                end;
            end;
    end;





    var
        HeatAmount: Decimal;
        WaterAmount: Decimal;
        ConsumptionTo: date;
        ConsumptionFrom: date;
}
