page 60522 "SVA Tenancy Card"
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
                }
                field(Number; Number)
                {
                }
                field(Address1; Address1)
                {
                }
                field(Address2; Address2)
                {
                }
                field("Post Code"; "Post Code")
                {
                }
                field(City; City)
                {
                }
                field("Country/Region Code"; "Country/Region Code")
                {
                }
                field(Type; Type)
                {
                }
                field(PeriodYear; PeriodYear)
                {
                }
                field(Rooms; Rooms)
                {
                }
                field(AreaT; AreaTotal)
                {
                }
                field(AreaLiv; AreaLiv)
                {
                }
                field(AreaPro; AreaPro)
                {
                }
            }
            group("Appliancies")
            {
                Caption = 'Appliancies';
                group("Stove")
                {
                    field(StoveManufactor; StoveManufactor)
                    {
                    }
                    field(StoveModel; StoveModel)
                    {
                    }
                    field(StoveYear; StoveYear)
                    {
                    }
                }
                group("Cook")
                {
                    Caption='Cook';
                    field(CookManufactor;CookManufactor)
                    {

                    }
                    field(CookModel;CookModel)
                    {

                    }
                    field(CookYear;CookYear)
                    {

                    }
                }
                group(Oven)
                {
                    caption='Oven';
                    field(Ovenmanufactor;OvenManufactor)
                    {
                    }
                    field(OvenModel;OvenModel)
                    {
                    }
                    field(OvenYear;OvenYear)
                    {
                    }
                }
                group("Hood")
                {
                    Caption='Hood';
                    field(HoodManufactor;HoodManufactor)
                    {

                    }
                    field(HoodStoveModel;HoodStoveModel)
                    {

                    }
                    field(HoodYear;HoodYear)
                    {

                    }
                }
                group("Fridge")
                {
                    Caption='Fridge';
                    field(FridgeManufactor;FridgeManufactor)
                    {

                    }
                    field(FridgeModel;FridgeModel)
                    {

                    }
                    field(FridgeYear;FridgeYear)
                    {

                    }
                }
                Group(Freezer)
                {
                    Caption='Freezer';
                    field(FreezerManufactor;FreezerManufactor)
                    {

                    }
                    field(FreezerModel;FreezerModel)
                    {

                    }
                    field(FreezerYear;FreezerYear)
                    {

                    }
                }
                group(Dishwasher)
                {
                    Caption='Dishwasher';
                    field(DishwasherManufactor;DishwasherManufactor)
                    {

                    }
                    field(DishwasherModel;DishwasherModel)
                    {

                    }
                    field(DishwasherYear;DishwasherYear)
                    {

                    }
                }
                group("Washer")
                {
                    Caption='Washer';
                    field(WasherManufactor;WasherManufactor)
                    {

                    }
                    field(WasherModel;WasherModel)
                    {

                    }
                    field(WasherYear;WasherYear)
                    {

                    }
                }
                group("Dryer")
                {
                    Caption='Dryer';
                    field(DryerManufactor;DryerManufactor)
                    {

                    }
                    field(DryerModel;DryerModel)
                    {

                    }
                    field(DryerYear;DryerYear)
                    {
                        
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
                    }
                    field(TypeA9_1_Room; TypeA9_1_Room)
                    {
                    }
                    field(TypeA9_1_Condominium; TypeA9_1_Condominium)
                    {
                    }
                    field(TypeA9_1_HousingCoop; TypeA9_1_HousingCoop)
                    {
                    }
                    field(TypeA9_1_OtherT; TypeA9_1_OtherT)
                    {
                    }
                    field(TypeA9_1_OtherTTxt; TypeA9_1_OtherTTxt)
                    {
                    }
                    field(TypeA9_1_Laundy; TypeA9_1_Laundy)
                    {
                    }
                    field(TypeA9_1_BicycleStorage; TypeA9_1_BicycleStorage)
                    {
                    }
                    field(TypeA9_1_Courtyard; TypeA9_1_Courtyard)
                    {
                    }
                    field(TypeA9_1_Garage; TypeA9_1_Garage)
                    {
                    }
                    field(TypeA9_1_GarageNo; TypeA9_1_GarageNo)
                    {
                    }
                    field(TypeA9_1_Attic; TypeA9_1_Attic)
                    {
                    }
                    field(TypeA9_1_AtticNo; TypeA9_1_AtticNo)
                    {
                    }
                    field(TypeA9_1_Other; TypeA9_1_Other)
                    {
                    }
                    field(TypeA9_1_OtherTxt; TypeA9_1_OtherTxt)
                    {
                    }
                    field(TypeA9_1_Use; TypeA9_1_Use)
                    {
                    }
                }
                group("Paragraf 4")
                {
                    Caption = 'Paragraph 4';
                    field(Deposit; Deposit)
                    {
                    }
                    field(PrepaidRent; PrepaidRent)
                    {
                    }
                }
                group("Paragraf 5")
                {
                    Caption = 'Paragraph 5';
                    field(TypeA9_5_LandlordHeat; TypeA9_5_LandlordHeat)
                    {
                    }
                    field(TypeA9_5_LNatgas; TypeA9_5_LNatgas)
                    {
                    }
                    field(TypeA9_5_lOil; TypeA9_5_lOil)
                    {
                    }
                    field(TypeA9_5_LElHeat; TypeA9_5_LElHeat)
                    {
                    }
                    field(TypeA9_5_LOther; TypeA9_5_LOther)
                    {
                    }
                    field(TypeA9_5_LOtherText; TypeA9_5_LOtherText)
                    {
                    }
                    field(TypeA9_5_LandlordWater; TypeA9_5_LandlordWater)
                    {
                    }
                    field(TypeA9_5_WaterMeter; TypeA9_5_WaterMeter)
                    {
                    }
                    field(TypeA9_5_LandlordEl; TypeA9_5_LandlordEl)
                    {
                    }
                    field(TypeA9_5_LandlordCooling; TypeA9_5_LandlordCooling)
                    {
                    }
                    field(TypeA9_5_CoolingMeter; TypeA9_5_CoolingMeter)
                    {
                    }
                }
                group("Paragraf 6")
                {
                    Caption = 'Paragraph 6';
                    field(TypeA9_6_AntennaLandlord; TypeA9_6_AntennaLandlord)
                    {
                    }
                    field(TypeA9_6_AntennaTenancies; TypeA9_6_AntennaTenancies)
                    {
                    }
                    field(TypeA9_6_Internet; TypeA9_6_Internet)
                    {
                    }
                }
                group(" Paragraf 7")
                {
                    Caption = 'Paragraph 7';
                    field(TypeA9_7_InspecionIn; TypeA9_7_InspecionIn)
                    {
                    }
                }
                group("Paragraf 8")
                {
                    Caption = 'Paragraph 8';
                    field(TypeA9_8_MaintainceInsideTenan; TypeA9_8_MaintainceInsideTenan)
                    {
                    }
                    field(TypeA9_8_MaintainceInsideLandl; TypeA9_8_MaintainceInsideLandl)
                    {
                    }
                }
                group("Paragraf 9")
                {
                    Caption = 'Paragraph 9';
                    field(TypeA9_9_Stove; TypeA9_9_Stove)
                    {
                    }
                    field(TypeA9_9_Fridge; TypeA9_9_Fridge)
                    {
                    }
                    field(TypeA9_9_Freezer; TypeA9_9_Freezer)
                    {
                    }
                    field(TypeA9_9_dishwasher; TypeA9_9_dishwasher)
                    {
                    }
                    field(TypeA9_9_Washer; TypeA9_9_Washer)
                    {
                    }
                    field(TypeA9_9_Dryer; TypeA9_9_Dryer)
                    {
                    }
                    field(TypeA9_9_Hood; TypeA9_9_Hood)
                    {
                    }
                    field(TypeA9_9_ElectricPanels; TypeA9_9_ElectricPanels)
                    {
                    }
                    field(TypeA9_9_El_qty; TypeA9_9_El_qty)
                    {
                    }
                    field(TypeA9_9_WaterHeater; TypeA9_9_WaterHeater)
                    {
                    }
                    field(TypeA9_9_WaterHeater_qty; TypeA9_9_WaterHeater_qty)
                    {
                    }
                    field(TypeA9_9_Other1; TypeA9_9_Other1)
                    {
                    }
                    field(TypeA9_9_Other1Text; TypeA9_9_Other1Text)
                    {
                    }
                    field(TypeA9_9_Other2; TypeA9_9_Other2)
                    {
                    }
                    field(TypeA9_9_Other2Text; TypeA9_9_Other2Text)
                    {
                    }
                    field(TypeA9_9_Other3; TypeA9_9_Other3)
                    {
                    }
                    field(TypeA9_9_Other3Text; TypeA9_9_Other3Text)
                    {
                    }
                }
                group("Paragraf 10")
                {
                    Caption = 'Paragraph 10';
                    field(TypeA9_10_TenRep; TypeA9_10_TenRep)
                    {
                    }
                    field(TypeA9_10_LiveStock; TypeA9_10_LiveStock)
                    {
                    }
                    field(TypeA9_10_HouseRules; TypeA9_10_HouseRules)
                    {
                    }
                }
            }
            part("Opkrævningslinjer"; 60560)
            {
                Caption = 'Subscription Lines';
                SubPageLink = Tenancies = FIELD (Number);
                SubPageView = SORTING (Tenancies, "Cost Types", "Date From", "Date To", KeyNumber)
                              ORDER(Ascending);
            }
        }
        area(factboxes)
        {
            systempart(Notes; Notes)
            {
            }
            systempart(Links; Links)
            {
            }
        }
    }

    actions
    {
    }
}

