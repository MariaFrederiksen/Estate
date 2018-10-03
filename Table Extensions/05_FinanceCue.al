tableextension 50005 "SVA Finance Cue" extends "Finance Cue"
// SVA 1.00 - 17/9-2018 - Maria Frederiksen
{
    fields
    {
        
        field(50001;"SVA Empty Tenancy";Integer)
        {
            Caption = 'Empty Tenancies';
            FieldClass = FlowField;
            CalcFormula = count("SVA Tenancy" where (Vacant=const(true)));
        }
        field(50002;"SVA Property";Integer)
        {
            Caption = 'Properties';
            FieldClass = FlowField;
            CalcFormula = count("SVA Property");
        }
        field(50003;"SVA Tenancy";Integer)
        {
            Caption = 'Tenancy';
            FieldClass = FlowField;
            CalcFormula = count("SVA Tenancy");
            
        }
        field(50004;"SVA Occupant";Integer)
        {
            Caption = 'Occupants';
            FieldClass = FlowField;
            CalcFormula  = count("SVA Occupant" where (EndDate=field("SVA Date Filter")));
            
            
        }
        field(50005;"SVA Date Filter";Date)
        {
            Caption = 'Date filter';
        }
    }
   
}