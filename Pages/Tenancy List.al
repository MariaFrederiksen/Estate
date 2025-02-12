page 50024 "SVA Tenancy List"
{
    Caption = 'List of Tenancies';
    CardPageID = "SVA Tenancy Card";
    PageType = List;
    SourceTable = "SVA Tenancy";
    UsageCategory = Lists;
    ApplicationArea = All;


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(PropertyNo; Rec.PropertyNo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Attached to property number';
                }
                field(Number; Rec.Number)
                {
                    ApplicationArea = All;
                    ToolTip = 'Tenancy number';
                }
                field(Address1; Rec.Address1)
                {
                    ApplicationArea = All;
                    ToolTip = 'Tenancy address';
                }
                field(Address2; Rec.Address2)
                {
                    ApplicationArea = All;
                    ToolTip = 'Tenancy address 2';

                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                    ToolTip = 'Tenancy city';
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    ToolTip = 'Tenancy type (Living,Commercial Leases,Partial,Owner,House,Other). ';
                }
                field(PeriodYear; Rec.PeriodYear)
                {
                    ApplicationArea = All;
                    ToolTip = 'Periods for invoiced collection';
                }
                field(AreaTotal; Rec.AreaTotal)
                {
                    ApplicationArea = All;
                    ToolTip = 'Total area of tenancy';
                }
                field(Rooms; Rec.Rooms)
                {
                    ApplicationArea = All;
                    ToolTip = 'Quantity of rooms';
                }
                field(Vacant; Rec.Vacant)
                {
                    ApplicationArea = All;
                    ToolTip = 'Is the tenancy vacant';
                }
                field(vacantDate; Rec.vacantDate)
                {
                    ApplicationArea = All;
                    ToolTip = 'When is the tenancy vacant from.';
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
        area(navigation)
        {
            action(Occupants)
            {
                ApplicationArea = All;
                Caption = 'Occupants';
                ToolTip = 'List of occupants in this tenancy.';
                Image = Customer;
                RunObject = Page "SVA Occupant List";
                RunPageLink = TenancyNo = FIELD(Number);
            }

            action(NewOccupant)
            {
                ApplicationArea = All;
                Caption = 'New Occupant';
                ToolTip = 'Create a new contract for this tenancy';
                Image = Customer;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    SVAParameters: Record "SVA Parameters";
                    SVAOccupant: Record "SVA Occupant";
                    NoSeriesManagement: Codeunit "NoSeriesManagement";
                begin
                    if rec.Vacant = false then
                        Error('Lejemålet er ikke ledigt');
                    SVAOccupant.Init();
                    SVAParameters.Reset();
                    IF SVAParameters.FindFirst() then
                        SVAOccupant.Number := NoSeriesManagement.GetNextNo(SVAParameters.Numberserie, WorkDate(), TRUE);
                    IF SVAOccupant.Number = '' then
                        Error('Nummerserie er ikke opsat. Kørslen afbrydes');
                    SVAOccupant.TenancyNo := Rec.Number;
                    SVAOccupant.Validate(Number);
                    SVAOccupant.PropertyNo := Rec.PropertyNo;
                    SVAOccupant.Insert(true);
                    Page.Run(Page::"SVA Contract From Tenancy", SVAOccupant, SVAOccupant.Number);
                end;

            }
        }
    }


    trigger OnOpenPage()
    var
        SVAOccupant: Record "SVA Occupant";
    begin
        SVAOccupant.VacantTenancies();
    end;
}

