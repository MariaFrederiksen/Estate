page 61000 "SVA Estate Role Center"
{
    // version NAVW110.00,NAVDK10.00

    Caption='Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            group(Activity)
            {
                part("Activities";61100)
                {
                }
                part("My Customer";9150)
                {
                }
            }
            group(Notes)
            {
                part("My job queue";675)
                {
                    Visible = false;
                }
                part("My vendors";9151)
                {
                }
                part("Report inbox";681)
                {
                }
                part("Connect online";9175)
                {
                    Visible = false;
                }
                systempart(MyNotes;MyNotes)
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
                Caption='A&ccount Schedule';
                Image = "Report";
                RunObject = Report 25;
            }
            group("&Balance")
            {
                Caption='&Trial Balance';
                Image = Balance;
                action("&Finans - balance")
                {
                    Caption='&G/L Trial Balance';
                    Image = "Report";
                    RunObject = Report 6;
                }
                action("Bank - &kontokort")
                {
                    Caption='Bank &Detail Trial Balance';
                    Image = "Report";
                    RunObject = Report 1404;
                }
                action("B&alance/budget")
                {
                    Caption='T&rial Balance/Budget';
                    Image = "Report";
                    RunObject = Report 9;
                }
                action("Råbalance efter &periode")
                {
                    Caption='Trial Balance by &Period';
                    Image = "Report";
                    RunObject = Report 38;
                }
                action("Årsr&egnskab")
                {
                    Caption='Closing Tria&l Balance';
                    Image = "Report";
                    RunObject = Report 10;
                }
            }
            action("Saldo for regnskabs&år")
            {
                Caption='&Fiscal Year Balance';
                Image = "Report";
                RunObject = Report 36;
            }
            action("Saldosammenlign. - &Forr. år")
            {
                Caption='Balance C&omp. . Prev. Year';
                Image = "Report";
                RunObject = Report 37;
            }
            separator("Seperator")
            {
            }
            action("&Aldersfordelte tilgodehavender")
            {
                Caption='&Aged Accounts Receivable';
                Image = "Report";
                RunObject = Report 120;
            }
            action("Aldersfor&delt gæld")
            {
                Caption='Aged Accou&nts Payable';
                Image = "Report";
                RunObject = Report 322;
            }
            action("Afste&m deb.- og kred.konti")
            {
                Caption='Reconcile Cust. and &Vend. Accs';
                Image = "Report";
                RunObject = Report 33;
            }
            separator("Separator 2")
            {
            }
            action("Kontrol af SE/&CVR-nr.")
            {
                Caption='VAT Reg&istration No. Check';
                Image = "Report";
                RunObject = Report 32;
            }
            action("Momsu&ndtagelser")
            {
                Caption='VAT E&xceptions';
                Image = "Report";
                RunObject = Report 31;
            }
            action("Momsan&givelse")
            {
                Caption='VAT State&ment';
                Image = "Report";
                RunObject = Report 12;
            }
            action("Moms - list&eangivelse TS")
            {
                Caption='VAT - VI&ES Declaration Tax Auth';
                Image = "Report";
                RunObject = Report 19;
            }
            action("M&oms - listeangivelse disk")
            {
                Caption='VAT - VIES Declaration Dis&k';
                Image = "Report";
                RunObject = Report 88;
            }
            action("Oversigt over E&U-salg")
            {
                Caption='EC &Sales List';
                Image = "Report";
                RunObject = Report 130;
            }
        }
        area(embedding)
        {
            action(Kontoplan)
            {
                Caption='Chart of Accounts';
                RunObject = Page 16;
            }
            action(Bankkonti)
            {
                Caption='Bank Accounts';
                Image = BankAccount;
                RunObject = Page 371;
            }
            action(Customers)
            {
                Caption='Customers';
                Image = Customer;
                RunObject = Page 22;
            }
            action(CustomersBalance)
            {
                Caption='Balance';
                Image = Balance;
                RunObject = Page 22;
                RunPageView = WHERE("Balance (LCY)"=FILTER(<>0));
            }
            action(Vendors)
            {
                Caption='Vendors';
                Image = Vendor;
                RunObject = Page 27;
            }
            action(VendorsBalance)
            {
                Caption='Balance';
                Image = Balance;
                RunObject = Page 27;
                RunPageView = WHERE("Balance (LCY)"=FILTER(<>0));
            }
            action(VendorsPaymentonHold)
            {
                Caption='Payment on Hold';
                RunObject = Page 27;
                RunPageView = WHERE(Blocked=FILTER(Payment));
            }
            action(Momsangivelse)
            {
                Caption='VAT Statements';
                RunObject = Page 320;
            }
            action("Købsfakturaer")
            {
                Caption='Purchase Invoices';
                RunObject = Page 9308;
            }
            action("Købsordrer")
            {
                Caption='Purchase Orders';
                RunObject = Page 9307;
            }
            action(Salgsfakturaer)
            {
                Caption='Sales Invoices';
                Image = Invoice;
                RunObject = Page 9301;
            }
            action(Salgsordrer)
            {
                Caption='Sales Orders';
                Image = "Order";
                RunObject = Page 9305;
            }
            action(Godkendelser)
            {
                Caption='Approvals';
                Image = Approvals;
                RunObject = Page 654;
                        }
            action(CashReceiptJournals)
            {
                Caption='Cash Receipt Journals';
                Image = Journals;
                RunObject = Page 251;
                RunPageView = WHERE("Template Type"=CONST("Cash Receipts"),
                                    Recurring=CONST(false));
            }
            action(PaymentJournals)
            {
                Caption='Payment Journals';
                Image = Journals;
                RunObject = Page 251;
                RunPageView = WHERE("Template Type"=CONST(Payments),
                                    Recurring=CONST(False));
            }
            action(GeneralJournals)
            {
                Caption='General Journals';
                Image = Journal;
                RunObject = Page 251;
                RunPageView = WHERE("Template Type"=CONST(General),
                                    Recurring=CONST(false));
            }
            action(RecurringGeneralJournals)
            {
                Caption='Recurring General Journals';
                RunObject = Page 251;
                RunPageView = WHERE("Template Type"=CONST(General),
                                    Recurring=CONST(TRUE));
            }
            action(Intrastatkladder)
            {
                Caption='Intrastat Journals';
                RunObject = Page 327;
            }
        }
        area(sections)
        {
            group("Bogførte dokumenter")
            {
                Caption='Posted Documents';
                Image = FiledPosted;
                ToolTip='View posted invoices and credit memos, and analyze G/L registers.';
                action("Bogf. salgsleverancer")
                {
                    Caption='Posted Sales Shipments';
                    Image = PostedShipment;
                    RunObject = Page 142;
                }
                action("Bogf. salgsfakturaer")
                {
                    Caption='Posted Sales Invoices';
                    Image = PostedOrder;
                    RunObject = Page 143;
                }
                action("Bogførte returvaremodt.")
                {
                    Caption='Posted Return Receipts';
                    Image = PostedReturnReceipt;
                    RunObject = Page 6662;
                }
                action("Bogf. salgskr.notaer")
                {
                    Caption='Posted Sales Credit Memos';
                    Image = PostedOrder;
                    RunObject = Page 144;
                }
                action("Bogf. købsmodtagelser")
                {
                    Caption='Posted Purchase Receipts';
                    RunObject = Page 145;
                }
                action("Bogf. købsfakturaer")
                {
                    Caption='Posted Purchase Invoices';
                    RunObject = Page 146;
                }
                action("Bogførte returvareleverancer")
                {
                    Caption='Posted Return Shipments';
                    RunObject = Page 6652;
                }
                action("Bogførte købskreditnotaer")
                {
                    Caption='Posted Purchase Credit Memos';
                    RunObject = Page 147;
                }
                action("Udstedte rykkere")
                {
                    Caption='Issued Reminders';
                    Image = OrderReminder;
                    RunObject = Page 440;
                }
                action("Udstedte rentenotaer")
                {
                    Caption='Issued Fi. Charge Memos';
                    RunObject = Page 452;
                }
                action(Finansjournaler)
                {
                    Caption='G/L Registers';
                    Image = GLRegisters;
                    RunObject = Page 116;
                }
                action(Ejendomme)
                {
                    Caption='Estate';
                    RunObject = Page 60510;
                }
            }
            Group("Approvals")
            {
                Caption='Approvals';
                                action("Anmodninger sendt til godkendelse")
                {
                    Caption='Requests Sent for Approval';
                    Image = Approvals;
                    RunObject = Page 658;
                    RunPageView = SORTING("Record ID to Approve","Workflow Step Instance ID","Sequence No.")
                                  ORDER(Ascending)
                                  WHERE(Status=FILTER(Open));
                }
                action(RequestsToApprove)
                {
                    Caption='Requests to Approve';
                    Image = Approvals;
                    RunObject = Page 654;
                }
            }
            group("Administration")
            {
                Caption='Administration';
                Image = Administration;
                action(Valutaer)
                {
                    Caption='Currencies';
                    Image = Currency;
                    RunObject = Page 5;
                }
                action(Regnskabsperioder)
                {
                    Caption='Accounting Periods';
                    Image = AccountingPeriods;
                    RunObject = Page 100;
                }
                action(Nummerserie)
                {
                    Caption='Number Series';
                    RunObject = Page 456;
                }
            }
        }
        area(creation)
        {
            action("D&ebitor")
            {
                Caption='C&ustomer';
                Image = Customer;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page 21;
                RunPageMode = Create;
            }
            action("Salgs&faktura")
            {
                Caption='Sales &Invoice';
                Image = NewSalesInvoice;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page 43;
                RunPageMode = Create;
            }
            action("&Salgskreditnota")
            {
                Caption='Sales Credit &Memo';
                Image = CreditMemo;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page 44;
                RunPageMode = Create;
            }
            action("Re&ntenota")
            {
                Caption='Sales &Fin. Charge Memo';
                Image = FinChargeMemo;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page 446;
                RunPageMode = Create;
            }
            action("R&ykker")
            {
                Caption='Sales &Reminder';
                Image = Reminder;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page 434;
                RunPageMode = Create;
            }
            separator("Seperator 4")
            {
            }
            action("&Kreditor")
            {
                Caption='&Vendor';
                Image = Vendor;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page 26;
                RunPageMode = Create;
            }
            action("&Købsfaktura")
            {
                Caption='&Purchase Invoice';
                Image = NewPurchaseInvoice;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page 51;
                RunPageMode = Create;
            }
        }
        area(processing)
        {
            separator(Opgaver)
            {
                Caption='Tasks';
                IsHeader = true;
            }
            action("Ind&betalingskladde")
            {
                Caption='Cash Re&ceipt Journal';
                Image = CashReceiptJournal;
                RunObject = Page 255;
            }
            action("&Udbetalingskladde")
            {
                Caption='Payment &Journal';
                Image = PaymentJournal;
                RunObject = Page 256;
            }
            action(Betalingsregistrering)
            {
                Caption='Payment Registration';
                Image = Payment;
                RunObject = Page 981;
            }
            separator("Seperator 3")
            {
            }
            action(Betalingsudligningskladder)
            {
                Caption='Payment Reconciliation Journals';
                Image = ApplyEntries;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page 1294;
                RunPageMode = View;
            }
            action("Bankkontoafs&temning")
            {
                Caption='B&ank Account Reconciliations';
                Image = BankAccountRec;
                RunObject = Page 379;
            }
            action("Afregn &moms")
            {
                Caption='Calc. and Pos&t VAT Settlement';
                Ellipsis = true;
                Image = SettleOpenTransactions;
                RunObject = Report 20;
            }
            separator("Opsætning")
            {
                Caption='Administration';
                IsHeader = true;
            }
            action("Sa&lgsopsætning")
            {
                Caption='Sa&les && Receivables Setup';
                Image = Setup;
                RunObject = Page 459;
            }
            separator(Oversigt)
            {
                Caption='History';
                IsHeader = true;
            }
        }
    }
}

