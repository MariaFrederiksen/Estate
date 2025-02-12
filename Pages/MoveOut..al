page 50008 "SVA MoveOut"
{
    PageType = Card;
    SourceTable = "SVA MovingOut Status";
    Caption = 'Moving out status';
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
                    ApplicationArea = All;
                    ToolTip = 'Occupant';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Name';
                }
                field(Name2; Rec.Name2)
                {
                    ApplicationArea = All;
                    ToolTip = 'Name on second occupant';
                }
                field("Address (new)"; Rec."Address (new)")
                {
                    ApplicationArea = All;
                    Tooltip = 'New address';
                }
                field(PostCode; Rec.PostCode)
                {
                    ApplicationArea = All;
                    ToolTip = 'Postcode';
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                    ToolTip = 'City';
                }
                field(TenancyNo; Rec.TenancyNo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Tenancy No.';
                }
                field(TenancyAddress; Rec.TenancyAddress)
                {
                    ApplicationArea = All;
                    Tooltip = 'Tenancy address';
                }
                field(TenancyPostCode; Rec.TenancyPostCode)
                {
                    ApplicationArea = All;
                    Tooltip = 'Tenancy Postcode';
                }
                field(TenancyCity; Rec.TenancyCity)
                {
                    ApplicationArea = All;
                    Tooltip = 'Tenancy city';
                }
                field(LandlordName; Rec.LandlordName)
                {
                    ApplicationArea = All;
                    Tooltip = 'Landlord';
                }
                field(landlordAddress; Rec.landlordAddress)
                {
                    ApplicationArea = All;
                    Tooltip = 'Landlord address';
                }
                field(LandlordPostCode; Rec.LandlordPostCode)
                {
                    ApplicationArea = All;
                    Tooltip = 'Landlord Postcode';
                }
                field(Landlordcity; Rec.Landlordcity)
                {
                    ApplicationArea = All;
                    Tooltip = 'Landlord city';
                }
                field(Representative; Rec.Representative)
                {
                    ApplicationArea = All;
                    Tooltip = 'Occupant representative';
                }
                field(BebrepProperty; Rec.BebrepProperty)
                {
                    ApplicationArea = All;
                    Tooltip = 'Is there occupant representative at the property?';
                }
                field(BebrepInd; Rec.BebrepInd)
                {
                    ApplicationArea = All;
                    Tooltip = 'Occupant representative called in';
                }
                field(BebrepTilstede; Rec.BebrepTilstede)
                {
                    ApplicationArea = All;
                    Tooltip = 'Occupant representative present';
                }
                field(BebrepName; Rec.BebrepName)
                {
                    ApplicationArea = All;
                    Tooltip = 'Occupant representative name';
                }
                field(BebrepEmail; Rec.BebrepEmail)
                {
                    ApplicationArea = All;
                    Tooltip = 'Occupant representative email';
                }
                field(BebrepKopi; Rec.BebrepKopi)
                {
                    ApplicationArea = All;
                    Tooltip = 'Do occupant representative get a copy';
                }
            }
            group("Room 1")
            {
                Caption = 'Room 1';
                field(Room1Description; Rec.Room1Description)
                {
                    ApplicationArea = All;
                    Tooltip = 'Unique description of the room (livingroom, room facing west)';
                }
                field(Rum1CeilingCondition; Rec.Rum1CeilingCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'Ceiling condition';
                }
                field(Rum1CeilingRepairs; Rec.Rum1CeilingRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Repairs of the ceiling';
                }
                field(Rum1WallsCondition; Rec.Rum1WallsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'Condition of walls';
                }
                field(Rum1WallsRepairs; Rec.Rum1WallsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Repairs of the walls';
                }
                field(Rum1FloorsCondition; Rec.Rum1FloorsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'Condition of floor';
                }
                field(Rum1FloorsRepairs; Rec.Rum1FloorsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Repairs of the floor';
                }
                field(Rum1CarpetsCondition; Rec.Rum1CarpetsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'Condition of carpet';
                }
                field(Rum1CarpetsRepairs; Rec.Rum1CarpetsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Repairs of the carpet';
                }
                field(Rum1WoodworksCondition; Rec.Rum1WoodworksCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'Condition of woodwork';
                }
                field(Rum1WoodworksRepairs; Rec.Rum1WoodworksRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Repairs of the woodwork';
                }
                field(Rum1WindowsmvCondition; Rec.Rum1WindowsmvCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'Condition of windows etc';
                }
                field(Rum1WindowsRepairs; Rec.Rum1WindowsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Repairs of the windows';
                }
                field(Rum1RadiatorCondition; Rec.Rum1RadiatorCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'Condition of radiator';
                }
                field(Rum1RadiatorRepairs; Rec.Rum1RadiatorRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Repairs of radiator';
                }
                field(Rum1ElCondition; Rec.Rum1ElCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'Condition of the electric installations';
                }
                field(Rum1ElRepairs; Rec.Rum1ElRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Repairs of the electric installations';
                }
                field(Rum1DoorsCondition; Rec.Rum1DoorsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'Condition of the door(s)';
                }
                field(Rum1DoorsRepairs; Rec.Rum1DoorsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Repairs of the door(s)';
                }
            }
            group("Room 2")
            {
                Caption = 'Room 2';
                field(Room2Description; Rec.Room2Description)
                {
                    ApplicationArea = All;
                    Tooltip = 'Unique description of the room (livingroom, room facing west)';
                }
                field(Rum2CeilingCondition; Rec.Rum2CeilingCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'Ceiling condition';
                }
                field(Rum2CeilingRepairs; Rec.Rum2CeilingRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Repairs of the ceiling';
                }
                field(Rum2WallsCondition; Rec.Rum2WallsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'Condition of walls';
                }
                field(Rum2WallsRepairs; Rec.Rum2WallsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Repairs of the walls';
                }
                field(Rum2FloorsCondition; Rec.Rum2FloorsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'Condition of floor';
                }
                field(Rum2FloorsRepairs; Rec.Rum2FloorsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Repairs of the floor';
                }
                field(Rum2CarpetsCondition; Rec.Rum2CarpetsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'Condition of carpet';
                }
                field(Rum2CarpetsRepairs; Rec.Rum2CarpetsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Repairs of the carpet';
                }
                field(Rum2WoodworksCondition; Rec.Rum2WoodworksCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'Condition of woodwork';
                }
                field(Rum2WoodworksRepairs; Rec.Rum2WoodworksRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Repairs of the woodwork';
                }
                field(Rum2WindowsmvCondition; Rec.Rum2WindowsmvCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'Condition of windows etc';
                }
                field(Rum2WindowsRepairs; Rec.Rum2WindowsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Repairs of the windows';
                }
                field(Rum2RadiatorCondition; Rec.Rum2RadiatorCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'Condition of radiator';
                }
                field(Rum2RadiatorRepairs; Rec.Rum2RadiatorRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Repairs of radiator';
                }
                field(Rum2ElCondition; Rec.Rum2ElCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'Condition of the electric installation';
                }
                field(Rum2ElRepairs; Rec.Rum2ElRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Repairs of the electric installations';
                }
                field(Rum2DoorsCondition; Rec.Rum2DoorsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'Condition of the door(s)';
                }
                field(Rum2DoorsRepairs; Rec.Rum2DoorsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Repairs of the door(s)';
                }
            }
            group("Room 3")
            {
                Caption = 'Room 3';
                field(Room3Description; Rec.Room3Description)
                {
                    ApplicationArea = All;
                    Tooltip = 'Unique description of the room (livingroom, room facing west)';
                }
                field(Rum3CeilingCondition; Rec.Rum3CeilingCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'Ceiling condition';
                }
                field(Rum3CeilingRepairs; Rec.Rum3CeilingRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Repairs of the ceiling';
                }
                field(Rum3WallsCondition; Rec.Rum3WallsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'Condition of walls';
                }
                field(Rum3WallsRepairs; Rec.Rum3WallsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Repairs of the walls';
                }
                field(Rum3FloorsCondition; Rec.Rum3FloorsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'Condition of floor';
                }
                field(Rum3FloorsRepairs; Rec.Rum3FloorsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Repairs of the floor';
                }
                field(Rum3CarpetsCondition; Rec.Rum3CarpetsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'Condition of carpet';
                }
                field(Rum3CarpetsRepairs; Rec.Rum3CarpetsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Repairs of the carpet';
                }
                field(Rum3WoodworksCondition; Rec.Rum3WoodworksCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'Condition of woodwork';
                }
                field(Rum3WoodworksRepairs; Rec.Rum3WoodworksRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Repairs of the woodwork';
                }
                field(Rum3WindowsmvCondition; Rec.Rum3WindowsmvCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'Condition of windows etc';
                }
                field(Rum3WindowsRepairs; Rec.Rum3WindowsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Repairs of the windows';
                }
                field(Rum3RadiatorCondition; Rec.Rum3RadiatorCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'Condition of radiator';
                }
                field(Rum3RadiatorRepairs; Rec.Rum3RadiatorRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Repairs of radiator';
                }
                field(Rum3ElCondition; Rec.Rum3ElCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'Condition of the electric installation';
                }
                field(Rum3ElRepairs; Rec.Rum3ElRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Repairs of the electric installations';
                }
                field(Rum3DoorsCondition; Rec.Rum3DoorsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'Condition of the door(s)';
                }
                field(Rum3DoorsRepairs; Rec.Rum3DoorsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Repairs of the door(s)';
                }
            }
            group("Room 4")
            {
                Caption = 'Room 4';
                field(Room4Description; Rec.Room4Description)
                {
                    ApplicationArea = All;
                    Tooltip = 'Unique description of the room (livingroom, room facing west)';
                }
                field(Rum4CeilingCondition; Rec.Rum4CeilingCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'Ceiling condition';
                }
                field(Rum4CeilingRepairs; Rec.Rum4CeilingRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Repairs of the ceiling';
                }
                field(Rum4WallsCondition; Rec.Rum4WallsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'Condition of walls';
                }
                field(Rum4WallsRepairs; Rec.Rum4WallsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Repairs of the walls';
                }
                field(Rum4FloorsCondition; Rec.Rum4FloorsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'Condition of floor';
                }
                field(Rum4FloorsRepairs; Rec.Rum4FloorsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Repairs of the floor';
                }
                field(Rum4CarpetsCondition; Rec.Rum4CarpetsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'Condition of carpet';
                }
                field(Rum4CarpetsRepairs; Rec.Rum4CarpetsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Repairs of the carpet';
                }
                field(Rum4WoodworksCondition; Rec.Rum4WoodworksCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'Condition of woodwork';
                }
                field(Rum4WoodworksRepairs; Rec.Rum4WoodworksRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Repairs of the woodwork';
                }
                field(Rum4WindowsmvCondition; Rec.Rum4WindowsmvCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'Condition of windows etc';
                }
                field(Rum4WindowsRepairs; Rec.Rum4WindowsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Repairs of the windows';
                }
                field(Rum4RadiatorCondition; Rec.Rum4RadiatorCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'Condition of radiator';
                }
                field(Rum4RadiatorRepairs; Rec.Rum4RadiatorRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Repairs of radiator';
                }
                field(Rum4ElCondition; Rec.Rum4ElCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'Condition of the electric installation';
                }
                field(Rum4ElRepairs; Rec.Rum4ElRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Repairs of the electric installations';
                }
                field(Rum4DoorsCondition; Rec.Rum4DoorsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'Condition of the door(s)';
                }
                field(Rum4DoorsRepairs; Rec.Rum4DoorsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Repairs of the door(s)';
                }
            }
            group(Entre)
            {
                Caption = 'Entre';
                field(EntreCeilingCondition; Rec.EntreCeilingCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'Ceiling condition';
                }
                field(EntreCeilingRepairs; Rec.EntreCeilingRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Repairs of the ceiling';
                }
                field(EntreWallsCondition; Rec.EntreWallsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'Condition of walls';
                }
                field(EntreWallsRepairs; Rec.EntreWallsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Repairs of the walls';
                }
                field(EntreFloorsCondition; Rec.EntreFloorsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'Condition of floor';
                }
                field(EntreFloorsRepairs; Rec.EntreFloorsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Repairs of the floor';
                }
                field(EntreCarpetsCondition; Rec.EntreCarpetsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'Condition of carpet';
                }
                field(EntreCarpetsRepairs; Rec.EntreCarpetsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Repairs of the carpet';
                }
                field(EntreWoodworksCondition; Rec.EntreWoodworksCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'Condition of woodwork';
                }
                field(EntreWoodworksRepairs; Rec.EntreWoodworksRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Repairs of the woodwork';
                }
                field(EntreWindowsmvCondition; Rec.EntreWindowsmvCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'Condition of windows etc';
                }
                field(EntreWindowsRepairs; Rec.EntreWindowsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Repairs of the windows';
                }
                field(EntreRadiatorCondition; Rec.EntreRadiatorCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'Condition of radiator';
                }
                field(EntreRadiatorRepairs; Rec.EntreRadiatorRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Repairs of radiator';
                }
                field(EntreElCondition; Rec.EntreElCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'Condition of the electric installation';
                }
                field(EntreElRepairs; Rec.EntreElRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Repairs of the electric installations';
                }
                field(EntreDoorsCondition; Rec.EntreDoorsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'Condition of the door(s)';
                }
                field(EntreDoorsRepairs; Rec.EntreDoorsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Repairs of the door(s)';
                }
            }
            group(Kitchen)
            {
                Caption = 'Kitchen';
                field(KitchenCeilingCondition; Rec.KitchenCeilingCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'Ceiling condition';
                }
                field(KitchenCeilingRepairs; Rec.KitchenCeilingRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Repairs of the ceiling';
                }
                field(KitchenWallsCondition; Rec.KitchenWallsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'Condition of walls';
                }
                field(KitchenWallsRepairs; Rec.KitchenWallsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Repairs of the walls';
                }
                field(KitchenFloorsCondition; Rec.KitchenFloorsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'Condition of floor';
                }
                field(KitchenFloorsRepairs; Rec.KitchenFloorsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Repairs of the floor';
                }
                field(KitchenCarpetsCondition; Rec.KitchenCarpetsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'Condition of carpet';
                }
                field(KitchenCarpetsRepairs; Rec.KitchenCarpetsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Repairs of the carpet';
                }
                field(KitchenWoodworksCondition; Rec.KitchenWoodworksCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'Condition of woodwork';
                }
                field(KitchenWoodworksRepairs; Rec.KitchenWoodworksRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Repairs of the woodwork';
                }
                field(KitchenWindowsmvCondition; Rec.KitchenWindowsmvCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'Condition of windows etc';
                }
                field(KitchenWindowsRepairs; Rec.KitchenWindowsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Repairs of the windows';
                }
                field(KitchenRadiatorCondition; Rec.KitchenRadiatorCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'Condition of radiator';
                }
                field(KitchenRadiatorRepairs; Rec.KitchenRadiatorRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Repairs of radiator';
                }
                field(KitchenElCondition; Rec.KitchenElCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'Condition of the electric installation';
                }
                field(KitchenElRepairs; Rec.KitchenElRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Repairs of the electric installations';
                }
                field(KitchenDoorsCondition; Rec.KitchenDoorsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'Condition of the door(s)';
                }
                field(KitchenDoorsRepairs; Rec.KitchenDoorsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Repairs of the door(s)';
                }
                field(KitchenTilesConditions; Rec.KitchenTilesConditions)
                {
                    ApplicationArea = All;
                    Tooltip = 'Condition of tiles in the kitchen';
                }
                field(KitchenTilesRepairs; Rec.KitchenTilesRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Repairs of tiles in the kitchen';
                }
                field(KitchenTableCondition; Rec.KitchenTableCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'Condition of kitchentable';
                }
                field(KitchenTableRepairs; Rec.KitchenTableRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Repairs of kitchentable';
                }
                field(KitchenSinkCondition; Rec.KitchenSinkCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'Condition of the sink';
                }
                field(KitchensinkRepairs; Rec.KitchensinkRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Repairs of the sink';
                }
                field(KitchenCabinetsCondition; Rec.KitchenCabinetsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'Condition of cabinets.';
                }
                field(KitchenCabinetsRepairs; Rec.KitchenCabinetsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Repairs of cabinets';
                }
                field(KitchenWatertapsCondition; Rec.KitchenWatertapsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'Condition of the watertap';
                }
                field(KitchenWatertapsRepairs; Rec.KitchenWatertapsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Repairs of the watertap';
                }
            }
            group(Bathroom)
            {
                Caption = 'Bathroom';
                field(BathroomCeilingCondition; Rec.BathroomCeilingCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'Ceiling condition';
                }
                field(BathroomCeilingRepairs; Rec.BathroomCeilingRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Repairs of the ceiling';
                }
                field(BathroomWallsCondition; Rec.BathroomWallsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'Condition of walls';
                }
                field(BathroomWallsRepairs; Rec.BathroomWallsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Repairs of the walls';
                }
                field(BathroomFloorsCondition; Rec.BathroomFloorsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'Condition of floor';
                }
                field(BathroomFloorsRepairs; Rec.BathroomFloorsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Repairs of the floor';
                }
                field(BathroomCarpetsCondition; Rec.BathroomCarpetsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'Condition of carpet';
                }
                field(BathroomCarpetsRepairs; Rec.BathroomCarpetsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Repairs of the carpet';
                }
                field(BathroomWoodworksCondition; Rec.BathroomWoodworksCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'Condition of woodwork';
                }
                field(BathroomWoodworksRepairs; Rec.BathroomWoodworksRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Repairs of the woodwork';
                }
                field(BathroomWindowsmvCondition; Rec.BathroomWindowsmvCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'Condition of windows etc';
                }
                field(BathroomWindowsRepairs; Rec.BathroomWindowsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Repairs of the windows';
                }
                field(BathroomRadiatorCondition; Rec.BathroomRadiatorCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'Condition of radiator';
                }
                field(BathroomRadiatorRepairs; Rec.BathroomRadiatorRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Repairs of radiator';
                }
                field(BathroomElCondition; Rec.BathroomElCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'Condition of the electric installation';
                }
                field(BathroomElRepairs; Rec.BathroomElRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Repairs of the electric installations';
                }
                field(BathroomDoorsCondition; Rec.BathroomDoorsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'Condition of the door(s)';
                }
                field(BathroomDoorsRepairs; Rec.BathroomDoorsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Repairs of the door(s)';
                }
                field(BathroomSinkCondition; Rec.BathroomSinkCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'Condition of the sink';
                }
                field(BathroomSinkRepairs; Rec.BathroomSinkRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Repairs of sink';
                }
                field(BathroomCisternDoorsCondition; Rec.BathroomCisternDoorsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'Condition of the door(s)';
                }
                field(BathroomCisternRepairs; Rec.BathroomCisternRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Repairs of the cistern';
                }
                field(BathroomToiletBowlCondition; Rec.BathroomToiletBowlCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'Condition of the toilet bowl';
                }
                field(BathroomToiletBowlRepairs; Rec.BathroomToiletBowlRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Repairs of the toilet bowl';
                }
                field(BathroomBathtopCondition; Rec.BathroomBathtopCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'Condition of Bathtop';
                }
                field(BathroombathTopRepairs; Rec.BathroombathTopRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Repairs of Bathtop';
                }
                field(BathroomShowerCondition; Rec.BathroomShowerCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'Condition of the shower';
                }
                field(BathroomShowerRepairs; Rec.BathroomShowerRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Repairs of shower';
                }
                field(BathroomWaterTapsCondition; Rec.BathroomWaterTapsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'Condition of the watertap';
                }
                field(BathroomWaterTapsRepairs; Rec.BathroomWaterTapsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Repairs of the watertap';
                }
            }
            group(Toilet)
            {
                Caption = 'Toilet';
                field(ToiletCeilingCondition; Rec.ToiletCeilingCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'Ceiling condition';
                }
                field(ToiletCeilingRepairs; Rec.ToiletCeilingRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Repairs of the ceiling';
                }
                field(ToiletWallsCondition; Rec.ToiletWallsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'Condition of walls';
                }
                field(ToiletWallsRepairs; Rec.ToiletWallsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Repairs of the walls';
                }
                field(ToiletFloorsCondition; Rec.ToiletFloorsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'Condition of floor';
                }
                field(ToiletFloorsRepairs; Rec.ToiletFloorsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Repairs of the floor';
                }
                field(ToiletCarpetsCondition; Rec.ToiletCarpetsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'Condition of carpet';
                }
                field(ToiletCarpetsRepairs; Rec.ToiletCarpetsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Repairs of the carpet';
                }
                field(ToiletWoodworksCondition; Rec.ToiletWoodworksCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'Condition of woodwork';
                }
                field(ToiletWoodworksRepairs; Rec.ToiletWoodworksRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Repairs of the woodwork';
                }
                field(ToiletWindowsmvCondition; Rec.ToiletWindowsmvCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'Condition of windows etc';
                }
                field(ToiletWindowsRepairs; Rec.ToiletWindowsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Repairs of the windows';
                }
                field(ToiletRadiatorCondition; Rec.ToiletRadiatorCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'Condition of radiator';
                }
                field(ToiletRadiatorRepairs; Rec.ToiletRadiatorRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Repairs of radiator';
                }
                field(ToiletElCondition; Rec.ToiletElCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'Condition of the electric installations';
                }
                field(ToiletElRepairs; Rec.ToiletElRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Repairs of the electric installations';
                }
                field(ToiletDoorsCondition; Rec.ToiletDoorsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'Condition of the door(s)';
                }
                field(ToiletDoorsRepairs; Rec.ToiletDoorsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Repairs of the door(s)';
                }
                field(ToiletSinkCondition; Rec.ToiletSinkCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'Condition of the sink';
                }
                field(ToiletSinkRepairs; Rec.ToiletSinkRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Repairs of the sink';
                }
                field(ToiletCisternDoorsCondition; Rec.ToiletCisternDoorsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'Condition of the door(s)';
                }
                field(ToiletCisternRepairs; Rec.ToiletCisternRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Repairs of toilet cistern';
                }
                field(ToiletToiletBowlCondition; Rec.ToiletToiletBowlCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'Condition of the toilet bowl';
                }
                field(ToiletToiletBowlRepairs; Rec.ToiletToiletBowlRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Repairs of toiletbowl';
                }
                field(ToiletwaterTapsCondition; Rec.ToiletwaterTapsCondition)
                {
                    ApplicationArea = All;
                    Tooltip = 'Condition of the watertap';
                }
                field(ToiletWaterTapsRepairs; Rec.ToiletWaterTapsRepairs)
                {
                    ApplicationArea = All;
                    Tooltip = 'Repairs of the watertap';
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
                        Tooltip = 'Productionyear';
                    }
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
                    field(StoveCondition; Rec.StoveCondition)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Condition';
                    }
                    field(StoveRepairs; Rec.StoveRepairs)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Repairs';
                    }
                }
                group(Cook)
                {
                    Caption = 'Cook';

                    field(CookYear; Rec.CookYear)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Productionyear';
                    }
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
                    field(CookCondition; Rec.CookCondition)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Condition';
                    }
                    field(CookRepairs; Rec.CookRepairs)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Repairs';
                    }

                }
                Group(Oven)
                {
                    Caption = 'Oven';
                    field(OvenYear; Rec.OvenYear)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Productionyear';
                    }
                    field(OvenManufactor; Rec.OvenManufactor)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Manufactor';
                    }
                    field(OvenModel; Rec.OvenModel)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Model code';
                    }
                    field(OvenCondition; Rec.OvenCondition)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Condition';
                    }
                    field(OvenRepairs; Rec.OvenRepairs)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Repairs';
                    }
                }
                group(Hood)
                {
                    Caption = 'Hood';
                    field(HoodYear; Rec.HoodYear)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Productionyear';
                    }
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
                    field(HoodCondition; Rec.HoodCondition)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Condition';
                    }
                    field(HoodRepairs; Rec.HoodeRepairs)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Repairs';
                    }
                }
                group(Fridge)
                {
                    Caption = 'Fridge';
                    field(FridgeYear; Rec.FridgeYear)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Productionyear';
                    }
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
                    field(FridgeCondition; Rec.FridgeCondition)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Condition';
                    }
                    field(FridgeRepairs; Rec.FridgeRepairs)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Repairs';
                    }
                }
                group(Freezer)
                {
                    Caption = 'Frezer';
                    field(FreezerYear; Rec.FreezerYear)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Productionyear';
                    }
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
                    field(FreezerCondition; Rec.FreezerCondition)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Condition';
                    }
                    field(FreezerRepairs; Rec.FreezerRepairs)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Repairs';
                    }
                }
                Group(Dishwasher)
                {
                    Caption = 'Dishwasher';
                    field(DishwasherYear; Rec.DishwasherYear)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Productionyear';
                    }
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
                    field(DishwasherCondition; Rec.DishwasherCondition)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Condition';
                    }
                    field(DishwasherRepairs; Rec.DishwasherRepairs)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Repairs';
                    }
                }
                group(Washer)
                {
                    Caption = 'Washer';
                    field(WasherYear; Rec.WasherYear)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Productionyear';
                    }
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
                    field(WasherCondition; Rec.WasherCondition)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Condition';
                    }
                    field(WasherRepairs; Rec.WasherRepairs)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Repairs';
                    }
                }
                group(Dryer)
                {
                    Caption = 'Dryer';
                    field(DryerYear; Rec.DryerYear)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Productionyear';
                    }
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
                    field(DryerCondition; Rec.DryerCondition)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Condition';
                    }
                    field(DryerRepairs; Rec.DryerRepairs)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Repairs';
                    }
                }
                group(EntryPhone)
                {
                    Caption = 'EntryPhone';

                    field(EntryPhoneYear; Rec.EntryPhoneYear)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Productionyear';
                    }
                    field(EntryPhoneManufactor; Rec.EntryPhoneManufactor)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Manufactor';
                    }
                    field(EntryPhoneModel; Rec.EntryPhoneModel)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Model code';
                    }
                    field(EntryPhoneCondition; Rec.EntryPhoneCondition)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Condition';
                    }
                    field(EntryPhoneRepairs; Rec.EntryPhoneRepairs)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Repairs';
                    }
                }
                group(Other)
                {
                    Caption = 'Other';
                    field(AntennaCondition; Rec.AntennaCondition)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Condition';
                    }
                    field(AntennaRepairs; Rec.AntennaRepairs)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Repairs';
                    }
                    field(KeyCondition; Rec.KeyCondition)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Condition';
                    }
                    field(KeyRepairs; Rec.KeyRepairs)
                    {
                        ApplicationArea = All;
                        Tooltip = 'Repairs';
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
            group(Reports)
            {
                Caption = 'Reports';
                action(MovingOut)
                {
                    ApplicationArea = all;
                    Caption = 'Moving out report';
                    ToolTip = 'Report to sign for moving out status.';
                    Image = MakeAgreement;
                    Promoted = true;
                    PromotedCategory = Report;
                    trigger OnAction();
                    begin
                        CLEAR(TableSVAMovingOutStatus);
                        TableSVAMovingOutStatus.SETRANGE(Occupant, Rec.Occupant);
                        CLEAR(SVAMovingoutstatus);
                        SVAMovingoutstatus.SETTABLEVIEW(TableSVAMovingOutStatus);
                        SVAMovingoutstatus.RunModal();
                    end;
                }

            }
        }
    }


    trigger OnAfterGetCurrRecord();
    begin
        CurrPage.UPDATE();
        CurrPage.UPDATE();
    end;

    var
        TableSVAMovingOutStatus: Record "SVA MovingOut Status";
        SVAMovingoutstatus: Report "SVA Moving out status";
}

