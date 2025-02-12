report 50040 "SVA Consumption Heat List"
{
    DefaultLayout = Word;
    WordLayout = './layouts/Consumption Heat List.docx';
    Caption = 'AC heat';
    UsageCategory = ReportsAndAnalysis;


    dataset
    {
        dataitem("SVA Tenancy"; "SVA Tenancy")
        {
            column(TenancyNumber; Number)
            {
            }
            column(Headline; Headline)
            {
            }
            column(CompanyName; PropertyName)
            {
            }
            column(ConsumptionFrom; format(ConsumptionFrom))
            {
            }
            column(ConsumptionTo; format(ConsumptionTo))
            {
            }
            column(PropertyNo; PropertyNo)
            {
            }

            dataitem(Occupant; "SVA Occupant")
            {
                DataItemLink = TenancyNo = FIELD(Number);
                DataItemTableView = sorting(TenancyNo, Number);

                column(Number; Number)
                {
                }
                column(TenancyNo; TenancyNo)
                {
                }
                column(Customer; "Customer No")
                {
                }
                column(Name1; Name1)
                {
                }
                column(Address; Address)
                {
                }
                column(EndDate; Format(EndDate))
                {
                }
                column(StartDate; Format(StartDate))
                {
                }
                column(HeatAmount; HeatAmount)
                {
                    DecimalPlaces = 0 : 2;
                }
                column(HeatTotal; format(HeatTotal))
                {
                }
                trigger OnAfterGetRecord()
                var
                    SVAOccupantTrans: Record "SVA Occupant Trans";
                begin
                    IF (EndDate < ConsumptionFrom) AND (EndDate <> 0D) THEN
                        CurrReport.Skip();
                    IF StartDate > ConsumptionTo THEN
                        CurrReport.Skip();
                    HeatAmount := 0;
                    SVAOccupantTrans.Reset();
                    SVAOccupantTrans.SetRange(SVAOccupantTrans.Occupant, Occupant.Number);
                    SVAOccupantTrans.SetRange(SVAOccupantTrans.Date, ConsumptionFrom, ConsumptionTo);
                    SVAOccupantTrans.SetRange(SVAOccupantTrans.Type, SVAOccupantTrans.Type::ACheat);
                    if SVAOccupantTrans.FindSet() then
                        repeat
                            HeatAmount += SVAOccupantTrans.Amount;
                        until SVAOccupantTrans.Next() = 0;
                    if HeatAmount = 0 then
                        CurrReport.Skip();
                end;
            }
            trigger OnAfterGetRecord();
            var
            begin
                Headline := HeadlineLbl;
                PropNo := PropertyNo;
                SVAProperty.Reset();
                SVAProperty.SETRANGE(SVAProperty.Property, PropNo);
                IF SVAProperty.FINDFIRST() then begin
                    PropertyName := SVAProperty.Name;
                    if PropertyName = '' then
                        PropertyName := SVAProperty.Address1;
                    If ConsumptionTo = 0D then begin
                        ConsumptionFrom := DMY2DATE(1, SVAProperty.HeatingYearFrom, DATE2DMY(TODAY, 3));
                        ConsumptionTo := CALCDATE('<1Y-1D>', ConsumptionFrom);
                        while Today < ConsumptionTo do begin
                            ConsumptionFrom := CalcDate('<-1Y>', ConsumptionFrom);
                            ConsumptionTo := CalcDate('<-1Y>', ConsumptionTo);
                        end;
                    end;
                end;
            end;
        }
    }
    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        SVAProperty: Record "SVA Property";
        Headline: Text[20];
        ConsumptionTo: Date;
        ConsumptionFrom: Date;
        PropNo: Code[10];
        HeadlineLbl: Label 'A conto heat';
        PropertyName: Text[50];
        HeatAmount: Decimal;
        HeatTotal: Decimal;

}


