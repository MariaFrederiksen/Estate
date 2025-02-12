reportextension 50001 "SVA Customer Balance to Date" extends "Customer - Balance to Date"
{
    dataset
    {
        add(Customer)
        {
            column(TenancyAdress; TenancyAdress)
            {
            }

        }
    }



    requestpage
    {
        // Add changes to the requestpage here
    }
    var
        TenancyAdress: Text[100];


}