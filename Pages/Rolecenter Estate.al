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
                }
                part("My Customer"; "My Customers")
                {
                }
            }
            group(Notes)
            {
                part("My job queue"; "My Job Queue")
                {
                    Visible = false;
                }
                part("My vendors"; "My Vendors")
                {
                    ToolTip = 'Vendors (crafts)';
                }
                
                systempart(MyNotes; MyNotes)
                {
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
                }
                action("Råbalance efter &periode")
                {
                    Caption = 'Trial Balance by &Period';
                    Image = "Report";
                    RunObject = Report "Trial Balance by Period";
                }
                action("Årsr&egnskab")
                {
                    Caption = 'Closing Tria&l Balance';
                    Image = "Report";
                    RunObject = Report "Closing Trial Balance";
                }
            }
            action("Saldo for regnskabs&år")
            {
                Caption = '&Fiscal Year Balance';
                Image = "Report";
                RunObject = Report "Fiscal Year Balance";
            }
            action("Saldosammenlign. - &Forr. år")
            {
                Caption = 'Balance C&omp. . Prev. Year';
                Image = "Report";
                RunObject = Report "Balance Comp. - Prev. Year";
            }
            separator("Seperator")
            {
            }
            action("&Aldersfordelte tilgodehavender")
            {
                Caption = '&Aged Accounts Receivable';
                Image = "Report";
                RunObject = Report "Aged Accounts Receivable";
            }
            action("Aldersfor&delt gæld")
            {
                Caption = 'Aged Accou&nts Payable';
                Image = "Report";
                RunObject = Report "Aged Accounts Payable";
            }
            action("Afste&m deb.- og kred.konti")
            {
                Caption = 'Reconcile Cust. and &Vend. Accs';
                Image = "Report";
                RunObject = Report "Reconcile Cust. and Vend. Accs";
            }
            separator("Separator 2")
            {
            }
            action("Kontrol af SE/&CVR-nr.")
            {
                Caption = 'VAT Reg&istration No. Check';
                Image = "Report";
                RunObject = Report "VAT Registration No. Check";
            }
            action("Momsu&ndtagelser")
            {
                Caption = 'VAT E&xceptions';
                Image = "Report";
                RunObject = Report "VAT Exceptions";
            }
            action("Momsan&givelse")
            {
                Caption = 'VAT State&ment';
                Image = "Report";
                RunObject = Report "VAT Statement";
            }
            action("Moms - list&eangivelse TS")
            {
                Caption = 'VAT - VI&ES Declaration Tax Auth';
                Image = "Report";
                RunObject = Report "VAT- VIES Declaration Tax Auth";
            }
            action("M&oms - listeangivelse disk")
            {
                Caption = 'VAT - VIES Declaration Dis&k';
                Image = "Report";
                RunObject = Report "VAT- VIES Declaration Disk";
            }
            action("Oversigt over E&U-salg")
            {
                Caption = 'EC &Sales List';
                Image = "Report";
                RunObject = Report "EC Sales List";
            }
        }
        area(embedding)
        {
            action(Kontoplan)
            {
                Caption = 'Chart of Accounts';
                RunObject = Page "Chart of Accounts";
            }
            action(Bankkonti)
            {
                Caption = 'Bank Accounts';
                Image = BankAccount;
                RunObject = Page "Bank Account List";
            }
            action(Customers)
            {
                Caption = 'Customers';
                Image = Customer;
                RunObject = Page "Customer List";
            }
            action(CustomersBalance)
            {
                Caption = 'Balance';
                Image = Balance;
                RunObject = Page "Customer List";
                RunPageView = WHERE ("Balance (LCY)" = FILTER (<> 0));
            }
            action(Vendors)
            {
                Caption = 'Vendors';
                Image = Vendor;
                RunObject = Page "Vendor List";
            }
            action(VendorsBalance)
            {
                Caption = 'Balance';
                Image = Balance;
                RunObject = Page "Vendor List";
                RunPageView = WHERE ("Balance (LCY)" = FILTER (<> 0));
            }
            action(Momsangivelse)
            {
                Caption = 'VAT Statements';
                RunObject = Page "VAT Statement Names";
            }
            action("Købsfakturaer")
            {
                Caption = 'Purchase Invoices';
                RunObject = Page "Purchase Invoices";
            }
            action(Salgsfakturaer)
            {
                Caption = 'Sales Invoices';
                Image = Invoice;
                RunObject = Page "Sales Invoice List";
            }

            action(Godkendelser)
            {
                Caption = 'Approvals';
                Image = Approvals;
                RunObject = Page "Requests to Approve";
            }
            action(CashReceiptJournals)
            {
                Caption = 'Cash Receipt Journals';
                Image = Journals;
                RunObject = Page "General Journal Batches";
                RunPageView = WHERE ("Template Type" = CONST ("Cash Receipts"),
                                    Recurring = CONST (false));
            }
            action(PaymentJournals)
            {
                Caption = 'Payment Journals';
                Image = Journals;
                RunObject = Page "General Journal Batches";
                RunPageView = WHERE ("Template Type" = CONST (Payments),
                                    Recurring = CONST (False));
            }
            action(GeneralJournals)
            {
                Caption = 'General Journals';
                Image = Journal;
                RunObject = Page "General Journal Batches";
                RunPageView = WHERE ("Template Type" = CONST (General),
                                    Recurring = CONST (false));
            }
            action(RecurringGeneralJournals)
            {
                Caption = 'Recurring General Journals';
                RunObject = Page "General Journal Batches";
                RunPageView = WHERE ("Template Type" = CONST (General),
                                    Recurring = CONST (TRUE));
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
                }
                action("Bogf. salgskr.notaer")
                {
                    Caption = 'Posted Sales Credit Memos';
                    Image = PostedOrder;
                    RunObject = Page "Posted Sales Credit Memo";
                }
                action("Bogf. købsfakturaer")
                {
                    Caption = 'Posted Purchase Invoices';
                    RunObject = Page "Posted Purchase Invoices";
                }
                action("Bogførte købskreditnotaer")
                {
                    Caption = 'Posted Purchase Credit Memos';
                    RunObject = Page "Posted Purchase Credit Memos";
                }
                action(Finansjournaler)
                {
                    Caption = 'G/L Registers';
                    Image = GLRegisters;
                    RunObject = Page "G/L Registers";
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
                    RunPageView = SORTING ("Record ID to Approve", "Workflow Step Instance ID", "Sequence No.")
                                  ORDER(Ascending)
                                  WHERE (Status = FILTER (Open));
                }
                action(RequestsToApprove)
                {
                    Caption = 'Requests to Approve';
                    Image = Approvals;
                    RunObject = Page "Requests to Approve";
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
                }
                action(Regnskabsperioder)
                {
                    Caption = 'Accounting Periods';
                    Image = AccountingPeriods;
                    RunObject = Page "Accounting Periods";
                }
                action(Nummerserie)
                {
                    Caption = 'Number Series';
                    RunObject = Page "No. Series";
                }
                action(Konteringsarter)
                {
                    Caption = 'CosttypeEstate';
                    ToolTip='Setup costtype for Estate';
                    RunObject = page "SVA Cost Type Estate List";
                }
                action(Estate)
                {
                    Caption = 'Estate';
                    ToolTip='Setup for NETS etc.';
                    RunObject = page "SVA Setup Estate List";
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
            }
            action("&Udbetalingskladde")
            {
                Caption = 'Payment &Journal';
                Image = PaymentJournal;
                RunObject = Page "Payment Journal";
            }
            action(Betalingsregistrering)
            {
                Caption = 'Payment Registration';
                Image = Payment;
                RunObject = Page "Payment Registration";
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
            }
            action("Bankkontoafs&temning")
            {
                Caption = 'B&ank Account Reconciliations';
                Image = BankAccountRec;
                RunObject = Page "Bank Acc. Reconciliation";
            }
            action("Afregn &moms")
            {
                Caption = 'Calc. and Pos&t VAT Settlement';
                Ellipsis = true;
                Image = SettleOpenTransactions;
                RunObject = Report "Calc. and Post VAT Settlement";
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
            }
            separator(Oversigt)
            {
                Caption = 'History';
                IsHeader = true;
            }
        }
    }
}

