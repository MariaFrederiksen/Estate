report 50042 "SVA Import NETS 0603"
{
    WordLayout = './layouts/Nets0603.docx';
    DefaultLayout = Word;
    Caption = 'Import from NETS';

    dataset
    {
        dataitem("CSV Buffer"; "CSV Buffer")
        {
            column(CompanyName; COMPANYPROPERTY.DISPLAYNAME())
            {
            }
            column(Account; Account)
            {
            }
            column(Name; Name)
            {

            }
            column(TransText; TransText)
            {

            }
            column(EffectiveDate; format(EffectiveDate))
            {
            }
            column(DateOfDeletion; Format(DateOfDeletion))
            {
            }

            trigger OnAfterGetRecord();
            begin
                if copystr(Value, 1, 5) = 'BS042' then begin
                    Account := '';
                    Name := '';
                    DateOfDeletion := 0D;

                    //Descriptions
                    if CopyStr(Value, 14, 4) = '0230' then
                        TransText := 'Aktiv';
                    if CopyStr(Value, 14, 4) = '0231' then
                        TransText := 'Registreret';
                    if CopyStr(Value, 14, 4) = '0232' then
                        TransText := 'Slettet af banken';
                    if CopyStr(Value, 14, 4) = '0233' then
                        TransText := 'Slettet af kunde';
                    if CopyStr(Value, 14, 4) = '0234' then
                        TransText := 'Slettet af betalingsservice';


                    D := 0;
                    M := 0;
                    Y := 0;

                    if CopyStr(Value, 50, 6) <> '000000' then begin
                        Evaluate(D, CopyStr(Value, 50, 2));
                        Evaluate(M, CopyStr(Value, 52, 2));
                        Evaluate(Y, CopyStr(Value, 54, 2));
                        EffectiveDate := DMY2Date(D, M, Y);
                    end;

                    D := 0;
                    M := 0;
                    Y := 0;
                    if CopyStr(Value, 56, 6) = '000000' then
                        DateOfDeletion := 0D;
                    if CopyStr(Value, 56, 6) <> '000000' then begin
                        Evaluate(D, CopyStr(Value, 56, 2));
                        Evaluate(M, CopyStr(Value, 58, 2));
                        Evaluate(Y, CopyStr(Value, 60, 2));
                        DateOfDeletion := DMY2Date(D, M, Y);
                    end;
                    //Customer
                    Account := CopyStr(Value, 26, 15);
                    while CopyStr(Account, 1, 1) = '0' do
                        Account := CopyStr(Account, 2, 15);

                    Customer.Reset();
                    Customer.SetRange("No.", Account);
                    if Customer.FindFirst() then
                        Name := Customer.Name;
                end;

                if copystr(Value, 1, 5) = 'BS002' then
                    CurrReport.Skip();
                if copystr(Value, 1, 5) = 'BS012' then
                    CurrReport.Skip();
                if copystr(Value, 1, 5) = 'BS092' then
                    CurrReport.Skip();
                if copystr(Value, 1, 5) = 'BS992' then
                    CurrReport.Skip();

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
        Account: Text[15];
        TransText: Text[30];
        EffectiveDate: Date;
        DateOfDeletion: Date;
        D: Integer;
        M: Integer;
        Y: Integer;
}
