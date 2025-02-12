report 50012 "SVA DemandNoticeResidence"
{
    WordLayout = './Layouts/DemandNoticeResidence.docx';
    Caption = 'Demand notice residence';
    DefaultLayout = Word;
    //UseRequestPage = false;

    dataset
    {
        dataitem(Occupant; "SVA Occupant")
        {
            column(Number_Occupant; Number)
            {
            }
            column(PropertyNo_Occupant; PropertyNo)
            {
            }
            column(TenancyNo_Occupant; TenancyNo)
            {
            }
            column(CustomerNo_Occupant; "Customer No")
            {
            }
            column(Name1_Occupant; Name1)
            {
            }
            column(Name2_Occupant; Name2)
            {
            }
            column(Address_Occupant; Address)
            {
            }
            column(Address2_Occupant; Address2)
            {
            }
            column(PostCode_Occupant; "Post Code")
            {
            }
            column(City_Occupant; City)
            {
            }
            column(CountryRegionCode_Occupant; "Country/Region Code")
            {
            }
            dataitem(Tenancy; "SVA Tenancy")
            {
                DataItemLink = Number = FIELD(TenancyNo);
                column(Address1_Tenancy; Tenancy.Address1)
                {
                }
                column(PostCode_Tenancy; Tenancy."Post Code")
                {
                }
                column(City_Tenancy; Tenancy.City)
                {
                }
            }
            dataitem("Sales Invoice Header"; "Sales Invoice Header")
            {
                DataItemLink = "SVA Occupant" = FIELD(Number);
                DataItemTableView = sorting("Posting Date", "No.") where(Closed = Const(False));

                column(No_SalesInvoiceHeader; "No.")
                {
                }
                column(PostingDate_SalesInvoiceHeader; FORMAT("Posting Date"))
                {
                }
                column(DueDate_SalesInvoiceHeader; FORMAT("Due Date"))
                {
                }
                column(AmountIncludingVAT_SalesInvoiceHeader; "Amount Including VAT")
                {
                }
                column(RemainingAmount_SalesInvoiceHeader; "Remaining Amount")
                {
                }
                column(PostingDescr; "Posting Description")
                {
                }
                dataitem("Sales Invoice Line"; "Sales Invoice Line")
                {
                    DataItemLink = "Document No." = FIELD("No.");
                    column(DocumentNo_SalesInvoiceLine; "Document No.")
                    {
                    }
                    column(Description_SalesInvoiceLine; Description)
                    {
                    }
                    column(AmountIncludingVAT_SalesInvoiceLine; "Amount Including VAT")
                    {
                    }

                    trigger OnAfterGetRecord();
                    begin

                        i += 1;
                        SVACosttype.Reset();
                        SVACosttype.SETRANGE(Costtype, "SVA Costtype");
                        IF SVACosttype.FINDFIRST() THEN
                            IF SVACosttype.Type = 8 THEN
                                LiableAmountTotal -= "Amount Including VAT";

                        SVADemandSpecification.Init();
                        SVADemandSpecification.Rownumber := i;
                        i += 1;
                        SVADemandSpecification.DocNo := "Sales Invoice Line"."Document No.";
                        SVADemandSpecification.Description := "Sales Invoice Line".Description;
                        SVADemandSpecification.Amount := "Sales Invoice Line"."Amount Including VAT";
                        SVADemandSpecification.Insert();
                    end;
                }

                trigger OnAfterGetRecord();
                begin
                    if "Due Date" > WorkDate() THEN
                        CurrReport.Skip();
                    //InvoiceAmountTotal += "Amount Including VAT";
                    InvoiceAmountTotal += "Remaining Amount";
                    LiableAmountTotal += "Remaining Amount";
                end;
            }
            dataitem(Parameters; "SVA Parameters")
            {
                column(ReminderFeeRes; ReminderFeeRes)
                {
                }
                column(ReminderFeeProf; ReminderFeeProf)
                {
                }

                trigger OnAfterGetRecord();
                begin
                    TotalAmount := InvoiceAmountTotal + ReminderFeeRes;
                    LiableAmountTotal := LiableAmountTotal + ReminderFeeRes;
                end;
            }
        }
        dataitem("SVA Demand Specification"; "SVA Demand Specification")
        {
            column(DocNo; DocNo)
            {

            }
            column(Description; Description)
            {

            }
            column(Amount; Amount)
            {

            }
        }

        dataitem("Company Information"; "Company Information")
        {
            column(CName; Name)
            {
            }
            column(CAdress; Address)
            {
            }
            column(CPostcode; "Post Code")
            {
            }
            column(CCity; City)
            {
            }
            column(CompanyVAT_Registration_No_; "VAT Registration No.")
            {
            }
            column(CompanyGetVATRegistrationNumberLbl; GetVATRegistrationNumberLbl())
            {
            }
            column(CompanyPhone_No_; "Phone No.")
            {
            }
            column(COmpanyPicture; Picture)
            {
            }
            column(CompanyBankBranchNo; CompanyInformation."Bank Branch No.")
            {
            }
            column(CompanyBanAccountNo; CompanyInformation."Bank Account No.")
            {
            }
            column(CompanyBankName; CompanyInformation."Bank Name")
            {
            }
            column(InvoicesAmount; InvoiceAmountTotal)
            {
            }
            column(TotalAmount; TotalAmount)
            {
            }
            column(LiableAmount; LiableAmountTotal)
            {
            }
            column(E_Mail; "E-Mail")
            {

            }
            column(Home_Page; "Home Page")
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

    trigger OnPreReport();
    begin
        CompanyInformation.GET();
        "SVA Demand Specification".DeleteAll();
    end;



    var
        CompanyInformation: Record "Company Information";
        SVACosttype: Record "SVA Cost type";
        SVADemandSpecification: Record "SVA Demand Specification";
        InvoiceAmountTotal: Decimal;
        TotalAmount: Decimal;
        LiableAmountTotal: Decimal;
        i: Integer;
}

