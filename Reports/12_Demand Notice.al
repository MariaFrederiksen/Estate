report 50600 "SVA DemandNoticeResidence"
{
    RDLCLayout = './Layouts/DemandNoticeResidence.rdlc';
    WordLayout = './Layouts/DemandNoticeResidence.docx';
    Caption='Demand notice';
    DefaultLayout = Word;

    dataset
    {
        dataitem(Occupant;"SVA Occupant")
        {
            column(Number_Occupant;Number)
            {
            }
            column(PropertyNo_Occupant;PropertyNo)
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
            column(Address_Occupant;Address)
            {
            }
            column(Address2_Occupant;Address2)
            {
            }
            column(PostCode_Occupant;"Post Code")
            {
            }
            column(City_Occupant;City)
            {
            }
            column(CountryRegionCode_Occupant;"Country/Region Code")
            {
            }
            dataitem(Tenancy;"SVA Tenancy")
            {
                DataItemLink = Number=FIELD(TenancyNo);
                column(Address1_Tenancy;Address1)
                {
                }
                column(PostCode_Tenancy;"Post Code")
                {
                }
                column(City_Tenancy;City)
                {
                }
            }
            dataitem("Sales Invoice Header";"Sales Invoice Header")
            {
                DataItemLink = "SVA Occupant"=FIELD(Number);
                column(No_SalesInvoiceHeader;"No.")
                {
                }
                column(PostingDate_SalesInvoiceHeader;FORMAT("Posting Date"))
                {
                }
                column(DueDate_SalesInvoiceHeader;FORMAT("Due Date"))
                {
                }
                column(AmountIncludingVAT_SalesInvoiceHeader;"Amount Including VAT")
                {
                }
                column(RemainingAmount_SalesInvoiceHeader;"Remaining Amount")
                {
                }
                column(PostingDescr;"Posting Description")
                {
                }
                dataitem("Sales Invoice Line";"Sales Invoice Line")
                {
                    DataItemLink = "Document No."=FIELD("No.");
                    column(DocumentNo_SalesInvoiceLine;"Document No.")
                    {
                    }
                    column(Description_SalesInvoiceLine;Description)
                    {
                    }
                    column(AmountIncludingVAT_SalesInvoiceLine;"Amount Including VAT")
                    {
                    }

                    trigger OnAfterGetRecord();
                    begin
                        Costtype.RESET;
                        Costtype.SETRANGE(Costtype,"SVA CostType");
                        IF Costtype.FINDFIRST() THEN BEGIN
                          IF Costtype.Type = 8 THEN BEGIN
                            LiableAmountTotal -= "Amount Including VAT";
                            END;
                          END;
                    end;
                }

                trigger OnAfterGetRecord();
                begin
                    IF "Due Date" > TODAY THEN
                      CurrReport.SKIP;
                    InvoiceAmountTotal += "Amount Including VAT";
                    LiableAmountTotal += "Amount Including VAT";
                end;
            }
            dataitem(Parameters;"SVA Parameters")
            {
                column(ReminderFeeRes;ReminderFeeRes)
                {
                }
                column(ReminderFeeProf;ReminderFeeProf)
                {
                }

                trigger OnAfterGetRecord();
                begin
                    TotalAmount := InvoiceAmountTotal + ReminderFeeRes;
                    LiableAmountTotal := LiableAmountTotal + ReminderFeeRes;
                end;
            }
        }
        dataitem("Company information";"Company Information")
        {
            column(CName;Name)
            {
            }
            column(CAdress;Address)
            {
            }
            column(CPostcode;"Post Code")
            {
            }
            column(CCIty;City)
            {
            }
            column(InvoicesAmount;InvoiceAmountTotal)
            {
            }
            column(TotalAmount;TotalAmount)
            {
            }
            column(LiableAmount;LiableAmountTotal)
            {
            }
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

    trigger OnInitReport();
    begin
        CompanyInfo.GET;
    end;

    var
        CompanyInfo : Record "Company Information";
        InvoiceAmountTotal : Decimal;
        TotalAmount : Decimal;
        Costtype : Record "SVA Cost type";
        LiableAmountTotal : Decimal;
}

