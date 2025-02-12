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
                field(PropertyNo; Rec.PropertyNo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Property No.';
                }
                field(Number; Rec.Number)
                {
                    ApplicationArea = All;
                    ToolTip = 'Tenancy No.';
                }
                field(Address1; Rec.Address1)
                {
                    ApplicationArea = All;
                    Tooltip = 'Address';
                }
                field(Address2; Rec.Address2)
                {
                    ApplicationArea = All;
                    Tooltip = 'Address 2';
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;
                    Tooltip = 'Postcode';
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                    Tooltip = 'City';
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ApplicationArea = All;
                    Tooltip = 'Country/region code';
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    Tooltip = 'Type of rent';
                }
                field(PeriodYear; Rec.PeriodYear)
                {
                    ApplicationArea = All;
                    Tooltip = 'Periods';
                }
                field(Rooms; Rec.Rooms)
                {
                    ApplicationArea = All;
                    Tooltip = 'Rooms incl. livingroom';
                }
                field(AreaT; Rec.AreaTotal)
                {
                    ApplicationArea = All;
                    Tooltip = 'Area';
                }
                field(AreaLiv; Rec.AreaLiv)
                {
                    ApplicationArea = All;
                    Tooltip = 'Living area';
                }
                field(AreaPro; Rec.AreaPro)
                {
                    ApplicationArea = All;
                    Tooltip = 'Commercial area';
                }
            }
            group("Appliancies")
            {
                Caption = 'Appliancies';
                group("Stove")
                {
                    Caption = 'Stove';
                    field(StoveManufactor; Rec.StoveManufactor)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Manufactor';
                    }
                    field(StoveModel; Rec.StoveModel)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Model code';
                    }
                    field(StoveYear; Rec.StoveYear)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Production year';
                    }
                }
                group("Cook")
                {
                    Caption = 'Cook';
                    field(CookManufactor; Rec.CookManufactor)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Manufactor';
                    }
                    field(CookModel; Rec.CookModel)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Model code';
                    }
                    field(CookYear; Rec.CookYear)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Production year';
                    }
                }
                group(Oven)
                {
                    Caption = 'Oven';
                    field(Ovenmanufactor; Rec.OvenManufactor)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Manufactor';
                    }
                    field(OvenModel; Rec.OvenModel)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Model code';
                    }
                    field(OvenYear; Rec.OvenYear)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Production year';
                    }
                }
                group("Hood")
                {
                    Caption = 'Hood';
                    field(HoodManufactor; Rec.HoodManufactor)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Manufactor';
                    }
                    field(HoodStoveModel; Rec.HoodStoveModel)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Model code';
                    }
                    field(HoodYear; Rec.HoodYear)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Production year';
                    }
                }
                group("Fridge")
                {
                    Caption = 'Fridge';
                    field(FridgeManufactor; Rec.FridgeManufactor)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Manufactor';
                    }
                    field(FridgeModel; Rec.FridgeModel)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Model code';
                    }
                    field(FridgeYear; Rec.FridgeYear)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Production year';
                    }
                }
                Group(Freezer)
                {
                    Caption = 'Freezer';
                    field(FreezerManufactor; Rec.FreezerManufactor)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Manufactor';
                    }
                    field(FreezerModel; Rec.FreezerModel)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Model code';
                    }
                    field(FreezerYear; Rec.FreezerYear)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Production year';
                    }
                }
                group(Dishwasher)
                {
                    Caption = 'Dishwasher';
                    field(DishwasherManufactor; Rec.DishwasherManufactor)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Manufactor';
                    }
                    field(DishwasherModel; Rec.DishwasherModel)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Model code';
                    }
                    field(DishwasherYear; Rec.DishwasherYear)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Production year';
                    }
                }
                group("Washer")
                {
                    Caption = 'Washer';
                    field(WasherManufactor; Rec.WasherManufactor)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Manufactor';
                    }
                    field(WasherModel; Rec.WasherModel)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Model code';
                    }
                    field(WasherYear; Rec.WasherYear)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Production year';
                    }
                }
                group("Dryer")
                {
                    Caption = 'Dryer';
                    field(DryerManufactor; Rec.DryerManufactor)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Manufactor';
                    }
                    field(DryerModel; Rec.DryerModel)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Model code';
                    }
                    field(DryerYear; Rec.DryerYear)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Production year';
                    }
                }

            }
            group("Type A")
            {
                Caption = 'Lease contract Type A';
                group("Paragraph 1")
                {
                    Caption = 'Paragraph 1';
                    field(TypeA9_1_Apartment; Rec.TypeA9_1_Apartment)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Apartment';
                    }
                    field(TypeA9_1_Room; Rec.TypeA9_1_Room)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Room';
                    }
                    field(TypeA9_1_Condominium; Rec.TypeA9_1_Condominium)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Condeminium';
                    }
                    field(TypeA9_1_HousingCoop; Rec.TypeA9_1_HousingCoop)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Housing cooperative';
                    }
                    field(TypeA9_1_OtherT; Rec.TypeA9_1_OtherT)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Other type of tenancy';
                    }
                    field(TypeA9_1_OtherTTxt; Rec.TypeA9_1_OtherTTxt)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Kind of tenancy';
                    }
                    field(TypeA9_1_Laundy; Rec.TypeA9_1_Laundy)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Is there access to a laundry';
                    }
                    field(TypeA9_1_BicycleStorage; Rec.TypeA9_1_BicycleStorage)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Is there access to bicyclestorage?';
                    }
                    field(TypeA9_1_Courtyard; Rec.TypeA9_1_Courtyard)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Is there access to a courtyard?';
                    }
                    field(TypeA9_1_Garage; Rec.TypeA9_1_Garage)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Is there a garage';
                    }
                    field(TypeA9_1_GarageNo; Rec.TypeA9_1_GarageNo)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Garage no.';
                    }
                    field(TypeA9_1_Attic; Rec.TypeA9_1_Attic)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Is there access to atticroom og basementroom?';
                    }
                    field(TypeA9_1_AtticNo; Rec.TypeA9_1_AtticNo)
                    {
                        ApplicationArea = All;
                        Tooltip = 'No. on atticroom og basemantroom';
                    }
                    field(TypeA9_1_Other; Rec.TypeA9_1_Other)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Other to use';
                    }
                    field(TypeA9_1_OtherTxt; Rec.TypeA9_1_OtherTxt)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Description';
                    }
                    field(TypeA9_1_Use; Rec.TypeA9_1_Use)
                    {
                        ApplicationArea = All;
                        Tooltip = 'What can the lease be uset for';
                    }
                }
                group("Paragraf 4")
                {
                    Caption = 'Paragraph 4';
                    field(Deposit; Rec.Deposit)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Month deposit';
                    }
                    field(PrepaidRent; Rec.PrepaidRent)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Month prepaid rent';
                    }
                }
                group("Paragraf 5")
                {
                    Caption = 'Paragraph 5';
                    field(TypeA9_5_LandlordHeat; Rec.TypeA9_5_LandlordHeat)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Landlord deliver heat';
                    }
                    field(TypeA9_5_LNatgas; Rec.TypeA9_5_LNatgas)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Natural gas';
                    }
                    field(TypeA9_5_lOil; Rec.TypeA9_5_lOil)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Oil';
                    }
                    field(TypeA9_5_LElHeat; Rec.TypeA9_5_LElHeat)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Electric heat';
                    }
                    field(TypeA9_5_LOther; Rec.TypeA9_5_LOther)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Other';
                    }
                    field(TypeA9_5_LOtherText; Rec.TypeA9_5_LOtherText)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Description';
                    }
                    field(TypeA9_5_TenantHeat; Rec.TypeA9_5_TenantHeat)
                    {
                        ApplicationArea = All;
                        Tooltip = 'tTe tenant takes care of the heat';
                    }
                    field(TypeA9_5_Tgas; Rec.TypeA9_5_Tgas)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Gas';
                    }
                    field(TypeA9_5_TNatgas; Rec.TypeA9_5_TNatgas)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Natural gas';
                    }
                    field(TypeA9_5_TOil; Rec.TypeA9_5_TOil)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Oil';
                    }
                    field(TypeA9_5_TOTher; Rec.TypeA9_5_TOTher)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Other';
                    }
                    field(TypeA9_5_TOtherText; Rec.TypeA9_5_TOtherText)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Description';
                    }
                    field(TypeA9_5_LandlordWater; Rec.TypeA9_5_LandlordWater)
                    {
                        ApplicationArea = All;
                        Tooltip = 'The landlord provides water for the lease';
                    }
                    field(TypeA9_5_WaterMeter; Rec.TypeA9_5_WaterMeter)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Watermeter';
                    }
                    field(TypeA9_5_LandlordEl; Rec.TypeA9_5_LandlordEl)
                    {
                        ApplicationArea = All;
                        Tooltip = 'The landlord provides electricity for the lease';
                    }
                    field(TypeA9_5_LandlordCooling; Rec.TypeA9_5_LandlordCooling)
                    {
                        ApplicationArea = All;
                        Tooltip = 'The landlord provides cooling for the lease';
                    }
                    field(TypeA9_5_CoolingMeter; Rec.TypeA9_5_CoolingMeter)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Coolingmeter';
                    }
                }
                group("Paragraf 6")
                {
                    Caption = 'Paragraph 6';
                    field(TypeA9_6_AntennaLandlord; Rec.TypeA9_6_AntennaLandlord)
                    {
                        ApplicationArea = All;
                        Tooltip = 'The landlord provides a common signal supply, to which the tenant must pay a contribution';
                    }
                    field(TypeA9_6_AntennaTenancies; Rec.TypeA9_6_AntennaTenancies)
                    {
                        ApplicationArea = All;
                        Tooltip = 'The tenants´ antenna association in the property provides a common signal supply';
                    }
                    field(TypeA9_6_Internet; Rec.TypeA9_6_Internet)
                    {
                        ApplicationArea = All;
                        Tooltip = 'The landlord provides access for internet';
                    }
                }
                group(" Paragraf 7")
                {
                    Caption = 'Paragraph 7';
                    field(TypeA9_7_InspecionIn; Rec.TypeA9_7_InspecionIn)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Is / is the condition of the tenancy determined by a move-in inspection?';
                    }
                }
                group("Paragraf 8")
                {
                    Caption = 'Paragraph 8';
                    field(TypeA9_8_MaintainceInsideTenan; Rec.TypeA9_8_MaintainceInsideTenan)
                    {
                        ApplicationArea = All;
                        Tooltip = 'The interior maintenance of the lease is for the tenant';
                    }
                    field(TypeA9_8_MaintainceInsideLandl; Rec.TypeA9_8_MaintainceInsideLandl)
                    {
                        ApplicationArea = All;
                        Tooltip = 'The interior maintenance of the lease is for the landlord';
                    }
                }
                group("Paragraf 9")
                {
                    Caption = 'Paragraph 9';
                    field(TypeA9_9_Stove; Rec.TypeA9_9_Stove)
                    {
                        ApplicationArea = All;
                        Tooltip = 'In the tenancy, is there a stove';
                    }
                    field(TypeA9_9_Fridge; Rec.TypeA9_9_Fridge)
                    {
                        ApplicationArea = All;
                        Tooltip = 'In the tenancy, is there a fridge';
                    }
                    field(TypeA9_9_Freezer; Rec.TypeA9_9_Freezer)
                    {
                        ApplicationArea = All;
                        Tooltip = 'In the tenancy, is there a freezer';
                    }
                    field(TypeA9_9_dishwasher; Rec.TypeA9_9_dishwasher)
                    {
                        ApplicationArea = All;
                        Tooltip = 'In the tenancy, is there a dishwasher';
                    }
                    field(TypeA9_9_Washer; Rec.TypeA9_9_Washer)
                    {
                        ApplicationArea = All;
                        Tooltip = 'In the tenancy, is there a washer';
                    }
                    field(TypeA9_9_Dryer; Rec.TypeA9_9_Dryer)
                    {
                        ApplicationArea = All;
                        Tooltip = 'In the tenancy, is there a dryer';
                    }
                    field(TypeA9_9_Hood; Rec.TypeA9_9_Hood)
                    {
                        ApplicationArea = All;
                        Tooltip = 'In the tenancy, is there a hood';
                    }
                    field(TypeA9_9_ElectricPanels; Rec.TypeA9_9_ElectricPanels)
                    {
                        ApplicationArea = All;
                        Tooltip = 'In the tenancy, is there electric panels';
                    }
                    field(TypeA9_9_El_qty; Rec.TypeA9_9_El_qty)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Qty of panels';
                    }
                    field(TypeA9_9_WaterHeater; Rec.TypeA9_9_WaterHeater)
                    {
                        ApplicationArea = All;
                        Tooltip = 'In the tenancy, is there a waterheater';
                    }
                    field(TypeA9_9_WaterHeater_qty; Rec.TypeA9_9_WaterHeater_qty)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Qty of waterheater';
                    }
                    field(TypeA9_9_Other1; Rec.TypeA9_9_Other1)
                    {
                        ApplicationArea = All;
                        Tooltip = 'In the tenancy, is there anything else';
                    }
                    field(TypeA9_9_Other1Text; Rec.TypeA9_9_Other1Text)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Description';
                    }
                    field(TypeA9_9_Other2; Rec.TypeA9_9_Other2)
                    {
                        ApplicationArea = All;
                        Tooltip = 'In the tenancy, is there anything else';
                    }
                    field(TypeA9_9_Other2Text; Rec.TypeA9_9_Other2Text)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Description';
                    }
                    field(TypeA9_9_Other3; Rec.TypeA9_9_Other3)
                    {
                        ApplicationArea = All;
                        Tooltip = 'In the tenancy, is there anything else';
                    }
                    field(TypeA9_9_Other3Text; Rec.TypeA9_9_Other3Text)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Description';
                    }
                }
                group("Paragraf 10")
                {
                    Caption = 'Paragraph 10';
                    field(TypeA9_10_TenRep; Rec.TypeA9_10_TenRep)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Are there tenant representative in the property?';
                    }
                    field(TypeA9_10_LiveStock; Rec.TypeA9_10_LiveStock)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Are livestock allowed?';
                    }
                    field(TypeA9_10_HouseRules; Rec.TypeA9_10_HouseRules)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Is the houserules handed out?';
                    }
                }
            }
            part("Opkrævningslinjer"; "SVA Subscription lines subform")
            {
                Caption = 'Subscription Lines';
                SubPageLink = Tenancies = FIELD(Number);
                SubPageView = SORTING(Tenancies, order, "Date From")
                              ORDER(Descending);
                ApplicationArea = All;
            }
        }
        area(factboxes)
        {
            part("Document Attachment Factbox"; "Document Attachment Factbox")
            {
                Caption = 'Attachments';
                ApplicationArea = all;
                SubPageLink = "Table ID" = Const(50002), "No." = field(Number);
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
            action(Attachments)
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                Image = Attach;
                ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';

                trigger OnAction()
                var
                    DocumentAttachmentDetails: Page "Document Attachment Details";
                    RecRef: RecordRef;
                begin
                    RecRef.GetTable(Rec);
                    DocumentAttachmentDetails.OpenForRecRef(RecRef);
                    DocumentAttachmentDetails.RunModal();
                end;
            }
        }
    }


    trigger OnOpenPage()
    var
        OfficeManagement: Codeunit "Office Management";
    begin
        IsOfficeAddin := Officemanagement.IsAvailable()
    end;

    var
        IsOfficeAddin: Boolean;
}

