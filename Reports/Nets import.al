report 50025 "SVA Import NETS"
{
    WordLayout = './layouts/Nets0602.docx';
    DefaultLayout = Word;
    Caption='Import from NETS';

    dataset
    {
        dataitem("CSV Buffer"; "CSV Buffer")
        {
            column(Account; Account)
            {
            }
            column(Name; Name)
            {

            }
            column(Payment; Payment)
            {
            }
            column(Amount; Amount)
            {

            }
            column(Invoice; Invoice)
            {
            }

            trigger OnAfterGetRecord();

            begin
                if copystr(Value, 1, 5) = 'BS042' then begin
                    Payment := '';
                    Amount := 0;
                    Account := '';
                    Name := '';
                    Invoice := '';
                    if CopyStr(Value, 14, 4) = '0236' then
                        Payment := 'Betaling';
                    if CopyStr(Value, 14, 4) = '0237' then begin
                        Payment := 'Betaling afvist';
                        AmountStr := CopyStr(Value, 57, 13);
                        while CopyStr(AmountStr, 1, 1) = '0' do
                            AmountStr := CopyStr(AmountStr, 2, 15);
                            if StrLen(AmountStr) > 0 then begin
                                AmountStr := CopyStr(Value, 57, 13);
                                Evaluate(Amount, AmountStr);
                                Amount := Amount / 100;
                                AmountOut := AmountOut+Amount;
                            end;
                    end;        
                    if CopyStr(Value, 14, 4) = '0238' then
                        Payment := 'Betaling afvist';
                    if CopyStr(Value, 14, 4) = '0239' then
                        Payment := 'Betaling tilbageført';


                    if CopyStr(Value, 14, 3) = '023' then begin
                        AmountStr := CopyStr(Value, 57, 13);
                        while CopyStr(AmountStr, 1, 1) = '0' do
                            AmountStr := CopyStr(AmountStr, 2, 15);
                        if StrLen(AmountStr) > 0 then begin
                            Evaluate(Amount, AmountStr);
                            Amount := Amount / 100;
                        end;

                        Account := CopyStr(Value, 26, 15);
                        while CopyStr(Account, 1, 1) = '0' do
                            Account := CopyStr(Account, 2, 15);

                        Invoice := CopyStr(Value, 70, 10); //kun til blank
                        Pos := StrPos(Invoice,' ');
                        Invoice := CopyStr(Invoice,1,Pos);

                        Customer.Reset;
                        Customer.SetRange("No.", Account);
                        if Customer.FindFirst then
                            Name := Customer.Name;
                    end;
                    if CopyStr(Value, 14, 3) = '029' then begin
                        Payment := '';
                        Amount := 0;
                        Account := '';
                        Name := '';
                        Invoice := '';
                        if CopyStr(Value, 14, 4) = '0297' then
                            Payment := 'Betaling fra girokort';
                        if CopyStr(Value, 14, 4) = '0299' then
                            Payment := 'Betaling fra girokort tilbageført';
                        
                        AmountStr := CopyStr(Value, 60, 13);
                        while CopyStr(AmountStr, 1, 1) = '0' do
                            AmountStr := CopyStr(AmountStr, 2, 15);

                        Evaluate(Amount, AmountStr);
                        Amount := Amount / 100;

                        Account := CopyStr(Value, 30, 15);
                        while CopyStr(Account, 1, 1) = '0' do
                            Account := CopyStr(Account, 2, 15);

                        Invoice := CopyStr(Value, 73, 9);
                        Pos := StrPos(Invoice,' ');
                        Invoice := CopyStr(Invoice,1,Pos);

                        Customer.Reset;
                        Customer.SetRange("No.", Account);
                        if Customer.FindFirst then
                            Name := Customer.Name;
                    end;
                end;
                if copystr(Value, 1, 5) = 'BS992' then begin
                    Payment := '';
                    Amount := 0;
                    Account := '';
                    Name := '';
                    Invoice := '';
                    Payment := 'Betalinger i filen:';
                    AmountStr := CopyStr(Value, 43, 15);
                    while CopyStr(AmountStr, 1, 1) = '0' do
                        AmountStr := CopyStr(AmountStr, 2, 15);
                    if StrLen(AmountStr) > 0 then begin
                        Evaluate(Amount, AmountStr);
                        Amount := Amount / 100;
                        Amount := Amount-AmountOut;
                    end;    
                end;
                if copystr(Value,1,5) = 'BS002' then
                    CurrReport.Skip;
                if copystr(Value,1,5) = 'BS012' then
                    CurrReport.Skip;
                if copystr(Value,1,5) = 'BS092' then
                    CurrReport.Skip;
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
        Customer: Record Customer;
        Name: Text[50];
        Payment: Text[35];
        AmountStr: Text[15];
        Amount: Decimal;
        AmountOut: Decimal;
        Account: Text[15];
        Invoice: Text[10];
    
        Pos : Integer;

}