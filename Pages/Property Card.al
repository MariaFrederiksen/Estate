page 50014 "SVA Property Card"
//Tooltip created
{
    Caption = 'Property';
    PageType = Card;
    SourceTable = "SVA Property";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(Property; Property)
                {
                    ApplicationArea = All;
                    ToolTip = 'Property number';
                }
                field(Name; Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Possibly property name';
                }
                field(Address1; Address1)
                {
                    ApplicationArea = All;
                    ToolTip = 'Property address';
                }
                field(Address2; Address2)
                {
                    ApplicationArea = All;
                    ToolTip = 'Property address 2';
                }
                field("Post Code"; "Post Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Property post code';
                }
                field(City; City)
                {
                    ApplicationArea = All;
                    ToolTip = 'Property city';
                }
                field("Country/Region Code"; "Country/Region Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Property country';
                }
                field(Email; Email)
                {
                    ApplicationArea = All;
                    ToolTip = 'Main email.';
                }
                field(CompanyRegNo; CompanyRegNo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Company registration number';
                }
                field(CadastralNo; CadastralNo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Property cadastral number';
                }
                field(SquareMetersTotal; SquareMetersTotal)
                {
                    ApplicationArea = All;
                    ToolTip = 'Property total square meter.';
                }
                field(SquareMetersProf; SquareMetersProf)
                {
                    ApplicationArea = All;
                    ToolTip = 'Property square meter used for business';
                }
                field(SquareMetersLiv; SquareMetersLiv)
                {
                    ApplicationArea = All;
                    ToolTip = 'Property square meter used for living';
                }
                field(Startdate; Startdate)
                {
                    ApplicationArea = All;
                    ToolTip = 'Startdate for the administration';
                }
                field(ArchiveDate; ArchiveDate)
                {
                    ApplicationArea = All;
                    ToolTip = 'Archived date. The date, administration of the property stopped';
                }
            }
            group(Own)
            {
                Caption = 'Owner';
                field(Owner; Owner)
                {
                    ApplicationArea = All;
                    ToolTip = 'Owner name. Not uset for associations';
                }
                field(OwnerAddress1; OwnerAddress1)
                {
                    ApplicationArea = All;
                    ToolTip = 'Owner address. Not uset for associations';
                }
                field(OwnerAddress2; OwnerAddress2)
                {
                    ApplicationArea = All;
                    ToolTip = 'Owner address 2. Not uset for associations';
                }
                field(OwnerPostCode; OwnerPostCode)
                {
                    ApplicationArea = All;
                    ToolTip = 'Owner post code. Not uset for associations';
                }
                field(OwnerCity; OwnerCity)
                {
                    ApplicationArea = All;
                    ToolTip = 'Owner city. Not uset for associations';
                }
                field(OwnerCountry; OwnerCountry)
                {
                    ApplicationArea = All;
                    ToolTip = 'Owner country. Not uset for associations';
                }
                field(OwnerPhone; OwnerPhone)
                {
                    ApplicationArea = All;
                    ToolTip = 'Owner phone. Not uset for associations';
                }
                field(OwnerCell; OwnerCell)
                {
                    ApplicationArea = All;
                    ToolTip = 'Owner cellphone. Not uset for associations';
                }
                field(OwnerEmail; OwnerEmail)
                {
                    ApplicationArea = All;
                    ToolTip = 'Owner email. Not uset for associations';
                }
            }
            group(Bankinformations)
            {
                Caption = 'Bank and NETS';
                field(Bankname; Bankname)
                {
                    ApplicationArea = All;
                    ToolTip = 'Bankname for this property';
                }
                field(BankRegNo; BankRegNo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Bank branch no for this property';
                }
                field(Bankaccount; Bankaccount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Bankaccount for this property';
                }
                field(ESRAgrType; ESRAgrType)
                {
                    ApplicationArea = All;
                    ToolTip = 'ESR type for agreement with NETS';
                }
                field(ESRNumber; ESRNumber)
                {
                    ApplicationArea = All;
                    ToolTip = 'ESR number for agreement with NETS';
                }
                field(ESRSystem; ESRSystem)
                {
                    ApplicationArea = All;
                    ToolTip = 'ESRsystem type for agreement with NETS';
                }
                field(ESRCustgrp; ESRCustgrp)
                {
                    ApplicationArea = All;
                    ToolTip = 'ESR customer group at NETS';
                }
                field("ESR Advis"; "ESR Advis")
                {
                    ApplicationArea = All;
                    ToolTip = 'ESR advis';

                }
            }
            group(Periods)
            {
                Caption = 'Periods';
                field(FinCompany; FinCompany)
                {
                    ApplicationArea = All;
                    ToolTip = 'Audit office';
                }
                field(FinCompanyNo; FinCompanyNo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Our account at audit office';
                }
                field(FinEmail; FinEmail)
                {
                    ExtendedDatatype = EMail;
                    ToolTip = 'Audit office email';
                    ApplicationArea = All;
                }
                field(FinancialYearFrom; FinancialYearFrom)
                {
                    ApplicationArea = All;
                    ToolTip = 'Financial year from';
                }
                field(FinancialYearTo; FinancialYearTo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Financial year to';
                }
            }
            group(Balances)
            {
                Caption = 'Balances';
                group(Heat)
                {
                    Caption = 'Heat accounting';
                    field(HeatCompany; HeatCompany)
                    {
                        ToolTip = 'Company, wich prepare accounting';
                        ApplicationArea = all;
                    }
                    field(HeatCompanyNo; HeatCompanyNo)
                    {
                        ToolTip = 'Our account at heatcompany';
                        ApplicationArea = all;
                    }
                    field(HeatEmail; HeatEmail)
                    {
                        ExtendedDatatype = EMail;
                        ToolTip = 'Heatcompany email';
                        ApplicationArea = all;
                    }
                    field(HeatingYearFrom; HeatingYearFrom)
                    {
                        ToolTip = 'Year from';
                        ApplicationArea = all;
                    }
                    field(HeatingYearTo; HeatingYearTo)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Year to';
                    }
                    field(HeatLatest; HeatLatest)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Latest accounting';
                    }
                }
                group(Water)
                {
                    Caption = 'Water accounting';
                    field(WaterCompany; WaterCompany)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Company, wich prepare accounting';
                    }
                    field(WaterCompanyNo; WaterCompanyNo)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Our account at watercompany';
                    }
                    field(WaterEmail; WaterEmail)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Watercompany email';
                        ExtendedDatatype = EMail;
                    }
                    field(WaterYearFrom; WaterYearFrom)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Year from';
                    }
                    field(WaterYearTo; WaterYearTo)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Year to';
                    }
                    field(WaterLatest; WaterLatest)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Latest accounting';
                    }
                }
                group(Electric)
                {
                    Caption = 'El-accounting';
                    field(ElCompany; ElCompany)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Company, wich prepare accounting';
                    }
                    field(ELCompanyNo; ELCompanyNo)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Our account at el-company';
                    }
                    field(ElEmail; ElEmail)
                    {
                        ApplicationArea = All;
                        ToolTip = 'El-company email';
                        ExtendedDatatype = EMail;
                    }
                    field(ElectricYearFrom; ElectricYearFrom)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Year from';
                    }
                    field(ElectricYearTo; ElectricYearTo)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Year to';
                    }
                    field(ElLatest; ElLatest)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Latest accounting';
                    }
                }
                group(Manage)
                {
                    Caption = 'Maintenance accounting';
                    field(ManYearFrom; ManYearFrom)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Year from';
                    }
                    field(ManYearTo; ManYearTo)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Year to';
                    }
                }
            }
            group("Type A9")
            {
                Caption = 'Fields for Type A 9. edition';
                group(Par1)
                {
                    Caption = 'Paragraph 1';
                    field(TypeA9_1_Laundry; TypeA9_1_Laundry)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Is there access to laundy?';
                    }
                    field(TypeA9_1_Bicycle; TypeA9_1_Bicycle)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Is there access to bicyclestorage?';
                    }
                    field(TypeA9_1_Courtyard; TypeA9_1_Courtyard)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Is there access to Courtyard?';
                    }
                }
                group(Par3)
                {
                    Caption = 'Paragraph 3';
                    field(TypeA9_3_Taxes; TypeA9_3_Taxes)
                    {
                        ApplicationArea = all;
                        ToolTip = 'The rent is based on taxes per date.';
                    }
                }
                group(Par4)
                {
                    Caption = 'Paragraph 4';
                    field(TypeA9_4_Deposit; TypeA9_4_DepMth)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Month of deposit.';
                    }
                    field(TypeA9_4_PrepaidRent; TypeA9_4_PrePaidMth)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Month of prepaid rent';
                    }
                }
                group(Par5)
                {
                    Caption = 'Paragraph 5';
                    field(TypeA9_5_LandlordHeat; TypeA9_5_LandlordHeat)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Landlord provides heat.';
                    }
                    field(TypeA9_5_LNatgas; TypeA9_5_LNatgas)
                    {
                        ApplicationArea = All;
                        Tooltip = 'The tenancy is heatet by natural gas/distant heat .';
                    }
                    field(TypeA9_5_lOil; TypeA9_5_lOil)
                    {
                        ApplicationArea = All;
                        Tooltip = 'The tenancy is heatet by Oil.';
                    }
                    field(TypeA9_5_LEl; TypeA9_5_LEl)
                    {
                        ApplicationArea = All;
                        Tooltip = 'The tenancy is heatet by electricity.';
                    }
                    field(TypeA9_5_LOther; TypeA9_5_LOther)
                    {
                        ApplicationArea = All;
                        Tooltip = 'The tenancy is heatet by other.';
                    }
                    field(TypeA9_5_LOtherText; TypeA9_5_LOtherText)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Wich type of heat?';
                    }
                    field(TypeA9_5_TenantHeat; TypeA9_5_TenantHeat)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Tenant provides heat.';
                    }
                    field(TypeA9_5_TEl; TypeA9_5_TEl)
                    {
                        ApplicationArea = All;
                        Tooltip = 'The tenancy is heatet by electricity.';
                    }
                    field(TypeA9_5_Tgas; TypeA9_5_Tgas)
                    {
                        ApplicationArea = All;
                        Tooltip = 'The tenancy is heatet by gas.';
                    }
                    field(TypeA9_5_TOil; TypeA9_5_TOil)
                    {
                        ApplicationArea = All;
                        Tooltip = 'The tenancy is heatet by oil.';
                    }
                    field(TypeA9_5_TNatgas; TypeA9_5_TNatgas)
                    {
                        ApplicationArea = All;
                        Tooltip = 'The tenancy is heatet by natural gas.';
                    }
                    field(TypeA9_5_TOTher; TypeA9_5_TOTher)
                    {
                        ApplicationArea = All;
                        Tooltip = 'The tenancy is heatet by other.';
                    }
                    field(TypeA9_5_TOtherText; TypeA9_5_TOtherText)
                    {
                        ApplicationArea = All;
                        Tooltip = 'What is the tenancy heatet by.';
                    }
                    field(TypeA9_5_Water; TypeA9_5_Water)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Landlord provides water.';
                    }
                    field(TypeA9_5_WM; TypeA9_5_WM)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Tenancy has water meter';
                    }

                    field(TypeA9_5_El; TypeA9_5_El)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Landlord provides electricity for other use than heat.';
                    }

                    field(TypeA9_5_Cooling; TypeA9_5_Cooling)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Landlord provides cooling.';
                    }
                    field(TypeA9_5_CM; TypeA9_5_CM)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Tenancy has cooling meter';
                    }

                }
                group(Par6)
                {
                    Caption = 'Paragraph 6';
                    field(TypeA9_6_TAntenna; TypeA9_6_TAntenna)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Tenant pays for common signal';
                    }
                    field(TypeA9_6_Internet; TypeA9_6_Internet)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Landlord provides for internet which tenants pays contribution';
                    }
                }
                group(Par7)
                {
                    Caption = 'Paragraph 7';
                    field(TypeA9_7_MoveIn; TypeA9_7_MoveIn)
                    {
                        ApplicationArea = all;
                    }
                }

                group(Par8)
                {
                    Caption = 'Paragraph 8';
                    field(TypeA9_8_MainLandlord; TypeA9_8_MainLandlord)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Inside maintenance by landlord';
                    }
                }
                group(Par10)
                {
                    Caption = 'Paragraph 10';
                    field(TypeA9_10_HouseStock; TypeA9_10_HouseStock)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Er det tilladt at holde husdyr i lejemålet?';
                    }
                    field(TypeA9_10_Houserules; TypeA9_10_Houserules)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Foreligger der ved lejeforholdets indgåelse en husorden for ejendommen?';
                    }
                    field(TypeA9_10_Occgroup; TypeA9_10_Occgroup)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Er der ved kontraktens indgåelse etableret beboerrepræsentation i ejendommen?';
                    }
                }
            }
        }
        area(factboxes)
        {
            systempart(Links; Links)
            {
                ApplicationArea = All;
            }
            systempart(Notes; Notes)
            {
                ApplicationArea = All;
            }

        }
    }

    actions
    {
        area(Reporting)
        {
            group(Reports)
            {
                Caption = 'AC statement';
                action("Consumption Heat")
                {
                    ApplicationArea = All;
                    Caption = 'AC Heat';
                    ToolTip = 'Making a status report for paid ac heat for the period';
                    Image = "Report";

                    trigger OnAction();
                    begin
                        IF Rec.HeatCompany = '' THEN BEGIN
                            Error('Denne ejendom har ikke varmeregnskab.');
                        END;
                        CLEAR(Occupant);
                        Occupant.SETRANGE(PropertyNo, Rec.Property);
                        IF Occupant.FindFirst() THEN begin
                            CLEAR(Heatreport);
                            Heatreport.SETTABLEVIEW(Occupant);
                            Heatreport.RUNMODAL;
                        end;
                    end;
                }
                action("Consumption Water")
                {
                    ApplicationArea = All;
                    Caption = 'AC Water';
                    ToolTip = 'Making a status report for paid ac water for the period';
                    Image = "Report";

                    trigger OnAction();
                    begin
                        IF Rec.WaterCompany = '' THEN BEGIN
                            Error('Denne ejendom har ikke vandregnskab.');
                        END;
                        CLEAR(Occupant);
                        Occupant.SETRANGE(PropertyNo, Rec.Property);
                        IF Occupant.FindFirst() then begin
                            CLEAR(Waterreport);
                            Waterreport.SETTABLEVIEW(Occupant);
                            Waterreport.RUNMODAL;
                        END;
                    end;
                }
                action("Consumption Electricity")
                {
                    ApplicationArea = All;
                    Caption = 'AC Electricity';
                    ToolTip = 'Making a status report for paid ac electricity for the period';
                    Image = "Report";

                    trigger OnAction();
                    begin
                        IF Rec.ElCompany = '' THEN BEGIN
                            Error('Denne ejendom har ikke el-regnskab.');
                        END;
                        CLEAR(Occupant);
                        Occupant.SETRANGE(PropertyNo, Rec.Property);
                        IF Occupant.FindFirst() then begin
                            CLEAR(ElReport);
                            ElReport.SETTABLEVIEW(Occupant);
                            ElReport.RUNMODAL;
                        END;
                    end;
                }
                action("Consumption Man")
                {
                    ApplicationArea = All;
                    Caption = 'AC Maintenace';
                    Image = "Report";

                    trigger OnAction();
                    begin
                        IF Rec.ManLatest = 0D THEN BEGIN
                            Error('Denne ejendom har ikke driftsregnskab.');
                        END;
                        CLEAR(Occupant);
                        Occupant.SETRANGE(PropertyNo, Rec.Property);
                        IF Occupant.FindFirst() then begin
                            CLEAR(ManReport);
                            ManReport.SETTABLEVIEW(Occupant);
                            ManReport.RUNMODAL;
                        end;
                    end;
                }
            }
            group(Deposita)
            {
                Caption = 'Depositum mv';
                action("Deposit")
                {
                    ApplicationArea = All;
                    Caption = 'Deposit';
                    ToolTip = 'A list of deposit per occupant.';
                    Image = "Report";

                    trigger OnAction();
                    begin
                        CLEAR(Occupant);
                        Occupant.SETRANGE(PropertyNo, Rec.Property);
                        IF Occupant.FindFirst() then begin
                            CLEAR(DepositReport);
                            DepositReport.SETTABLEVIEW(Occupant);
                            DepositReport.RUNMODAL;
                        end;

                    end;
                }
                action("Prepaid rent")
                {
                    ApplicationArea = All;
                    Caption = 'Prepaid rent';
                    ToolTip = 'A list of prepaid rent per occupant.';
                    Image = "Report";

                    trigger OnAction();
                    begin
                        CLEAR(Occupant);
                        Occupant.SETRANGE(PropertyNo, Rec.Property);
                        IF Occupant.FindFirst() then begin
                            CLEAR(PrepaidReport);
                            PrepaidReport.SETTABLEVIEW(Occupant);
                            PrepaidReport.RUNMODAL;
                        end;

                    end;
                }
            }
            group(Oversigt)
            {
                Caption = 'Overview';
                action("Vacant tenancies")
                {
                    ApplicationArea = All;
                    Caption = 'Vacant tenancies';
                    ToolTip = 'Making report showing vacant tenancies in this company.';
                    Image = "Report";

                    trigger OnAction();
                    begin
                        CLEAR(TenancyRecords);
                        TenancyRecords.SETRANGE(TenancyRecords.PropertyNo, Rec.Property);
                        if TenancyRecords.FindFirst() then begin
                            CLEAR(VacantTenancies);
                            VacantTenancies.SETTABLEVIEW(TenancyRecords);
                            VacantTenancies.RUNMODAL;
                        end;
                    end;
                }
                Action(IncomeProperty)
                {
                    ApplicationArea = All;
                    Caption = 'Income property';
                    Image = Report2;
                    ToolTip = 'Income for property and tenancies';
                    trigger OnAction();
                    begin
                        CLEAR(TenancyRecords);
                        TenancyRecords.SETRANGE(TenancyRecords.PropertyNo, Rec.Property);
                        if TenancyRecords.FindFirst() then begin
                            CLEAR(IncomeProperty);
                            IncomeProperty.SETTABLEVIEW(TenancyRecords);
                            IncomeProperty.RUNMODAL;
                        end;
                    end;
                }
            }
        }

        area(Processing)
        {
            group(Files)
            {
                Caption = 'Write AC heat to file';
                action("Heat file")
                {
                    ApplicationArea = All;
                    Caption = 'Heat file';
                    ToolTip = 'Making file for heat accounting in this company.';
                    Image = "ExportFile";

                    trigger OnAction();
                    begin
                        if Rec.HeatCompany = '' then
                            Error('Denne ejendom har ikke varmeregnskab.');
                        TempTable.Reset;
                        TempTable.SetRange(Name, 'Varme ' + Property);
                        if TempTable.FindSet then
                            repeat
                                Temptable.delete;
                            until TempTable.Next = 0;
                        FindDates();
                        Position := StrPos(Rec.HeatCompany, 'Brunata');
                        CLEAR(Occupant);
                        Occupant.SETRANGE(PropertyNo, Rec.Property);
                        IF Occupant.FindSet THEN
                            repeat
                                if Position = 0 then
                                    WriteToFileVarmekontrol();
                                if Position > 0 then
                                    WritetoFileBrunata();
                            until Occupant.Next = 0;
                        MakeFile();
                    end;
                }
            }
        }
        area(Navigation)
        {
            action(Tenancies)
            {
                ApplicationArea = All;
                Caption = 'Tenancies';
                Image = AlternativeAddress;
                RunObject = Page "SVA Tenancy List";
                RunPageLink = PropertyNo = FIELD(Property);

            }
            action(Residens)
            {
                ApplicationArea = all;
                Caption = 'Occupants';
                Image = Customer;
                RunObject = Page "SVA Occupant List";
                RunPageLink = PropertyNo = FIELD(Property);

            }
            action(Dimensioner)
            {
                ApplicationArea = all;
                Caption = 'Dimensions';
                Image = Dimensions;
                RunObject = Page "Default Dimensions";
                RunPageLink = "Table ID" = CONST(50001),
                                  "No." = FIELD(Property);
                ShortCutKey = 'Shift+Ctrl+D';
                ToolTip = 'View or edits dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';
            }
        }
    }

    var

        Heatreport: Report "SVA Consumption Heat";
        Occupant: Record "SVA Occupant";
        Waterreport: Report "SVA Consumption Water";
        ElReport: Report "SVA Consumption Electricity";
        ManReport: Report "SVA Consumption Man";
        DepositReport: Report "SVA Deposit";
        PrepaidReport: Report "SVA Prepaid rent";
        TenancyRecords: Record "SVA Tenancy";
        VacantTenancies: Report "SVA Vacant Tenancies";
        IncomeProperty: Report "SVA Income Property";
        TempTable: Record "SVA Export Temp";
        OccupantTrans: Record "SVA Occupant Trans";
        PropertyCard: Record "SVA Property";
        ConsumptionTo: Date;
        ConsumptionFrom: Date;
        Month1: Integer;
        Year1: Integer;
        TmpDate: Date;
        OccupantAmount: Decimal;
        OcAmountInt: Integer;
        TempCount: Integer;
        TempLine: Text[300];
        OcAmountText: Text[10];
        OcNumber: Text[10];
        Position: Integer;
        Tenancies: Record "SVA Tenancy";






    local procedure WritetoFileVarmekontrol()
    begin
        //find poster, der er har korrekt dato og korrekt art. 
        //Dan en linje
        OccupantAmount := 0;
        OccupantTrans.Reset;
        OccupantTrans.SetRange(Occupant, Occupant.Number);
        OccupantTrans.SetRange(Date, ConsumptionFrom, ConsumptionTo);
        OccupantTrans.SetRange(Type, 2); //Varme
        if OccupantTrans.FindSet then
            repeat
                OccupantAmount += OccupantTrans.Amount;
            until OccupantTrans.Next = 0;
        if STRPOS(Occupant.TenancyNo, '-') > 0 then
            Occupant.TenancyNo := DELSTR(Occupant.TenancyNo, STRPOS(Occupant.TenancyNo, '-'), 1);
        OcNumber := Occupant.Number;
        if STRPOS(OcNumber, 'L') > 0 then
            OcNumber := DELSTR(OcNumber, STRPOS(OcNumber, 'L'), 1);
        Templine := '';
        Templine := PADSTR(Templine, 40, '0');
        TempLine := InsStr(TempLine, HeatcompanyNo, 10 - StrLen(HeatcompanyNo)); //1-10 heatcompanyaccountNo
        TempLine := InsStr(TempLine, Property, 20 - StrLen(Property));//11-20 Property
        TempLine := InsStr(TempLine, Occupant.TenancyNo, 40 - Strlen(Occupant.TenancyNo) + 1); //31-40 TenancyNo only numbers
        Templine := InsStr(TempLine, OcNumber, 50 - StrLen(OcNumber) + 1); //41-50 OccupantNo
        TempLine := InsStr(TempLine, '                                                                                         ', 51); //51-80 Name 1
        TempLine := InsStr(TempLine, Occupant.Name1, 51); //51-80 Name 1
        TempLine := InsStr(TempLine, Occupant.Name2, 81); //81-110 Name 2
        TempLine := InsStr(TempLine, Occupant.Address, 111); //111-140 Address
        TempLine := InsStr(TempLine, Occupant."Post Code", 141); //141-144 Post code
        TempLine := InsStr(Templine, Occupant.City, 145); //145-164 City
        TempLine := InsStr(TempLine, format(Occupant.StartDate, 0, '<Day,2><Month,2><Year4>'), 165); //165-172 Startdate
        If Occupant.EndDate = 0D then
            TempLine := InsStr(TempLine, '00000000', 173);
        if Occupant.EndDate <> 0D then
            TempLine := InsStr(TempLine, format(Occupant.StartDate, 0, '<Day,2><Month,2><Year4>'), 173); //173-180 enddate
        //OccupantAmount := 1999; //testbeløb
        OcAmountInt := OccupantAmount * 100;
        OcAmountText := Format(OcAmountInt);
        if OccupantAmount < 0 then
            TempLine := InsStr(Templine, '-', 181); //181
        if OccupantAmount >= 0 then
            TempLine := InsStr(Templine, ' ', 181); //181
        TempLine := DelStr(Templine, 185, 10);
        TempLine := InsStr(Templine, '000000000', 182); //182-191 amount in øre
        TempLine := InsStr(TempLine, OcAmountText, 192 - StrLen(OcAmountText));
        TempLine := InsStr(TempLine, 'Varmekontrol', 192); //192-203
        Templine := InsStr(TempLine, 'ISO8859', 204); //204-213
        TempLine := DelStr(Templine, 214, 100);
        Reporting(TempLine);
    end;

    local procedure WritetoFileBrunata()
    begin
        //find poster, der er har korrekt dato og korrekt art. 
        //Dan en linje
        OccupantAmount := 0;
        OccupantTrans.Reset;
        OccupantTrans.SetRange(Occupant, Occupant.Number);
        OccupantTrans.SetRange(Date, ConsumptionFrom, ConsumptionTo);
        OccupantTrans.SetRange(Type, 2); //Varme
        if OccupantTrans.FindSet then
            repeat
                OccupantAmount += OccupantTrans.Amount;
            until OccupantTrans.Next = 0;
        if STRPOS(Occupant.TenancyNo, '-') > 0 then
            Occupant.TenancyNo := DELSTR(Occupant.TenancyNo, STRPOS(Occupant.TenancyNo, '-'), 1);
        OcNumber := Occupant.Number;
        if STRPOS(OcNumber, 'L') > 0 then
            OcNumber := DELSTR(OcNumber, STRPOS(OcNumber, 'L'), 1);
        Templine := '';
        Templine := PADSTR(Templine, 40, '0');
        TempLine := InsStr(TempLine, HeatcompanyNo, 10 - StrLen(HeatcompanyNo)); //1-10 heatcompanyaccountNo
        TempLine := InsStr(TempLine, Property, 20 - StrLen(Property));//11-20 Property
        TempLine := InsStr(TempLine, Occupant.TenancyNo, 40 - Strlen(Occupant.TenancyNo) + 1); //31-40 TenancyNo only numbers
        Templine := InsStr(TempLine, OcNumber, 50 - StrLen(OcNumber) + 1); //41-50 OccupantNo
        TempLine := InsStr(TempLine, '                                                                                         ', 51); //51-80 Name 1
        TempLine := InsStr(TempLine, Occupant.Name1, 51); //51-80 Name 1
        TempLine := InsStr(TempLine, Occupant.Name2, 81); //81-110 Name 2
        TempLine := InsStr(TempLine, Occupant.Address, 111); //111-140 Address
        TempLine := InsStr(TempLine, Occupant."Post Code", 141); //141-144 Post code
        TempLine := InsStr(Templine, Occupant.City, 145); //145-164 City
        TempLine := InsStr(TempLine, format(Occupant.StartDate, 0, '<Day,2><Month,2><Year4>'), 165); //165-172 Startdate
        If Occupant.EndDate = 0D then
            TempLine := InsStr(TempLine, '00000000', 173);
        if Occupant.EndDate <> 0D then
            TempLine := InsStr(TempLine, format(Occupant.StartDate, 0, '<Day,2><Month,2><Year4>'), 173); //173-180 enddate
        OccupantAmount := 1999; //testbeløb
        OcAmountInt := OccupantAmount * 100;
        OcAmountText := Format(OcAmountInt);
        if OccupantAmount < 0 then
            TempLine := InsStr(Templine, '-', 181); //181
        if OccupantAmount >= 0 then
            TempLine := InsStr(Templine, ' ', 181); //181
        TempLine := DelStr(Templine, 185, 10);
        TempLine := InsStr(Templine, '000000000', 182); //182-191 amount in øre
        TempLine := InsStr(TempLine, OcAmountText, 192 - StrLen(OcAmountText));
        TempLine := InsStr(TempLine, 'Varmekontrol', 192); //192-203
        Templine := InsStr(TempLine, 'ISO8859', 204); //204-213
        TempLine := DelStr(Templine, 214, 100);
        Reporting(TempLine);
    end;

    local procedure Reporting(Text250: Text[256]);
    begin
        TempCount += 1;
        TempTable."Line No." := TempCount;
        TempTable.Name := 'Varme ejd ' + Property;
        TempTable."Output Line" := Text250;
        TempTable.INSERT;
    end;

    Local procedure MakeFile();
    begin
        Xmlport.Run(xmlport::"SVA File for Consumption", false);
    end;

    local procedure FindDates();
    begin
        If ConsumptionTo = 0D then begin
            ConsumptionFrom := DMY2DATE(1, HeatingYearFrom, DATE2DMY(TODAY, 3));
            ConsumptionTo := CALCDATE('<1Y-1D>', ConsumptionFrom);
            while Today < ConsumptionTo do begin
                ConsumptionFrom := CalcDate('<-1Y>', ConsumptionFrom);
                ConsumptionTo := CalcDate('<-1Y>', ConsumptionTo);
            end;
        end;
    end;
}

