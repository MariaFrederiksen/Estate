page 50050 "SVA Estate Role Center"
//Tooltips created.
{
    // version NAVW110.00,NAVDK10.00

    Caption = 'Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            group(Activity)
            {
                part("Activities"; "SVA Bookkeeper Activities")
                {
                    ApplicationArea = All;
                }
                part("My Customer"; "My Customers")
                {
                    ApplicationArea = All;
                }
            }
            group(Notes)
            {
                part("My job queue"; "My Job Queue")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                part("My vendors"; "My Vendors")
                {
                    ToolTip = 'Vendors (crafts)';
                    ApplicationArea = All;
                }

                systempart(MyNotes; MyNotes)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(reporting)
        {
            action("Kon&toskema")
            {
                Caption = 'A&ccount Schedule';
                Image = "Report";
                RunObject = Report "Account Schedule";
                ApplicationArea = All;
            }
            group("&Balance")
            {
                Caption = '&Trial Balance';
                Image = Balance;
                action("Bank - &kontokort")
                {
                    Caption = 'Bank &Detail Trial Balance';
                    Image = "Report";
                    RunObject = Report "Bank Acc. - Detail Trial Bal.";
                    ApplicationArea = All;
                }
                action("Råbalance efter &periode")
                {
                    Caption = 'Trial Balance by &Period';
                    Image = "Report";
                    RunObject = Report "Trial Balance by Period";
                    ApplicationArea = All;
                }
                action("Årsr&egnskab")
                {
                    Caption = 'Closing Tria&l Balance';
                    Image = "Report";
                    RunObject = Report "Closing Trial Balance";
                    ApplicationArea = All;
                }
            }
            action("Saldo for regnskabs&år")
            {
                Caption = '&Fiscal Year Balance';
                Image = "Report";
                RunObject = Report "Fiscal Year Balance";
                ApplicationArea = All;
            }
            action("Saldosammenlign. - &Forr. år")
            {
                Caption = 'Balance C&omp. . Prev. Year';
                Image = "Report";
                RunObject = Report "Balance Comp. - Prev. Year";
                ApplicationArea = All;
            }
            separator("Seperator")
            {
            }
            action("&Aldersfordelte tilgodehavender")
            {
                Caption = '&Aged Accounts Receivable';
                Image = "Report";
                RunObject = Report "Aged Accounts Receivable";
                ApplicationArea = All;
            }
            action("Aldersfor&delt gæld")
            {
                Caption = 'Aged Accou&nts Payable';
                Image = "Report";
                RunObject = Report "Aged Accounts Payable";
                ApplicationArea = All;
            }
            action("Afste&m deb.- og kred.konti")
            {
                Caption = 'Reconcile Cust. and &Vend. Accs';
                Image = "Report";
                RunObject = Report "Reconcile Cust. and Vend. Accs";
                ApplicationArea = All;
            }
            separator("Separator 2")
            {
            }
            action("Kontrol af SE/&CVR-nr.")
            {
                Caption = 'VAT Reg&istration No. Check';
                Image = "Report";
                RunObject = Report "VAT Registration No. Check";
                ApplicationArea = All;
            }
            action("Momsu&ndtagelser")
            {
                Caption = 'VAT E&xceptions';
                Image = "Report";
                RunObject = Report "VAT Exceptions";
                ApplicationArea = All;
            }
            action("Momsan&givelse")
            {
                Caption = 'VAT State&ment';
                Image = "Report";
                RunObject = Report "VAT Statement";
                ApplicationArea = All;
            }
            action("Moms - list&eangivelse TS")
            {
                Caption = 'VAT - VI&ES Declaration Tax Auth';
                Image = "Report";
                RunObject = Report "VAT- VIES Declaration Tax Auth";
                ApplicationArea = All;
            }
            action("M&oms - listeangivelse disk")
            {
                Caption = 'VAT - VIES Declaration Dis&k';
                Image = "Report";
                RunObject = Report "VAT- VIES Declaration Disk";
                ApplicationArea = All;
            }
            action("Oversigt over E&U-salg")
            {
                Caption = 'EC &Sales List';
                Image = "Report";
                RunObject = Report "EC Sales List";
                ApplicationArea = All;
            }
        }
        area(embedding)
        {
            action(Kontoplan)
            {
                Caption = 'Chart of Accounts';
                RunObject = Page "Chart of Accounts";
                ApplicationArea = All;
            }
            action(Bankkonti)
            {
                Caption = 'Bank Accounts';
                Image = BankAccount;
                RunObject = Page "Bank Account List";
                ApplicationArea = All;
            }
            action(Customers)
            {
                Caption = 'Customers';
                Image = Customer;
                RunObject = Page "Customer List";
                ApplicationArea = All;
            }
            action(CustomersBalance)
            {
                Caption = 'Balance';
                Image = Balance;
                RunObject = Page "Customer List";
                RunPageView = WHERE("Balance (LCY)" = FILTER(<> 0));
                ApplicationArea = All;
            }
            action(Vendors)
            {
                Caption = 'Vendors';
                Image = Vendor;
                RunObject = Page "Vendor List";
                ApplicationArea = All;
            }
            action(VendorsBalance)
            {
                Caption = 'Balance';
                Image = Balance;
                RunObject = Page "Vendor List";
                RunPageView = WHERE("Balance (LCY)" = FILTER(<> 0));
                ApplicationArea = All;
            }
            action(Momsangivelse)
            {
                Caption = 'VAT Statements';
                RunObject = Page "VAT Statement Names";
                ApplicationArea = All;
            }
            action("Købsfakturaer")
            {
                Caption = 'Purchase Invoices';
                RunObject = Page "Purchase Invoices";
                ApplicationArea = All;
            }
            action(Salgsfakturaer)
            {
                Caption = 'Sales Invoices';
                Image = Invoice;
                RunObject = Page "Sales Invoice List";
                ApplicationArea = All;
            }

            action(Godkendelser)
            {
                Caption = 'Approvals';
                Image = Approvals;
                RunObject = Page "Requests to Approve";
                ApplicationArea = All;
            }
            action(CashReceiptJournals)
            {
                Caption = 'Cash Receipt Journals';
                Image = Journals;
                RunObject = Page "General Journal Batches";
                RunPageView = WHERE("Template Type" = CONST("Cash Receipts"),
                                    Recurring = CONST(false));
                ApplicationArea = All;
            }
            action(PaymentJournals)
            {
                Caption = 'Payment Journals';
                Image = Journals;
                RunObject = Page "General Journal Batches";
                RunPageView = WHERE("Template Type" = CONST(Payments),
                                    Recurring = CONST(False));
                ApplicationArea = All;
            }
            action(GeneralJournals)
            {
                Caption = 'General Journals';
                Image = Journal;
                RunObject = Page "General Journal Batches";
                RunPageView = WHERE("Template Type" = CONST(General),
                                    Recurring = CONST(false));
                ApplicationArea = All;
            }
            action(RecurringGeneralJournals)
            {
                Caption = 'Recurring General Journals';
                RunObject = Page "General Journal Batches";
                RunPageView = WHERE("Template Type" = CONST(General),
                                    Recurring = CONST(TRUE));
                ApplicationArea = All;
            }

        }
        area(sections)
        {
            group("Bogførte dokumenter")
            {
                Caption = 'Posted Documents';
                Image = FiledPosted;
                ToolTip = 'View posted invoices and credit memos, and analyze G/L registers.';
                action("Bogf. salgsfakturaer")
                {
                    Caption = 'Posted Sales Invoices';
                    Image = PostedOrder;
                    RunObject = Page "Posted Sales Invoices";
                    ApplicationArea = All;
                }
                action("Bogf. købsfakturaer")
                {
                    Caption = 'Posted Purchase Invoices';
                    RunObject = Page "Posted Purchase Invoices";
                    ApplicationArea = All;
                }
                action("Bogførte købskreditnotaer")
                {
                    Caption = 'Posted Purchase Credit Memos';
                    RunObject = Page "Posted Purchase Credit Memos";
                    ApplicationArea = All;
                }
                action(Finansjournaler)
                {
                    Caption = 'G/L Registers';
                    Image = GLRegisters;
                    RunObject = Page "G/L Registers";
                    ApplicationArea = All;
                }

            }
            Group("Approvals")
            {
                Caption = 'Approvals';
                action("Anmodninger sendt til godkendelse")
                {
                    Caption = 'Requests Sent for Approval';
                    Image = Approvals;
                    RunObject = Page "Approval Entries";
                    RunPageView = SORTING("Record ID to Approve", "Workflow Step Instance ID", "Sequence No.")
                                  ORDER(Ascending)
                                  WHERE(Status = FILTER(Open));
                    ApplicationArea = All;
                }
                action(RequestsToApprove)
                {
                    Caption = 'Requests to Approve';
                    Image = Approvals;
                    RunObject = Page "Requests to Approve";
                    ApplicationArea = All;
                }
            }
            group("Administration")
            {
                Caption = 'Administration';
                Image = Administration;
                action(Valutaer)
                {
                    Caption = 'Currencies';
                    Image = Currency;
                    RunObject = Page Currencies;
                    ApplicationArea = All;
                }
                action(Regnskabsperioder)
                {
                    Caption = 'Accounting Periods';
                    Image = AccountingPeriods;
                    RunObject = Page "Accounting Periods";
                    ApplicationArea = All;
                }
                action(Nummerserie)
                {
                    Caption = 'Number Series';
                    RunObject = Page "No. Series";
                    ApplicationArea = All;
                }
                action(Konteringsarter)
                {
                    Caption = 'CosttypeEstate';
                    ToolTip = 'Setup costtype for Estate';
                    RunObject = page "SVA Cost Type Estate List";
                    ApplicationArea = All;
                }
            }
        }
        area(creation)
        {
            action("D&ebitor")
            {
                Caption = 'C&ustomer';
                Image = Customer;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Customer Card";
                RunPageMode = Create;
                ApplicationArea = All;
            }
            action("Salgs&faktura")
            {
                Caption = 'Sales &Invoice';
                Image = NewSalesInvoice;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Sales Invoice";
                RunPageMode = Create;
                ApplicationArea = All;
            }
            action("&Salgskreditnota")
            {
                Caption = 'Sales Credit &Memo';
                Image = CreditMemo;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Sales Credit Memo";
                RunPageMode = Create;
                ApplicationArea = All;
            }
            separator("Seperator 4")
            {
            }
            action("&Kreditor")
            {
                Caption = '&Vendor';
                Image = Vendor;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Vendor Card";
                RunPageMode = Create;
                ApplicationArea = All;
            }
            action("&Købsfaktura")
            {
                Caption = '&Purchase Invoice';
                Image = NewPurchaseInvoice;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Purchase Invoice";
                RunPageMode = Create;
                ApplicationArea = All;
            }
        }
        area(processing)
        {
            separator(Opgaver)
            {
                Caption = 'Tasks';
                IsHeader = true;
            }
            action("Ind&betalingskladde")
            {
                Caption = 'Cash Re&ceipt Journal';
                Image = CashReceiptJournal;
                RunObject = Page "Cash Receipt Journal";
                ApplicationArea = All;
            }
            action("&Udbetalingskladde")
            {
                Caption = 'Payment &Journal';
                Image = PaymentJournal;
                RunObject = Page "Payment Journal";
                ApplicationArea = All;
            }
            action(Betalingsregistrering)
            {
                Caption = 'Payment Registration';
                Image = Payment;
                RunObject = Page "Payment Registration";
                ApplicationArea = All;
            }
            separator("Seperator 3")
            {
            }
            action(Betalingsudligningskladder)
            {
                Caption = 'Payment Reconciliation Journals';
                Image = ApplyEntries;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page "Pmt. Reconciliation Journals";
                RunPageMode = View;
                ApplicationArea = All;
            }
            action("Bankkontoafs&temning")
            {
                Caption = 'B&ank Account Reconciliations';
                Image = BankAccountRec;
                RunObject = Page "Bank Acc. Reconciliation";
                ApplicationArea = All;
            }
            action("Afregn &moms")
            {
                Caption = 'Calc. and Pos&t VAT Settlement';
                Ellipsis = true;
                Image = SettleOpenTransactions;
                RunObject = Report "Calc. and Post VAT Settlement";
                ApplicationArea = All;
            }
            separator("Opsætning")
            {
                Caption = 'Administration';
                IsHeader = true;
            }
            action("Sa&lgsopsætning")
            {
                Caption = 'Sa&les && Receivables Setup';
                Image = Setup;
                RunObject = Page "Sales & Receivables Setup";
                ApplicationArea = All;
            }
            separator(Oversigt)
            {
                Caption = 'History';
                IsHeader = true;
            }
        }
    }
}

