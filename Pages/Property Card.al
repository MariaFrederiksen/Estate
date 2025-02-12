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
                field(Property; Rec.Property)
                {
                    ApplicationArea = All;
                    ToolTip = 'Property number';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Possibly property name';
                }
                field(Address1; Rec.Address1)
                {
                    ApplicationArea = All;
                    ToolTip = 'Property address';
                }
                field(Address2; Rec.Address2)
                {
                    ApplicationArea = All;
                    ToolTip = 'Property address 2';
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Property post code';
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                    ToolTip = 'Property city';
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Property country';
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    ApplicationArea = all;
                    ToolTip = 'Vat product posting group for this property. Dimension 1 should be set equal to the propertynumber.';
                }
                field(Email; Rec.Email)
                {
                    ApplicationArea = all;
                    ToolTip = 'Emails to occupant and customers is sent to this mail too.';
                }
                /* field(CompanyRegNo; Rec.CompanyRegNo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Company registration number';
                } */
                field(CadastralNo; Rec.CadastralNo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Property cadastral number';
                }
                field(SquareMetersTotal; Rec.SquareMetersTotal)
                {
                    ApplicationArea = All;
                    ToolTip = 'Property total square meter.';
                }
                field(SquareMetersProf; Rec.SquareMetersProf)
                {
                    ApplicationArea = All;
                    ToolTip = 'Property square meter used for business';
                }
                field(SquareMetersLiv; Rec.SquareMetersLiv)
                {
                    ApplicationArea = All;
                    ToolTip = 'Property square meter used for living';
                }
                field(Startdate; Rec.Startdate)
                {
                    ApplicationArea = All;
                    ToolTip = 'Startdate for the administration';
                }
                field(ArchiveDate; Rec.ArchiveDate)
                {
                    ApplicationArea = All;
                    ToolTip = 'Archived date. The date, administration of the property stopped';
                }
            }
            group(Bebrepresentative)
            {
                Caption = 'Residential representative';
                field("Resident representation"; Rec."Resident representation")
                {
                    ApplicationArea = all;
                    ToolTip = 'Resident representation for this property.';
                }
                field(RR_Contact; Rec.RR_Contact)
                {
                    ApplicationArea = all;
                    ToolTip = 'Contact ID';
                }
                field(RR_Name; Rec.RR_Name)
                {
                    ApplicationArea = all;
                    ToolTip = 'Contact name';
                }
                field(RR_Amount; Rec.RR_Amount)
                {
                    ApplicationArea = all;
                    ToolTip = 'Amount per month';
                }
                field(RR_Fromdate; Rec.RR_Fromdate)
                {
                    ApplicationArea = all;
                    ToolTip = 'Valid from';
                }
            }
            group(Own)
            {
                Caption = 'Owner';
                field(Owner; Rec.Owner)
                {
                    ApplicationArea = All;
                    ToolTip = 'Owner name. Not uset for associations';
                }
                field(OwnerAddress1; Rec.OwnerAddress1)
                {
                    ApplicationArea = All;
                    ToolTip = 'Owner address. Not uset for associations';
                }
                field(OwnerAddress2; Rec.OwnerAddress2)
                {
                    ApplicationArea = All;
                    ToolTip = 'Owner address 2. Not uset for associations';
                }
                field(OwnerPostCode; Rec.OwnerPostCode)
                {
                    ApplicationArea = All;
                    ToolTip = 'Owner post code. Not uset for associations';
                }
                field(OwnerCity; Rec.OwnerCity)
                {
                    ApplicationArea = All;
                    ToolTip = 'Owner city. Not uset for associations';
                }
                field(OwnerCountry; Rec.OwnerCountry)
                {
                    ApplicationArea = All;
                    ToolTip = 'Owner country. Not uset for associations';
                }
                field(OwnerPhone; Rec.OwnerPhone)
                {
                    ApplicationArea = All;
                    ToolTip = 'Owner phone. Not uset for associations';
                }
                field(OwnerCell; Rec.OwnerCell)
                {
                    ApplicationArea = All;
                    ToolTip = 'Owner cellphone. Not uset for associations';
                }
                field(OwnerEmail; Rec.OwnerEmail)
                {
                    ApplicationArea = All;
                    ToolTip = 'Owner email. Emails to occupant and customers is sent to this mail too.';
                }
            }
            /* group(Bankinformations)
            NOTE:
            Do not delete. Can be handy at some time.
            {
                Caption = 'Bank and NETS';
                field(Bankname; Rec.Bankname)
                {
                    ApplicationArea = All;
                    ToolTip = 'Bankname for this property';
                }
                field(BankRegNo; Rec.BankRegNo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Bank branch no for this property';
                }
                field(Bankaccount; Rec.Bankaccount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Bankaccount for this property';
                }
                field(ESRAgrType; Rec.ESRAgrType)
                {
                    ApplicationArea = All;
                    ToolTip = 'ESR type for agreement with NETS';
                }
                field(ESRNumber; Rec.ESRNumber)
                {
                    ApplicationArea = All;
                    ToolTip = 'ESR number for agreement with NETS';
                }
                field(ESRSystem; Rec.ESRSystem)
                {
                    ApplicationArea = All;
                    ToolTip = 'ESRsystem type for agreement with NETS';
                }
                field(ESRCustgrp; Rec.ESRCustgrp)
                {
                    ApplicationArea = All;
                    ToolTip = 'ESR customer group at NETS';
                }
                field("ESR Advis"; Rec."ESR Advis")
                {
                    ApplicationArea = All;
                    ToolTip = 'ESR advis';

                }
            } */
            group(Periods)
            {
                Caption = 'Periods';
                field(FinCompany; Rec.FinCompany)
                {
                    ApplicationArea = All;
                    ToolTip = 'Audit office';
                }
                field(FinCompanyNo; Rec.FinCompanyNo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Our account at audit office';
                }
                field(FinEmail; Rec.FinEmail)
                {
                    ExtendedDatatype = EMail;
                    ToolTip = 'Audit office email';
                    ApplicationArea = All;
                }
                field(FinancialYearFrom; Rec.FinancialYearFrom)
                {
                    ApplicationArea = All;
                    ToolTip = 'Financial year from';
                }
                field(FinancialYearTo; Rec.FinancialYearTo)
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
                    field(HeatCompany; Rec.HeatCompany)
                    {
                        ToolTip = 'Company, wich prepare accounting';
                        ApplicationArea = all;
                    }
                    field(HeatCompanyNo; Rec.HeatCompanyNo)
                    {
                        ToolTip = 'Our account at heatcompany';
                        ApplicationArea = all;
                    }
                    field(HeatCompanyLogin; Rec.HeatCompanyLogin)
                    {
                        ToolTip = 'Login at heatcompany';
                        ApplicationArea = all;
                    }
                    field(HeatEmail; Rec.HeatEmail)
                    {
                        ExtendedDatatype = EMail;
                        ToolTip = 'Heatcompany email';
                        ApplicationArea = all;
                    }
                    field(HeatEmailMoving; Rec.HeatEmailMoving)
                    {
                        ExtendedDatatype = EMail;
                        ToolTip = 'Heatcompany email';
                        ApplicationArea = all;
                    }
                    field(HeatingYearFrom; Rec.HeatingYearFrom)
                    {
                        ToolTip = 'Year from';
                        ApplicationArea = all;
                    }
                    field(HeatingYearTo; Rec.HeatingYearTo)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Year to';
                    }
                    field(HeatLatest; Rec.HeatLatest)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Latest accounting';
                    }
                }
                group(Water)
                {
                    Caption = 'Water accounting';
                    field(WaterCompany; Rec.WaterCompany)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Company, wich prepare accounting';
                    }
                    field(WaterCompanyNo; Rec.WaterCompanyNo)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Our account at watercompany';
                    }
                    field(WaterCompanyLogin; Rec.WaterCompanyLogin)
                    {
                        ToolTip = 'Login at heatcompany';
                        ApplicationArea = all;
                    }
                    field(WaterEmail; Rec.WaterEmail)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Watercompany email';
                        ExtendedDatatype = EMail;
                    }
                    field(WaterEmailMoving; Rec.WaterEmailMoving)
                    {
                        ExtendedDatatype = EMail;
                        ToolTip = 'Watercompany email';
                        ApplicationArea = all;
                    }
                    field(WaterYearFrom; Rec.WaterYearFrom)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Year from';
                    }
                    field(WaterYearTo; Rec.WaterYearTo)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Year to';
                    }
                    field(WaterLatest; Rec.WaterLatest)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Latest accounting';
                    }
                }
                group(Electric)
                {
                    Caption = 'El-accounting';
                    field(ElCompany; Rec.ElCompany)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Company, wich prepare accounting';
                    }
                    field(ELCompanyNo; Rec.ELCompanyNo)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Our account at el-company';
                    }
                    field(ElEmail; Rec.ElEmail)
                    {
                        ApplicationArea = All;
                        ToolTip = 'El-company email';
                        ExtendedDatatype = EMail;
                    }
                    field(ElectricYearFrom; Rec.ElectricYearFrom)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Year from';
                    }
                    field(ElectricYearTo; Rec.ElectricYearTo)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Year to';
                    }
                    field(ElLatest; Rec.ElLatest)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Latest accounting';
                    }
                }
                group(Manage)
                {
                    Caption = 'Maintenance accounting';
                    field(ManYearFrom; Rec.ManYearFrom)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Year from';
                    }
                    field(ManYearTo; Rec.ManYearTo)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Year to';
                    }
                    field(ManLatest; Rec.ManLatest)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Latest accounting';
                    }
                }
            }
            group("Type A9")
            {
                Caption = 'Fields for Type A 9. edition';
                group(Par1)
                {
                    Caption = 'Paragraph 1';
                    field(TypeA9_1_Laundry; Rec.TypeA9_1_Laundry)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Is there access to laundy?';
                    }
                    field(TypeA9_1_Bicycle; Rec.TypeA9_1_Bicycle)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Is there access to bicyclestorage?';
                    }
                    field(TypeA9_1_Courtyard; Rec.TypeA9_1_Courtyard)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Is there access to Courtyard?';
                    }
                }
                group(Par3)
                {
                    Caption = 'Paragraph 3';
                    field(TypeA9_3_Taxes; Rec.TypeA9_3_Taxes)
                    {
                        ApplicationArea = all;
                        ToolTip = 'The rent is based on taxes per date.';
                    }
                }
                group(Par4)
                {
                    Caption = 'Paragraph 4';
                    field(TypeA9_4_Deposit; Rec.TypeA9_4_DepMth)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Month of deposit.';
                    }
                    field(TypeA9_4_PrepaidRent; Rec.TypeA9_4_PrePaidMth)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Month of prepaid rent';
                    }
                }
                group(Par5)
                {
                    Caption = 'Paragraph 5';
                    field(TypeA9_5_LandlordHeat; Rec.TypeA9_5_LandlordHeat)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Landlord provides heat.';
                    }
                    field(TypeA9_5_LNatgas; Rec.TypeA9_5_LNatgas)
                    {
                        ApplicationArea = All;
                        Tooltip = 'The tenancy is heatet by natural gas/distant heat .';
                    }
                    field(TypeA9_5_lOil; Rec.TypeA9_5_lOil)
                    {
                        ApplicationArea = All;
                        Tooltip = 'The tenancy is heatet by Oil.';
                    }
                    field(TypeA9_5_LEl; Rec.TypeA9_5_LEl)
                    {
                        ApplicationArea = All;
                        Tooltip = 'The tenancy is heatet by electricity.';
                    }
                    field(TypeA9_5_LOther; Rec.TypeA9_5_LOther)
                    {
                        ApplicationArea = All;
                        Tooltip = 'The tenancy is heatet by other.';
                    }
                    field(TypeA9_5_LOtherText; Rec.TypeA9_5_LOtherText)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Wich type of heat?';
                    }
                    field(TypeA9_5_TenantHeat; Rec.TypeA9_5_TenantHeat)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Tenant provides heat.';
                    }
                    field(TypeA9_5_TEl; Rec.TypeA9_5_TEl)
                    {
                        ApplicationArea = All;
                        Tooltip = 'The tenancy is heatet by electricity.';
                    }
                    field(TypeA9_5_Tgas; Rec.TypeA9_5_Tgas)
                    {
                        ApplicationArea = All;
                        Tooltip = 'The tenancy is heatet by gas.';
                    }
                    field(TypeA9_5_TOil; Rec.TypeA9_5_TOil)
                    {
                        ApplicationArea = All;
                        Tooltip = 'The tenancy is heatet by oil.';
                    }
                    field(TypeA9_5_TNatgas; Rec.TypeA9_5_TNatgas)
                    {
                        ApplicationArea = All;
                        Tooltip = 'The tenancy is heatet by natural gas.';
                    }
                    field(TypeA9_5_TOTher; Rec.TypeA9_5_TOTher)
                    {
                        ApplicationArea = All;
                        Tooltip = 'The tenancy is heatet by other.';
                    }
                    field(TypeA9_5_TOtherText; Rec.TypeA9_5_TOtherText)
                    {
                        ApplicationArea = All;
                        Tooltip = 'What is the tenancy heatet by.';
                    }
                    field(TypeA9_5_Water; Rec.TypeA9_5_Water)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Landlord provides water.';
                    }
                    field(TypeA9_5_WM; Rec.TypeA9_5_WM)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Tenancy has water meter';
                    }

                    field(TypeA9_5_El; Rec.TypeA9_5_El)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Landlord provides electricity for other use than heat.';
                    }

                    field(TypeA9_5_Cooling; Rec.TypeA9_5_Cooling)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Landlord provides cooling.';
                    }
                    field(TypeA9_5_CM; Rec.TypeA9_5_CM)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Tenancy has cooling meter';
                    }

                }
                group(Par6)
                {
                    Caption = 'Paragraph 6';
                    field(TypeA9_6_TAntenna; Rec.TypeA9_6_TAntenna)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Tenant pays for common signal';
                    }
                    field(TypeA9_6_Internet; Rec.TypeA9_6_Internet)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Landlord provides for internet which tenants pays contribution';
                    }
                }
                group(Par7)
                {
                    Caption = 'Paragraph 7';
                    field(TypeA9_7_MoveIn; Rec.TypeA9_7_MoveIn)
                    {
                        ApplicationArea = all;
                        ToolTip = 'Is / will the condition of the lease be ascertained by a move-in inspection';
                    }
                }

                group(Par8)
                {
                    Caption = 'Paragraph 8';
                    field(TypeA9_8_MainLandlord; Rec.TypeA9_8_MainLandlord)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Inside maintenance by landlord';
                    }
                }
                group(Par10)
                {
                    Caption = 'Paragraph 10';
                    field(TypeA9_10_HouseStock; Rec.TypeA9_10_HouseStock)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Er det tilladt at holde husdyr i lejemålet?';
                    }
                    field(TypeA9_10_Houserules; Rec.TypeA9_10_Houserules)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Foreligger der ved lejeforholdets indgåelse en husorden for ejendommen?';
                    }
                    field(TypeA9_10_Occgroup; Rec.TypeA9_10_Occgroup)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Er der ved kontraktens indgåelse etableret beboerrepræsentation i ejendommen?';
                    }
                }
            }
        }
        area(factboxes)
        {
            part("Document Attachment Factbox"; "Document Attachment Factbox")
            {
                Caption = 'Attachments';
                ApplicationArea = all;
                SubPageLink = "Table ID" = Const(50001), "No." = field(Property);
                Visible = not IsOfficeAddin;
            }

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
                        IF Rec.HeatCompany = '' THEN
                            Error('Denne ejendom har ikke varmeregnskab.');

                        CLEAR(SVAOccupant);
                        SVAOccupant.SETRANGE(PropertyNo, Rec.Property);
                        IF SVAOccupant.FindFirst() THEN begin
                            CLEAR(SVAConsumptionHeat);
                            SVAConsumptionHeat.SETTABLEVIEW(SVAOccupant);
                            SVAConsumptionHeat.RunModal();
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
                        IF Rec.WaterCompany = '' THEN
                            Error('Denne ejendom har ikke vandregnskab.');

                        CLEAR(SVAOccupant);
                        SVAOccupant.SETRANGE(PropertyNo, Rec.Property);
                        IF SVAOccupant.FindFirst() then begin
                            CLEAR(SVAConsumptionWater);
                            SVAConsumptionWater.SETTABLEVIEW(SVAOccupant);
                            SVAConsumptionWater.RunModal();
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
                        IF Rec.ElCompany = '' THEN
                            Error('Denne ejendom har ikke el-regnskab.');

                        CLEAR(SVAOccupant);
                        SVAOccupant.SETRANGE(PropertyNo, Rec.Property);
                        IF SVAOccupant.FindFirst() then begin
                            CLEAR(SVAConsumptionElectricity);
                            SVAConsumptionElectricity.SETTABLEVIEW(SVAOccupant);
                            SVAConsumptionElectricity.RunModal();
                        END;
                    end;
                }
                action("Consumption Man")
                {
                    ApplicationArea = All;
                    Caption = 'AC Maintenace';
                    ToolTip = 'Making a status report for paid ac maintenance for the period';
                    Image = "Report";

                    trigger OnAction();
                    begin
                        IF Rec.ManYearFrom = 0 THEN
                            Error('Denne ejendom har ikke driftsregnskab.');

                        CLEAR(SVAOccupant);
                        SVAOccupant.SETRANGE(PropertyNo, Rec.Property);
                        IF SVAOccupant.FindFirst() then begin
                            CLEAR(SVAConsumptionMan);
                            SVAConsumptionMan.SETTABLEVIEW(SVAOccupant);
                            SVAConsumptionMan.RunModal();
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
                    ToolTip = 'A list of deposit per Occupant.';
                    Image = "Report";

                    trigger OnAction();
                    begin
                        CLEAR(SVAOccupant);
                        SVAOccupant.SETRANGE(PropertyNo, Rec.Property);
                        IF SVAOccupant.FindFirst() then begin
                            CLEAR(SVADeposit);
                            SVADeposit.SETTABLEVIEW(SVAOccupant);
                            SVADeposit.RunModal();
                        end;
                    end;
                }
                /* action(DepositPrepaidRent)
                {
                    ApplicationArea = all;
                    Caption = 'Deposit and prepaid rent';
                    ToolTip = 'Deposit and prepaid rent paid by each occupant by a given date';
                    Image = Receivables;
                    RunObject = Page "SVA Occupant Deposit Date";
                    RunPageLink = PropertyNo = FIELD(Property);
                } */
                action("Prepaid rent")
                {
                    ApplicationArea = All;
                    Caption = 'Prepaid rent';
                    ToolTip = 'A list of prepaid rent per SVAOccupant.';
                    Image = "Report";

                    trigger OnAction();
                    begin
                        CLEAR(SVAOccupant);
                        SVAOccupant.SETRANGE(PropertyNo, Rec.Property);
                        IF SVAOccupant.FindFirst() then begin
                            CLEAR(SVAPrepaidrent);
                            SVAPrepaidrent.SETTABLEVIEW(SVAOccupant);
                            SVAPrepaidrent.RunModal();
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
                        CLEAR(SVATenancy);
                        SVATenancy.SETRANGE(SVATenancy.PropertyNo, Rec.Property);
                        if SVATenancy.FindFirst() then begin
                            CLEAR(SVAVacantTenancies);
                            SVAVacantTenancies.SETTABLEVIEW(SVATenancy);
                            SVAVacantTenancies.RunModal();
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
                        CLEAR(SVATenancy);
                        SVATenancy.SETRANGE(SVATenancy.PropertyNo, Rec.Property);
                        if SVATenancy.FindFirst() then begin
                            CLEAR(SVAIncomeProperty);
                            SVAIncomeProperty.SETTABLEVIEW(SVATenancy);
                            SVAIncomeProperty.RunModal();
                        end;
                    end;
                }

                action(Phonelist)
                {
                    Caption = 'Occupant mail and phonelist';
                    ToolTip = 'Phone/mail list for all active occupants at this property';
                    ApplicationArea = All;
                    Image = MakeAgreement;
                    trigger OnAction();
                    begin
                        CLEAR(SVAProperty);
                        SVAProperty.SETRANGE(Property, Rec.Property);
                        IF SVAProperty.FindFirst() then begin
                            CLEAR(SVAOccupantList);
                            SVAOccupantList.SETTABLEVIEW(SVAProperty);
                            SVAOccupantList.RunModal();
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
                    Image = SaveViewAs;

                    trigger OnAction();
                    begin
                        if Rec.HeatCompany = '' then
                            Error('Denne ejendom har ikke varmeregnskab.');
                        SVAExportTemp.Reset();
                        SVAExportTemp.SetRange(Name, 'Varme ' + Rec.Property);
                        if SVAExportTemp.FindSet() then
                            repeat
                                SVAExportTemp.Delete();
                            until SVAExportTemp.NEXT() = 0;
                        FindDates();
                        Position := StrPos(Rec.HeatCompany, 'Brunata');
                        CLEAR(SVAOccupant);
                        SVAOccupant.SETRANGE(PropertyNo, Rec.Property);
                        IF SVAOccupant.FindSet() THEN
                            repeat
                                if Position = 0 then
                                    WriteToFileVarmekontrol();
                                if Position > 0 then
                                    WritetoFileBrunata();
                            until SVAOccupant.NEXT() = 0;
                        MakeFile();
                    end;
                }

            }
            action("SendEmail")
            {
                ApplicationArea = All;
                Caption = 'Email to occupants';
                ToolTip = 'Forms an email to all active residents of this property';
                Image = Email;
                trigger OnAction();
                var
                    SVAProperty: Record "SVA Property";
                begin
                    SVAProperty.SendEmailToOccupants(Rec, true);
                end;
            }
            action(Bebrep)
            {
                ApplicationArea = all;
                Caption = 'Fee for resident representation';
                ToolTip = 'Create fee for resident representation on every tenancy';
                Image = Create;
                trigger OnAction()
                var
                    SVAProperty: Record "SVA Property";
                begin
                    SVAProperty.CreateResRepOnOccupants(Rec);
                end;
            }
        }
        area(Navigation)
        {
            action(Tenancies)
            {
                ApplicationArea = All;
                Caption = 'Tenancies';
                ToolTip = 'Navigate to tenancies for this property.';
                Image = AlternativeAddress;
                RunObject = Page "SVA Tenancy List";
                RunPageLink = PropertyNo = FIELD(Property);

            }
            action(Residens)
            {
                ApplicationArea = all;
                Caption = 'Occupants';
                ToolTip = 'Navigate to occupants for this property.';
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
    trigger OnOpenPage()
    var
        OfficeManagement: Codeunit "Office Management";
    begin
        IsOfficeAddin := Officemanagement.IsAvailable();
    end;

    var


        SVAOccupant: Record "SVA Occupant";
        SVAExportTemp: Record "SVA Export Temp";
        SVAOccupantTrans: Record "SVA Occupant Trans";
        SVAProperty: Record "SVA Property";
        SVATenancy: Record "SVA Tenancy";
        SVAOccupantList: report "SVA Occupant List";
        SVAConsumptionWater: Report "SVA Consumption Water";
        SVAConsumptionHeat: Report "SVA Consumption Heat";
        SVAConsumptionElectricity: Report "SVA Consumption Electricity";
        SVAConsumptionMan: Report "SVA Consumption Man";
        SVADeposit: Report "SVA Deposit";
        SVAPrepaidRent: Report "SVA Prepaid Rent";
        SVAVacantTenancies: Report "SVA Vacant Tenancies";
        SVAIncomeProperty: Report "SVA Income Property";
        ConsumptionTo: Date;
        ConsumptionFrom: Date;
        OccupantAmount: Decimal;
        OcAmountInt: Integer;
        TempCount: Integer;
        TempLine: Text[300];
        OcAmountText: Text[10];
        OcNumber: Text[10];
        Position: Integer;
        IsOfficeAddin: Boolean;

    local procedure WritetoFileVarmekontrol()
    begin
        //find poster, der er har korrekt dato og korrekt art. 
        //Dan en linje
        OccupantAmount := 0;
        SVAOccupantTrans.Reset();
        SVAOccupantTrans.SetRange(Occupant, SVAOccupant.Number);
        SVAOccupantTrans.SetRange(Date, ConsumptionFrom, ConsumptionTo);
        SVAOccupantTrans.SetRange(Type, 2); //Varme
        if SVAOccupantTrans.FindSet() then
            repeat
                OccupantAmount += SVAOccupantTrans.Amount;
            until SVAOccupantTrans.NEXT() = 0;
        if STRPOS(SVAOccupant.TenancyNo, '-') > 0 then
            SVAOccupant.TenancyNo := DELSTR(SVAOccupant.TenancyNo, STRPOS(SVAOccupant.TenancyNo, '-'), 1);
        OcNumber := SVAOccupant.Number;
        if STRPOS(OcNumber, 'L') > 0 then
            OcNumber := DELSTR(OcNumber, STRPOS(OcNumber, 'L'), 1);
        Templine := '';
        Templine := PADSTR(Templine, 40, '0');
        TempLine := InsStr(TempLine, Rec.HeatcompanyNo, 10 - StrLen(Rec.HeatcompanyNo)); //1-10 heatcompanyaccountNo
        TempLine := InsStr(TempLine, Rec.Property, 20 - StrLen(Rec.Property));//11-20 Property
        TempLine := InsStr(TempLine, SVAOccupant.TenancyNo, 40 - Strlen(SVAOccupant.TenancyNo) + 1); //31-40 TenancyNo only numbers
        Templine := InsStr(TempLine, OcNumber, 50 - StrLen(OcNumber) + 1); //41-50 OccupantNo
        TempLine := InsStr(TempLine, '                                                                                         ', 51); //51-80 Name 1
        TempLine := InsStr(TempLine, SVAOccupant.Name1, 51); //51-80 Name 1
        TempLine := InsStr(TempLine, SVAOccupant.Name2, 81); //81-110 Name 2
        TempLine := InsStr(TempLine, SVAOccupant.Address, 111); //111-140 Address
        TempLine := InsStr(TempLine, SVAOccupant."Post Code", 141); //141-144 Post code
        TempLine := InsStr(Templine, SVAOccupant.City, 145); //145-164 City
        TempLine := InsStr(TempLine, format(SVAOccupant.StartDate, 0, '<Day,2><Month,2><Year4>'), 165); //165-172 Startdate
        If SVAOccupant.EndDate = 0D then
            TempLine := InsStr(TempLine, '00000000', 173);
        if SVAOccupant.EndDate <> 0D then
            TempLine := InsStr(TempLine, format(SVAOccupant.StartDate, 0, '<Day,2><Month,2><Year4>'), 173); //173-180 enddate
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
        SVAOccupantTrans.Reset();
        SVAOccupantTrans.SetRange(Occupant, SVAOccupant.Number);
        SVAOccupantTrans.SetRange(Date, ConsumptionFrom, ConsumptionTo);
        SVAOccupantTrans.SetRange(Type, 2); //Varme
        if SVAOccupantTrans.FindSet() then
            repeat
                OccupantAmount += SVAOccupantTrans.Amount;
            until SVAOccupantTrans.NEXT() = 0;
        if STRPOS(SVAOccupant.TenancyNo, '-') > 0 then
            SVAOccupant.TenancyNo := DELSTR(SVAOccupant.TenancyNo, STRPOS(SVAOccupant.TenancyNo, '-'), 1);
        OcNumber := SVAOccupant.Number;
        if STRPOS(OcNumber, 'L') > 0 then
            OcNumber := DELSTR(OcNumber, STRPOS(OcNumber, 'L'), 1);
        Templine := '';
        Templine := PADSTR(Templine, 40, '0');
        TempLine := InsStr(TempLine, Rec.HeatcompanyNo, 10 - StrLen(Rec.HeatcompanyNo)); //1-10 heatcompanyaccountNo
        TempLine := InsStr(TempLine, Rec.Property, 20 - StrLen(Rec.Property));//11-20 Property
        TempLine := InsStr(TempLine, SVAOccupant.TenancyNo, 40 - Strlen(SVAOccupant.TenancyNo) + 1); //31-40 TenancyNo only numbers
        Templine := InsStr(TempLine, OcNumber, 50 - StrLen(OcNumber) + 1); //41-50 OccupantNo
        TempLine := InsStr(TempLine, '                                                                                         ', 51); //51-80 Name 1
        TempLine := InsStr(TempLine, SVAOccupant.Name1, 51); //51-80 Name 1
        TempLine := InsStr(TempLine, SVAOccupant.Name2, 81); //81-110 Name 2
        TempLine := InsStr(TempLine, SVAOccupant.Address, 111); //111-140 Address
        TempLine := InsStr(TempLine, SVAOccupant."Post Code", 141); //141-144 Post code
        TempLine := InsStr(Templine, SVAOccupant.City, 145); //145-164 City
        TempLine := InsStr(TempLine, format(SVAOccupant.StartDate, 0, '<Day,2><Month,2><Year4>'), 165); //165-172 Startdate
        If SVAOccupant.EndDate = 0D then
            TempLine := InsStr(TempLine, '00000000', 173);
        if SVAOccupant.EndDate <> 0D then
            TempLine := InsStr(TempLine, format(SVAOccupant.StartDate, 0, '<Day,2><Month,2><Year4>'), 173); //173-180 enddate
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
        SVAExportTemp.Init();
        TempCount += 1;
        SVAExportTemp."Line No." := TempCount;
        SVAExportTemp.Name := 'Varme ejd ' + Rec.Property;
        SVAExportTemp."Output Line" := Text250;
        SVAExportTemp.Insert();
    end;

    Local procedure MakeFile();
    begin
        Xmlport.Run(xmlport::"SVA File for Consumption", false);
    end;

    local procedure FindDates();
    begin
        If ConsumptionTo = 0D then begin
            ConsumptionFrom := DMY2DATE(1, Rec.HeatingYearFrom, DATE2DMY(TODAY, 3));
            ConsumptionTo := CALCDATE('<1Y-1D>', ConsumptionFrom);
            while Today < ConsumptionTo do begin
                ConsumptionFrom := CalcDate('<-1Y>', ConsumptionFrom);
                ConsumptionTo := CalcDate('<-1Y>', ConsumptionTo);
            end;
        end;
    end;
}

