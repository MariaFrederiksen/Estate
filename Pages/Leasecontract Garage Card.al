page 60590 "SVA Leasecontract_Garage"
{
    // Page er oprettet for at kunne udfylde Lejekontrakt for garage korrekt. En del informationer findes i andre tabeller, og
    // udfyldes (se tabllen), når man går ind på kontrakten første gang. Senere ændringer overskrives ikke.

    Caption='Leasecontract Garage';
    PageType = Card;
    SourceTable = "SVA LeaseContract_A9";

    layout
    {
        area(content)
        {
            group(Lejeaftale)
            {
                Caption='Leasecontract';
                field(Number;Number)
                {
                }
                field(TypeA9_1_Address;TypeA9_1_Address)
                {
                }
                field(TypeA9_1_City;TypeA9_1_City)
                {
                }
                field(TypeA9_1_Landlord;TypeA9_1_Landlord)
                {
                }
                field(TypeA9_1_LandlordCVR;TypeA9_1_LandlordCVR)
                {
                }
                field(TypeA9_1_LandlordAddress;TypeA9_1_LandlordAddress)
                {
                }
                field(TypeA9_1_TenentName;TypeA9_1_TenentName)
                {
                }
                field(TypeA9_1_TenentAddress;TypeA9_1_TenentAddress)
                {
                }
                field(TypeA9_1_TenantCPR;TypeA9_1_TenantCPR)
                {
                }
                field(TypeA9_1_GarageNo;TypeA9_1_GarageNo)
                {
                }
                field(TypeA9_2_Startdate;TypeA9_2_Startdate)
                {
                }
                field(TypeA9_3_RentPerPeriode;TypeA9_3_RentPerPeriode)
                {
                    Caption='Rent per period';
                }
                field(TypeA9_3_RentPerYear;TypeA9_3_RentPerYear)
                {
                }
                field(TypeA9_4_DepMth;TypeA9_4_DepMth)
                {
                }
                field(TypeA9_4_DepAmount;TypeA9_4_DepAmount)
                {
                }
                field(TypeA9_4_PrepaidRentMth;TypeA9_4_PrepaidRentMth)
                {
                }
                field(TypeA9_4_PrepaidRent;TypeA9_4_PrepaidRent)
                {
                }
                field(TypeA9_4_Rentetc;TypeA9_4_Rentetc)
                {
                    Caption='Rent';
                }
                field(TypeA9_4_RentFrom;TypeA9_4_RentFrom)
                {
                }
                field(TypeA9_4_RentTo;TypeA9_4_RentTo)
                {
                }
                field(TypeA9_4_TotalAmount;TypeA9_4_TotalAmount)
                {
                }
                field(TypeA9_4_DueDate;TypeA9_4_DueDate)
                {
                }
                field(TypeA9_4_RentFirstTime;TypeA9_4_RentFirstTime)
                {
                }
                field(TypeA9_3_Bankname;TypeA9_3_Bankname)
                {
                }
                field(TypeA9_3_BankRegNo;TypeA9_3_BankRegNo)
                {
                }
                field(TypeA9_3_BankAccount;TypeA9_3_BankAccount)
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Notes;Notes)
            {
            }
            systempart(Links;Links)
            {
            }
        }
    }

    actions
    {
        area(reporting)
        {
            group(Lejekontrakt)
            {
                action(LeaseContract)
                {
                    Caption='Leasecontract';
                    Image = "report";

                    trigger OnAction();
                    begin
                        CLEAR(Contract);
                        Contract.SETRANGE(Number, Rec.Number);
                        IF Contract.FindFirst() THEN begin
                          CLEAR(Garage);
                          Garage.SETTABLEVIEW(Contract);
                          Garage.RUNMODAL;
                          END;
                    end;
                }
                action(MoveInInvoice)
                {
                    Caption='Move in invoice';
                    Image = Invoice;

                    trigger OnAction();
                    begin
                        CLEAR(Occupant);
                        Occupant.SETRANGE(Number, Rec.Number);
                        IF Occupant.FINDFIRST() THEN BEGIN
                            //Dan ordrehoved
                            SalesHeader.INIT;
                            SalesHeader.VALIDATE("Document Type",SalesHeader."Document Type"::Invoice);
                            SalesHeader."No.":='';
                            SalesHeader."Bill-to Customer No." := Occupant."Customer No";
                            SalesHeader."Bill-to Name" := Occupant.Name1;
                            SalesHeader."Bill-to Address" := Occupant.Address;
                            SalesHeader."Bill-to Address 2" := Occupant.Address2;
                            SalesHeader."Bill-to Post Code" := Occupant."Post Code";
                            SalesHeader."Bill-to City" := Occupant.City;
                            SalesHeader."Bill-to Country/Region Code" := Occupant."Country/Region Code";
                            SalesHeader."Sell-to Customer No." := Occupant."Customer No";
                            SalesHeader."Sell-to Customer Name" := Occupant.Name1;
                            SalesHeader."Sell-to Address" := Occupant.Address;
                            SalesHeader."Sell-to Address 2" := Occupant.Address2;
                            SalesHeader."Sell-to Post Code" := Occupant."Post Code";
                            SalesHeader."Sell-to City" := Occupant.City;
                            SalesHeader."Sell-to Country/Region Code" := Occupant."Country/Region Code";
                            SalesHeader."Posting Date" := TODAY;
                            SalesHeader."SVA Included" := TRUE;
                            SalesHeader."SVA Occupant" := Occupant.Number;

                            CLEAR(Contract);
                            Contract.SETRANGE(Number,Occupant.Number);
                            IF Contract.FINDFIRST() THEN BEGIN
                              SalesHeader."Due Date" := TypeA9_4_DueDate;
                              END;

                            Cust.RESET;
                            Cust.SETRANGE("Bill-to Customer No.",Occupant."Customer No");
                              IF Cust.FINDFIRST() THEN BEGIN
                                SalesHeader."Payment Terms Code" := Cust."Payment Terms Code";
                                SalesHeader."Currency Code" := Cust."Currency Code";
                                END;
                            SalesHeader.INSERT(TRUE);
                            END;
                        //Dan ordrelinjer
                        LineNo := 0;
                        CLEAR(Contract);
                        Contract.SETRANGE(Number,Occupant.Number);
                        IF Contract.FINDFIRST() THEN BEGIN
                            //Depositum
                            IF Contract.TypeA9_4_DepMth > 0 THEN BEGIN
                              SalesLine.INIT;
                              SalesLine.VALIDATE(SalesLine."Document Type",SalesHeader."Document Type"::Invoice);
                              SalesLine."Line No." := LineNo + 1;
                              LineNo := LineNo + 1;
                              SalesLine.Type := 1;
                              SalesLine."Document No." := SalesHeader."No.";
                              SalesLine.Quantity := Contract.TypeA9_4_DepMth;
                              SalesLine."Qty. to Ship" := SalesLine.Quantity;
                              SalesLine."Qty. to Invoice" := SalesLine.Quantity;
                              SalesLine."Unit Price" := Contract.TypeA9_4_DepAmount/Contract.TypeA9_4_DepMth;
                              SalesLine.Amount := Contract.TypeA9_4_DepAmount;
                              SalesLine."Line Amount" := Contract.TypeA9_4_DepAmount;
                              CostTypeEstate.RESET;
                              CostTypeEstate.SETRANGE(Type,9);
                              IF CostTypeEstate.FINDFIRST() THEN BEGIN
                                SalesLine."No." := CostTypeEstate.Account;
                                SalesLine.Description := CostTypeEstate.Description;
                                SalesLine."VAT Prod. Posting Group" := CostTypeEstate.VatGroup;
                                SalesLine."SVA Costtype" := CostTypeEstate.Costtype;
                                END;
                              LedAccount.RESET;
                              LedAccount.SETRANGE(LedAccount."No.",CostTypeEstate.Account);
                              IF LedAccount.FINDFIRST THEN BEGIN
                                SalesLine."Gen. Bus. Posting Group" := LedAccount."Gen. Bus. Posting Group";
                                SalesLine."Gen. Prod. Posting Group" := LedAccount."Gen. Prod. Posting Group";
                                END;
                              SalesLine.INSERT(TRUE);
                              END;
                            //Forudbetalt leje
                            IF Contract.TypeA9_4_PrepaidRentMth > 0 THEN BEGIN
                              SalesLine.INIT;
                              SalesLine.VALIDATE(SalesLine."Document Type",SalesHeader."Document Type"::Invoice);
                              SalesLine."Line No." := LineNo + 1;
                              LineNo := LineNo + 1;
                              SalesLine.Type := 1;
                              SalesLine."Document No." := SalesHeader."No.";
                              SalesLine.Quantity := Contract.TypeA9_4_PrepaidRentMth;
                              SalesLine."Qty. to Ship" := SalesLine.Quantity;
                              SalesLine."Qty. to Invoice" := SalesLine.Quantity;
                              SalesLine."Unit Price" := Contract.TypeA9_4_PrepaidRent/Contract.TypeA9_4_PrepaidRentMth;
                              SalesLine.Amount := Contract.TypeA9_4_PrepaidRent;
                              SalesLine."Line Amount" := Contract.TypeA9_4_PrepaidRent;
                              CostTypeEstate.RESET;
                              CostTypeEstate.SETRANGE(Type,10);
                              IF CostTypeEstate.FINDFIRST() THEN BEGIN
                                SalesLine."No." := CostTypeEstate.Account;
                                SalesLine.Description := CostTypeEstate.Description;
                                SalesLine."VAT Prod. Posting Group" := CostTypeEstate.VatGroup;
                                SalesLine."SVA Costtype" := CostTypeEstate.Costtype;
                                END;
                              LedAccount.RESET;
                              LedAccount.SETRANGE(LedAccount."No.",CostTypeEstate.Account);
                              IF LedAccount.FINDFIRST THEN BEGIN
                                SalesLine."Gen. Bus. Posting Group" := LedAccount."Gen. Bus. Posting Group";
                                  SalesLine."Gen. Prod. Posting Group" := LedAccount."Gen. Prod. Posting Group";
                                END;
                              SalesLine.INSERT(TRUE);
                              END;
                            //Første måneds leje
                            IF Contract.TypeA9_3_RentPerPeriode > 0 THEN BEGIN
                              SalesLine.INIT;
                              SalesLine.VALIDATE(SalesLine."Document Type",SalesHeader."Document Type"::Invoice);
                              SalesLine."Line No." := LineNo + 1;
                              LineNo := LineNo + 1;
                              SalesLine.Type := 1;
                              SalesLine."Document No." := SalesHeader."No.";
                              SalesLine.Quantity := 1;
                              SalesLine."Qty. to Ship" := SalesLine.Quantity;
                              SalesLine."Qty. to Invoice" := SalesLine.Quantity;
                              SalesLine."Unit Price" := Contract.TypeA9_3_RentPerPeriode;
                              SalesLine.Amount := Contract.TypeA9_3_RentPerPeriode;
                              SalesLine."Line Amount" := Contract.TypeA9_3_RentPerPeriode;
                              CostTypeEstate.RESET;
                              CostTypeEstate.SETRANGE(Type,1);
                              IF CostTypeEstate.FINDFIRST() THEN BEGIN
                                SalesLine."No." := CostTypeEstate.Account;
                                SalesLine.Description := 'Leje '+FORMAT(TypeA9_4_RentFrom)+' til '+FORMAT(TypeA9_4_RentTo);
                                SalesLine."VAT Prod. Posting Group" := CostTypeEstate.VatGroup;
                                SalesLine."SVA Costtype" := CostTypeEstate.Costtype;
                                END;
                              LedAccount.RESET;
                              LedAccount.SETRANGE(LedAccount."No.",CostTypeEstate.Account);
                              IF LedAccount.FINDFIRST THEN BEGIN
                                SalesLine."Gen. Bus. Posting Group" := LedAccount."Gen. Bus. Posting Group";
                                SalesLine."Gen. Prod. Posting Group" := LedAccount."Gen. Prod. Posting Group";
                                END;
                              SalesLine.INSERT(TRUE);
                              END;
                            //ACVarme
                            IF Contract.TypeA9_3_ACHeat > 0 THEN BEGIN
                              SalesLine.INIT;
                              SalesLine.VALIDATE(SalesLine."Document Type",SalesHeader."Document Type"::Invoice);
                              SalesLine."Line No." := LineNo + 1;
                              LineNo := LineNo + 1;
                              SalesLine.Type := 1;
                              SalesLine."Document No." := SalesHeader."No.";
                              SalesLine.Quantity := 1;
                              SalesLine."Qty. to Ship" := SalesLine.Quantity;
                              SalesLine."Qty. to Invoice" := SalesLine.Quantity;
                              SalesLine."Unit Price" := Contract.TypeA9_3_ACHeat;
                              SalesLine.Amount := Contract.TypeA9_3_ACHeat;
                              SalesLine."Line Amount" := Contract.TypeA9_3_ACHeat;
                              CostTypeEstate.RESET;
                              CostTypeEstate.SETRANGE(Type,2);
                              IF CostTypeEstate.FINDFIRST() THEN BEGIN
                                SalesLine."No." := CostTypeEstate.Account;
                                SalesLine.Description := CostTypeEstate.Description;
                                SalesLine."VAT Prod. Posting Group" := CostTypeEstate.VatGroup;
                                SalesLine."SVA Costtype" := CostTypeEstate.Costtype;
                                END;
                              LedAccount.RESET;
                              LedAccount.SETRANGE(LedAccount."No.",CostTypeEstate.Account);
                              IF LedAccount.FINDFIRST THEN BEGIN
                                SalesLine."Gen. Bus. Posting Group" := LedAccount."Gen. Bus. Posting Group";
                                SalesLine."Gen. Prod. Posting Group" := LedAccount."Gen. Prod. Posting Group";
                                END;
                              SalesLine.INSERT(TRUE);
                              END;
                           //ACVand
                            IF Contract.TypeA9_3_ACWater > 0 THEN BEGIN
                              SalesLine.INIT;
                              SalesLine.VALIDATE(SalesLine."Document Type",SalesHeader."Document Type"::Invoice);
                              SalesLine."Line No." := LineNo + 1;
                              LineNo := LineNo + 1;
                              SalesLine.Type := 1;
                              SalesLine."Document No." := SalesHeader."No.";
                              SalesLine.Quantity := 1;
                              SalesLine."Qty. to Ship" := SalesLine.Quantity;
                              SalesLine."Qty. to Invoice" := SalesLine.Quantity;
                              SalesLine."Unit Price" := Contract.TypeA9_3_ACWater;
                              SalesLine.Amount := Contract.TypeA9_3_ACWater;
                              SalesLine."Line Amount" := Contract.TypeA9_3_ACWater;
                              CostTypeEstate.RESET;
                              CostTypeEstate.SETRANGE(Type,3);
                              IF CostTypeEstate.FINDFIRST() THEN BEGIN
                                SalesLine."No." := CostTypeEstate.Account;
                                SalesLine.Description := CostTypeEstate.Description;
                                SalesLine."VAT Prod. Posting Group" := CostTypeEstate.VatGroup;
                                SalesLine."SVA Costtype" := CostTypeEstate.Costtype;
                                END;
                              LedAccount.RESET;
                              LedAccount.SETRANGE(LedAccount."No.",CostTypeEstate.Account);
                              IF LedAccount.FINDFIRST THEN BEGIN
                                SalesLine."Gen. Bus. Posting Group" := LedAccount."Gen. Bus. Posting Group";
                                SalesLine."Gen. Prod. Posting Group" := LedAccount."Gen. Prod. Posting Group";
                                END;
                              SalesLine.INSERT(TRUE);
                              END;
                            //ACEl
                            IF Contract.TypeA9_3_ACElectricity > 0 THEN BEGIN
                              SalesLine.INIT;
                              SalesLine.VALIDATE(SalesLine."Document Type",SalesHeader."Document Type"::Invoice);
                              SalesLine."Line No." := LineNo + 1;
                              LineNo := LineNo + 1;
                              SalesLine.Type := 1;
                              SalesLine."Document No." := SalesHeader."No.";
                              SalesLine.Quantity := 1;
                              SalesLine."Qty. to Ship" := SalesLine.Quantity;
                              SalesLine."Qty. to Invoice" := SalesLine.Quantity;
                              SalesLine."Unit Price" := Contract.TypeA9_3_ACElectricity;
                              SalesLine.Amount := Contract.TypeA9_3_ACElectricity;
                              SalesLine."Line Amount" := Contract.TypeA9_3_ACElectricity;
                              CostTypeEstate.RESET;
                              CostTypeEstate.SETRANGE(Type,4);
                              IF CostTypeEstate.FINDFIRST() THEN BEGIN
                                SalesLine."No." := CostTypeEstate.Account;
                                SalesLine.Description := CostTypeEstate.Description;
                                SalesLine."VAT Prod. Posting Group" := CostTypeEstate.VatGroup;
                                SalesLine."SVA Costtype" := CostTypeEstate.Costtype;
                                END;
                              LedAccount.RESET;
                              LedAccount.SETRANGE(LedAccount."No.",CostTypeEstate.Account);
                              IF LedAccount.FINDFIRST THEN BEGIN
                                SalesLine."Gen. Bus. Posting Group" := LedAccount."Gen. Bus. Posting Group";
                                SalesLine."Gen. Prod. Posting Group" := LedAccount."Gen. Prod. Posting Group";
                                END;
                              SalesLine.INSERT(TRUE);
                              END;
                            //ACkøling
                            IF Contract.TypeA9_3_ACCooling > 0 THEN BEGIN
                              SalesLine.INIT;
                              SalesLine.VALIDATE(SalesLine."Document Type",SalesHeader."Document Type"::Invoice);
                              SalesLine."Line No." := LineNo + 1;
                              LineNo := LineNo + 1;
                              SalesLine.Type := 1;
                              SalesLine."Document No." := SalesHeader."No.";
                              SalesLine.Quantity := 1;
                              SalesLine."Qty. to Ship" := SalesLine.Quantity;
                              SalesLine."Qty. to Invoice" := SalesLine.Quantity;
                              SalesLine."Unit Price" := Contract.TypeA9_3_ACCooling;
                              SalesLine.Amount := Contract.TypeA9_3_ACCooling;
                              SalesLine."Line Amount" := Contract.TypeA9_3_ACCooling;
                              CostTypeEstate.RESET;
                              CostTypeEstate.SETRANGE(Type,5);
                              IF CostTypeEstate.FINDFIRST() THEN BEGIN
                                SalesLine."No." := CostTypeEstate.Account;
                                SalesLine.Description := CostTypeEstate.Description;
                                SalesLine."VAT Prod. Posting Group" := CostTypeEstate.VatGroup;
                                SalesLine."SVA Costtype" := CostTypeEstate.Costtype;
                                END;
                              LedAccount.RESET;
                              LedAccount.SETRANGE(LedAccount."No.",CostTypeEstate.Account);
                              IF LedAccount.FINDFIRST THEN BEGIN
                                SalesLine."Gen. Bus. Posting Group" := LedAccount."Gen. Bus. Posting Group";
                                SalesLine."Gen. Prod. Posting Group" := LedAccount."Gen. Prod. Posting Group";
                                END;
                              SalesLine.INSERT(TRUE);
                              END;
                            //Antenne
                            IF Contract.TypeA9_3_Antenna > 0 THEN BEGIN
                              SalesLine.INIT;
                              SalesLine.VALIDATE(SalesLine."Document Type",SalesHeader."Document Type"::Invoice);
                              SalesLine."Line No." := LineNo + 1;
                              LineNo := LineNo + 1;
                              SalesLine.Type := 1;
                              SalesLine."Document No." := SalesHeader."No.";
                              SalesLine.Quantity := 1;
                              SalesLine."Qty. to Ship" := SalesLine.Quantity;
                              SalesLine."Qty. to Invoice" := SalesLine.Quantity;
                              SalesLine."Unit Price" := Contract.TypeA9_3_Antenna;
                              SalesLine.Amount := Contract.TypeA9_3_Antenna;
                              SalesLine."Line Amount" := Contract.TypeA9_3_Antenna;
                              CostTypeEstate.RESET;
                              CostTypeEstate.SETRANGE(Type,6);
                              IF CostTypeEstate.FINDFIRST() THEN BEGIN
                                SalesLine."No." := CostTypeEstate.Account;
                                SalesLine.Description := CostTypeEstate.Description;
                                SalesLine."VAT Prod. Posting Group" := CostTypeEstate.VatGroup;
                                SalesLine."SVA Costtype" := CostTypeEstate.Costtype;
                                END;
                              LedAccount.RESET;
                              LedAccount.SETRANGE(LedAccount."No.",CostTypeEstate.Account);
                              IF LedAccount.FINDFIRST THEN BEGIN
                                SalesLine."Gen. Bus. Posting Group" := LedAccount."Gen. Bus. Posting Group";
                                SalesLine."Gen. Prod. Posting Group" := LedAccount."Gen. Prod. Posting Group";
                                END;
                              SalesLine.INSERT(TRUE);
                              END;
                            //Internet
                            IF Contract.TypeA9_3_Internet > 0 THEN BEGIN
                              SalesLine.INIT;
                              SalesLine.VALIDATE(SalesLine."Document Type",SalesHeader."Document Type"::Invoice);
                              SalesLine."Line No." := LineNo + 1;
                              LineNo := LineNo + 1;
                              SalesLine.Type := 1;
                              SalesLine."Document No." := SalesHeader."No.";
                              SalesLine.Quantity := 1;
                              SalesLine."Qty. to Ship" := SalesLine.Quantity;
                              SalesLine."Qty. to Invoice" := SalesLine.Quantity;
                              SalesLine."Unit Price" := Contract.TypeA9_3_Internet;
                              SalesLine.Amount := Contract.TypeA9_3_Internet;
                              SalesLine."Line Amount" := Contract.TypeA9_3_Internet;
                              CostTypeEstate.RESET;
                              CostTypeEstate.SETRANGE(Type,7);
                              IF CostTypeEstate.FINDFIRST() THEN BEGIN
                                SalesLine."No." := CostTypeEstate.Account;
                                SalesLine.Description := CostTypeEstate.Description;
                                SalesLine."VAT Prod. Posting Group" := CostTypeEstate.VatGroup;
                                SalesLine."SVA Costtype" := CostTypeEstate.Costtype;
                                END;
                              LedAccount.RESET;
                              LedAccount.SETRANGE(LedAccount."No.",CostTypeEstate.Account);
                              IF LedAccount.FINDFIRST THEN BEGIN
                                SalesLine."Gen. Bus. Posting Group" := LedAccount."Gen. Bus. Posting Group";
                                SalesLine."Gen. Prod. Posting Group" := LedAccount."Gen. Prod. Posting Group";
                                END;
                              SalesLine.INSERT(TRUE);
                              END;
                            //Beboerrepræsentation
                            IF Contract.TypeA9_3_TenantGroup > 0 THEN BEGIN
                              SalesLine.INIT;
                              SalesLine.VALIDATE(SalesLine."Document Type",SalesHeader."Document Type"::Invoice);
                              SalesLine."Line No." := LineNo + 1;
                              LineNo := LineNo + 1;
                              SalesLine.Type := 1;
                              SalesLine."Document No." := SalesHeader."No.";
                              SalesLine.Quantity := 1;
                              SalesLine."Qty. to Ship" := SalesLine.Quantity;
                              SalesLine."Qty. to Invoice" := SalesLine.Quantity;
                              SalesLine."Unit Price" := Contract.TypeA9_3_TenantGroup;
                              SalesLine.Amount := Contract.TypeA9_3_TenantGroup;
                              SalesLine."Line Amount" := Contract.TypeA9_3_TenantGroup;
                              CostTypeEstate.RESET;
                              CostTypeEstate.SETRANGE(Type,8);
                              IF CostTypeEstate.FINDFIRST() THEN BEGIN
                                SalesLine."No." := CostTypeEstate.Account;
                                SalesLine.Description := CostTypeEstate.Description;
                                SalesLine."VAT Prod. Posting Group" := CostTypeEstate.VatGroup;
                                SalesLine."SVA Costtype" := CostTypeEstate.Costtype;
                                END;
                              LedAccount.RESET;
                              LedAccount.SETRANGE(LedAccount."No.",CostTypeEstate.Account);
                              IF LedAccount.FINDFIRST THEN BEGIN
                                SalesLine."Gen. Bus. Posting Group" := LedAccount."Gen. Bus. Posting Group";
                                SalesLine."Gen. Prod. Posting Group" := LedAccount."Gen. Prod. Posting Group";
                                END;
                              SalesLine.INSERT(TRUE);
                              END;
                            //Andet 1
                            IF Contract.TypeA9_3_OtherAmount1 > 0 THEN BEGIN
                              SalesLine.INIT;
                              SalesLine.VALIDATE(SalesLine."Document Type",SalesHeader."Document Type"::Invoice);
                              SalesLine."Line No." := LineNo + 1;
                              LineNo := LineNo + 1;
                              SalesLine.Type := 1;
                              SalesLine."Document No." := SalesHeader."No.";
                              SalesLine.Quantity := 1;
                              SalesLine."Qty. to Ship" := SalesLine.Quantity;
                              SalesLine."Qty. to Invoice" := SalesLine.Quantity;
                              SalesLine."Unit Price" := Contract.TypeA9_3_OtherAmount1;
                              SalesLine.Amount := Contract.TypeA9_3_OtherAmount1;
                              SalesLine."Line Amount" := Contract.TypeA9_3_OtherAmount1;
                              CostTypeEstate.RESET;
                              CostTypeEstate.SETRANGE(Type,1);
                              IF CostTypeEstate.FINDFIRST() THEN BEGIN
                                SalesLine."No." := CostTypeEstate.Account;
                                SalesLine.Description := Contract.TypeA9_3_OtherText1;
                                SalesLine."VAT Prod. Posting Group" := CostTypeEstate.VatGroup;
                                SalesLine."SVA Costtype" := CostTypeEstate.Costtype;
                                END;
                              LedAccount.RESET;
                              LedAccount.SETRANGE(LedAccount."No.",CostTypeEstate.Account);
                              IF LedAccount.FINDFIRST THEN BEGIN
                                SalesLine."Gen. Bus. Posting Group" := LedAccount."Gen. Bus. Posting Group";
                                SalesLine."Gen. Prod. Posting Group" := LedAccount."Gen. Prod. Posting Group";
                                END;
                              SalesLine.INSERT(TRUE);
                              END;
                            //Andet 2
                            IF Contract.TypeA9_3_OtherAmount2 > 0 THEN BEGIN
                              SalesLine.INIT;
                              SalesLine.VALIDATE(SalesLine."Document Type",SalesHeader."Document Type"::Invoice);
                              SalesLine."Line No." := LineNo + 1;
                              LineNo := LineNo + 1;
                              SalesLine.Type := 1;
                              SalesLine."Document No." := SalesHeader."No.";
                              SalesLine.Quantity := 1;
                              SalesLine."Qty. to Ship" := SalesLine.Quantity;
                              SalesLine."Qty. to Invoice" := SalesLine.Quantity;
                              SalesLine."Unit Price" := Contract.TypeA9_3_OtherAmount2;
                              SalesLine.Amount := Contract.TypeA9_3_OtherAmount2;
                              SalesLine."Line Amount" := Contract.TypeA9_3_OtherAmount2;
                              CostTypeEstate.RESET;
                              CostTypeEstate.SETRANGE(Type,1);
                              IF CostTypeEstate.FINDFIRST() THEN BEGIN
                                SalesLine."No." := CostTypeEstate.Account;
                                SalesLine.Description := Contract.TypeA9_3_OtherText1;
                                SalesLine."VAT Prod. Posting Group" := CostTypeEstate.VatGroup;
                                SalesLine."SVA Costtype" := CostTypeEstate.Costtype;
                                END;
                              LedAccount.RESET;
                              LedAccount.SETRANGE(LedAccount."No.",CostTypeEstate.Account);
                              IF LedAccount.FINDFIRST THEN BEGIN
                                SalesLine."Gen. Bus. Posting Group" := LedAccount."Gen. Bus. Posting Group";
                                SalesLine."Gen. Prod. Posting Group" := LedAccount."Gen. Prod. Posting Group";
                                END;
                              SalesLine.INSERT(TRUE);
                              END;
                          END;
                            //Posting
                            CODEUNIT.RUN(CODEUNIT::"Sales-Post",SalesHeader);
                            // Opret linjerne på beboer posteringer
                            Invoice.RESET;
                            Invoice.SETRANGE(Invoice."Posting Date",TODAY);
                            Invoice.SETRANGE(Invoice."Pre-Assigned No.",SalesHeader."No.");
                            Invoice.SETRANGE(Invoice."SVA Occupant",SalesHeader."SVA Occupant");
                            IF Invoice.FINDFIRST THEN
                              InvoiceLine.RESET;
                              InvoiceLine.SETRANGE(InvoiceLine."Document No.",Invoice."No.");
                              IF InvoiceLine.FIND('-') THEN
                                REPEAT
                                  OCtrans.Occupant := Invoice."SVA Occupant";
                                  OCtrans.Date := Invoice."Posting Date";
                                  OCtrans."Cost type Estate" := InvoiceLine."SVA Costtype";
                                  OCtrans."Invoice No" := InvoiceLine."Document No.";
                                  OCtrans.Description := InvoiceLine.Description;
                                  OCtrans.Qty := InvoiceLine.Quantity;
                                  OCtrans.Price := InvoiceLine."Unit Price";
                                  OCtrans.Amount := InvoiceLine.Amount;

                                  CostTypeEstate.RESET;
                                  CostTypeEstate.SETRANGE(Costtype,InvoiceLine."SVA Costtype");
                                  IF CostTypeEstate.FINDFIRST() THEN BEGIN
                                    OCtrans.Type := CostTypeEstate.Type;
                                    END;
                                  OCtrans.INSERT();
                                UNTIL InvoiceLine.NEXT = 0;

                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord();
    begin
        CurrPage.UPDATE;
    end;

    var
        Occupant : Record "SVA Occupant";
        Tenancy : Record "SVA Tenancy";
        Property : Record "SVA Property";
        Subscription : Record "SVA Subscription Lines";
        CompanyInfo : Record "Company Information";
        Customer : Record Customer;
        Contract : Record "SVA LeaseContract_A9";
        Garage : Report "SVA Contract Garage";
        SalesHeader : Record "Sales header";
        SalesLine : Record "Sales Line";
        Cust : Record Customer;
        LineNo : Integer;
        CostTypeEstate : Record "SVA Cost type";
        LedAccount : Record "G/L Account";
        Invoice : Record "Sales Invoice Header";
        InvoiceLine : Record "Sales Invoice Line";
        OCtrans : Record "SVA Occupant Trans";
}

