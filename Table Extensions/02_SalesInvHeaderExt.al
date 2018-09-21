tableextension 50003 "SVA SalesInvHeaderExt" extends "Sales Invoice Header"
// SVA 1.00 - 17/9-2018 - Maria Frederiksen
{
    fields
    {
        field(50001;"SVA Included";Boolean)
        {
            Caption = 'Included';
        }
        field(50002;"SVA Send";Boolean)
        {
            Caption = 'Send';
        }
        field(50003;"SVA Send Date";Date)
        {
            Caption = 'Send date';
        }
         field(50004;"SVA Occupant";Code[10])
        {
            Caption = 'Occupant';
        }       
    }
}