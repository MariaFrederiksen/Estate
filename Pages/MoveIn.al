page 50110 "SVA MoveIn"
//Tooltip created
{
    PageType = Card;
    SourceTable = "SVA MovingIn Status";
    Caption = 'Moving in status';
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(Occupant; Occupant)
                {

                    ToolTip = 'Occupant';
                }
                field(Name; Name)
                {

                    Tooltip = 'Tenant name';
                }
                field(Name2; Name2)
                {

                    Tooltip = 'Tenant name, if more than one tenant';
                }
                field("Address"; "Address (new)")
                {

                    Tooltip = 'Inovice address';
                }
                field(PostCode; PostCode)
                {

                    Tooltip = 'Tenant postcode';
                }
                field(City; City)
                {

                    Tooltip = 'Tenant city';
                }
                field(TenancyNo; TenancyNo)
                {
                    NotBlank = true;
                    Tooltip = 'Tenancy no.';
                }
                field(TenancyAddress; TenancyAddress)
                {

                    Tooltip = 'Teanancy address';
                }
                field(TenancyPostCode; TenancyPostCode)
                {

                    Tooltip = 'Tenancy postcode';
                }
                field(TenancyCity; TenancyCity)
                {

                    Tooltip = 'Tenancy city';
                }
                field(LandlordName; LandlordName)
                {

                    Tooltip = 'Name of landlord';
                }
                field(landlordAddress; landlordAddress)
                {

                    Tooltip = 'Landlord address';
                }
                field(LandlordPostCode; LandlordPostCode)
                {

                    Tooltip = 'Landlord postcode';
                }
                field(Landlordcity; Landlordcity)
                {

                    Tooltip = 'Landlord city';
                }
                field(Representative; Representative)
                {

                    Tooltip = 'Landlords reprensentavie name';
                }
                field(BebrepProperty; BebrepProperty)
                {

                    Tooltip = 'Has the property a tenantgroup';
                }
                field(BebrepInd; BebrepInd)
                {

                    Tooltip = 'Is tenantgroup representative summoned?';
                }
                field(BebrepTilstede; BebrepTilstede)
                {

                    Tooltip = 'Is tentant representative present?';
                }
                field(BebrepName; BebrepName)
                {

                    Tooltip = 'Tentant representatives name?';

                }
                field(BebrepEmail; BebrepEmail)
                {

                    Tooltip = 'Tenant representatives email';
                }
                field(BebrepKopi; BebrepKopi)
                {

                    Tooltip = 'Has tenant representative got a copy of this document?';
                }
            }
            group("Room 1")
            {
                Caption = 'Room 1';
                field(Room1Description; Room1Description)
                {

                    Tooltip = 'Unique identifing of the room';
                }
                field(Rum1CeilingCondition; Rum1CeilingCondition)
                {
                    Tooltip = 'What is the condition of the ceiling?';
                }
                field(Rum1CeilingRepairs; Rum1CeilingRepairs)
                {
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Rum1WallsCondition; Rum1WallsCondition)
                {

                    Tooltip = 'What is the condition of the walls?';
                }

                field(Rum1WallsRepairs; Rum1WallsRepairs)
                {

                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Rum1FloorsCondition; Rum1FloorsCondition)
                {

                    Tooltip = 'What is the condition of the floor?';
                }
                field(Rum1FloorsRepairs; Rum1FloorsRepairs)
                {

                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Rum1CarpetsCondition; Rum1CarpetsCondition)
                {

                    Tooltip = 'What is the condition of the carpets?';
                }
                field(Rum1CarpetsRepairs; Rum1CarpetsRepairs)
                {

                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Rum1WoodworksCondition; Rum1WoodworksCondition)
                {

                    Tooltip = 'What is the condition of the woodwork?';
                }
                field(Rum1WoodworksRepairs; Rum1WoodworksRepairs)
                {

                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Rum1WindowsmvCondition; Rum1WindowsmvCondition)
                {

                    Tooltip = 'What is the condition of the windows etc.?';
                }
                field(Rum1WindowsRepairs; Rum1WindowsRepairs)
                {

                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Rum1RadiatorCondition; Rum1RadiatorCondition)
                {

                    Tooltip = 'What is the condition of the radiators?';
                }
                field(Rum1RadiatorRepairs; Rum1RadiatorRepairs)
                {

                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Rum1ElCondition; Rum1ElCondition)
                {

                    Tooltip = 'What is the condition of electricity parts?';
                }
                field(Rum1ElRepairs; Rum1ElRepairs)
                {

                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Rum1DoorsCondition; Rum1DoorsCondition)
                {

                    Tooltip = 'What is the condition of doors?';
                }
                field(Rum1DoorsRepairs; Rum1DoorsRepairs)
                {

                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
            }
            group("Room 2")
            {
                Caption = 'Room 2';
                field(Room2Description; Room2Description)
                {

                    Tooltip = 'Unique identifing of the room';
                }
                field(Rum2CeilingCondition; Rum2CeilingCondition)
                {
                    Tooltip = 'What is the condition of the ceiling?';
                }
                field(Rum2CeilingRepairs; Rum2CeilingRepairs)
                {
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Rum2WallsCondition; Rum2WallsCondition)
                {
                    Tooltip = 'What is the condition of the walls?';
                }
                field(Rum2WallsRepairs; Rum2WallsRepairs)
                {
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Rum2FloorsCondition; Rum2FloorsCondition)
                {
                    Tooltip = 'What is the condition of the floor?';
                }
                field(Rum2FloorsRepairs; Rum2FloorsRepairs)
                {
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Rum2CarpetsCondition; Rum2CarpetsCondition)
                {
                    Tooltip = 'What is the condition of the carpets?';
                }
                field(Rum2CarpetsRepairs; Rum2CarpetsRepairs)
                {
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Rum2WoodworksCondition; Rum2WoodworksCondition)
                {
                    Tooltip = 'What is the condition of the woodwork?';
                }
                field(Rum2WoodworksRepairs; Rum2WoodworksRepairs)
                {
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Rum2WindowsmvCondition; Rum2WindowsmvCondition)
                {
                    Tooltip = 'What is the condition of the windows etc.?';
                }
                field(Rum2WindowsRepairs; Rum2WindowsRepairs)
                {
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Rum2RadiatorCondition; Rum2RadiatorCondition)
                {
                    Tooltip = 'What is the condition of the radiators?';
                }
                field(Rum2RadiatorRepairs; Rum2RadiatorRepairs)
                {
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Rum2ElCondition; Rum2ElCondition)
                {
                    Tooltip = 'What is the condition of electricity parts?';
                }
                field(Rum2ElRepairs; Rum2ElRepairs)
                {
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Rum2DoorsCondition; Rum2DoorsCondition)
                {

                    Tooltip = 'What is the condition of doors?';
                }
                field(Rum2DoorsRepairs; Rum2DoorsRepairs)
                {
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
            }
            group("Room 3")
            {
                Caption = 'Room 3';
                field(Room3Description; Room3Description)
                {
                    Tooltip = 'Unique identifing of the room';
                }
                field(Rum3CeilingCondition; Rum3CeilingCondition)
                {
                    Tooltip = 'What is the condition of the ceiling?';
                }
                field(Rum3CeilingRepairs; Rum3CeilingRepairs)
                {
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Rum3WallsCondition; Rum3WallsCondition)
                {
                    Tooltip = 'What is the condition of the walls?';
                }
                field(Rum3WallsRepairs; Rum3WallsRepairs)
                {
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Rum3FloorsCondition; Rum3FloorsCondition)
                {
                    Tooltip = 'What is the condition of the floor?';
                }
                field(Rum3FloorsRepairs; Rum3FloorsRepairs)
                {
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Rum3CarpetsCondition; Rum3CarpetsCondition)
                {
                    Tooltip = 'What is the condition of the carpets?';
                }
                field(Rum3CarpetsRepairs; Rum3CarpetsRepairs)
                {
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Rum3WoodworksCondition; Rum3WoodworksCondition)
                {
                    Tooltip = 'What is the condition of the woodwork?';
                }
                field(Rum3WoodworksRepairs; Rum3WoodworksRepairs)
                {
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Rum3WindowsmvCondition; Rum3WindowsmvCondition)
                {
                    Tooltip = 'What is the condition of the windows etc.?';
                }
                field(Rum3WindowsRepairs; Rum3WindowsRepairs)
                {
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Rum3RadiatorCondition; Rum3RadiatorCondition)
                {
                    Tooltip = 'What is the condition of the radiators?';
                }
                field(Rum3RadiatorRepairs; Rum3RadiatorRepairs)
                {
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Rum3ElCondition; Rum3ElCondition)
                {
                    Tooltip = 'What is the condition of electricity parts?';
                }
                field(Rum3ElRepairs; Rum3ElRepairs)
                {
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Rum3DoorsCondition; Rum3DoorsCondition)
                {
                    Tooltip = 'What is the condition of doors?';
                }
                field(Rum3DoorsRepairs; Rum3DoorsRepairs)
                {
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
            }
            group("Room 4")
            {
                Caption = 'Room 4';
                field(Room4Description; Room4Description)
                {
                    Tooltip = 'Unique identifing of the room';
                }
                field(Rum4CeilingCondition; Rum4CeilingCondition)
                {
                    Tooltip = 'What is the condition of the ceiling?';
                }
                field(Rum4CeilingRepairs; Rum4CeilingRepairs)
                {
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Rum4WallsCondition; Rum4WallsCondition)
                {
                    Tooltip = 'What is the condition of the walls?';
                }
                field(Rum4WallsRepairs; Rum4WallsRepairs)
                {
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Rum4FloorsCondition; Rum4FloorsCondition)
                {
                    Tooltip = 'What is the condition of the floor?';
                }
                field(Rum4FloorsRepairs; Rum4FloorsRepairs)
                {
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Rum4CarpetsCondition; Rum4CarpetsCondition)
                {
                    Tooltip = 'What is the condition of the carpets?';
                }
                field(Rum4CarpetsRepairs; Rum4CarpetsRepairs)
                {
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Rum4WoodworksCondition; Rum4WoodworksCondition)
                {
                    Tooltip = 'What is the condition of the woodwork?';
                }
                field(Rum4WoodworksRepairs; Rum4WoodworksRepairs)
                {
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Rum4WindowsmvCondition; Rum4WindowsmvCondition)
                {
                    Tooltip = 'What is the condition of the windows etc.?';
                }
                field(Rum4WindowsRepairs; Rum4WindowsRepairs)
                {
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Rum4RadiatorCondition; Rum4RadiatorCondition)
                {
                    Tooltip = 'What is the condition of the radiators?';
                }
                field(Rum4RadiatorRepairs; Rum4RadiatorRepairs)
                {
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Rum4ElCondition; Rum4ElCondition)
                {
                    Tooltip = 'What is the condition of electricity parts?';
                }
                field(Rum4ElRepairs; Rum4ElRepairs)
                {
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Rum4DoorsCondition; Rum4DoorsCondition)
                {
                    Tooltip = 'What is the condition of doors?';
                }
                field(Rum4DoorsRepairs; Rum4DoorsRepairs)
                {
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
            }
            group(Entre)
            {
                Caption = 'Entre';
                field(EntreCeilingCondition; EntreCeilingCondition)
                {
                    Tooltip = 'What is the condition of the ceiling?';
                }
                field(EntreCeilingRepairs; EntreCeilingRepairs)
                {
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(EntreWallsCondition; EntreWallsCondition)
                {
                    Tooltip = 'What is the condition of the walls?';
                }
                field(EntreWallsRepairs; EntreWallsRepairs)
                {
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(EntreFloorsCondition; EntreFloorsCondition)
                {
                    Tooltip = 'What is the condition of the floor?';
                }
                field(EntreFloorsRepairs; EntreFloorsRepairs)
                {
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(EntreCarpetsCondition; EntreCarpetsCondition)
                {
                    Tooltip = 'What is the condition of the carpets?';
                }
                field(EntreCarpetsRepairs; EntreCarpetsRepairs)
                {
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(EntreWoodworksCondition; EntreWoodworksCondition)
                {
                    Tooltip = 'What is the condition of the woodwork?';
                }
                field(EntreWoodworksRepairs; EntreWoodworksRepairs)
                {
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(EntreWindowsmvCondition; EntreWindowsmvCondition)
                {
                    Tooltip = 'What is the condition of the windows etc.?';
                }
                field(EntreWindowsRepairs; EntreWindowsRepairs)
                {
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(EntreRadiatorCondition; EntreRadiatorCondition)
                {
                    Tooltip = 'What is the condition of the radiators?';
                }
                field(EntreRadiatorRepairs; EntreRadiatorRepairs)
                {
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(EntreElCondition; EntreElCondition)
                {
                    Tooltip = 'What is the condition of electricity parts?';
                }
                field(EntreElRepairs; EntreElRepairs)
                {
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(EntreDoorsCondition; EntreDoorsCondition)
                {
                    Tooltip = 'What is the condition of doors?';
                }
                field(EntreDoorsRepairs; EntreDoorsRepairs)
                {
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
            }
            group(Kitchen)
            {
                Caption = 'Kitchen';
                field(KitchenCeilingCondition; KitchenCeilingCondition)
                {
                    Tooltip = 'What is the condition of the ceiling?';
                }
                field(KitchenCeilingRepairs; KitchenCeilingRepairs)
                {
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(KitchenWallsCondition; KitchenWallsCondition)
                {
                    Tooltip = 'What is the condition of the walls?';
                }
                field(KitchenWallsRepairs; KitchenWallsRepairs)
                {
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(KitchenFloorsCondition; KitchenFloorsCondition)
                {
                    Tooltip = 'What is the condition of the floor?';
                }
                field(KitchenFloorsRepairs; KitchenFloorsRepairs)
                {
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(KitchenCarpetsCondition; KitchenCarpetsCondition)
                {
                    Tooltip = 'What is the condition of the carpets?';
                }
                field(KitchenCarpetsRepairs; KitchenCarpetsRepairs)
                {
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(KitchenWoodworksCondition; KitchenWoodworksCondition)
                {
                    Tooltip = 'What is the condition of the woodwork?';
                }
                field(KitchenWoodworksRepairs; KitchenWoodworksRepairs)
                {
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(KitchenWindowsmvCondition; KitchenWindowsmvCondition)
                {
                    Tooltip = 'What is the condition of the windows etc.?';
                }
                field(KitchenWindowsRepairs; KitchenWindowsRepairs)
                {
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(KitchenRadiatorCondition; KitchenRadiatorCondition)
                {
                    Tooltip = 'What is the condition of the radiators?';
                }
                field(KitchenRadiatorRepairs; KitchenRadiatorRepairs)
                {
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(KitchenElCondition; KitchenElCondition)
                {
                    Tooltip = 'What is the condition of electricity parts?';
                }
                field(KitchenElRepairs; KitchenElRepairs)
                {
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(KitchenDoorsCondition; KitchenDoorsCondition)
                {
                    Tooltip = 'What is the condition of doors?';
                }
                field(KitchenDoorsRepairs; KitchenDoorsRepairs)
                {
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(KitchenTilesConditions; KitchenTilesConditions)
                {

                    Tooltip = 'What is the condition of the tiles?';
                }
                field(KitchenTilesRepairs; KitchenTilesRepairs)
                {

                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(KitchenTableCondition; KitchenTableCondition)
                {

                    Tooltip = 'What is the condition of the tables?';
                }
                field(KitchenTableRepairs; KitchenTableRepairs)
                {

                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(KitchenSinkCondition; KitchenSinkCondition)
                {

                    Tooltip = 'What is the condition of the sink?';
                }
                field(KitchensinkRepairs; KitchensinkRepairs)
                {

                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(KitchenCabinetsCondition; KitchenCabinetsCondition)
                {

                    Tooltip = 'What is the condition of the cabinets?';
                }
                field(KitchenCabinetsRepairs; KitchenCabinetsRepairs)
                {
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(KitchenWatertapsCondition; KitchenWatertapsCondition)
                {

                    Tooltip = 'What is the condition of the watertaps?';
                }
                field(KitchenWatertapsRepairs; KitchenWatertapsRepairs)
                {

                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
            }
            group(Bathroom)
            {
                Caption = 'Bathroom';
                field(BathroomCeilingCondition; BathroomCeilingCondition)
                {
                    Tooltip = 'What is the condition of the ceiling?';
                }
                field(BathroomCeilingRepairs; BathroomCeilingRepairs)
                {
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(BathroomWallsCondition; BathroomWallsCondition)
                {
                    Tooltip = 'What is the condition of the walls?';
                }
                field(BathroomWallsRepairs; BathroomWallsRepairs)
                {
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(BathroomFloorsCondition; BathroomFloorsCondition)
                {
                    Tooltip = 'What is the condition of the floor?';
                }
                field(BathroomFloorsRepairs; BathroomFloorsRepairs)
                {
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(BathroomCarpetsCondition; BathroomCarpetsCondition)
                {
                    Tooltip = 'What is the condition of the carpets?';
                }
                field(BathroomCarpetsRepairs; BathroomCarpetsRepairs)
                {
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(BathroomWoodworksCondition; BathroomWoodworksCondition)
                {
                    Tooltip = 'What is the condition of the woodwork?';
                }
                field(BathroomWoodworksRepairs; BathroomWoodworksRepairs)
                {
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(BathroomWindowsmvCondition; BathroomWindowsmvCondition)
                {
                    Tooltip = 'What is the condition of the windows etc.?';
                }
                field(BathroomWindowsRepairs; BathroomWindowsRepairs)
                {
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(BathroomRadiatorCondition; BathroomRadiatorCondition)
                {
                    Tooltip = 'What is the condition of the radiators?';
                }
                field(BathroomRadiatorRepairs; BathroomRadiatorRepairs)
                {
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(BathroomElCondition; BathroomElCondition)
                {
                    Tooltip = 'What is the condition of electricity parts?';
                }
                field(BathroomElRepairs; BathroomElRepairs)
                {
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(BathroomDoorsCondition; BathroomDoorsCondition)
                {
                    Tooltip = 'What is the condition of doors?';
                }
                field(BathroomDoorsRepairs; BathroomDoorsRepairs)
                {
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(BathroomSinkCondition; BathroomSinkCondition)
                {

                    Tooltip = 'What is the condition of sink?';
                }
                field(BathroomSinkRepairs; BathroomSinkRepairs)
                {

                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(BathroomCisternDoorsCondition; BathroomCisternDoorsCondition)
                {

                    Tooltip = 'What is the condition of cistern?';
                }
                field(BathroomCisternRepairs; BathroomCisternRepairs)
                {

                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(BathroomToiletBowlCondition; BathroomToiletBowlCondition)
                {

                    Tooltip = 'What is the condition of toiletbowl?';
                }
                field(BathroomToiletBowlRepairs; BathroomToiletBowlRepairs)
                {

                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(BathroomBathtopCondition; BathroomBathtopCondition)
                {

                    Tooltip = 'What is the condition of Bathtop?';
                }
                field(BathroombathTopRepairs; BathroombathTopRepairs)
                {

                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(BathroomShowerCondition; BathroomShowerCondition)
                {

                    Tooltip = 'What is the condition of shower?';
                }
                field(BathroomShowerRepairs; BathroomShowerRepairs)
                {

                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(BathroomWaterTapsCondition; BathroomWaterTapsCondition)
                {

                    Tooltip = 'What is the condition of watertaps?';
                }
                field(BathroomWaterTapsRepairs; BathroomWaterTapsRepairs)
                {

                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
            }
            group(Toilet)
            {
                Caption = 'Toilet';
                field(ToiletCeilingCondition; ToiletCeilingCondition)
                {
                    Tooltip = 'What is the condition of the ceiling?';
                }
                field(ToiletCeilingRepairs; ToiletCeilingRepairs)
                {
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(ToiletWallsCondition; ToiletWallsCondition)
                {
                    Tooltip = 'What is the condition of the walls?';
                }
                field(ToiletWallsRepairs; ToiletWallsRepairs)
                {
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(ToiletFloorsCondition; ToiletFloorsCondition)
                {
                    Tooltip = 'What is the condition of the floor?';
                }
                field(ToiletFloorsRepairs; ToiletFloorsRepairs)
                {
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(ToiletCarpetsCondition; ToiletCarpetsCondition)
                {
                    Tooltip = 'What is the condition of the carpets?';
                }
                field(ToiletCarpetsRepairs; ToiletCarpetsRepairs)
                {
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(ToiletWoodworksCondition; ToiletWoodworksCondition)
                {
                    Tooltip = 'What is the condition of the woodwork?';
                }
                field(ToiletWoodworksRepairs; ToiletWoodworksRepairs)
                {
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(ToiletWindowsmvCondition; ToiletWindowsmvCondition)
                {
                    Tooltip = 'What is the condition of the windows etc.?';
                }
                field(ToiletWindowsRepairs; ToiletWindowsRepairs)
                {
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(ToiletRadiatorCondition; ToiletRadiatorCondition)
                {
                    Tooltip = 'What is the condition of the radiators?';
                }
                field(ToiletRadiatorRepairs; ToiletRadiatorRepairs)
                {
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(ToiletElCondition; ToiletElCondition)
                {
                    Tooltip = 'What is the condition of electricity parts?';
                }
                field(ToiletElRepairs; ToiletElRepairs)
                {
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(ToiletDoorsCondition; ToiletDoorsCondition)
                {
                    Tooltip = 'What is the condition of doors?';
                }
                field(ToiletDoorsRepairs; ToiletDoorsRepairs)
                {
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(ToiletSinkCondition; ToiletSinkCondition)
                {

                    Tooltip = 'What is the condition of the sink?';
                }
                field(ToiletSinkRepairs; ToiletSinkRepairs)
                {

                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(ToiletCisternDoorsCondition; ToiletCisternDoorsCondition)
                {

                    Tooltip = 'What is the condition of the cistern?';
                }
                field(ToiletCisternRepairs; ToiletCisternRepairs)
                {

                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(ToiletToiletBowlCondition; ToiletToiletBowlCondition)
                {

                    Tooltip = 'What is the condition of the toiletbowl?';
                }
                field(ToiletToiletBowlRepairs; ToiletToiletBowlRepairs)
                {

                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(ToiletwaterTapsCondition; ToiletwaterTapsCondition)
                {

                    Tooltip = 'What is the condition of watertaps?';
                }
                field(ToiletWaterTapsRepairs; ToiletWaterTapsRepairs)
                {

                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
            }
            group(Appliances)
            {
                Caption = 'Appliances';
                Group(stove)
                {
                    Caption = 'Stove';
                    field(StoveYear; StoveYear)
                    {

                        Tooltip = 'Year of production.';
                    }
                    field(StoveManufactor; StoveManufactor)
                    {

                        Tooltip = 'Who is the manufactor?';
                    }
                    field(StoveModel; StoveModel)
                    {
                        Tooltip = 'Model designation';
                    }
                    field(StoveCondition; StoveCondition)
                    {

                        Tooltip = 'What is the condition of the stove?';
                    }
                    field(StoveRepairs; StoveRepairs)
                    {

                        Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                    }
                }
                group(Cook)
                {
                    caption = 'Cook';

                    field(CookYear; CookYear)
                    {
                        Tooltip = 'Year of production.';
                    }
                    field(CookManufactor; CookManufactor)
                    {
                        Tooltip = 'Who is the manufactor?';
                    }
                    field(CookModel; CookModel)
                    {
                        Tooltip = 'Model designation';
                    }
                    field(CookCondition; CookCondition)
                    {

                        Tooltip = 'What is the condition of the Cook?';
                    }
                    field(CookRepairs; CookRepairs)
                    {

                        Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                    }

                }
                Group(Oven)
                {
                    Caption = 'Oven';
                    field(OvenYear; OvenYear)
                    {
                        Tooltip = 'Year of production.';
                    }
                    field(OvenManufactor; OvenManufactor)
                    {
                        Tooltip = 'Who is the manufactor?';
                    }
                    field(OvenModel; OvenModel)
                    {
                        Tooltip = 'Model designation';
                    }
                    field(OvenCondition; OvenCondition)
                    {

                        Tooltip = 'What is the condition of the Oven?';
                    }
                    field(OvenRepairs; OvenRepairs)
                    {
                        Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                    }
                }
                group(Hood)
                {
                    caption = 'Hood';
                    field(HoodYear; HoodYear)
                    {
                        Tooltip = 'Year of production.';
                    }
                    field(HoodManufactor; HoodManufactor)
                    {
                        Tooltip = 'Who is the manufactor?';
                    }
                    field(HoodStoveModel; HoodStoveModel)
                    {
                        Tooltip = 'Model designation';
                    }
                    field(HoodCondition; HoodCondition)
                    {

                        Tooltip = 'What is the condition of the hood?';
                    }
                    field(HoodRepairs; HoodeRepairs)
                    {
                        Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                    }
                }
                group(Fridge)
                {
                    caption = 'Fridge';
                    field(FridgeYear; FridgeYear)
                    {
                        Tooltip = 'Year of production.';
                    }
                    field(FridgeManufactor; FridgeManufactor)
                    {
                        Tooltip = 'Who is the manufactor?';
                    }
                    field(FridgeModel; FridgeModel)
                    {
                        Tooltip = 'Model designation';
                    }
                    field(FridgeCondition; FridgeCondition)
                    {

                        Tooltip = 'What is the condition of the fridge?';
                    }
                    field(FridgeRepairs; FridgeRepairs)
                    {
                        Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                    }
                }
                group(Freezer)
                {
                    caption = 'Frezer';
                    field(FreezerYear; FreezerYear)
                    {
                        Tooltip = 'Year of production.';
                    }
                    field(FreezerManufactor; FreezerManufactor)
                    {
                        Tooltip = 'Who is the manufactor?';
                    }
                    field(FreezerModel; FreezerModel)
                    {
                        Tooltip = 'Model designation';
                    }
                    field(FreezerCondition; FreezerCondition)
                    {

                        Tooltip = 'What is the condition of the freezer?';
                    }
                    field(FreezerRepairs; FreezerRepairs)
                    {
                        Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                    }
                }
                Group(Dishwasher)
                {
                    caption = 'Dishwasher';
                    field(DishwasherYear; DishwasherYear)
                    {
                        Tooltip = 'Year of production.';
                    }
                    field(DishwasherManufactor; DishwasherManufactor)
                    {
                        Tooltip = 'Who is the manufactor?';
                    }
                    field(DishwasherModel; DishwasherModel)
                    {
                        Tooltip = 'Model designation';
                    }
                    field(DishwasherCondition; DishwasherCondition)
                    {

                        Tooltip = 'What is the condition of the dishwasher?';
                    }
                    field(DishwasherRepairs; DishwasherRepairs)
                    {

                        Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                    }
                }
                group(Washer)
                {
                    Caption = 'Washer';
                    field(WasherYear; WasherYear)
                    {
                        Tooltip = 'Year of production.';
                    }
                    field(WasherManufactor; WasherManufactor)
                    {
                        Tooltip = 'Who is the manufactor?';
                    }
                    field(WasherModel; WasherModel)
                    {
                        Tooltip = 'Model designation';
                    }
                    field(WasherCondition; WasherCondition)
                    {

                        Tooltip = 'What is the condition of the washer?';
                    }
                    field(WasherRepairs; WasherRepairs)
                    {

                        Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                    }
                }
                group(Dryer)
                {
                    Caption = 'Dryer';
                    field(DryerYear; DryerYear)
                    {
                        Tooltip = 'Year of production.';
                    }
                    field(DryerManufactor; DryerManufactor)
                    {
                        Tooltip = 'Who is the manufactor?';
                    }
                    field(DryerModel; DryerModel)
                    {
                        Tooltip = 'Model designation';
                    }
                    field(DryerCondition; DryerCondition)
                    {

                        Tooltip = 'What is the condition of the dryer?';
                    }
                    field(DryerRepairs; DryerRepairs)
                    {

                        Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                    }
                }
                group(EntryPhone)
                {
                    Caption = 'EntryPhone';

                    field(EntryPhoneYear; EntryPhoneYear)
                    {
                        Tooltip = 'Year of production.';
                    }
                    field(EntryPhoneManufactor; EntryPhoneManufactor)
                    {

                        Tooltip = 'Who is the manufactor?';
                    }
                    field(EntryPhoneModel; EntryPhoneModel)
                    {

                        Tooltip = 'Model designation';
                    }
                    field(EntryPhoneCondition; EntryPhoneCondition)
                    {

                        Tooltip = 'What is the condition of the entryphone?';
                    }
                    field(EntryPhoneRepairs; EntryPhoneRepairs)
                    {

                        Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                    }
                }
                group(Other)
                {
                    Caption = 'Other';
                    field(AntennaCondition; AntennaCondition)
                    {

                        Tooltip = 'What is the condition of the antenna?';
                    }
                    field(AntennaRepairs; AntennaRepairs)
                    {

                        Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                    }
                    field(KeyCondition; KeyCondition)
                    {
                        Tooltip = 'What is the condition of the key?';
                    }
                    field(KeyRepairs; KeyRepairs)
                    {
                        Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                    }
                }
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
        area(Reporting)
        {
            //group(Reports)
            //{
            // Caption = 'Reports';
            action(Movingin)
            {
                Caption = 'Moving in report';
                tooltip = 'Report for moving in status';
                Image = MakeAgreement;
                Promoted = true;
                PromotedCategory = Report;

                trigger OnAction();
                begin
                    CLEAR(OccupantCard);
                    OccupantCard.SETRANGE(Occupant, Rec.Occupant);
                    CLEAR(MoveIn);
                    MoveIn.SETTABLEVIEW(OccupantCard);
                    MoveIn.RUNMODAL;
                end;
            }
            //}
        }
    }
    trigger OnAfterGetCurrRecord();
    begin
        CurrPage.UPDATE;
    end;

    var
        myInt: Integer;

        OccupantCard: Record "SVA MovingIn Status";
        MoveIn: Report "SVA Moving in status";


}

