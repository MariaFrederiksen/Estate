pageextension 50002 "SVA Sales Invoice Line Ext." extends "Sales Invoice Subform"
{
    layout
    {
        addfirst(Control1)

        {
            field(CosttypeLine; Rec."SVA CostType")
            {
                Caption = 'Costtype';
                ApplicationArea = all;
                ToolTip = 'Costtype on this line.';
                trigger OnValidate()
                var
                    SVACosttype: Record "SVA Cost type";
                begin
                    SVACosttype.Init();
                    SVACosttype.SetRange(Costtype, Rec."SVA CostType");
                    if SVACosttype.FindFirst() then begin
                        Rec.Type := Rec.Type::"G/L Account";
                        Rec.Validate(Type);
                        Rec."No." := SVACosttype.Account;
                        Rec.Validate("No.");
                        Rec.Description := SVACosttype.Description;
                        Rec.Quantity := 1;
                        Rec.Validate(Quantity);

                        Rec."SVA CostType" := SVACosttype.Costtype;
                    end;
                end;
            }
        }
    }
}
