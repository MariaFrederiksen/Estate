report 50220 "SVA Moving out Journal"
{
    DefaultLayout = RDLC;
    RDLCLayout = './layouts/Moving out collections.rdlc';
    Caption='Collection Journal';

    dataset
    {
        dataitem(Occupant;"SVA Occupant")
        {
            column(Number_Occupant;Number)
            {
            }
            column(TenancyNo_Occupant;TenancyNo)
            {
            }
            column(CustomerNo_Occupant;"Customer No")
            {
            }
            column(Name1_Occupant;Name1)
            {
            }
            column(Name2_Occupant;Name2)
            {
            }
            column(EndDate_Occupant;EndDate)
            {
            }
            column(CAddress;CAddress)
            {
            }
            column(CPostcode;CPostCode)
            {
            }
            column(CCIty;CCity)
            {
            }
            column(TAddress;TAddress)
            {
            }
            column(TPostCode;TPostCode)
            {
            }
            column(TCity;TCity)
            {
            }
            dataitem("Occupant Trans";"SVA Occupant Trans")
            {
                DataItemLink = Occupant=FIELD(Number);
                DataItemTableView = WHERE(Type=FILTER(>OccGroup));
                column(Date;Date)
                {
                }
                column(CostType;"Cost type Estate")
                {
                }
                column(Description;Description)
                {
                }
                column(Qty;Qty)
                {
                }
                column(Price;Price)
                {
                }
                column(Amount;Amount)
                {
                }
                column(Type;Type)
                {
                }

                trigger OnAfterGetRecord();
                begin
                    IF Type = 11 THEN //Afregning
                        CurrReport.SKIP;
                    IF Type = 9 THEN //Depositum
                        Qty := Qty*-1;
                    IF Type = 10 THEN //Forudbetalt leje
                        Qty := Qty*-1;
                    Amount := Qty*Price;
                end;
            }
            dataitem(DataItem1000000014;"SVA Subscription Lines")
            {
                DataItemLink = Tenancies=FIELD(TenancyNo);
                DataItemTableView = WHERE(Type=FILTER(MoveOut));
                column(CostTypes_SubscriptionLines;"Cost Types")
                {
                }
                column(Description_SubscriptionLines;Description)
                {
                }
                column(AmountPeriod_SubscriptionLines;"Amount Period")
                {
                }
            }

            trigger OnAfterGetRecord();
            begin
                Customer.RESET;
                Customer.SETRANGE("No.","Customer No");
                IF Customer.FINDFIRST() THEN  BEGIN
                  CAddress := Customer.Address;
                  CPostCode := Customer."Post Code";
                  CCity := Customer.City
                  END;

                Tenancy.RESET;
                Tenancy.SETRANGE(Number,TenancyNo);
                IF Tenancy.FINDFIRST() THEN BEGIN
                  TAddress := Tenancy.Address1;
                  TPostCode := Tenancy."Post Code";
                  TCity := Tenancy.City;
                  END;
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
        CostTypeType : Record "SVA Cost type";
        Customer : Record "Customer";
        Tenancy : Record "SVA Tenancy";
        CAddress : Text[30];
        CPostCode : Text[10];
        CCity : Text[30];
        TAddress : Text[30];
        TPostCode : Text[10];
        TCity : Text[30];
}

