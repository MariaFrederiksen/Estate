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
                field(Occupant; Rec.Occupant)
                {
                    ToolTip = 'Occupant';
                    ApplicationArea = all;
                }
                field(Name; Rec.Name)
                {
                    Tooltip = 'Tenant name';
                    ApplicationArea = all;
                }
                field(Name2; Rec.Name2)
                {
                    Tooltip = 'Tenant name, if more than one tenant';
                    ApplicationArea = all;
                }
                field("Address"; Rec."Address (new)")
                {
                    Tooltip = 'Invoice address';
                    ApplicationArea = all;
                }
                field(PostCode; Rec.PostCode)
                {
                    Tooltip = 'Tenant postcode';
                    ApplicationArea = all;

                }
                field(City; Rec.City)
                {
                    Tooltip = 'Tenant city';
                    ApplicationArea = all;
                }
                field(Email1; Rec.Email1)
                {
                    ApplicationArea = all;
                    ToolTip = 'Email';
                }
                field(Phone; Rec.Phone)
                {
                    ApplicationArea = all;
                    ToolTip = 'Phone';
                }
                field(TenancyNo; Rec.TenancyNo)
                {
                    NotBlank = true;
                    Tooltip = 'Tenancy no.';
                    ApplicationArea = all;
                }
                field(TenancyAddress; Rec.TenancyAddress)
                {
                    ApplicationArea = All;
                    Tooltip = 'Teanancy address';
                }
                field(TenancyPostCode; Rec.TenancyPostCode)
                {
                    ApplicationArea = All;
                    Tooltip = 'Tenancy postcode';
                }
                field(TenancyCity; Rec.TenancyCity)
                {
                    ApplicationArea = All;
                    Tooltip = 'Tenancy city';
                }

                field(LandlordName; Rec.LandlordName)
                {
                    ApplicationArea = All;
                    Tooltip = 'Name of landlord';
                }
                field(landlordAddress; Rec.landlordAddress)
                {
                    ApplicationArea = All;
                    Tooltip = 'Landlord address';
                }
                field(LandlordPostCode; Rec.LandlordPostCode)
                {
                    ApplicationArea = All;
                    Tooltip = 'Landlord postcode';
                }
                field(Landlordcity; Rec.Landlordcity)
                {
                    ApplicationArea = All;
                    Tooltip = 'Landlord city';
                }
                field(Representative; Rec.Representative)
                {
                    ApplicationArea = All;
                    Tooltip = 'Landlords reprensentavie name';
                }
                field(BebrepProperty; Rec.BebrepProperty)
                {
                    ApplicationArea = All;
                    Tooltip = 'Has the property a tenantgroup';
                }
                field(BebrepInd; Rec.BebrepInd)
                {
                    ApplicationArea = All;
                    Tooltip = 'Is tenantgroup representative summoned?';
                }
                field(BebrepTilstede; Rec.BebrepTilstede)
                {
                    ApplicationArea = All;
                    Tooltip = 'Is tentant representative present?';
                }
                field(BebrepName; Rec.BebrepName)
                {
                    ApplicationArea = All;
                    Tooltip = 'Tentant representatives name?';

                }
                field(BebrepEmail; Rec.BebrepEmail)
                {
                    ApplicationArea = All;
                    Tooltip = 'Tenant representatives email';
                }
                field(BebrepKopi; Rec.BebrepKopi)
                {
                    ApplicationArea = All;
                    Tooltip = 'Has tenant representative got a copy of this document?';
                }
            }
            group("Room 1")
            {
                Caption = 'Room 1';
                field(Room1Description; Rec.Room1Description)
                {
                    ApplicationArea = All;
                    Tooltip = 'Unique identifing of the room';
                }
                field(Rum1CeilingCondition; Rec.Rum1CeilingCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the ceiling?';
                }
                field(Rum1CeilingRepairs; Rec.Rum1CeilingRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Rum1WallsCondition; Rec.Rum1WallsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the walls?';
                }

                field(Rum1WallsRepairs; Rec.Rum1WallsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Rum1FloorsCondition; Rec.Rum1FloorsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the floor?';
                }
                field(Rum1FloorsRepairs; Rec.Rum1FloorsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Rum1CarpetsCondition; Rec.Rum1CarpetsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the carpets?';
                }
                field(Rum1CarpetsRepairs; Rec.Rum1CarpetsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Rum1WoodworksCondition; Rec.Rum1WoodworksCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the woodwork?';
                }
                field(Rum1WoodworksRepairs; Rec.Rum1WoodworksRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Rum1WindowsmvCondition; Rec.Rum1WindowsmvCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the windows etc.?';
                }
                field(Rum1WindowsRepairs; Rec.Rum1WindowsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Rum1RadiatorCondition; Rec.Rum1RadiatorCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the radiators?';
                }
                field(Rum1RadiatorRepairs; Rec.Rum1RadiatorRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Rum1ElCondition; Rec.Rum1ElCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of electricity parts?';
                }
                field(Rum1ElRepairs; Rec.Rum1ElRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Rum1DoorsCondition; Rec.Rum1DoorsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of doors?';
                }
                field(Rum1DoorsRepairs; Rec.Rum1DoorsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Room1Notes; Rec.Room1Notes)
                {
                    ApplicationArea = all;
                    ToolTip = 'Notes for this room';
                }
            }
            group("Room 2")
            {
                Caption = 'Room 2';
                field(Room2Description; Rec.Room2Description)
                {
                    ApplicationArea = All;
                    Tooltip = 'Unique identifing of the room';
                }
                field(Rum2CeilingCondition; Rec.Rum2CeilingCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the ceiling?';
                }
                field(Rum2CeilingRepairs; Rec.Rum2CeilingRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Rum2WallsCondition; Rec.Rum2WallsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the walls?';
                }
                field(Rum2WallsRepairs; Rec.Rum2WallsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Rum2FloorsCondition; Rec.Rum2FloorsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the floor?';
                }
                field(Rum2FloorsRepairs; Rec.Rum2FloorsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Rum2CarpetsCondition; Rec.Rum2CarpetsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the carpets?';
                }
                field(Rum2CarpetsRepairs; Rec.Rum2CarpetsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Rum2WoodworksCondition; Rec.Rum2WoodworksCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the woodwork?';
                }
                field(Rum2WoodworksRepairs; Rec.Rum2WoodworksRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Rum2WindowsmvCondition; Rec.Rum2WindowsmvCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the windows etc.?';
                }
                field(Rum2WindowsRepairs; Rec.Rum2WindowsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Rum2RadiatorCondition; Rec.Rum2RadiatorCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the radiators?';
                }
                field(Rum2RadiatorRepairs; Rec.Rum2RadiatorRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Rum2ElCondition; Rec.Rum2ElCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of electricity parts?';
                }
                field(Rum2ElRepairs; Rec.Rum2ElRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Rum2DoorsCondition; Rec.Rum2DoorsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of doors?';
                }
                field(Rum2DoorsRepairs; Rec.Rum2DoorsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Room2Notes; Rec.Room2Notes)
                {
                    ApplicationArea = all;
                    ToolTip = 'Notes for this room';
                }
            }
            group("Room 3")
            {
                Caption = 'Room 3';
                field(Room3Description; Rec.Room3Description)
                {
                    ApplicationArea = All;
                    Tooltip = 'Unique identifing of the room';
                }
                field(Rum3CeilingCondition; Rec.Rum3CeilingCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the ceiling?';
                }
                field(Rum3CeilingRepairs; Rec.Rum3CeilingRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Rum3WallsCondition; Rec.Rum3WallsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the walls?';
                }
                field(Rum3WallsRepairs; Rec.Rum3WallsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Rum3FloorsCondition; Rec.Rum3FloorsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the floor?';
                }
                field(Rum3FloorsRepairs; Rec.Rum3FloorsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Rum3CarpetsCondition; Rec.Rum3CarpetsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the carpets?';
                }
                field(Rum3CarpetsRepairs; Rec.Rum3CarpetsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Rum3WoodworksCondition; Rec.Rum3WoodworksCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the woodwork?';
                }
                field(Rum3WoodworksRepairs; Rec.Rum3WoodworksRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Rum3WindowsmvCondition; Rec.Rum3WindowsmvCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the windows etc.?';
                }
                field(Rum3WindowsRepairs; Rec.Rum3WindowsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Rum3RadiatorCondition; Rec.Rum3RadiatorCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the radiators?';
                }
                field(Rum3RadiatorRepairs; Rec.Rum3RadiatorRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Rum3ElCondition; Rec.Rum3ElCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of electricity parts?';
                }
                field(Rum3ElRepairs; Rec.Rum3ElRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Rum3DoorsCondition; Rec.Rum3DoorsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of doors?';
                }
                field(Rum3DoorsRepairs; Rec.Rum3DoorsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Room3Notes; Rec.Room3Notes)
                {
                    ApplicationArea = all;
                    ToolTip = 'Notes for this room';
                }
            }
            group("Room 4")
            {
                Caption = 'Room 4';
                field(Room4Description; Rec.Room4Description)
                {
                    ApplicationArea = All;
                    Tooltip = 'Unique identifing of the room';
                }
                field(Rum4CeilingCondition; Rec.Rum4CeilingCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the ceiling?';
                }
                field(Rum4CeilingRepairs; Rec.Rum4CeilingRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Rum4WallsCondition; Rec.Rum4WallsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the walls?';
                }
                field(Rum4WallsRepairs; Rec.Rum4WallsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Rum4FloorsCondition; Rec.Rum4FloorsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the floor?';
                }
                field(Rum4FloorsRepairs; Rec.Rum4FloorsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Rum4CarpetsCondition; Rec.Rum4CarpetsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the carpets?';
                }
                field(Rum4CarpetsRepairs; Rec.Rum4CarpetsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Rum4WoodworksCondition; Rec.Rum4WoodworksCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the woodwork?';
                }
                field(Rum4WoodworksRepairs; Rec.Rum4WoodworksRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Rum4WindowsmvCondition; Rec.Rum4WindowsmvCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the windows etc.?';
                }
                field(Rum4WindowsRepairs; Rec.Rum4WindowsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Rum4RadiatorCondition; Rec.Rum4RadiatorCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the radiators?';
                }
                field(Rum4RadiatorRepairs; Rec.Rum4RadiatorRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Rum4ElCondition; Rec.Rum4ElCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of electricity parts?';
                }
                field(Rum4ElRepairs; Rec.Rum4ElRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Rum4DoorsCondition; Rec.Rum4DoorsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of doors?';
                }
                field(Rum4DoorsRepairs; Rec.Rum4DoorsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(Room4Notes; Rec.Room4Notes)
                {
                    ApplicationArea = all;
                    ToolTip = 'Notes for this room';
                }
            }
            group(Entre)
            {
                Caption = 'Entre';
                field(EntreCeilingCondition; Rec.EntreCeilingCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the ceiling?';
                }
                field(EntreCeilingRepairs; Rec.EntreCeilingRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(EntreWallsCondition; Rec.EntreWallsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the walls?';
                }
                field(EntreWallsRepairs; Rec.EntreWallsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(EntreFloorsCondition; Rec.EntreFloorsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the floor?';
                }
                field(EntreFloorsRepairs; Rec.EntreFloorsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(EntreCarpetsCondition; Rec.EntreCarpetsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the carpets?';
                }
                field(EntreCarpetsRepairs; Rec.EntreCarpetsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(EntreWoodworksCondition; Rec.EntreWoodworksCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the woodwork?';
                }
                field(EntreWoodworksRepairs; Rec.EntreWoodworksRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(EntreWindowsmvCondition; Rec.EntreWindowsmvCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the windows etc.?';
                }
                field(EntreWindowsRepairs; Rec.EntreWindowsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(EntreRadiatorCondition; Rec.EntreRadiatorCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the radiators?';
                }
                field(EntreRadiatorRepairs; Rec.EntreRadiatorRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(EntreElCondition; Rec.EntreElCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of electricity parts?';
                }
                field(EntreElRepairs; Rec.EntreElRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(EntreDoorsCondition; Rec.EntreDoorsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of doors?';
                }
                field(EntreDoorsRepairs; Rec.EntreDoorsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(EntreNotes; Rec.EntreNotes)
                {
                    ApplicationArea = all;
                    ToolTip = 'Notes for this room';
                }
            }
            group(Kitchen)
            {
                Caption = 'Kitchen';
                field(KitchenCeilingCondition; Rec.KitchenCeilingCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the ceiling?';
                }
                field(KitchenCeilingRepairs; Rec.KitchenCeilingRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(KitchenWallsCondition; Rec.KitchenWallsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the walls?';
                }
                field(KitchenWallsRepairs; Rec.KitchenWallsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(KitchenFloorsCondition; Rec.KitchenFloorsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the floor?';
                }
                field(KitchenFloorsRepairs; Rec.KitchenFloorsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(KitchenCarpetsCondition; Rec.KitchenCarpetsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the carpets?';
                }
                field(KitchenCarpetsRepairs; Rec.KitchenCarpetsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(KitchenWoodworksCondition; Rec.KitchenWoodworksCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the woodwork?';
                }
                field(KitchenWoodworksRepairs; Rec.KitchenWoodworksRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(KitchenWindowsmvCondition; Rec.KitchenWindowsmvCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the windows etc.?';
                }
                field(KitchenWindowsRepairs; Rec.KitchenWindowsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(KitchenRadiatorCondition; Rec.KitchenRadiatorCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the radiators?';
                }
                field(KitchenRadiatorRepairs; Rec.KitchenRadiatorRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(KitchenElCondition; Rec.KitchenElCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of electricity parts?';
                }
                field(KitchenElRepairs; Rec.KitchenElRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(KitchenDoorsCondition; Rec.KitchenDoorsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of doors?';
                }
                field(KitchenDoorsRepairs; Rec.KitchenDoorsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(KitchenTilesConditions; Rec.KitchenTilesConditions)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the tiles?';
                }
                field(KitchenTilesRepairs; Rec.KitchenTilesRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(KitchenTableCondition; Rec.KitchenTableCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the tables?';
                }
                field(KitchenTableRepairs; Rec.KitchenTableRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(KitchenSinkCondition; Rec.KitchenSinkCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the sink?';
                }
                field(KitchensinkRepairs; Rec.KitchensinkRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(KitchenCabinetsCondition; Rec.KitchenCabinetsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the cabinets?';
                }
                field(KitchenCabinetsRepairs; Rec.KitchenCabinetsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(KitchenWatertapsCondition; Rec.KitchenWatertapsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the watertaps?';
                }
                field(KitchenWatertapsRepairs; Rec.KitchenWatertapsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(KitchenNotes; Rec.KitchenNotes)
                {
                    ApplicationArea = all;
                    ToolTip = 'Notes for this room';
                }
            }
            group(Bathroom)
            {
                Caption = 'Bathroom';
                field(BathroomCeilingCondition; Rec.BathroomCeilingCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the ceiling?';
                }
                field(BathroomCeilingRepairs; Rec.BathroomCeilingRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(BathroomWallsCondition; Rec.BathroomWallsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the walls?';
                }
                field(BathroomWallsRepairs; Rec.BathroomWallsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(BathroomFloorsCondition; Rec.BathroomFloorsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the floor?';
                }
                field(BathroomFloorsRepairs; Rec.BathroomFloorsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(BathroomCarpetsCondition; Rec.BathroomCarpetsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the carpets?';
                }
                field(BathroomCarpetsRepairs; Rec.BathroomCarpetsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(BathroomWoodworksCondition; Rec.BathroomWoodworksCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the woodwork?';
                }
                field(BathroomWoodworksRepairs; Rec.BathroomWoodworksRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(BathroomWindowsmvCondition; Rec.BathroomWindowsmvCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the windows etc.?';
                }
                field(BathroomWindowsRepairs; Rec.BathroomWindowsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(BathroomRadiatorCondition; Rec.BathroomRadiatorCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the radiators?';
                }
                field(BathroomRadiatorRepairs; Rec.BathroomRadiatorRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(BathroomElCondition; Rec.BathroomElCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of electricity parts?';
                }
                field(BathroomElRepairs; Rec.BathroomElRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(BathroomDoorsCondition; Rec.BathroomDoorsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of doors?';
                }
                field(BathroomDoorsRepairs; Rec.BathroomDoorsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(BathroomSinkCondition; Rec.BathroomSinkCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of sink?';
                }
                field(BathroomSinkRepairs; Rec.BathroomSinkRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(BathroomCisternDoorsCondition; Rec.BathroomCisternDoorsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of cistern?';
                }
                field(BathroomCisternRepairs; Rec.BathroomCisternRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(BathroomToiletBowlCondition; Rec.BathroomToiletBowlCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of toiletbowl?';
                }
                field(BathroomToiletBowlRepairs; Rec.BathroomToiletBowlRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(BathroomBathtopCondition; Rec.BathroomBathtopCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of Bathtop?';
                }
                field(BathroombathTopRepairs; Rec.BathroombathTopRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(BathroomShowerCondition; Rec.BathroomShowerCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of shower?';
                }
                field(BathroomShowerRepairs; Rec.BathroomShowerRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(BathroomWaterTapsCondition; Rec.BathroomWaterTapsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of watertaps?';
                }
                field(BathroomWaterTapsRepairs; Rec.BathroomWaterTapsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(BathroomNotes; Rec.BathroomNotes)
                {
                    ApplicationArea = all;
                    ToolTip = 'Notes for this room';
                }
            }
            group(Toilet)
            {
                Caption = 'Toilet';
                field(ToiletCeilingCondition; Rec.ToiletCeilingCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the ceiling?';
                }
                field(ToiletCeilingRepairs; Rec.ToiletCeilingRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(ToiletWallsCondition; Rec.ToiletWallsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the walls?';
                }
                field(ToiletWallsRepairs; Rec.ToiletWallsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(ToiletFloorsCondition; Rec.ToiletFloorsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the floor?';
                }
                field(ToiletFloorsRepairs; Rec.ToiletFloorsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(ToiletCarpetsCondition; Rec.ToiletCarpetsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the carpets?';
                }
                field(ToiletCarpetsRepairs; Rec.ToiletCarpetsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(ToiletWoodworksCondition; Rec.ToiletWoodworksCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the woodwork?';
                }
                field(ToiletWoodworksRepairs; Rec.ToiletWoodworksRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(ToiletWindowsmvCondition; Rec.ToiletWindowsmvCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the windows etc.?';
                }
                field(ToiletWindowsRepairs; Rec.ToiletWindowsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(ToiletRadiatorCondition; Rec.ToiletRadiatorCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the radiators?';
                }
                field(ToiletRadiatorRepairs; Rec.ToiletRadiatorRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(ToiletElCondition; Rec.ToiletElCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of electricity parts?';
                }
                field(ToiletElRepairs; Rec.ToiletElRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(ToiletDoorsCondition; Rec.ToiletDoorsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of doors?';
                }
                field(ToiletDoorsRepairs; Rec.ToiletDoorsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(ToiletSinkCondition; Rec.ToiletSinkCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the sink?';
                }
                field(ToiletSinkRepairs; Rec.ToiletSinkRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(ToiletCisternDoorsCondition; Rec.ToiletCisternDoorsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the cistern?';
                }
                field(ToiletCisternRepairs; Rec.ToiletCisternRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(ToiletToiletBowlCondition; Rec.ToiletToiletBowlCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of the toiletbowl?';
                }
                field(ToiletToiletBowlRepairs; Rec.ToiletToiletBowlRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(ToiletwaterTapsCondition; Rec.ToiletwaterTapsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'What is the condition of watertaps?';
                }
                field(ToiletWaterTapsRepairs; Rec.ToiletWaterTapsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                }
                field(ToiletroomNotes; Rec.ToiletroomNotes)
                {
                    ApplicationArea = all;
                    ToolTip = 'Notes for this room';
                }
            }
            group(Appliances)
            {
                Caption = 'Appliances';
                Group(stove)
                {
                    Caption = 'Stove';
                    field(StoveYear; Rec.StoveYear)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Year of production.';
                    }
                    field(StoveManufactor; Rec.StoveManufactor)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Who is the manufactor?';
                    }
                    field(StoveModel; Rec.StoveModel)
                    {
                        ApplicationArea = all;
                        Tooltip = 'Model designation';
                    }
                    field(StoveCondition; Rec.StoveCondition)
                    {
                        ApplicationArea = All;
                        Tooltip = 'What is the condition of the stove?';
                    }
                    field(StoveRepairs; Rec.StoveRepairs)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                    }
                }
                group(Cook)
                {
                    Caption = 'Cook';

                    field(CookYear; Rec.CookYear)
                    {
                        ApplicationArea = all;
                        Tooltip = 'Year of production.';
                    }
                    field(CookManufactor; Rec.CookManufactor)
                    {
                        ApplicationArea = all;
                        Tooltip = 'Who is the manufactor?';
                    }
                    field(CookModel; Rec.CookModel)
                    {
                        ApplicationArea = all;
                        Tooltip = 'Model designation';
                    }
                    field(CookCondition; Rec.CookCondition)
                    {
                        ApplicationArea = All;
                        Tooltip = 'What is the condition of the Cook?';
                    }
                    field(CookRepairs; Rec.CookRepairs)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                    }

                }
                Group(Oven)
                {
                    Caption = 'Oven';
                    field(OvenYear; Rec.OvenYear)
                    {
                        ApplicationArea = all;
                        Tooltip = 'Year of production.';
                    }
                    field(OvenManufactor; Rec.OvenManufactor)
                    {
                        ApplicationArea = all;
                        Tooltip = 'Who is the manufactor?';
                    }
                    field(OvenModel; Rec.OvenModel)
                    {
                        ApplicationArea = all;
                        Tooltip = 'Model designation';
                    }
                    field(OvenCondition; Rec.OvenCondition)
                    {
                        ApplicationArea = All;
                        Tooltip = 'What is the condition of the Oven?';
                    }
                    field(OvenRepairs; Rec.OvenRepairs)
                    {
                        ApplicationArea = all;
                        Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                    }
                }
                group(Hood)
                {
                    Caption = 'Hood';
                    field(HoodYear; Rec.HoodYear)
                    {
                        ApplicationArea = all;
                        Tooltip = 'Year of production.';
                    }
                    field(HoodManufactor; Rec.HoodManufactor)
                    {
                        ApplicationArea = all;
                        Tooltip = 'Who is the manufactor?';
                    }
                    field(HoodStoveModel; Rec.HoodStoveModel)
                    {
                        ApplicationArea = all;
                        Tooltip = 'Model designation';
                    }
                    field(HoodCondition; Rec.HoodCondition)
                    {
                        ApplicationArea = All;
                        Tooltip = 'What is the condition of the hood?';
                    }
                    field(HoodRepairs; Rec.HoodeRepairs)
                    {
                        ApplicationArea = all;
                        Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                    }
                }
                group(Fridge)
                {
                    Caption = 'Fridge';
                    field(FridgeYear; Rec.FridgeYear)
                    {
                        ApplicationArea = all;
                        Tooltip = 'Year of production.';
                    }
                    field(FridgeManufactor; Rec.FridgeManufactor)
                    {
                        ApplicationArea = all;
                        Tooltip = 'Who is the manufactor?';
                    }
                    field(FridgeModel; Rec.FridgeModel)
                    {
                        ApplicationArea = all;
                        Tooltip = 'Model designation';
                    }
                    field(FridgeCondition; Rec.FridgeCondition)
                    {
                        ApplicationArea = All;
                        Tooltip = 'What is the condition of the fridge?';
                    }
                    field(FridgeRepairs; Rec.FridgeRepairs)
                    {
                        ApplicationArea = all;
                        Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                    }
                }
                group(Freezer)
                {
                    Caption = 'Frezer';
                    field(FreezerYear; Rec.FreezerYear)
                    {
                        ApplicationArea = all;
                        Tooltip = 'Year of production.';
                    }
                    field(FreezerManufactor; Rec.FreezerManufactor)
                    {
                        ApplicationArea = all;
                        Tooltip = 'Who is the manufactor?';
                    }
                    field(FreezerModel; Rec.FreezerModel)
                    {
                        ApplicationArea = all;
                        Tooltip = 'Model designation';
                    }
                    field(FreezerCondition; Rec.FreezerCondition)
                    {
                        ApplicationArea = All;
                        Tooltip = 'What is the condition of the freezer?';
                    }
                    field(FreezerRepairs; Rec.FreezerRepairs)
                    {
                        ApplicationArea = all;
                        Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                    }
                }
                Group(Dishwasher)
                {
                    Caption = 'Dishwasher';
                    field(DishwasherYear; Rec.DishwasherYear)
                    {
                        ApplicationArea = all;
                        Tooltip = 'Year of production.';
                    }
                    field(DishwasherManufactor; Rec.DishwasherManufactor)
                    {
                        ApplicationArea = all;
                        Tooltip = 'Who is the manufactor?';
                    }
                    field(DishwasherModel; Rec.DishwasherModel)
                    {
                        ApplicationArea = all;
                        Tooltip = 'Model designation';
                    }
                    field(DishwasherCondition; Rec.DishwasherCondition)
                    {
                        ApplicationArea = All;
                        Tooltip = 'What is the condition of the dishwasher?';
                    }
                    field(DishwasherRepairs; Rec.DishwasherRepairs)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                    }
                }
                group(Washer)
                {
                    Caption = 'Washer';
                    field(WasherYear; Rec.WasherYear)
                    {
                        ApplicationArea = all;
                        Tooltip = 'Year of production.';
                    }
                    field(WasherManufactor; Rec.WasherManufactor)
                    {
                        ApplicationArea = all;
                        Tooltip = 'Who is the manufactor?';
                    }
                    field(WasherModel; Rec.WasherModel)
                    {
                        ApplicationArea = all;
                        Tooltip = 'Model designation';
                    }
                    field(WasherCondition; Rec.WasherCondition)
                    {
                        ApplicationArea = All;
                        Tooltip = 'What is the condition of the washer?';
                    }
                    field(WasherRepairs; Rec.WasherRepairs)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                    }
                }
                group(Dryer)
                {
                    Caption = 'Dryer';
                    field(DryerYear; Rec.DryerYear)
                    {
                        ApplicationArea = all;
                        Tooltip = 'Year of production.';
                    }
                    field(DryerManufactor; Rec.DryerManufactor)
                    {
                        ApplicationArea = all;
                        Tooltip = 'Who is the manufactor?';
                    }
                    field(DryerModel; Rec.DryerModel)
                    {
                        ApplicationArea = all;
                        Tooltip = 'Model designation';
                    }
                    field(DryerCondition; Rec.DryerCondition)
                    {
                        ApplicationArea = All;
                        Tooltip = 'What is the condition of the dryer?';
                    }
                    field(DryerRepairs; Rec.DryerRepairs)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                    }
                }
            }
            group(Others)
            {
                Caption = 'Other';
                group(Antenna)
                {
                    Caption = 'Antenna';
                    field(AntennaCondition; Rec.AntennaCondition)
                    {
                        ApplicationArea = All;
                        Tooltip = 'What is the condition of the antenna?';
                    }
                    field(AntennaRepairs; Rec.AntennaRepairs)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                    }
                }
                group(Laundry)
                {
                    Caption = 'Laundry';

                    field(WashKeymanufactor; Rec.WashKeymanufactor)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Who is the Wash key manufactor?';
                    }
                    field(WashKeyQty; Rec.WashKeyQty)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Provided quantity';
                    }

                }
                group(EntryPhone)
                {
                    Caption = 'EntryPhone';

                    field(EntryPhoneYear; Rec.EntryPhoneYear)
                    {
                        ApplicationArea = all;
                        Tooltip = 'Year of production.';
                    }
                    field(EntryPhoneManufactor; Rec.EntryPhoneManufactor)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Who is the manufactor?';
                    }
                    field(EntryPhoneModel; Rec.EntryPhoneModel)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Model designation';
                    }
                    field(EntryPhoneCondition; Rec.EntryPhoneCondition)
                    {
                        ApplicationArea = All;
                        Tooltip = 'What is the condition of the entryphone?';
                    }
                    field(EntryPhoneRepairs; Rec.EntryPhoneRepairs)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                    }
                }
                Group(Mailbox)
                {
                    Caption = 'Mailbox';

                    field(MailboxYear; Rec.MailboxYear)
                    {
                        ApplicationArea = all;
                        Tooltip = 'Year of production.';
                    }
                    field(MailboxManufactor; Rec.MailboxManufactor)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Who is the manufactor?';
                    }
                    field(MailboxModel; Rec.MailboxModel)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Model designation';
                    }
                    field(MailboxCondition; Rec.MailboxCondition)
                    {
                        ApplicationArea = All;
                        Tooltip = 'What is the condition of the mailbox?';
                    }
                    field(MailboxRepairs; Rec.MailboxRepairs)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                    }
                }
                Group(Keys)
                {
                    Caption = 'Keys';
                    field(KeyCondition; Rec.KeyCondition)
                    {
                        ApplicationArea = all;
                        Tooltip = 'What is the condition of the key?';
                    }
                    field(KeyRepairs; Rec.KeyRepairs)
                    {
                        ApplicationArea = all;
                        Tooltip = 'Who is responsible for repairs? (None means that nothing has to be done';
                    }
                    field(Keymanufactor; Rec.Keymanufactor)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Who is the manufactor?';
                    }
                    field(KeyQty; Rec.KeyQty)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Provided quantity';
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
                    Tooltip = 'Report for moving in status';
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

