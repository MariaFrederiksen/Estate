page 50029 "SVA Moveout Invoice Line"
{
    PageType = ListPart;
    SourceTable = "SVA MoveOut Invoice Line";
    AutoSplitKey = true;
    Caption = 'MoveOut Invoice Line';
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = true;
    RefreshOnActivate = true;

    layout
    {
        area(Content)
        {
            repeater(InoviceLine)
            {
                field("SVA Cost Type"; Rec."Cost Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Cost Type';
                }
                field(Account; Rec.Account)
                {
                    ApplicationArea = All;
                    ToolTip = 'G/L Account';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Description';
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    ToolTip = 'Qty';
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = All;
                    ToolTip = 'Unit price';

                }
                field("Line Amount"; Rec."Line Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Line amount';
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Prod. Posting Group';
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'VAT Prod. Posting Group';
                }
            }
            group(Totals)
            {
                Caption = 'Totals';
                field(Amount; Amount)
                {
                    Caption = 'Balance amount';
                    ApplicationArea = all;
                    ToolTip = 'Balance amount for all lines for this invoice';
                    Editable = false;
                }
                field(VATAmount; VATAmount)
                {
                    Caption = 'Balance VAT';
                    ApplicationArea = all;
                    ToolTip = 'Balance VAT amount for all lines for this invoice';
                    Editable = false;
                }
                field(AmountInclVAT; AmountInclVAT)
                {
                    Caption = 'Balance amount incl. VAT';
                    ApplicationArea = all;
                    ToolTip = 'Balance amount incl. VAT for all lines for this invoice';
                    Editable = false;
                }
            }
        }
    }
    var
        LinNo: Integer;
        Amount: Decimal;
        VATAmount: Decimal;
        AmountInclVAT: Decimal;
        VatRate: Decimal;

    trigger OnOpenPage()
    var
        l_SVAMoveOutInvoiceLine: Record "SVA MoveOut Invoice Line";
    begin
        l_SVAMoveOutInvoiceLine.Reset();
        if l_SVAMoveOutInvoiceLine.FindSet() then
            repeat
                if LinNo < l_SVAMoveOutInvoiceLine."Line No." then
                    LinNo := l_SVAMoveOutInvoiceLine."Line No.";
            Until l_SVAMoveOutInvoiceLine.Next() = 0;
    end;

    trigger OnAfterGetCurrRecord()
    var
        l_SVAMoveOutIncoiceHeader: Record "SVA MoveOut Invoice Header";
        l_SVAMoveOutInvoiceLine: Record "SVA MoveOut Invoice Line";
        l_Customer: Record Customer;
        l_VATPostingSetup: Record "VAT Posting Setup";
    begin
        if LinNo < Rec."Line No." then
            LinNo := Rec."Line No.";

        Amount := 0;
        VATAmount := 0;
        AmountInclVAT := 0;
        l_SVAMoveOutInvoiceLine.Reset();
        l_SVAMoveOutInvoiceLine.SetRange("Line Number", Rec."Line Number");
        if l_SVAMoveOutInvoiceLine.FindSet() then
            repeat
                //Find VAT
                VatRate := 0;
                l_SVAMoveOutIncoiceHeader.Get(Rec."Line Number");
                l_Customer.Reset();
                l_Customer.Get(l_SVAMoveOutIncoiceHeader."Customer No");
                l_VATPostingSetup.Reset();
                l_VATPostingSetup.SetRange("VAT Prod. Posting Group", l_SVAMoveOutInvoiceLine."VAT Prod. Posting Group");
                l_VATPostingSetup.SetRange("VAT Bus. Posting Group", l_Customer."VAT Bus. Posting Group");
                if l_VATPostingSetup.FindFirst() then
                    VatRate := l_VATPostingSetup."VAT %" / 100;

                //Calculate balances          
                Amount += l_SVAMoveOutInvoiceLine."Line Amount";
                VATAmount += l_SVAMoveOutInvoiceLine."Line Amount" * VatRate;
            until l_SVAMoveOutInvoiceLine.Next() = 0;
        AmountInclVAT := Amount + VATAmount;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Line No." := LinNo + 10000;
    end;
}



