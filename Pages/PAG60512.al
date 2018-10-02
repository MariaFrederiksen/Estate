page 60512 "Property Card"
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
                }
                field(Name;Name)
                {
                }
                field(Address1;Address1)
                {
                }
                field(Address2;Address2)
                {
                }
                field("Post Code";"Post Code")
                {
                }
                field(City;City)
                {
                }
                field("Country/Region Code";"Country/Region Code")
                {
                }
                field(Email;Email)
                {
                }
                field(CompanyRegNo;CompanyRegNo)
                {
                }
                field(CadastralNo;CadastralNo)
                {
                }
                field(SquareMetersTotal;SquareMetersTotal)
                {
                }
                field(SquareMetersProf;SquareMetersProf)
                {
                }
                field(SquareMetersLiv;SquareMetersLiv)
                {
                }
                field(Startdate;Startdate)
                {
                }
                field(ArchiveDate;ArchiveDate)
                {
                }
            }
            group(Own)
            {
                Caption = 'Owner';
                field(Owner;Owner)
                {
                }
                field(OwnerAddress1;OwnerAddress1)
                {
                }
                field(OwnerAddress2;OwnerAddress2)
                {
                }
                field(OwnerPostCode;OwnerPostCode)
                {
                }
                field(OwnerCity;OwnerCity)
                {
                }
                field(OwnerCountry;OwnerCountry)
                {
                }
                field(OwnerPhone;OwnerPhone)
                {
                }
                field(OwnerCell;OwnerCell)
                {
                }
                field(OwnerEmail;OwnerEmail)
                {
                }
            }
            group(Bankinformations)
            {
                Caption = 'Bank and NETS';
                field(Bankname;Bankname)
                {
                }
                field(BankRegNo;BankRegNo)
                {
                }
                field(Bankaccount;Bankaccount)
                {
                }
                field(CGPNumber;CGPNumber)
                {
                }
                field(ESRNumber;ESRNumber)
                {
                }
                field(ESRAgrType;ESRAgrType)
                {
                }
                field(DataVendor;DataVendor)
                {
                }
                field(ESRSystem;ESRSystem)
                {
                }
            }
            group(Periods)
            {
                Caption = 'Periods';
                field(FinCompany;FinCompany)
                {
                }
                field(FinCompanyNo;FinCompanyNo)
                {
                }
                field(FinEmail;FinEmail)
                {
                     ExtendedDatatype = EMail;
                }
                field(FinancialYearFrom;FinancialYearFrom)
                {
                }
                field(FinancialYearTo;FinancialYearTo)
                {
                }
            }
            group(Balances)
            {
                Caption = 'Periods';
                group(Heat)
                {
                    Caption = 'Heat accounting';
                    field(HeatCompany;HeatCompany)
                    {
                
                    }
                    field(HeatCompanyNo;HeatCompanyNo)
                    {
                    
                    }
                    field(HeatEmail;HeatEmail)
                    {
                   
                        ExtendedDatatype = EMail;
                    }
                    field(HeatingYearFrom;HeatingYearFrom)
                    {
                   
                    }
                    field(HeatingYearTo;HeatingYearTo)
                    {
                    
                    }
                    field(HeatLatest;HeatLatest)
                    {
                    }
                }
                group(Water)
                {
                    Caption = 'Water accounting';
                    field(WaterCompany;WaterCompany)
                    {
                   
                    }
                    field(WaterCompanyNo;WaterCompanyNo)
                    {
                   
                    }
                    field(WaterEmail;WaterEmail)
                    {
                    
                        ExtendedDatatype = EMail;
                    }
                    field(WaterYearFrom;WaterYearFrom)
                    {
                    
                    }
                    field(WaterYearTo;WaterYearTo)
                    {
                    
                    }
                    field(WaterLatest;WaterLatest)
                    {
                    }
                }
                group(Electric)
                {
                    Caption = 'El-accounting';
                    field(ElCompany;ElCompany)
                    {
                  
                    }
                    field(ELCompanyNo;ELCompanyNo)
                    {
      
                    }
                    field(ElEmail;ElEmail)
                    {

                        ExtendedDatatype = EMail;
                    }
                    field(ElectricYearFrom;ElectricYearFrom)
                    {
                 
                    }
                    field(ElectricYearTo;ElectricYearTo)
                    {
                 
                    }
                    field(ElLatest;ElLatest)
                    {
             
                    }
                }
                group(Manage)
                {
                    Caption = 'Maintenance accounting';
                    field(ManYearFrom;ManYearFrom)
                    {
            
                    }
                    field(ManYearTo;ManYearTo)
                    {

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
                        }
                        field(TypeA9_1_Bicycle;TypeA9_1_Bicycle)
                        {
                        }
                        field(TypeA9_1_Courtyard;TypeA9_1_Courtyard)
                        {
                        }
                }    
                group(Par3)
                {
                    Caption='Paragraph 3';
                    field(TypeA9_3_Taxes;TypeA9_3_Taxes)
                    {
                    }
                }
                group(Par4)
                {
                    Caption='Paragraph 4';
                    field(TypeA9_4_Deposit;TypeA9_4_DepMth)
                    {
                    }
                    field(TypeA9_4_PrepaidRent;TypeA9_4_PrePaidMth)
                    {
                    }
                }
                group(Par5)
                {
                    Caption = 'Paragraph 5';
                    field(TypeA9_5_LandlordHeat;TypeA9_5_LandlordHeat)
                    {
                    }
                    field(TypeA9_5_LNatgas;TypeA9_5_LNatgas)
                    {
                    }
                    field(TypeA9_5_lOil;TypeA9_5_lOil)
                    {
                    }
                    field(TypeA9_5_LEl;TypeA9_5_LEl)
                    {
                    }
                    field(TypeA9_5_LOther;TypeA9_5_LOther)
                    {
                    }
                    field(TypeA9_5_LOtherText;TypeA9_5_LOtherText)
                    {
                    }
                    field(TypeA9_5_TenantHeat;TypeA9_5_TenantHeat)
                    {
                    }
                    field(TypeA9_5_TEl;TypeA9_5_TEl)
                    {
                    }
                    field(TypeA9_5_Tgas;TypeA9_5_Tgas)
                    {
                    }
                    field(TypeA9_5_TOil;TypeA9_5_TOil)
                    {
                    }
                    field(TypeA9_5_TNatgas;TypeA9_5_TNatgas)
                    {
                    }
                    field(TypeA9_5_TOTher;TypeA9_5_TOTher)
                    {
                    }
                    field(TypeA9_5_TOtherText;TypeA9_5_TOtherText)
                    {
                    }
                    field(TypeA9_5_Water;TypeA9_5_Water)
                    {
                    }
                    field(TypeA9_5_WM;TypeA9_5_WM)
                    {
                    }
                    field(TypeA9_5_Wperiod;TypeA9_5_Wperiod)
                    {
                    }
                    field(TypeA9_5_El;TypeA9_5_El)
                    {
                    }
                    field(TypeA9_5_ElPeriod;TypeA9_5_ElPeriod)
                    {
                    }
                    field(TypeA9_5_Cooling;TypeA9_5_Cooling)
                    {
                    }
                    field(TypeA9_5_CM;TypeA9_5_CM)
                    {
                    }
                    field(TypeA9_5_CPeriod;TypeA9_5_CPeriod)
                    {
                    }
                }
                group(Par6)
                {
                    Caption='Paragraph 6';
                    field(TypeA9_6_TAntenna;TypeA9_6_TAntenna)
                    {
                    }
                    field(TypeA9_6_Internet;TypeA9_6_Internet)
                    {
                    }
                }
                group(Par8)
                {
                    Caption='Paragraph 8';
                    field(TypeA9_8_MainLandlord;TypeA9_8_MainLandlord)
                    {
                    }
                }
                group(Par10)
                {
                    Caption='Paragraph 10';
                    field(TypeA9_10_HouseStock;TypeA9_10_HouseStock)
                    {
                    }
                    field(TypeA9_10_Houserules;TypeA9_10_Houserules)
                    {
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
                    Image = "Report";
                    
                    trigger OnAction();
                    begin
                         IF Rec.HeatCompany = '' THEN BEGIN
                           MESSAGE('Denne ejendom har ikke varmeregnskab.');
                           EXIT;
                           END;
                         CLEAR(Occupant);
                         Occupant.SETRANGE(PropertyNo,Rec.Property);
                         CLEAR(Heatreport);
                         Heatreport.SETTABLEVIEW(Occupant);
                         Heatreport.RUNMODAL;
                    end;
                }
                action("Consumption Water")
                {
                    Caption='AC Water';
                    Image = "Report";
                    
                    trigger OnAction();
                    begin
                         IF Rec.WaterCompany = '' THEN BEGIN
                           MESSAGE('Denne ejendom har ikke vandregnskab.');
                           EXIT;
                           END;
                         CLEAR(Occupant);
                         Occupant.SETRANGE(PropertyNo,Rec.Property);
                         CLEAR(Waterreport);
                         Waterreport.SETTABLEVIEW(Occupant);
                         Waterreport.RUNMODAL;
                    end;
                }
                action("Consumption Electricity")
                {
                    Caption='AC Electricity';
                    Image = "Report";
                    
                    trigger OnAction();
                    begin
                         IF Rec.ElCompany = '' THEN BEGIN
                           MESSAGE('Denne ejendom har ikke el-regnskab.');
                           EXIT;
                           END;
                         CLEAR(Occupant);
                         Occupant.SETRANGE(PropertyNo,Rec.Property);
                         CLEAR(ElReport);
                         ElReport.SETTABLEVIEW(Occupant);
                         ElReport.RUNMODAL;
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
                         CLEAR(ManReport);
                         ManReport.SETTABLEVIEW(Occupant);
                         ManReport.RUNMODAL;
                    end;
                }
                action("Vacant tenancies")
                {
                    Caption='Vacant tenancies';
                    Image = "Report";
                  
                    trigger OnAction();
                    begin
                        CLEAR(TenancyRecords);
                        TenancyRecords.SETRANGE(TenancyRecords.PropertyNo,Rec.Property);
                        CLEAR(VacantTenancies);
                        VacantTenancies.SETTABLEVIEW(TenancyRecords);
                        VacantTenancies.RUNMODAL;
                    end;
                }
            }
            group(Lejereguleringer)
            {
                Caption='Regulations';
                action(Regulations)
                {
                    Caption='Rent regulations';
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

