page 50023 "SVA Tenancy Card"
{
    Caption = 'Tenancy';
    PageType = Card;
    SourceTable = "SVA Tenancy";

    layout
    {
        area(content)
        {
            group(Generelt)
            {
                field(PropertyNo; PropertyNo)
                {
                    ApplicationArea = All;
                }
                field(Number; Number)
                {
                    ApplicationArea = All;
                }
                field(Address1; Address1)
                {
                    ApplicationArea = All;
                }
                field(Address2; Address2)
                {
                    ApplicationArea = All;
                }
                field("Post Code"; "Post Code")
                {
                    ApplicationArea = All;
                }
                field(City; City)
                {
                    ApplicationArea = All;
                }
                field("Country/Region Code"; "Country/Region Code")
                {
                    ApplicationArea = All;
                }
                field(Type; Type)
                {
                    ApplicationArea = All;
                }
                field(PeriodYear; PeriodYear)
                {
                    ApplicationArea = All;
                }
                field(Rooms; Rooms)
                {
                    ApplicationArea = All;
                }
                field(AreaT; AreaTotal)
                {
                    ApplicationArea = All;
                }
                field(AreaLiv; AreaLiv)
                {
                    ApplicationArea = All;
                }
                field(AreaPro; AreaPro)
                {
                    ApplicationArea = All;
                }
            }
            group("Appliancies")
            {
                Caption = 'Appliancies';
                group("Stove")
                {
                    Caption = 'Stove';
                    field(StoveManufactor; StoveManufactor)
                    {
                        ApplicationArea = All;
                    }
                    field(StoveModel; StoveModel)
                    {
                        ApplicationArea = All;
                    }
                    field(StoveYear; StoveYear)
                    {
                        ApplicationArea = All;
                    }
                }
                group("Cook")
                {
                    Caption = 'Cook';
                    field(CookManufactor; CookManufactor)
                    {
                        ApplicationArea = All;
                    }
                    field(CookModel; CookModel)
                    {
                        ApplicationArea = All;
                    }
                    field(CookYear; CookYear)
                    {
                        ApplicationArea = All;
                    }
                }
                group(Oven)
                {
                    caption = 'Oven';
                    field(Ovenmanufactor; OvenManufactor)
                    {
                        ApplicationArea = All;
                    }
                    field(OvenModel; OvenModel)
                    {
                        ApplicationArea = All;
                    }
                    field(OvenYear; OvenYear)
                    {
                        ApplicationArea = All;
                    }
                }
                group("Hood")
                {
                    Caption = 'Hood';
                    field(HoodManufactor; HoodManufactor)
                    {
                        ApplicationArea = All;
                    }
                    field(HoodStoveModel; HoodStoveModel)
                    {
                        ApplicationArea = All;
                    }
                    field(HoodYear; HoodYear)
                    {
                        ApplicationArea = All;
                    }
                }
                group("Fridge")
                {
                    Caption = 'Fridge';
                    field(FridgeManufactor; FridgeManufactor)
                    {
                        ApplicationArea = All;
                    }
                    field(FridgeModel; FridgeModel)
                    {
                        ApplicationArea = All;
                    }
                    field(FridgeYear; FridgeYear)
                    {
                        ApplicationArea = All;
                    }
                }
                Group(Freezer)
                {
                    Caption = 'Freezer';
                    field(FreezerManufactor; FreezerManufactor)
                    {
                        ApplicationArea = All;
                    }
                    field(FreezerModel; FreezerModel)
                    {
                        ApplicationArea = All;
                    }
                    field(FreezerYear; FreezerYear)
                    {
                        ApplicationArea = All;
                    }
                }
                group(Dishwasher)
                {
                    Caption = 'Dishwasher';
                    field(DishwasherManufactor; DishwasherManufactor)
                    {
                        ApplicationArea = All;
                    }
                    field(DishwasherModel; DishwasherModel)
                    {
                        ApplicationArea = All;
                    }
                    field(DishwasherYear; DishwasherYear)
                    {
                        ApplicationArea = All;
                    }
                }
                group("Washer")
                {
                    Caption = 'Washer';
                    field(WasherManufactor; WasherManufactor)
                    {
                        ApplicationArea = All;
                    }
                    field(WasherModel; WasherModel)
                    {
                        ApplicationArea = All;
                    }
                    field(WasherYear; WasherYear)
                    {
                        ApplicationArea = All;
                    }
                }
                group("Dryer")
                {
                    Caption = 'Dryer';
                    field(DryerManufactor; DryerManufactor)
                    {
                        ApplicationArea = All;
                    }
                    field(DryerModel; DryerModel)
                    {
                        ApplicationArea = All;
                    }
                    field(DryerYear; DryerYear)
                    {
                        ApplicationArea = All;
                    }
                }

            }
            group("Type A")
            {
                Caption = 'Lease contract Type A';
                group("Paragraph 1")
                {
                    Caption = 'Paragraph 1';
                    field(TypeA9_1_Apartment; TypeA9_1_Apartment)
                    {
                        ApplicationArea = All;
                    }
                    field(TypeA9_1_Room; TypeA9_1_Room)
                    {
                        ApplicationArea = All;
                    }
                    field(TypeA9_1_Condominium; TypeA9_1_Condominium)
                    {
                        ApplicationArea = All;
                    }
                    field(TypeA9_1_HousingCoop; TypeA9_1_HousingCoop)
                    {
                        ApplicationArea = All;
                    }
                    field(TypeA9_1_OtherT; TypeA9_1_OtherT)
                    {
                        ApplicationArea = All;
                    }
                    field(TypeA9_1_OtherTTxt; TypeA9_1_OtherTTxt)
                    {
                        ApplicationArea = All;
                    }
                    field(TypeA9_1_Laundy; TypeA9_1_Laundy)
                    {
                        ApplicationArea = All;
                    }
                    field(TypeA9_1_BicycleStorage; TypeA9_1_BicycleStorage)
                    {
                        ApplicationArea = All;
                    }
                    field(TypeA9_1_Courtyard; TypeA9_1_Courtyard)
                    {
                        ApplicationArea = All;
                    }
                    field(TypeA9_1_Garage; TypeA9_1_Garage)
                    {
                        ApplicationArea = All;
                    }
                    field(TypeA9_1_GarageNo; TypeA9_1_GarageNo)
                    {
                        ApplicationArea = All;
                    }
                    field(TypeA9_1_Attic; TypeA9_1_Attic)
                    {
                        ApplicationArea = All;
                    }
                    field(TypeA9_1_AtticNo; TypeA9_1_AtticNo)
                    {
                        ApplicationArea = All;
                    }
                    field(TypeA9_1_Other; TypeA9_1_Other)
                    {
                        ApplicationArea = All;
                    }
                    field(TypeA9_1_OtherTxt; TypeA9_1_OtherTxt)
                    {
                        ApplicationArea = All;
                    }
                    field(TypeA9_1_Use; TypeA9_1_Use)
                    {
                        ApplicationArea = All;
                    }
                }
                group("Paragraf 4")
                {
                    Caption = 'Paragraph 4';
                    field(Deposit; Deposit)
                    {
                        ApplicationArea = All;
                    }
                    field(PrepaidRent; PrepaidRent)
                    {
                        ApplicationArea = All;
                    }
                }
                group("Paragraf 5")
                {
                    Caption = 'Paragraph 5';
                    field(TypeA9_5_LandlordHeat; TypeA9_5_LandlordHeat)
                    {
                        ApplicationArea = All;
                    }
                    field(TypeA9_5_LNatgas; TypeA9_5_LNatgas)
                    {
                        ApplicationArea = All;
                    }
                    field(TypeA9_5_lOil; TypeA9_5_lOil)
                    {
                        ApplicationArea = All;
                    }
                    field(TypeA9_5_LElHeat; TypeA9_5_LElHeat)
                    {
                        ApplicationArea = All;
                    }
                    field(TypeA9_5_LOther; TypeA9_5_LOther)
                    {
                        ApplicationArea = All;
                    }
                    field(TypeA9_5_LOtherText; TypeA9_5_LOtherText)
                    {
                        ApplicationArea = All;
                    }
                    field(TypeA9_5_TenantHeat; TypeA9_5_TenantHeat)
                    {
                        ApplicationArea = All;
                    }
                    field(TypeA9_5_Tgas; TypeA9_5_Tgas)
                    {
                        ApplicationArea = All;
                    }
                    field(TypeA9_5_TNatgas; TypeA9_5_TNatgas)
                    {
                        ApplicationArea = All;
                    }
                    field(TypeA9_5_TOil; TypeA9_5_TOil)
                    {
                        ApplicationArea = All;
                    }
                    field(TypeA9_5_TOTher; TypeA9_5_TOTher)
                    {
                        ApplicationArea = All;
                    }
                    field(TypeA9_5_TOtherText; TypeA9_5_TOtherText)
                    {
                        ApplicationArea = All;
                    }
                    field(TypeA9_5_LandlordWater; TypeA9_5_LandlordWater)
                    {
                        ApplicationArea = All;
                    }
                    field(TypeA9_5_WaterMeter; TypeA9_5_WaterMeter)
                    {
                        ApplicationArea = All;
                    }
                    field(TypeA9_5_LandlordEl; TypeA9_5_LandlordEl)
                    {
                        ApplicationArea = All;
                    }
                    field(TypeA9_5_LandlordCooling; TypeA9_5_LandlordCooling)
                    {
                        ApplicationArea = All;
                    }
                    field(TypeA9_5_CoolingMeter; TypeA9_5_CoolingMeter)
                    {
                        ApplicationArea = All;
                    }
                }
                group("Paragraf 6")
                {
                    Caption = 'Paragraph 6';
                    field(TypeA9_6_AntennaLandlord; TypeA9_6_AntennaLandlord)
                    {
                        ApplicationArea = All;
                    }
                    field(TypeA9_6_AntennaTenancies; TypeA9_6_AntennaTenancies)
                    {
                        ApplicationArea = All;
                    }
                    field(TypeA9_6_Internet; TypeA9_6_Internet)
                    {
                        ApplicationArea = All;
                    }
                }
                group(" Paragraf 7")
                {
                    Caption = 'Paragraph 7';
                    field(TypeA9_7_InspecionIn; TypeA9_7_InspecionIn)
                    {
                        ApplicationArea = All;
                    }
                }
                group("Paragraf 8")
                {
                    Caption = 'Paragraph 8';
                    field(TypeA9_8_MaintainceInsideTenan; TypeA9_8_MaintainceInsideTenan)
                    {
                        ApplicationArea = All;
                    }
                    field(TypeA9_8_MaintainceInsideLandl; TypeA9_8_MaintainceInsideLandl)
                    {
                        ApplicationArea = All;
                    }
                }
                group("Paragraf 9")
                {
                    Caption = 'Paragraph 9';
                    field(TypeA9_9_Stove; TypeA9_9_Stove)
                    {
                        ApplicationArea = All;
                    }
                    field(TypeA9_9_Fridge; TypeA9_9_Fridge)
                    {
                        ApplicationArea = All;
                    }
                    field(TypeA9_9_Freezer; TypeA9_9_Freezer)
                    {
                        ApplicationArea = All;
                    }
                    field(TypeA9_9_dishwasher; TypeA9_9_dishwasher)
                    {
                        ApplicationArea = All;
                    }
                    field(TypeA9_9_Washer; TypeA9_9_Washer)
                    {
                        ApplicationArea = All;
                    }
                    field(TypeA9_9_Dryer; TypeA9_9_Dryer)
                    {
                        ApplicationArea = All;
                    }
                    field(TypeA9_9_Hood; TypeA9_9_Hood)
                    {
                        ApplicationArea = All;
                    }
                    field(TypeA9_9_ElectricPanels; TypeA9_9_ElectricPanels)
                    {
                        ApplicationArea = All;
                    }
                    field(TypeA9_9_El_qty; TypeA9_9_El_qty)
                    {
                        ApplicationArea = All;
                    }
                    field(TypeA9_9_WaterHeater; TypeA9_9_WaterHeater)
                    {
                        ApplicationArea = All;
                    }
                    field(TypeA9_9_WaterHeater_qty; TypeA9_9_WaterHeater_qty)
                    {
                        ApplicationArea = All;
                    }
                    field(TypeA9_9_Other1; TypeA9_9_Other1)
                    {
                        ApplicationArea = All;
                    }
                    field(TypeA9_9_Other1Text; TypeA9_9_Other1Text)
                    {
                        ApplicationArea = All;
                    }
                    field(TypeA9_9_Other2; TypeA9_9_Other2)
                    {
                        ApplicationArea = All;
                    }
                    field(TypeA9_9_Other2Text; TypeA9_9_Other2Text)
                    {
                        ApplicationArea = All;
                    }
                    field(TypeA9_9_Other3; TypeA9_9_Other3)
                    {
                        ApplicationArea = All;
                    }
                    field(TypeA9_9_Other3Text; TypeA9_9_Other3Text)
                    {
                        ApplicationArea = All;
                    }
                }
                group("Paragraf 10")
                {
                    Caption = 'Paragraph 10';
                    field(TypeA9_10_TenRep; TypeA9_10_TenRep)
                    {
                        ApplicationArea = All;
                    }
                    field(TypeA9_10_LiveStock; TypeA9_10_LiveStock)
                    {
                        ApplicationArea = All;
                    }
                    field(TypeA9_10_HouseRules; TypeA9_10_HouseRules)
                    {
                        ApplicationArea = All;
                    }
                }
            }
            part("Opkrævningslinjer"; "SVA Subscription lines subform")
            {
                Caption = 'Subscription Lines';
                SubPageLink = Tenancies = FIELD(Number);
                SubPageView = SORTING(Tenancies, "Cost Types", "Date From", "Date To", KeyNumber)
                              ORDER(Ascending);
                ApplicationArea = All;
            }
        }
        area(factboxes)
        {
            part("Attached Documents"; 1174)
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(50002),
                              "No." = FIELD(Number);
                Visible = NOT IsOfficeAddin;
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
        area(Navigation)
        {
            action(Occupants)
            {
                ApplicationArea = all;
                Caption = 'Occupants';
                ToolTip = 'List of occupants in this tenancy.';
                Image = Customer;
                RunObject = Page "SVA Occupant List";
                RunPageLink = TenancyNo = FIELD(Number);
            }
            action(Dimensioner)
            {
                ApplicationArea = all;
                Caption = 'Dimensions';
                Image = Dimensions;
                RunObject = Page 540;
                RunPageLink = "Table ID" = CONST(50002),
                                  "No." = FIELD(Number);
                ShortCutKey = 'Shift+Ctrl+D';
                ToolTip = 'View or edits dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';
            }
        }
    }
    trigger OnOpenPage()
    var
        Officemanagement: Codeunit 1630;
    begin
        IsOfficeAddin := Officemanagement.IsAvailable()
    end;

    var
        IsOfficeAddin: Boolean;
}

