tableextension 50041 "SVA Gen. Journal Line" extends "Gen. Journal Line"
{
    fields
    {
        field(50001; "SVA Occupant"; Text[10])
        {
            Caption = 'Occupant';
            TableRelation = "SVA Occupant".Number;
            DataClassification = CustomerContent;
            Editable = true;
            trigger OnValidate()
            var
                SVAOccupant: Record "SVA Occupant";
            begin
                //Set dimensions
                SVAOccupant.Reset();
                SVAOccupant.SetRange(Number, "SVA Occupant");
                if SVAOccupant.FindFirst() then begin
                    "Dimension Set ID" := SVAOccupant."Dimension Set Id";
                    Validate("Dimension Set ID");
                end;
            end;
        }
    }
    trigger OnModify();
    var
        SVAOccupant: Record "SVA Occupant";
        SVAProperty: Record "SVA Property";
    begin
        if (Rec."Account Type" = Rec."Account Type"::Customer) and (Rec."Dimension Set ID" = 0) then
            if Rec."Account No." <> '' then begin
                SVAOccupant.Reset();
                SVAOccupant.SetRange("Customer No", Rec."Account No.");
                if SVAOccupant.FindSet() then
                    repeat
                        if SVAOccupant.EndDate = 0D then begin
                            Rec."Dimension Set ID" := SVAOccupant."Dimension Set Id";
                            Rec.Validate("Dimension Set ID");
                        end;
                        if (SVAOccupant.EndDate <> 0D) and (Rec."Dimension Set ID" = 0) then begin
                            Rec."Dimension Set ID" := SVAOccupant."Dimension Set Id";
                            Rec.Validate("Dimension Set ID");
                        end;
                    until SVAOccupant.Next() = 0;
            end;
        if "Shortcut Dimension 1 Code" <> '' then begin
            SVAProperty.Reset();
            SVAProperty.SetRange(Property, "Shortcut Dimension 1 Code");
            if SVAProperty.FindFirst() then
                if SVAProperty."VAT Prod. Posting Group" <> '' then begin
                    Rec."VAT Prod. Posting Group" := SVAProperty."VAT Prod. Posting Group";
                    Rec.Validate("VAT Prod. Posting Group");

                end;
        end;
    end;
}