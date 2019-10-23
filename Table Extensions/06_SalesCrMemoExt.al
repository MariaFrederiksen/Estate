tableextension 50006 "SVA Sales Cr.memo Ext" extends "Sales Cr.Memo Header"
// SVA 1.00 - 17/9-2018 - Maria Frederiksen
{
    fields
    {
        field(50001; "SVA Included"; Boolean)
        {
            Caption = 'Included';
            DataClassification = CustomerContent;
            AccessByPermission = TableData 50006 = rimd;
        }
        field(50002; "SVA Send"; Boolean)
        {
            Caption = 'Send';
            DataClassification = CustomerContent;
            AccessByPermission = TableData 50006 = rimd;
        }
        field(50003; "SVA Send Date"; Date)
        {
            Caption = 'Send date';
            DataClassification = CustomerContent;
            AccessByPermission = TableData 50006 = rimd;
        }
        field(50004; "SVA Occupant"; Code[10])
        {
            Caption = 'Occupant';
            TableRelation = "SVA Occupant".Number;
            DataClassification = CustomerContent;
            AccessByPermission = TableData 50006 = rimd;
        }
    }
    trigger OnBeforeInsert();
    var
        OccupantRec: Record "SVA Occupant";
    begin
        if "SVA Occupant" = '' then begin
            OccupantRec.Reset;
            OccupantRec.SetRange("Customer No", "Sell-to Customer No.");
            if OccupantRec.FindSet then
                repeat
                    "SVA Occupant" := OccupantRec.Number;
                until OccupantRec.Next = 0;
        end;
    end;

}