report 50020 "SVA Moving out status"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Moving out status.rdlc';
    Caption = 'Moving out Status';

    dataset
    {
        dataitem("Movingout Status"; "SVA MovingOut Status")
        {
            DataItemTableView = SORTING (Occupant);
            RequestFilterFields = Occupant;

            column(Occupant_MovingOutStatus; Occupant)
            {
            }
            column(Name_MovingOutStatus; Name)
            {
            }
            column(Name2_MovingOutStatus; Name2)
            {
            }
            column(Addressnew_MovingOutStatus; "Address (new)")
            {
            }
            column(PostCode_MovingOutStatus; PostCode)
            {
            }
            column(City_MovingOutStatus; City)
            {
            }
            column(Phone; Phone)
            {
            }
            column(Email1; Email1)
            {
            }
            column(StartDate; StartDate)
            {
            }
            column(EndDate; EndDate)
            {
            }

            column(TenancyNo_MovingOutStatus; TenancyNo)
            {
            }
            column(TenancyAddress_MovingOutStatus; TenancyAddress)
            {
            }
            column(TenancyPostCode_MovingOutStatus; TenancyPostCode)
            {
            }
            column(TenancyCity_MovingOutStatus; TenancyCity)
            {
            }
            column(LandlordName_MovingOutStatus; LandlordName)
            {
            }
            column(landlordAddress_MovingOutStatus; landlordAddress)
            {
            }
            column(LandlordPostCode_MovingOutStatus; LandlordPostCode)
            {
            }
            column(Landlordcity_MovingOutStatus; Landlordcity)
            {
            }
            column(Representative_MovingOutStatus; Representative)
            {
            }
            column(BebrepProperty_MovingOutStatus; BebrepProperty)
            {
            }
            column(BebrepInd_MovingOutStatus; BebrepInd)
            {
            }
            column(BebrepTilstede_MovingOutStatus; BebrepTilstede)
            {
            }
            column(BebrepName_MovingOutStatus; BebrepName)
            {
            }
            column(BebrepEmail_MovingOutStatus; BebrepEmail)
            {
            }
            column(BebrepKopi_MovingOutStatus; BebrepKopi)
            {
            }
            column(Room1Description_MovingOutStatus; Room1Description)
            {
            }
            column(Rum1CeilingCondition_MovingOutStatus; Rum1CeilingCondition)
            {
            }
            column(Rum1CeilingRepairs_MovingOutStatus; Rum1CeilingRepairs)
            {
            }
            column(Rum1WallsCondition_MovingOutStatus; Rum1WallsCondition)
            {
            }
            column(Rum1WallsRepairs_MovingOutStatus; Rum1WallsRepairs)
            {
            }
            column(Rum1FloorsCondition_MovingOutStatus; Rum1FloorsCondition)
            {
            }
            column(Rum1FloorsRepairs_MovingOutStatus; Rum1FloorsRepairs)
            {
            }
            column(Rum1CarpetsCondition_MovingOutStatus; Rum1CarpetsCondition)
            {
            }
            column(Rum1CarpetsRepairs_MovingOutStatus; Rum1CarpetsRepairs)
            {
            }
            column(Rum1WoodworksCondition_MovingOutStatus; Rum1WoodworksCondition)
            {
            }
            column(Rum1WoodworksRepairs_MovingOutStatus; Rum1WoodworksRepairs)
            {
            }
            column(Rum1WindowsmvCondition_MovingOutStatus; Rum1WindowsmvCondition)
            {
            }
            column(Rum1WindowsRepairs_MovingOutStatus; Rum1WindowsRepairs)
            {
            }
            column(Rum1RadiatorCondition_MovingOutStatus; Rum1RadiatorCondition)
            {
            }
            column(Rum1RadiatorRepairs_MovingOutStatus; Rum1RadiatorRepairs)
            {
            }
            column(Rum1ElCondition_MovingOutStatus; Rum1ElCondition)
            {
            }
            column(Rum1ElRepairs_MovingOutStatus; Rum1ElRepairs)
            {
            }
            column(Rum1DoorsCondition_MovingOutStatus; Rum1DoorsCondition)
            {
            }
            column(Rum1DoorsRepairs_MovingOutStatus; Rum1DoorsRepairs)
            {
            }
            column(Room2Description_MovingOutStatus; Room2Description)
            {
            }
            column(Rum2CeilingCondition_MovingOutStatus; Rum2CeilingCondition)
            {
            }
            column(Rum2CeilingRepairs_MovingOutStatus; Rum2CeilingRepairs)
            {
            }
            column(Rum2WallsCondition_MovingOutStatus; Rum2WallsCondition)
            {
            }
            column(Rum2WallsRepairs_MovingOutStatus; Rum2WallsRepairs)
            {
            }
            column(Rum2FloorsCondition_MovingOutStatus; Rum2FloorsCondition)
            {
            }
            column(Rum2FloorsRepairs_MovingOutStatus; Rum2FloorsRepairs)
            {
            }
            column(Rum2CarpetsCondition_MovingOutStatus; Rum2CarpetsCondition)
            {
            }
            column(Rum2CarpetsRepairs_MovingOutStatus; Rum2CarpetsRepairs)
            {
            }
            column(Rum2WoodworksCondition_MovingOutStatus; Rum2WoodworksCondition)
            {
            }
            column(Rum2WoodworksRepairs_MovingOutStatus; Rum2WoodworksRepairs)
            {
            }
            column(Rum2WindowsmvCondition_MovingOutStatus; Rum2WindowsmvCondition)
            {
            }
            column(Rum2WindowsRepairs_MovingOutStatus; Rum2WindowsRepairs)
            {
            }
            column(Rum2RadiatorCondition_MovingOutStatus; Rum2RadiatorCondition)
            {
            }
            column(Rum2RadiatorRepairs_MovingOutStatus; Rum2RadiatorRepairs)
            {
            }
            column(Rum2ElCondition_MovingOutStatus; Rum2ElCondition)
            {
            }
            column(Rum2ElRepairs_MovingOutStatus; Rum2ElRepairs)
            {
            }
            column(Rum2DoorsCondition_MovingOutStatus; Rum2DoorsCondition)
            {
            }
            column(Rum2DoorsRepairs_MovingOutStatus; Rum2DoorsRepairs)
            {
            }
            column(Room3Description_MovingOutStatus; Room3Description)
            {
            }
            column(Rum3CeilingCondition_MovingOutStatus; Rum3CeilingCondition)
            {
            }
            column(Rum3CeilingRepairs_MovingOutStatus; Rum3CeilingRepairs)
            {
            }
            column(Rum3WallsCondition_MovingOutStatus; Rum3WallsCondition)
            {
            }
            column(Rum3WallsRepairs_MovingOutStatus; Rum3WallsRepairs)
            {
            }
            column(Rum3FloorsCondition_MovingOutStatus; Rum3FloorsCondition)
            {
            }
            column(Rum3FloorsRepairs_MovingOutStatus; Rum3FloorsRepairs)
            {
            }
            column(Rum3CarpetsCondition_MovingOutStatus; Rum3CarpetsCondition)
            {
            }
            column(Rum3CarpetsRepairs_MovingOutStatus; Rum3CarpetsRepairs)
            {
            }
            column(Rum3WoodworksCondition_MovingOutStatus; Rum3WoodworksCondition)
            {
            }
            column(Rum3WoodworksRepairs_MovingOutStatus; Rum3WoodworksRepairs)
            {
            }
            column(Rum3WindowsmvCondition_MovingOutStatus; Rum3WindowsmvCondition)
            {
            }
            column(Rum3WindowsRepairs_MovingOutStatus; Rum3WindowsRepairs)
            {
            }
            column(Rum3RadiatorCondition_MovingOutStatus; Rum3RadiatorCondition)
            {
            }
            column(Rum3RadiatorRepairs_MovingOutStatus; Rum3RadiatorRepairs)
            {
            }
            column(Rum3ElCondition_MovingOutStatus; Rum3ElCondition)
            {
            }
            column(Rum3ElRepairs_MovingOutStatus; Rum3ElRepairs)
            {
            }
            column(RumDoorsCondition_MovingOutStatus; Rum3DoorsCondition)
            {
            }
            column(Rum3DoorsRepairs_MovingOutStatus; Rum3DoorsRepairs)
            {
            }
            column(Room4Description_MovingOutStatus; Room4Description)
            {
            }
            column(Rum4CeilingCondition_MovingOutStatus; Rum4CeilingCondition)
            {
            }
            column(Rum4CeilingRepairs_MovingOutStatus; Rum4CeilingRepairs)
            {
            }
            column(Rum4WallsCondition_MovingOutStatus; Rum4WallsCondition)
            {
            }
            column(Rum4WallsRepairs_MovingOutStatus; Rum4WallsRepairs)
            {
            }
            column(Rum4FloorsCondition_MovingOutStatus; Rum4FloorsCondition)
            {
            }
            column(Rum4FloorsRepairs_MovingOutStatus; Rum4FloorsRepairs)
            {
            }
            column(Rum4CarpetsCondition_MovingOutStatus; Rum4CarpetsCondition)
            {
            }
            column(Rum4CarpetsRepairs_MovingOutStatus; Rum4CarpetsRepairs)
            {
            }
            column(Rum4WoodworksCondition_MovingOutStatus; Rum4WoodworksCondition)
            {
            }
            column(Rum4WoodworksRepairs_MovingOutStatus; Rum4WoodworksRepairs)
            {
            }
            column(Rum4WindowsmvCondition_MovingOutStatus; Rum4WindowsmvCondition)
            {
            }
            column(Rum4WindowsRepairs_MovingOutStatus; Rum4WindowsRepairs)
            {
            }
            column(Rum4RadiatorCondition_MovingOutStatus; Rum4RadiatorCondition)
            {
            }
            column(Rum4RadiatorRepairs_MovingOutStatus; Rum4RadiatorRepairs)
            {
            }
            column(Rum4ElCondition_MovingOutStatus; Rum4ElCondition)
            {
            }
            column(Rum4ElRepairs_MovingOutStatus; Rum4ElRepairs)
            {
            }
            column(Rum4DoorsCondition_MovingOutStatus; Rum4DoorsCondition)
            {
            }
            column(Rum4DoorsRepairs_MovingOutStatus; Rum4DoorsRepairs)
            {
            }
            column(EntreCeilingCondition_MovingOutStatus; EntreCeilingCondition)
            {
            }
            column(EntreCeilingRepairs_MovingOutStatus; EntreCeilingRepairs)
            {
            }
            column(EntreWallsCondition_MovingOutStatus; EntreWallsCondition)
            {
            }
            column(EntreWallsRepairs_MovingOutStatus; EntreWallsRepairs)
            {
            }
            column(EntreFloorsCondition_MovingOutStatus; EntreFloorsCondition)
            {
            }
            column(EntreFloorsRepairs_MovingOutStatus; EntreFloorsRepairs)
            {
            }
            column(EntreCarpetsCondition_MovingOutStatus; EntreCarpetsCondition)
            {
            }
            column(EntreCarpetsRepairs_MovingOutStatus; EntreCarpetsRepairs)
            {
            }
            column(EntreWoodworksCondition_MovingOutStatus; EntreWoodworksCondition)
            {
            }
            column(EntreWoodworksRepairs_MovingOutStatus; EntreWoodworksRepairs)
            {
            }
            column(EntreWindowsmvCondition_MovingOutStatus; EntreWindowsmvCondition)
            {
            }
            column(EntreWindowsRepairs_MovingOutStatus; EntreWindowsRepairs)
            {
            }
            column(EntreRadiatorCondition_MovingOutStatus; EntreRadiatorCondition)
            {
            }
            column(EntreRadiatorRepairs_MovingOutStatus; EntreRadiatorRepairs)
            {
            }
            column(EntreElCondition_MovingOutStatus; EntreElCondition)
            {
            }
            column(EntreElRepairs_MovingOutStatus; EntreElRepairs)
            {
            }
            column(EntreDoorsCondition_MovingOutStatus; EntreDoorsCondition)
            {
            }
            column(EntreDoorsRepairs_MovingOutStatus; EntreDoorsRepairs)
            {
            }
            column(KitchenCeilingCondition_MovingOutStatus; KitchenCeilingCondition)
            {
            }
            column(KitchenCeilingRepairs_MovingOutStatus; KitchenCeilingRepairs)
            {
            }
            column(KitchenWallsCondition_MovingOutStatus; KitchenWallsCondition)
            {
            }
            column(KitchenWallsRepairs_MovingOutStatus; KitchenWallsRepairs)
            {
            }
            column(KitchenFloorsCondition_MovingOutStatus; KitchenFloorsCondition)
            {
            }
            column(KitchenFloorsRepairs_MovingOutStatus; KitchenFloorsRepairs)
            {
            }
            column(KitchenCarpetsCondition_MovingOutStatus; KitchenCarpetsCondition)
            {
            }
            column(KitchenCarpetsRepairs_MovingOutStatus; KitchenCarpetsRepairs)
            {
            }
            column(KitchenWoodworksCondition_MovingOutStatus; KitchenWoodworksCondition)
            {
            }
            column(KitchenWoodworksRepairs_MovingOutStatus; KitchenWoodworksRepairs)
            {
            }
            column(KitchenWindowsmvCondition_MovingOutStatus; KitchenWindowsmvCondition)
            {
            }
            column(KitchenWindowsRepairs_MovingOutStatus; KitchenWindowsRepairs)
            {
            }
            column(KitchenRadiatorCondition_MovingOutStatus; KitchenRadiatorCondition)
            {
            }
            column(KitchenRadiatorRepairs_MovingOutStatus; KitchenRadiatorRepairs)
            {
            }
            column(KitchenElCondition_MovingOutStatus; KitchenElCondition)
            {
            }
            column(KitchenElRepairs_MovingOutStatus; KitchenElRepairs)
            {
            }
            column(KitchenDoorsCondition_MovingOutStatus; KitchenDoorsCondition)
            {
            }
            column(KitchenDoorsRepairs_MovingOutStatus; KitchenDoorsRepairs)
            {
            }
            column(KitchenTilesConditions_MovingOutStatus; KitchenTilesConditions)
            {
            }
            column(KitchenTilesRepairs_MovingOutStatus; KitchenTilesRepairs)
            {
            }
            column(KitchenTableCondition_MovingOutStatus; KitchenTableCondition)
            {
            }
            column(KitchenTableRepairs_MovingOutStatus; KitchenTableRepairs)
            {
            }
            column(KitchenSinkCondition_MovingOutStatus; KitchenSinkCondition)
            {
            }
            column(KitchensinkRepairs_MovingOutStatus; KitchensinkRepairs)
            {
            }
            column(KitchenCabinetsCondition_MovingOutStatus; KitchenCabinetsCondition)
            {
            }
            column(KitchenCabinetsRepairs_MovingOutStatus; KitchenCabinetsRepairs)
            {
            }
            column(KitchenWatertapsCondition_MovingOutStatus; KitchenWatertapsCondition)
            {
            }
            column(KitchenWatertapsRepairs_MovingOutStatus; KitchenWatertapsRepairs)
            {
            }
            column(BathroomCeilingCondition_MovingOutStatus; BathroomCeilingCondition)
            {
            }
            column(BathroomCeilingRepairs_MovingOutStatus; BathroomCeilingRepairs)
            {
            }
            column(BathroomWallsCondition_MovingOutStatus; BathroomWallsCondition)
            {
            }
            column(BathroomWallsRepairs_MovingOutStatus; BathroomWallsRepairs)
            {
            }
            column(BathroomFloorsCondition_MovingOutStatus; BathroomFloorsCondition)
            {
            }
            column(BathroomFloorsRepairs_MovingOutStatus; BathroomFloorsRepairs)
            {
            }
            column(BathroomCarpetsCondition_MovingOutStatus; BathroomCarpetsCondition)
            {
            }
            column(BathroomCarpetsRepairs_MovingOutStatus; BathroomCarpetsRepairs)
            {
            }
            column(BathroomWoodworksCondition_MovingOutStatus; BathroomWoodworksCondition)
            {
            }
            column(BathroomWoodworksRepairs_MovingOutStatus; BathroomWoodworksRepairs)
            {
            }
            column(BathroomWindowsmvCondition_MovingOutStatus; BathroomWindowsmvCondition)
            {
            }
            column(BathroomWindowsRepairs_MovingOutStatus; BathroomWindowsRepairs)
            {
            }
            column(BathroomRadiatorCondition_MovingOutStatus; BathroomRadiatorCondition)
            {
            }
            column(BathroomRadiatorRepairs_MovingOutStatus; BathroomRadiatorRepairs)
            {
            }
            column(BathroomElCondition_MovingOutStatus; BathroomElCondition)
            {
            }
            column(BathroomElRepairs_MovingOutStatus; BathroomElRepairs)
            {
            }
            column(BathroomDoorsCondition_MovingOutStatus; BathroomDoorsCondition)
            {
            }
            column(BathroomDoorsRepairs_MovingOutStatus; BathroomDoorsRepairs)
            {
            }
            column(BathroomSinkCondition_MovingOutStatus; BathroomSinkCondition)
            {
            }
            column(BathroomSinkRepairs_MovingOutStatus; BathroomSinkRepairs)
            {
            }
            column(BathroomCisternDoorsCondition_MovingOutStatus; BathroomCisternDoorsCondition)
            {
            }
            column(BathroomCisternRepairs_MovingOutStatus; BathroomCisternRepairs)
            {
            }
            column(BathroomToiletBowlCondition_MovingOutStatus; BathroomToiletBowlCondition)
            {
            }
            column(BathroomToiletBowlRepairs_MovingOutStatus; BathroomToiletBowlRepairs)
            {
            }
            column(BathroomBathtopCondition_MovingOutStatus; BathroomBathtopCondition)
            {
            }
            column(BathroombathTopRepairs_MovingOutStatus; BathroombathTopRepairs)
            {
            }
            column(BathroomShowerCondition_MovingOutStatus; BathroomShowerCondition)
            {
            }
            column(BathroomShowerRepairs_MovingOutStatus; BathroomShowerRepairs)
            {
            }
            column(BathroomWaterTapsCondition_MovingOutStatus; BathroomWaterTapsCondition)
            {
            }
            column(BathroomWaterTapsRepairs_MovingOutStatus; BathroomWaterTapsRepairs)
            {
            }
            column(ToiletCeilingCondition_MovingOutStatus; ToiletCeilingCondition)
            {
            }
            column(ToiletCeilingRepairs_MovingOutStatus; ToiletCeilingRepairs)
            {
            }
            column(ToiletWallsCondition_MovingOutStatus; ToiletWallsCondition)
            {
            }
            column(ToiletWallsRepairs_MovingOutStatus; ToiletWallsRepairs)
            {
            }
            column(ToiletFloorsCondition_MovingOutStatus; ToiletFloorsCondition)
            {
            }
            column(ToiletFloorsRepairs_MovingOutStatus; ToiletFloorsRepairs)
            {
            }
            column(ToiletCarpetsCondition_MovingOutStatus; ToiletCarpetsCondition)
            {
            }
            column(ToiletCarpetsRepairs_MovingOutStatus; ToiletCarpetsRepairs)
            {
            }
            column(ToiletWoodworksCondition_MovingOutStatus; ToiletWoodworksCondition)
            {
            }
            column(ToiletWoodworksRepairs_MovingOutStatus; ToiletWoodworksRepairs)
            {
            }
            column(ToiletWindowsmvCondition_MovingOutStatus; ToiletWindowsmvCondition)
            {
            }
            column(ToiletWindowsRepairs_MovingOutStatus; ToiletWindowsRepairs)
            {
            }
            column(ToiletRadiatorCondition_MovingOutStatus; ToiletRadiatorCondition)
            {
            }
            column(ToiletRadiatorRepairs_MovingOutStatus; ToiletRadiatorRepairs)
            {
            }
            column(ToiletElCondition_MovingOutStatus; ToiletElCondition)
            {
            }
            column(ToiletElRepairs_MovingOutStatus; ToiletElRepairs)
            {
            }
            column(ToiletDoorsCondition_MovingOutStatus; ToiletDoorsCondition)
            {
            }
            column(ToiletDoorsRepairs_MovingOutStatus; ToiletDoorsRepairs)
            {
            }
            column(ToiletSinkCondition_MovingOutStatus; ToiletSinkCondition)
            {
            }
            column(ToiletSinkRepairs_MovingOutStatus; ToiletSinkRepairs)
            {
            }
            column(ToiletCisternDoorsCondition_MovingOutStatus; ToiletCisternDoorsCondition)
            {
            }
            column(ToiletCisternRepairs_MovingOutStatus; ToiletCisternRepairs)
            {
            }
            column(ToiletToiletBowlCondition_MovingOutStatus; ToiletToiletBowlCondition)
            {
            }
            column(ToiletToiletBowlRepairs_MovingOutStatus; ToiletToiletBowlRepairs)
            {
            }
            column(ToiletwaterTapsCondition_MovingOutStatus; ToiletwaterTapsCondition)
            {
            }
            column(ToiletWaterTapsRepairs_MovingOutStatus; ToiletWaterTapsRepairs)
            {
            }
            column(StoveYear_MovingOutStatus; StoveYear)
            {
            }
            column(StoveManufactor_MovingOutStatus; StoveManufactor)
            {
            }
            column(StoveModel_MovingOutStatus; StoveModel)
            {
            }
            column(StoveCondition_MovingOutStatus; StoveCondition)
            {
            }
            column(StoveRepairs_MovingOutStatus; StoveRepairs)
            {
            }
            column(CookYear_MovingOutStatus; CookYear)
            {
            }
            column(CookManufactor_MovingOutStatus; CookManufactor)
            {
            }
            column(CookModel_MovingOutStatus; CookModel)
            {
            }
            column(CookCondition_MovingOutStatus; CookCondition)
            {
            }
            column(CookRepairs_MovingOutStatus; CookRepairs)
            {
            }
            column(OvenYear_MovingOutStatus; OvenYear)
            {
            }
            column(OvenManufactor_MovingOutStatus; OvenManufactor)
            {
            }
            column(OvenModel_MovingOutStatus; OvenModel)
            {
            }
            column(OvenCondition_MovingOutStatus; OvenCondition)
            {
            }
            column(OvenRepairs_MovingOutStatus; OvenRepairs)
            {
            }
            column(HoodYear_MovingOutStatus; HoodYear)
            {
            }
            column(HoodManufactor_MovingOutStatus; HoodManufactor)
            {
            }
            column(HoodStoveModel_MovingOutStatus; HoodStoveModel)
            {
            }
            column(HoodCondition_MovingOutStatus; HoodCondition)
            {
            }
            column(HoodeRepairs_MovingOutStatus; HoodeRepairs)
            {
            }
            column(FridgeYear_MovingOutStatus; FridgeYear)
            {
            }
            column(FridgeManufactor_MovingOutStatus; FridgeManufactor)
            {
            }
            column(FridgeModel_MovingOutStatus; FridgeModel)
            {
            }
            column(FridgeCondition_MovingOutStatus; FridgeCondition)
            {
            }
            column(FridgeRepairs_MovingOutStatus; FridgeRepairs)
            {
            }
            column(FreezerYear_MovingOutStatus; FreezerYear)
            {
            }
            column(FreezerManufactor_MovingOutStatus; FreezerManufactor)
            {
            }
            column(FreezerModel_MovingOutStatus; FreezerModel)
            {
            }
            column(FreezerCondition_MovingOutStatus; FreezerCondition)
            {
            }
            column(FreezerRepairs_MovingOutStatus; FreezerRepairs)
            {
            }
            column(DishwasherYear_MovingOutStatus; DishwasherYear)
            {
            }
            column(DishwasherManufactor_MovingOutStatus; DishwasherManufactor)
            {
            }
            column(DishwasherModel_MovingOutStatus; DishwasherModel)
            {
            }
            column(DishwasherCondition_MovingOutStatus; DishwasherCondition)
            {
            }
            column(DishwasherRepairs_MovingOutStatus; DishwasherRepairs)
            {
            }
            column(WasherYear_MovingOutStatus; WasherYear)
            {
            }
            column(WasherManufactor_MovingOutStatus; WasherManufactor)
            {
            }
            column(WasherModel_MovingOutStatus; WasherModel)
            {
            }
            column(WasherCondition_MovingOutStatus; WasherCondition)
            {
            }
            column(WasherRepairs_MovingOutStatus; WasherRepairs)
            {
            }
            column(DryerYear_MovingOutStatus; DryerYear)
            {
            }
            column(DryerManufactor_MovingOutStatus; DryerManufactor)
            {
            }
            column(DryerModel_MovingOutStatus; DryerModel)
            {
            }
            column(DryerCondition_MovingOutStatus; DryerCondition)
            {
            }
            column(DryerRepairs_MovingOutStatus; DryerRepairs)
            {
            }
            column(EntryPhoneYear_MovingOutStatus; EntryPhoneYear)
            {
            }
            column(EntryPhoneManufactor_MovingOutStatus; EntryPhoneManufactor)
            {
            }
            column(EntryPhoneModel_MovingOutStatus; EntryPhoneModel)
            {
            }
            column(EntryPhoneCondition_MovingOutStatus; EntryPhoneCondition)
            {
            }
            column(EntryPhoneRepairs_MovingOutStatus; EntryPhoneRepairs)
            {
            }
            column(AntennaCondition_MovingOutStatus; AntennaCondition)
            {
            }
            column(AntennaRepairs_MovingOutStatus; AntennaRepairs)
            {
            }
            column(KeyCondition_MovingOutStatus; KeyCondition)
            {
            }
            column(KeyRepairs_MovingOutStatus; KeyRepairs)
            {
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }
}

