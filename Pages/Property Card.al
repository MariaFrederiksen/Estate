page 60512 "SVA Property Card"
//Tooltip created
{
    Caption='Property';
    PageType = Card;
    SourceTable = "SVA Property";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption='General';
                field(Property;Property)
                {
                    ToolTip='Property number';
                }
                field(Name;Name)
                {
                    ToolTip='Possibly property name';
                }
                field(Address1;Address1)
                {
                    ToolTip='Property address';
                }
                field(Address2;Address2)
                {
                    ToolTip='Property address 2';
                }
                field("Post Code";"Post Code")
                {
                    ToolTip='Property post code';
                }
                field(City;City)
                {
                    ToolTip='Property city';
                }
                field("Country/Region Code";"Country/Region Code")
                {
                    ToolTip='Property country';
                }
                field(Email;Email)
                {
                    ToolTip='Main email.';
                }
                field(CompanyRegNo;CompanyRegNo)
                {
                    ToolTip='Company registration number';
                }
                field(CadastralNo;CadastralNo)
                {
                    ToolTip='Property cadastral number';
                }
                field(SquareMetersTotal;SquareMetersTotal)
                {
                    ToolTip='Property total square meter.';
                }
                field(SquareMetersProf;SquareMetersProf)
                {
                    ToolTip='Property square meter used for business';
                }
                field(SquareMetersLiv;SquareMetersLiv)
                {
                    ToolTip='Property square meter used for living';
                }
                field(Startdate;Startdate)
                {
                    ToolTip='Startdate for the administration';
                }
                field(ArchiveDate;ArchiveDate)
                {
                    ToolTip='Archived date. The date, administration of the property stopped';
                }
            }
            group(Own)
            {
                Caption = 'Owner';
                field(Owner;Owner)
                {
                    ToolTip='Owner name. Not uset for associations';
                }
                field(OwnerAddress1;OwnerAddress1)
                {
                    ToolTip='Owner address. Not uset for associations';
                }
                field(OwnerAddress2;OwnerAddress2)
                {
                    ToolTip='Owner address 2. Not uset for associations';
                }
                field(OwnerPostCode;OwnerPostCode)
                {
                    ToolTip='Owner post code. Not uset for associations';
                }
                field(OwnerCity;OwnerCity)
                {
                    ToolTip='Owner city. Not uset for associations';
                }
                field(OwnerCountry;OwnerCountry)
                {
                    ToolTip='Owner country. Not uset for associations';
                }
                field(OwnerPhone;OwnerPhone)
                {
                    ToolTip='Owner phone. Not uset for associations';
                }
                field(OwnerCell;OwnerCell)
                {
                    ToolTip='Owner cellphone. Not uset for associations';
                }
                field(OwnerEmail;OwnerEmail)
                {
                    ToolTip='Owner email. Not uset for associations';
                }
            }
            group(Bankinformations)
            {
                Caption = 'Bank and NETS';
                field(Bankname;Bankname)
                {
                    ToolTip='Bankname for this property';
                }
                field(BankRegNo;BankRegNo)
                {
                    ToolTip='Bank branch no for this property';
                }
                field(Bankaccount;Bankaccount)
                {
                    ToolTip='Bankaccount for this property';
                }
                field(CGPNumber;CGPNumber)
                {
                    ToolTip='CPG number for this property';
                }
                field(ESRNumber;ESRNumber)
                {
                    ToolTip='ESR number for agreement with NETS';
                }
                field(ESRAgrType;ESRAgrType)
                {
                    ToolTip='ESR type for agreement with NETS';
                }
                field(DataVendor;DataVendor)
                {
                    ToolTip='Datavendor for agreement with NETS';
                }
                field(ESRSystem;ESRSystem)
                {
                    ToolTip='ESRsystem type for agreement with NETS';
                }
            }
            group(Periods)
            {
                Caption = 'Periods';
                field(FinCompany;FinCompany)
                {
                    ToolTip='Audit office';
                }
                field(FinCompanyNo;FinCompanyNo)
                {
                    ToolTip='Our account at audit office';
                }
                field(FinEmail;FinEmail)
                {
                     ExtendedDatatype = EMail;
                     ToolTip='Audit office email';
                }
                field(FinancialYearFrom;FinancialYearFrom)
                {
                    ToolTip='Financial year from';
                }
                field(FinancialYearTo;FinancialYearTo)
                {
                    ToolTip='Financial year to';
                }
            }
            group(Balances)
            {
                Caption = 'Balances';
                group(Heat)
                {
                    Caption = 'Heat accounting';
                    field(HeatCompany;HeatCompany)
                    {
                        ToolTip='Company, wich prepare accounting';
                    }
                    field(HeatCompanyNo;HeatCompanyNo)
                    {
                        ToolTip='Our account at heatcompany';
                    }
                    field(HeatEmail;HeatEmail)
                    {
                   
                        ExtendedDatatype = EMail;
                        ToolTip='Heatcompany email';
                    }
                    field(HeatingYearFrom;HeatingYearFrom)
                    {
                        ToolTip='Year from';
                    }
                    field(HeatingYearTo;HeatingYearTo)
                    {
                        ToolTip='Year to';
                    }
                    field(HeatLatest;HeatLatest)
                    {
                        ToolTip='Latest accounting';
                    }
                }
                group(Water)
                {
                    Caption = 'Water accounting';
                    field(WaterCompany;WaterCompany)
                    {
                        ToolTip='Company, wich prepare accounting';
                    }
                    field(WaterCompanyNo;WaterCompanyNo)
                    {
                        ToolTip='Our account at watercompany';
                    }
                    field(WaterEmail;WaterEmail)
                    {
                        ToolTip='Watercompany email';
                        ExtendedDatatype = EMail;
                    }
                    field(WaterYearFrom;WaterYearFrom)
                    {
                         ToolTip='Year from';                                              
                    }
                    field(WaterYearTo;WaterYearTo)
                    {
                        ToolTip='Year to';
                    }
                    field(WaterLatest;WaterLatest)
                    {
                        ToolTip='Latest accounting';
                    }
                }
                group(Electric)
                {
                    Caption = 'El-accounting';
                    field(ElCompany;ElCompany)
                    {
                        ToolTip='Company, wich prepare accounting';
                    }
                    field(ELCompanyNo;ELCompanyNo)
                    {
                        ToolTip='Our account at el-company';
                    }
                    field(ElEmail;ElEmail)
                    {
                        ToolTip='El-company email';
                        ExtendedDatatype = EMail;
                    }
                    field(ElectricYearFrom;ElectricYearFrom)
                    {
                        ToolTip='Year from';
                    }
                    field(ElectricYearTo;ElectricYearTo)
                    {
                        ToolTip='Year to';
                    }
                    field(ElLatest;ElLatest)
                    {
                        ToolTip='Latest accounting';
                    }
                }
                group(Manage)
                {
                    Caption = 'Maintenance accounting';
                    field(ManYearFrom;ManYearFrom)
                    {
                        ToolTip='Year from';
                    }
                    field(ManYearTo;ManYearTo)
                    {
                        ToolTip='Year to';
                    }
                }
            }
            group("Type A9")
            {
                Caption = 'Fields for Type A 9. edition';
                group(Par1)
                {
                        Caption='Paragraph 1';
                        field(TypeA9_1_Laundry;TypeA9_1_Laundry)
                        {
                            ToolTip='Is there access to laundy?';
                        }
                        field(TypeA9_1_Bicycle;TypeA9_1_Bicycle)
                        {
                            ToolTip='Is there access to bicyclestorage?';
                        }
                        field(TypeA9_1_Courtyard;TypeA9_1_Courtyard)
                        {
                            ToolTip='Is there access to Courtyard?';
                        }
                }    
                group(Par3)
                {
                    Caption='Paragraph 3';
                    field(TypeA9_3_Taxes;TypeA9_3_Taxes)
                    {

                        ToolTip='The rent is based on taxes per date.';
                    }
                }
                group(Par4)
                {
                    Caption='Paragraph 4';
                    field(TypeA9_4_Deposit;TypeA9_4_DepMth)
                    {
                        ToolTip='Month of deposit.';
                    }
                    field(TypeA9_4_PrepaidRent;TypeA9_4_PrePaidMth)
                    {
                        Tooltip='Month of prepaid rent';
                    }
                }
                group(Par5)
                {
                    Caption = 'Paragraph 5';
                    field(TypeA9_5_LandlordHeat;TypeA9_5_LandlordHeat)
                    {
                        Tooltip='Landlord provides heat.';
                    }
                    field(TypeA9_5_LNatgas;TypeA9_5_LNatgas)
                    {
                        Tooltip='The tenancy is heatet by natural gas/distant heat .';
                    }
                    field(TypeA9_5_lOil;TypeA9_5_lOil)
                    {
                        Tooltip='The tenancy is heatet by Oil.';
                    }
                    field(TypeA9_5_LEl;TypeA9_5_LEl)
                    {
                        Tooltip='The tenancy is heatet by electricity.';
                    }
                    field(TypeA9_5_LOther;TypeA9_5_LOther)
                    {
                        Tooltip='The tenancy is heatet by other.';
                    }
                    field(TypeA9_5_LOtherText;TypeA9_5_LOtherText)
                    {
                        Tooltip='Wich type of heat?';
                    }
                    field(TypeA9_5_TenantHeat;TypeA9_5_TenantHeat)
                    {
                        Tooltip='Tenant provides heat.';
                    }
                    field(TypeA9_5_TEl;TypeA9_5_TEl)
                    {
                        Tooltip='The tenancy is heatet by electricity.';
                    }
                    field(TypeA9_5_Tgas;TypeA9_5_Tgas)
                    {
                        Tooltip='The tenancy is heatet by gas.';
                    }
                    field(TypeA9_5_TOil;TypeA9_5_TOil)
                    {
                        Tooltip='The tenancy is heatet by oil.';
                    }
                    field(TypeA9_5_TNatgas;TypeA9_5_TNatgas)
                    {
                        Tooltip='The tenancy is heatet by natural gas.';
                    }
                    field(TypeA9_5_TOTher;TypeA9_5_TOTher)
                    {
                        Tooltip='The tenancy is heatet by other.';
                    }
                    field(TypeA9_5_TOtherText;TypeA9_5_TOtherText)
                    {
                        Tooltip='What is the tenancy heatet by.';
                    }
                    field(TypeA9_5_Water;TypeA9_5_Water)
                    {
                        Tooltip='Landlord provides water.';
                    }
                    field(TypeA9_5_WM;TypeA9_5_WM)
                    {
                        Tooltip='Tenancy has water meter';
                    }
                   
                    field(TypeA9_5_El;TypeA9_5_El)
                    {
                        Tooltip='Landlord provides electricity for other use than heat.';
                    }
                    
                    field(TypeA9_5_Cooling;TypeA9_5_Cooling)
                    {
                        Tooltip='Landlord provides cooling.';
                    }
                    field(TypeA9_5_CM;TypeA9_5_CM)
                    {
                        Tooltip='Tenancy has cooling meter';
                    }
                    
                }
                group(Par6)
                {
                    Caption='Paragraph 6';
                    field(TypeA9_6_TAntenna;TypeA9_6_TAntenna)
                    {
                        Tooltip='Tenant pays for common signal';
                    }
                    field(TypeA9_6_Internet;TypeA9_6_Internet)
                    {
                        Tooltip='Landlord provides for internet which tenants pays contribution';
                    }
                }
                group(Par8)
                {
                    Caption='Paragraph 8';
                    field(TypeA9_8_MainLandlord;TypeA9_8_MainLandlord)
                    {
                        Tooltip='Inside maintenance by landlord';
                    }
                }
                group(Par10)
                {
                    Caption='Paragraph 10';
                    field(TypeA9_10_HouseStock;TypeA9_10_HouseStock)
                    {
                        Tooltip='Er det tilladt at holde husdyr i lejemålet?';
                    }
                    field(TypeA9_10_Houserules;TypeA9_10_Houserules)
                    {
                        Tooltip='Foreligger der ved lejeforholdets indgåelse en husorden for ejendommen?';
                    }
                    field(TypeA9_10_Occgroup;TypeA9_10_Occgroup)
                    {
                        Tooltip='Er der ved kontraktens indgåelse etableret beboerrepræsentation i ejendommen?';
                    }
                }
            }
        }
        area(factboxes)
        {
            systempart(Notat;Notes)
            {
            }
            systempart(Links;Links)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Rapporter)
            {
                Caption='Reports';
                action("Consumption Heat")
                {
                    Caption='AC Heat';
                    ToolTip='Making a status report for paid ac heat for the period';
                    Image = "Report";
                    
                    trigger OnAction();
                    begin
                         IF Rec.HeatCompany = '' THEN BEGIN
                           MESSAGE('Denne ejendom har ikke varmeregnskab.');
                           EXIT;
                           END;
                         CLEAR(Occupant);
                         Occupant.SETRANGE(PropertyNo,Rec.Property);
                         IF Occupant.FindFirst() THEN begin
                            CLEAR(Heatreport);
                            Heatreport.SETTABLEVIEW(Occupant);
                            Heatreport.RUNMODAL;
                            end;
                    end;
                }
                action("Consumption Water")
                {
                    Caption='AC Water';
                    ToolTip='Making a status report for paid ac water for the period';
                    Image = "Report";
                    
                    trigger OnAction();
                    begin
                         IF Rec.WaterCompany = '' THEN BEGIN
                           MESSAGE('Denne ejendom har ikke vandregnskab.');
                           EXIT;
                           END;
                         CLEAR(Occupant);
                         Occupant.SETRANGE(PropertyNo,Rec.Property);
                         IF Occupant.FindFirst() then begin
                            CLEAR(Waterreport);
                            Waterreport.SETTABLEVIEW(Occupant);
                            Waterreport.RUNMODAL;
                            END;
                    end;
                }
                action("Consumption Electricity")
                {
                    Caption='AC Electricity';
                    ToolTip='Making a status report for paid ac electricity for the period';
                    Image = "Report";
                    
                    trigger OnAction();
                    begin
                         IF Rec.ElCompany = '' THEN BEGIN
                           MESSAGE('Denne ejendom har ikke el-regnskab.');
                           EXIT;
                           END;
                         CLEAR(Occupant);
                         Occupant.SETRANGE(PropertyNo,Rec.Property);
                         IF Occupant.FindFirst() then begin
                            CLEAR(ElReport);
                            ElReport.SETTABLEVIEW(Occupant);
                            ElReport.RUNMODAL;
                            END;
                    end;
                }
                action("Consumption Man")
                {
                    Caption='AC Maintenace';
                    Image = "Report";
                    
                    trigger OnAction();
                    begin
                         IF Rec.ManLatest = 0D THEN BEGIN
                           MESSAGE('Denne ejendom har ikke driftsregnskab.');
                           EXIT;
                           END;
                         CLEAR(Occupant);
                         Occupant.SETRANGE(PropertyNo,Rec.Property);
                         IF Occupant.FindFirst() then begin
                            CLEAR(ManReport);
                            ManReport.SETTABLEVIEW(Occupant);
                            ManReport.RUNMODAL;
                            end;
                    end;
                }
                action("Vacant tenancies")
                {
                    Caption='Vacant tenancies';
                    ToolTip='Making report showing vacant tenancies in this company.';
                    Image = "Report";
                  
                    trigger OnAction();
                    begin
                        CLEAR(TenancyRecords);
                        TenancyRecords.SETRANGE(TenancyRecords.PropertyNo,Rec.Property);
                        if TenancyRecords.FindFirst() then begin 
                            CLEAR(VacantTenancies);
                            VacantTenancies.SETTABLEVIEW(TenancyRecords);
                            VacantTenancies.RUNMODAL;
                            end;
                    end;
                }
            }
            group(Lejereguleringer)
            {
                Caption='Regulations';
                action(Regulations)
                {
                    Caption='Rent regulations (indeks)';
                    ToolTip='Making a list of rent regulations.';
                    Image = Recalculate;
                    RunObject = Page 60620;
                    RunPageLink = PropertyNo=FIELD(Property);
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord();
    begin
        //CurrPage.UPDATE;
    end;

    trigger OnOpenPage();
    begin
          Email := '';
          Occupant.RESET;
          Occupant.SETRANGE(Occupant.PropertyNo,Property);
          IF Occupant.FIND('-') THEN BEGIN
            REPEAT
            IF Occupant.Email1 <> '' THEN BEGIN
              Email += Occupant.Email1+';';
              END;
            IF Occupant.Email2 <> '' THEN BEGIN
              Email += Occupant.Email2+';';
              END;
          UNTIL Occupant.NEXT = 0;
          END;
          IF STRLEN(Email) >= 5 THEN
            Email := DELSTR(Email,STRLEN(Email),1);
          CurrPage.UPDATE;
    end;

    var
        PropertyRec : Record "SVA Property";
        Heatreport : Report "SVA Consumption Heat";
        Occupant : Record "SVA Occupant";
        Waterreport : Report "SVA Consumption Water";
        ElReport : Report "SVA Consumption Electricity";
        ManReport : Report "SVA Consumption Man";
        TenancyRecords : Record "SVA Tenancy";
        VacantTenancies : Report "SVA Vacant Tenancies";
}

