page 50007 "SVA MoveIn"
//Tooltip created
{
    PageType = Card;
    SourceTable = "SVA MovingIn Status";
    Caption = 'Moving in status';
    UsageCategory = Tasks;
    ApplicationArea = All;
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
                    ApplicationArea = all;
                }
                field(Name; Name)
                {
                    Tooltip = 'Tenant name';
                    ApplicationArea = all;
                }
                field(Name2; Name2)
                {
                    Tooltip = 'Tenant name, if more than one tenant';
                    ApplicationArea = all;
                }
                field("Address"; "Address (new)")
                {
                    Tooltip = 'Invoice address';
                    ApplicationArea = all;
                }
                field(PostCode; PostCode)
                {
                    Tooltip = 'Tenant postcode';
                    ApplicationArea = all;

                }
                field(City; City)
                {
                    Tooltip = 'Tenant city';
                    ApplicationArea = all;
                }
                field(TenancyNo; TenancyNo)
                {
                    NotBlank = true;
                    Tooltip = 'Tenancy no.';
                    ApplicationArea = all;
                }
                field(TenancyAddress; TenancyAddress)
                {
                    ApplicationArea = All;
                    Tooltip = 'Teanancy address';
                }
                field(TenancyPostCode; TenancyPostCode)
                {
                    ApplicationArea = All;
                    Tooltip = 'Tenancy postcode';
                }
                field(TenancyCity; TenancyCity)
                {
                    ApplicationArea = All;
                    Tooltip = 'Tenancy city';
                }
                field(LandlordName; LandlordName)
                {
                    ApplicationArea = All;
                    Tooltip = 'Name of landlord';
                }
                field(landlordAddress; landlordAddress)
                {
                    ApplicationArea = All;
                    Tooltip = 'Landlord address';
                }
                field(LandlordPostCode; LandlordPostCode)
                {
                    ApplicationArea = All;
                    Tooltip = 'Landlord postcode';
                }
                field(Landlordcity; Landlordcity)
                {
                    ApplicationArea = All;
                    Tooltip = 'Landlord city';
                }
                field(Representative; Representative)
                {
                    ApplicationArea = All;
                    Tooltip = 'Landlords reprensentavie name';
                }
                field(BebrepProperty; BebrepProperty)
                {
                    ApplicationArea = All;
                    Tooltip = 'Has the property a tenantgroup';
                }
                field(BebrepInd; BebrepInd)
                {
                    ApplicationArea = All;
                    Tooltip = 'Is tenantgroup representative summoned?';
                }
                field(BebrepTilstede; BebrepTilstede)
                {
                    ApplicationArea = All;
                    Tooltip = 'Is tentant representative present?';
                }
                field(BebrepName; BebrepName)
                {
                    ApplicationArea = All;
                    Tooltip = 'Tentant representatives name?';

                }
                field(BebrepEmail; BebrepEmail)
                {
                    ApplicationArea = All;
                    Tooltip = 'Tenant representatives email';
                }
                field(BebrepKopi; BebrepKopi)
                {
                    ApplicationArea = All;
                    Tooltip = 'Has tenant representative got a copy of this document?';
                }
            }
            group("Room 1")
            {
                Caption = 'Room 1';
                field(Room1Description; Room1Description)
                {
                    ApplicationArea = All;
                    Tooltip = 'Unique identifing of the room';
                }
                field(Rum1CeilingCondition; Rum1CeilingCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the ceiling?';
                }
                field(Rum1CeilingRepairs; Rum1CeilingRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Rum1WallsCondition; Rum1WallsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the walls?';
                }

                field(Rum1WallsRepairs; Rum1WallsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Rum1FloorsCondition; Rum1FloorsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the floor?';
                }
                field(Rum1FloorsRepairs; Rum1FloorsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Rum1CarpetsCondition; Rum1CarpetsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the carpets?';
                }
                field(Rum1CarpetsRepairs; Rum1CarpetsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Rum1WoodworksCondition; Rum1WoodworksCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the woodwork?';
                }
                field(Rum1WoodworksRepairs; Rum1WoodworksRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Rum1WindowsmvCondition; Rum1WindowsmvCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the windows etc.?';
                }
                field(Rum1WindowsRepairs; Rum1WindowsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Rum1RadiatorCondition; Rum1RadiatorCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the radiators?';
                }
                field(Rum1RadiatorRepairs; Rum1RadiatorRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Rum1ElCondition; Rum1ElCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of electricity parts?';
                }
                field(Rum1ElRepairs; Rum1ElRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Rum1DoorsCondition; Rum1DoorsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of doors?';
                }
                field(Rum1DoorsRepairs; Rum1DoorsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
            }
            group("Room 2")
            {
                Caption = 'Room 2';
                field(Room2Description; Room2Description)
                {
                    ApplicationArea = All;
                    Tooltip = 'Unique identifing of the room';
                }
                field(Rum2CeilingCondition; Rum2CeilingCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the ceiling?';
                }
                field(Rum2CeilingRepairs; Rum2CeilingRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Rum2WallsCondition; Rum2WallsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the walls?';
                }
                field(Rum2WallsRepairs; Rum2WallsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Rum2FloorsCondition; Rum2FloorsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the floor?';
                }
                field(Rum2FloorsRepairs; Rum2FloorsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Rum2CarpetsCondition; Rum2CarpetsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the carpets?';
                }
                field(Rum2CarpetsRepairs; Rum2CarpetsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Rum2WoodworksCondition; Rum2WoodworksCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the woodwork?';
                }
                field(Rum2WoodworksRepairs; Rum2WoodworksRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Rum2WindowsmvCondition; Rum2WindowsmvCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the windows etc.?';
                }
                field(Rum2WindowsRepairs; Rum2WindowsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Rum2RadiatorCondition; Rum2RadiatorCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the radiators?';
                }
                field(Rum2RadiatorRepairs; Rum2RadiatorRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Rum2ElCondition; Rum2ElCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of electricity parts?';
                }
                field(Rum2ElRepairs; Rum2ElRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Rum2DoorsCondition; Rum2DoorsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of doors?';
                }
                field(Rum2DoorsRepairs; Rum2DoorsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
            }
            group("Room 3")
            {
                Caption = 'Room 3';
                field(Room3Description; Room3Description)
                {
                    ApplicationArea = All;
                    Tooltip = 'Unique identifing of the room';
                }
                field(Rum3CeilingCondition; Rum3CeilingCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the ceiling?';
                }
                field(Rum3CeilingRepairs; Rum3CeilingRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Rum3WallsCondition; Rum3WallsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the walls?';
                }
                field(Rum3WallsRepairs; Rum3WallsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Rum3FloorsCondition; Rum3FloorsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the floor?';
                }
                field(Rum3FloorsRepairs; Rum3FloorsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Rum3CarpetsCondition; Rum3CarpetsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the carpets?';
                }
                field(Rum3CarpetsRepairs; Rum3CarpetsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Rum3WoodworksCondition; Rum3WoodworksCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the woodwork?';
                }
                field(Rum3WoodworksRepairs; Rum3WoodworksRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Rum3WindowsmvCondition; Rum3WindowsmvCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the windows etc.?';
                }
                field(Rum3WindowsRepairs; Rum3WindowsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Rum3RadiatorCondition; Rum3RadiatorCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the radiators?';
                }
                field(Rum3RadiatorRepairs; Rum3RadiatorRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Rum3ElCondition; Rum3ElCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of electricity parts?';
                }
                field(Rum3ElRepairs; Rum3ElRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Rum3DoorsCondition; Rum3DoorsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of doors?';
                }
                field(Rum3DoorsRepairs; Rum3DoorsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
            }
            group("Room 4")
            {
                Caption = 'Room 4';
                field(Room4Description; Room4Description)
                {
                    ApplicationArea = All;
                    Tooltip = 'Unique identifing of the room';
                }
                field(Rum4CeilingCondition; Rum4CeilingCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the ceiling?';
                }
                field(Rum4CeilingRepairs; Rum4CeilingRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Rum4WallsCondition; Rum4WallsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the walls?';
                }
                field(Rum4WallsRepairs; Rum4WallsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Rum4FloorsCondition; Rum4FloorsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the floor?';
                }
                field(Rum4FloorsRepairs; Rum4FloorsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Rum4CarpetsCondition; Rum4CarpetsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the carpets?';
                }
                field(Rum4CarpetsRepairs; Rum4CarpetsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Rum4WoodworksCondition; Rum4WoodworksCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the woodwork?';
                }
                field(Rum4WoodworksRepairs; Rum4WoodworksRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Rum4WindowsmvCondition; Rum4WindowsmvCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the windows etc.?';
                }
                field(Rum4WindowsRepairs; Rum4WindowsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Rum4RadiatorCondition; Rum4RadiatorCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the radiators?';
                }
                field(Rum4RadiatorRepairs; Rum4RadiatorRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Rum4ElCondition; Rum4ElCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of electricity parts?';
                }
                field(Rum4ElRepairs; Rum4ElRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Rum4DoorsCondition; Rum4DoorsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of doors?';
                }
                field(Rum4DoorsRepairs; Rum4DoorsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
            }
            group(Entre)
            {
                Caption = 'Entre';
                field(EntreCeilingCondition; EntreCeilingCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the ceiling?';
                }
                field(EntreCeilingRepairs; EntreCeilingRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(EntreWallsCondition; EntreWallsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the walls?';
                }
                field(EntreWallsRepairs; EntreWallsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(EntreFloorsCondition; EntreFloorsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the floor?';
                }
                field(EntreFloorsRepairs; EntreFloorsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(EntreCarpetsCondition; EntreCarpetsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the carpets?';
                }
                field(EntreCarpetsRepairs; EntreCarpetsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(EntreWoodworksCondition; EntreWoodworksCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the woodwork?';
                }
                field(EntreWoodworksRepairs; EntreWoodworksRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(EntreWindowsmvCondition; EntreWindowsmvCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the windows etc.?';
                }
                field(EntreWindowsRepairs; EntreWindowsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(EntreRadiatorCondition; EntreRadiatorCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the radiators?';
                }
                field(EntreRadiatorRepairs; EntreRadiatorRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(EntreElCondition; EntreElCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of electricity parts?';
                }
                field(EntreElRepairs; EntreElRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(EntreDoorsCondition; EntreDoorsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of doors?';
                }
                field(EntreDoorsRepairs; EntreDoorsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
            }
            group(Kitchen)
            {
                Caption = 'Kitchen';
                field(KitchenCeilingCondition; KitchenCeilingCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the ceiling?';
                }
                field(KitchenCeilingRepairs; KitchenCeilingRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(KitchenWallsCondition; KitchenWallsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the walls?';
                }
                field(KitchenWallsRepairs; KitchenWallsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(KitchenFloorsCondition; KitchenFloorsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the floor?';
                }
                field(KitchenFloorsRepairs; KitchenFloorsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(KitchenCarpetsCondition; KitchenCarpetsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the carpets?';
                }
                field(KitchenCarpetsRepairs; KitchenCarpetsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(KitchenWoodworksCondition; KitchenWoodworksCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the woodwork?';
                }
                field(KitchenWoodworksRepairs; KitchenWoodworksRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(KitchenWindowsmvCondition; KitchenWindowsmvCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the windows etc.?';
                }
                field(KitchenWindowsRepairs; KitchenWindowsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(KitchenRadiatorCondition; KitchenRadiatorCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the radiators?';
                }
                field(KitchenRadiatorRepairs; KitchenRadiatorRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(KitchenElCondition; KitchenElCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of electricity parts?';
                }
                field(KitchenElRepairs; KitchenElRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(KitchenDoorsCondition; KitchenDoorsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of doors?';
                }
                field(KitchenDoorsRepairs; KitchenDoorsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(KitchenTilesConditions; KitchenTilesConditions)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the tiles?';
                }
                field(KitchenTilesRepairs; KitchenTilesRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(KitchenTableCondition; KitchenTableCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the tables?';
                }
                field(KitchenTableRepairs; KitchenTableRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(KitchenSinkCondition; KitchenSinkCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the sink?';
                }
                field(KitchensinkRepairs; KitchensinkRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(KitchenCabinetsCondition; KitchenCabinetsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the cabinets?';
                }
                field(KitchenCabinetsRepairs; KitchenCabinetsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(KitchenWatertapsCondition; KitchenWatertapsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the watertaps?';
                }
                field(KitchenWatertapsRepairs; KitchenWatertapsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
            }
            group(Bathroom)
            {
                Caption = 'Bathroom';
                field(BathroomCeilingCondition; BathroomCeilingCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the ceiling?';
                }
                field(BathroomCeilingRepairs; BathroomCeilingRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(BathroomWallsCondition; BathroomWallsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the walls?';
                }
                field(BathroomWallsRepairs; BathroomWallsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(BathroomFloorsCondition; BathroomFloorsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the floor?';
                }
                field(BathroomFloorsRepairs; BathroomFloorsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(BathroomCarpetsCondition; BathroomCarpetsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the carpets?';
                }
                field(BathroomCarpetsRepairs; BathroomCarpetsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(BathroomWoodworksCondition; BathroomWoodworksCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the woodwork?';
                }
                field(BathroomWoodworksRepairs; BathroomWoodworksRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(BathroomWindowsmvCondition; BathroomWindowsmvCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the windows etc.?';
                }
                field(BathroomWindowsRepairs; BathroomWindowsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(BathroomRadiatorCondition; BathroomRadiatorCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the radiators?';
                }
                field(BathroomRadiatorRepairs; BathroomRadiatorRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(BathroomElCondition; BathroomElCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of electricity parts?';
                }
                field(BathroomElRepairs; BathroomElRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(BathroomDoorsCondition; BathroomDoorsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of doors?';
                }
                field(BathroomDoorsRepairs; BathroomDoorsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(BathroomSinkCondition; BathroomSinkCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of sink?';
                }
                field(BathroomSinkRepairs; BathroomSinkRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(BathroomCisternDoorsCondition; BathroomCisternDoorsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of cistern?';
                }
                field(BathroomCisternRepairs; BathroomCisternRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(BathroomToiletBowlCondition; BathroomToiletBowlCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of toiletbowl?';
                }
                field(BathroomToiletBowlRepairs; BathroomToiletBowlRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(BathroomBathtopCondition; BathroomBathtopCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of Bathtop?';
                }
                field(BathroombathTopRepairs; BathroombathTopRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(BathroomShowerCondition; BathroomShowerCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of shower?';
                }
                field(BathroomShowerRepairs; BathroomShowerRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(BathroomWaterTapsCondition; BathroomWaterTapsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of watertaps?';
                }
                field(BathroomWaterTapsRepairs; BathroomWaterTapsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
            }
            group(Toilet)
            {
                Caption = 'Toilet';
                field(ToiletCeilingCondition; ToiletCeilingCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the ceiling?';
                }
                field(ToiletCeilingRepairs; ToiletCeilingRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(ToiletWallsCondition; ToiletWallsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the walls?';
                }
                field(ToiletWallsRepairs; ToiletWallsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(ToiletFloorsCondition; ToiletFloorsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the floor?';
                }
                field(ToiletFloorsRepairs; ToiletFloorsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(ToiletCarpetsCondition; ToiletCarpetsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the carpets?';
                }
                field(ToiletCarpetsRepairs; ToiletCarpetsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(ToiletWoodworksCondition; ToiletWoodworksCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the woodwork?';
                }
                field(ToiletWoodworksRepairs; ToiletWoodworksRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(ToiletWindowsmvCondition; ToiletWindowsmvCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the windows etc.?';
                }
                field(ToiletWindowsRepairs; ToiletWindowsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(ToiletRadiatorCondition; ToiletRadiatorCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the radiators?';
                }
                field(ToiletRadiatorRepairs; ToiletRadiatorRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(ToiletElCondition; ToiletElCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of electricity parts?';
                }
                field(ToiletElRepairs; ToiletElRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(ToiletDoorsCondition; ToiletDoorsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of doors?';
                }
                field(ToiletDoorsRepairs; ToiletDoorsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(ToiletSinkCondition; ToiletSinkCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the sink?';
                }
                field(ToiletSinkRepairs; ToiletSinkRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(ToiletCisternDoorsCondition; ToiletCisternDoorsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the cistern?';
                }
                field(ToiletCisternRepairs; ToiletCisternRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(ToiletToiletBowlCondition; ToiletToiletBowlCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the toiletbowl?';
                }
                field(ToiletToiletBowlRepairs; ToiletToiletBowlRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(ToiletwaterTapsCondition; ToiletwaterTapsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of watertaps?';
                }
                field(ToiletWaterTapsRepairs; ToiletWaterTapsRepairs)
                {
                    ApplicationArea = All;
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
                        ApplicationArea = All;
                        Tooltip = 'Year of production.';
                    }
                    field(StoveManufactor; StoveManufactor)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Who is the manufactor?';
                    }
                    field(StoveModel; StoveModel)
                    {
                        ApplicationArea = all;
                        Tooltip = 'Model designation';
                    }
                    field(StoveCondition; StoveCondition)
                    {
                        ApplicationArea = All;
                        Tooltip = 'What is the condition of the stove?';
                    }
                    field(StoveRepairs; StoveRepairs)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                    }
                }
                group(Cook)
                {
                    caption = 'Cook';

                    field(CookYear; CookYear)
                    {
                        ApplicationArea = all;
                        Tooltip = 'Year of production.';
                    }
                    field(CookManufactor; CookManufactor)
                    {
                        ApplicationArea = all;
                        Tooltip = 'Who is the manufactor?';
                    }
                    field(CookModel; CookModel)
                    {
                        ApplicationArea = all;
                        Tooltip = 'Model designation';
                    }
                    field(CookCondition; CookCondition)
                    {
                        ApplicationArea = All;
                        Tooltip = 'What is the condition of the Cook?';
                    }
                    field(CookRepairs; CookRepairs)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                    }

                }
                Group(Oven)
                {
                    Caption = 'Oven';
                    field(OvenYear; OvenYear)
                    {
                        ApplicationArea = all;
                        Tooltip = 'Year of production.';
                    }
                    field(OvenManufactor; OvenManufactor)
                    {
                        ApplicationArea = all;
                        Tooltip = 'Who is the manufactor?';
                    }
                    field(OvenModel; OvenModel)
                    {
                        ApplicationArea = all;
                        Tooltip = 'Model designation';
                    }
                    field(OvenCondition; OvenCondition)
                    {
                        ApplicationArea = All;
                        Tooltip = 'What is the condition of the Oven?';
                    }
                    field(OvenRepairs; OvenRepairs)
                    {
                        ApplicationArea = all;
                        Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                    }
                }
                group(Hood)
                {
                    caption = 'Hood';
                    field(HoodYear; HoodYear)
                    {
                        ApplicationArea = all;
                        Tooltip = 'Year of production.';
                    }
                    field(HoodManufactor; HoodManufactor)
                    {
                        ApplicationArea = all;
                        Tooltip = 'Who is the manufactor?';
                    }
                    field(HoodStoveModel; HoodStoveModel)
                    {
                        ApplicationArea = all;
                        Tooltip = 'Model designation';
                    }
                    field(HoodCondition; HoodCondition)
                    {
                        ApplicationArea = All;
                        Tooltip = 'What is the condition of the hood?';
                    }
                    field(HoodRepairs; HoodeRepairs)
                    {
                        ApplicationArea = all;
                        Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                    }
                }
                group(Fridge)
                {
                    caption = 'Fridge';
                    field(FridgeYear; FridgeYear)
                    {
                        ApplicationArea = all;
                        Tooltip = 'Year of production.';
                    }
                    field(FridgeManufactor; FridgeManufactor)
                    {
                        ApplicationArea = all;
                        Tooltip = 'Who is the manufactor?';
                    }
                    field(FridgeModel; FridgeModel)
                    {
                        ApplicationArea = all;
                        Tooltip = 'Model designation';
                    }
                    field(FridgeCondition; FridgeCondition)
                    {
                        ApplicationArea = All;
                        Tooltip = 'What is the condition of the fridge?';
                    }
                    field(FridgeRepairs; FridgeRepairs)
                    {
                        ApplicationArea = all;
                        Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                    }
                }
                group(Freezer)
                {
                    caption = 'Frezer';
                    field(FreezerYear; FreezerYear)
                    {
                        ApplicationArea = all;
                        Tooltip = 'Year of production.';
                    }
                    field(FreezerManufactor; FreezerManufactor)
                    {
                        ApplicationArea = all;
                        Tooltip = 'Who is the manufactor?';
                    }
                    field(FreezerModel; FreezerModel)
                    {
                        ApplicationArea = all;
                        Tooltip = 'Model designation';
                    }
                    field(FreezerCondition; FreezerCondition)
                    {
                        ApplicationArea = All;
                        Tooltip = 'What is the condition of the freezer?';
                    }
                    field(FreezerRepairs; FreezerRepairs)
                    {
                        ApplicationArea = all;
                        Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                    }
                }
                Group(Dishwasher)
                {
                    caption = 'Dishwasher';
                    field(DishwasherYear; DishwasherYear)
                    {
                        ApplicationArea = all;
                        Tooltip = 'Year of production.';
                    }
                    field(DishwasherManufactor; DishwasherManufactor)
                    {
                        ApplicationArea = all;
                        Tooltip = 'Who is the manufactor?';
                    }
                    field(DishwasherModel; DishwasherModel)
                    {
                        ApplicationArea = all;
                        Tooltip = 'Model designation';
                    }
                    field(DishwasherCondition; DishwasherCondition)
                    {
                        ApplicationArea = All;
                        Tooltip = 'What is the condition of the dishwasher?';
                    }
                    field(DishwasherRepairs; DishwasherRepairs)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                    }
                }
                group(Washer)
                {
                    Caption = 'Washer';
                    field(WasherYear; WasherYear)
                    {
                        ApplicationArea = all;
                        Tooltip = 'Year of production.';
                    }
                    field(WasherManufactor; WasherManufactor)
                    {
                        ApplicationArea = all;
                        Tooltip = 'Who is the manufactor?';
                    }
                    field(WasherModel; WasherModel)
                    {
                        ApplicationArea = all;
                        Tooltip = 'Model designation';
                    }
                    field(WasherCondition; WasherCondition)
                    {
                        ApplicationArea = All;
                        Tooltip = 'What is the condition of the washer?';
                    }
                    field(WasherRepairs; WasherRepairs)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                    }
                }
                group(Dryer)
                {
                    Caption = 'Dryer';
                    field(DryerYear; DryerYear)
                    {
                        ApplicationArea = all;
                        Tooltip = 'Year of production.';
                    }
                    field(DryerManufactor; DryerManufactor)
                    {
                        ApplicationArea = all;
                        Tooltip = 'Who is the manufactor?';
                    }
                    field(DryerModel; DryerModel)
                    {
                        ApplicationArea = all;
                        Tooltip = 'Model designation';
                    }
                    field(DryerCondition; DryerCondition)
                    {
                        ApplicationArea = All;
                        Tooltip = 'What is the condition of the dryer?';
                    }
                    field(DryerRepairs; DryerRepairs)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                    }
                }
                group(EntryPhone)
                {
                    Caption = 'EntryPhone';

                    field(EntryPhoneYear; EntryPhoneYear)
                    {
                        ApplicationArea = all;
                        Tooltip = 'Year of production.';
                    }
                    field(EntryPhoneManufactor; EntryPhoneManufactor)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Who is the manufactor?';
                    }
                    field(EntryPhoneModel; EntryPhoneModel)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Model designation';
                    }
                    field(EntryPhoneCondition; EntryPhoneCondition)
                    {
                        ApplicationArea = All;
                        Tooltip = 'What is the condition of the entryphone?';
                    }
                    field(EntryPhoneRepairs; EntryPhoneRepairs)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                    }
                }
                group(Other)
                {
                    Caption = 'Other';
                    field(AntennaCondition; AntennaCondition)
                    {
                        ApplicationArea = All;
                        Tooltip = 'What is the condition of the antenna?';
                    }
                    field(AntennaRepairs; AntennaRepairs)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                    }
                    field(KeyCondition; KeyCondition)
                    {
                        ApplicationArea = all;
                        Tooltip = 'What is the condition of the key?';
                    }
                    field(KeyRepairs; KeyRepairs)
                    {
                        ApplicationArea = all;
                        Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
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
            group(Rapport)
            {
                Caption = 'Report';

                action(Movingin)
                {
                    ApplicationArea = all;
                    Caption = 'Moving in report';
                    tooltip = 'Report for moving in status';
                    Image = MakeAgreement;
                    Promoted = true;
                    PromotedCategory = Report;

                    trigger OnAction();
                    begin
                        CLEAR(SVAMovingInStatus);
                        SVAMovingInStatus.SETRANGE(Occupant, Rec.Occupant);
                        CLEAR(RepSVAMovinginstatus);
                        RepSVAMovinginstatus.SETTABLEVIEW(SVAMovingInStatus);
                        RepSVAMovinginstatus.RunModal();
                    end;
                }
            }
        }
    }
    trigger OnAfterGetCurrRecord();
    begin
        CurrPage.UPDATE();
    end;

    var
        SVAMovingInStatus: Record "SVA MovingIn Status";
        RepSVAMovinginstatus: Report "SVA Moving in status";


}

