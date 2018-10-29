table 50009 "SVA MovingOut Status"
{
    Caption='Moving out status';

    fields
    {
        field(10; Occupant; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "SVA Occupant".Number;

            trigger OnValidate();
            begin
                IF Name = '' THEN BEGIN  //Empty record
                    CompanyInfo.GET;
                    LandlordName := CompanyInfo.Name;
                    landlordAddress := CompanyInfo.Address;
                    LandlordPostCode := CompanyInfo."Post Code";
                    Landlordcity := CompanyInfo.City;
                    OccupantCard.RESET;
                    OccupantCard.SETRANGE(OccupantCard.Number, Rec.Occupant);
                    IF OccupantCard.FINDFIRST() THEN BEGIN
                        Name := OccupantCard.Name1;
                        Name2 := OccupantCard.Name2;
                    END;

                    Tenancy.RESET;
                    Tenancy.SETRANGE(Number, OccupantCard.TenancyNo);
                    IF Tenancy.FIND('-') THEN BEGIN
                        TenancyNo := OccupantCard.TenancyNo;
                        TenancyAddress := Tenancy.Address1;
                        TenancyPostCode := Tenancy."Post Code";
                        TenancyCity := Tenancy.City;
                        //appliances
                        StoveManufactor := Tenancy.StoveManufactor;
                        StoveModel := Tenancy.StoveModel;
                        StoveYear := Tenancy.StoveYear;
                        CookManufactor := Tenancy.CookManufactor;
                        CookModel := Tenancy.CookModel;
                        CookYear := Tenancy.CookYear;
                        OvenManufactor := Tenancy.OvenManufactor;
                        OvenModel := Tenancy.OvenModel;
                        OvenYear := Tenancy.OvenYear;
                        HoodManufactor := Tenancy.HoodManufactor;
                        HoodStoveModel := Tenancy.HoodStoveModel;
                        HoodYear := Tenancy.HoodYear;
                        FridgeManufactor := Tenancy.FridgeManufactor;
                        FridgeModel := Tenancy.FridgeModel;
                        FridgeYear := Tenancy.FridgeYear;
                        FreezerManufactor := Tenancy.FreezerManufactor;
                        FreezerModel := Tenancy.FreezerModel;
                        FreezerYear := Tenancy.FreezerYear;
                        DishwasherManufactor := Tenancy.DishwasherManufactor;
                        DishwasherModel := Tenancy.DishwasherModel;
                        DishwasherYear := Tenancy.DishwasherYear;
                        WasherManufactor := Tenancy.WasherManufactor;
                        WasherModel := Tenancy.WasherModel;
                        WasherYear := Tenancy.WasherYear;
                        DryerManufactor := Tenancy.DryerManufactor;
                        DryerModel := Tenancy.DryerModel;
                        DryerYear := Tenancy.DryerYear;
                    END;
                END;

                Property.Reset;
                Property.SetRange(Property, OccupantCard.PropertyNo);
                IF Property.FindFirst() then begin
                    BebrepProperty := Property.TypeA9_10_Occgroup;
                end;
            end;
        }
        field(11; Name; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(12; Name2; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(13; "Address (new)"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(14; PostCode; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(15; City; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(16; TenancyNo; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(17; TenancyAddress; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(18; TenancyPostCode; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(19; TenancyCity; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(20; LandlordName; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(21; landlordAddress; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(22; LandlordPostCode; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(23; Landlordcity; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(24; Representative; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(30; BebrepProperty; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(31; BebrepInd; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(32; BebrepTilstede; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(33; BebrepName; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(34; BebrepEmail; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(35; BebrepKopi; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(100; Room1Description; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(101; Rum1CeilingCondition; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;

        }
        field(102; Rum1CeilingRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'No,Landlord,"Sanded/planed",lacquer,Painted,Repairs,Papering,Replaced,Cleaned';
            OptionMembers = No, Landlord, "Sanded/planed", lacquer, Painted, Repairs, Papering, Replaced, Cleaned;
        }
        field(103; Rum1WallsCondition; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;
        }
        field(104; Rum1WallsRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'No,Landlord,"Sanded/planed",lacquer,Painted,Repairs,Papering,Replaced,Cleaned';
            OptionMembers = No, Landlord, "Sanded/planed", lacquer, Painted, Repairs, Papering, Replaced, Cleaned;
        }
        field(105; Rum1FloorsCondition; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;
        }
        field(106; Rum1FloorsRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'No,Landlord,"Sanded/planed",lacquer,Painted,Repairs,Papering,Replaced,Cleaned';
            OptionMembers = No, Landlord, "Sanded/planed", lacquer, Painted, Repairs, Papering, Replaced, Cleaned;
        }
        field(107; Rum1CarpetsCondition; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;
        }
        field(108; Rum1CarpetsRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'No,Landlord,"Sanded/planed",lacquer,Painted,Repairs,Papering,Replaced,Cleaned';
            OptionMembers = No, Landlord, "Sanded/planed", lacquer, Painted, Repairs, Papering, Replaced, Cleaned;
        }
        field(109; Rum1WoodworksCondition; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;
        }
        field(110; Rum1WoodworksRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'No,Landlord,"Sanded/planed",lacquer,Painted,Repairs,Papering,Replaced,Cleaned';
            OptionMembers = No, Landlord, "Sanded/planed", lacquer, Painted, Repairs, Papering, Replaced, Cleaned;
        }
        field(111; Rum1WindowsmvCondition; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;
        }
        field(112; Rum1WindowsRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'No,Landlord,"Sanded/planed",lacquer,Painted,Repairs,Papering,Replaced,Cleaned';
            OptionMembers = No, Landlord, "Sanded/planed", lacquer, Painted, Repairs, Papering, Replaced, Cleaned;
        }
        field(113; Rum1RadiatorCondition; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;
        }
        field(114; Rum1RadiatorRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'No,Landlord,"Sanded/planed",lacquer,Painted,Repairs,Papering,Replaced,Cleaned';
            OptionMembers = No, Landlord, "Sanded/planed", lacquer, Painted, Repairs, Papering, Replaced, Cleaned;
        }
        field(115; Rum1ElCondition; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;
        }
        field(116; Rum1ElRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'No,Landlord,"Sanded/planed",lacquer,Painted,Repairs,Papering,Replaced,Cleaned';
            OptionMembers = No, Landlord, "Sanded/planed", lacquer, Painted, Repairs, Papering, Replaced, Cleaned;
        }
        field(117; Rum1DoorsCondition; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;
        }
        field(118; Rum1DoorsRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'No,Landlord,"Sanded/planed",lacquer,Painted,Repairs,Papering,Replaced,Cleaned';
            OptionMembers = No, Landlord, "Sanded/planed", lacquer, Painted, Repairs, Papering, Replaced, Cleaned;
        }
        field(200; Room2Description; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(201; Rum2CeilingCondition; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;
        }
        field(202; Rum2CeilingRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'No,Landlord,"Sanded/planed",lacquer,Painted,Repairs,Papering,Replaced,Cleaned';
            OptionMembers = No, Landlord, "Sanded/planed", lacquer, Painted, Repairs, Papering, Replaced, Cleaned;
        }
        field(203; Rum2WallsCondition; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;
        }
        field(204; Rum2WallsRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'No,Landlord,"Sanded/planed",lacquer,Painted,Repairs,Papering,Replaced,Cleaned';
            OptionMembers = No, Landlord, "Sanded/planed", lacquer, Painted, Repairs, Papering, Replaced, Cleaned;
        }
        field(205; Rum2FloorsCondition; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;
        }
        field(206; Rum2FloorsRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'No,Landlord,"Sanded/planed",lacquer,Painted,Repairs,Papering,Replaced,Cleaned';
            OptionMembers = No, Landlord, "Sanded/planed", lacquer, Painted, Repairs, Papering, Replaced, Cleaned;
        }
        field(207; Rum2CarpetsCondition; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;
        }
        field(208; Rum2CarpetsRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'No,Landlord,"Sanded/planed",lacquer,Painted,Repairs,Papering,Replaced,Cleaned';
            OptionMembers = No, Landlord, "Sanded/planed", lacquer, Painted, Repairs, Papering, Replaced, Cleaned;
        }
        field(209; Rum2WoodworksCondition; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;
        }
        field(210; Rum2WoodworksRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'No,Landlord,"Sanded/planed",lacquer,Painted,Repairs,Papering,Replaced,Cleaned';
            OptionMembers = No, Landlord, "Sanded/planed", lacquer, Painted, Repairs, Papering, Replaced, Cleaned;
        }
        field(211; Rum2WindowsmvCondition; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;
        }
        field(212; Rum2WindowsRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'No,Landlord,"Sanded/planed",lacquer,Painted,Repairs,Papering,Replaced,Cleaned';
            OptionMembers = No, Landlord, "Sanded/planed", lacquer, Painted, Repairs, Papering, Replaced, Cleaned;
        }
        field(213; Rum2RadiatorCondition; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;
        }
        field(214; Rum2RadiatorRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'No,Landlord,"Sanded/planed",lacquer,Painted,Repairs,Papering,Replaced,Cleaned';
            OptionMembers = No, Landlord, "Sanded/planed", lacquer, Painted, Repairs, Papering, Replaced, Cleaned;
        }
        field(215; Rum2ElCondition; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;
        }
        field(216; Rum2ElRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'No,Landlord,"Sanded/planed",lacquer,Painted,Repairs,Papering,Replaced,Cleaned';
            OptionMembers = No, Landlord, "Sanded/planed", lacquer, Painted, Repairs, Papering, Replaced, Cleaned;
        }
        field(217; Rum2DoorsCondition; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;
        }
        field(218; Rum2DoorsRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'No,Landlord,"Sanded/planed",lacquer,Painted,Repairs,Papering,Replaced,Cleaned';
            OptionMembers = No, Landlord, "Sanded/planed", lacquer, Painted, Repairs, Papering, Replaced, Cleaned;
        }
        field(300; Room3Description; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(301; Rum3CeilingCondition; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;
        }
        field(302; Rum3CeilingRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'No,Landlord,"Sanded/planed",lacquer,Painted,Repairs,Papering,Replaced,Cleaned';
            OptionMembers = No, Landlord, "Sanded/planed", lacquer, Painted, Repairs, Papering, Replaced, Cleaned;
        }
        field(303; Rum3WallsCondition; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;
        }
        field(304; Rum3WallsRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'No,Landlord,"Sanded/planed",lacquer,Painted,Repairs,Papering,Replaced,Cleaned';
            OptionMembers = No, Landlord, "Sanded/planed", lacquer, Painted, Repairs, Papering, Replaced, Cleaned;
        }
        field(305; Rum3FloorsCondition; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;
        }
        field(306; Rum3FloorsRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'No,Landlord,"Sanded/planed",lacquer,Painted,Repairs,Papering,Replaced,Cleaned';
            OptionMembers = No, Landlord, "Sanded/planed", lacquer, Painted, Repairs, Papering, Replaced, Cleaned;
        }
        field(307; Rum3CarpetsCondition; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;
        }
        field(308; Rum3CarpetsRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'No,Landlord,"Sanded/planed",lacquer,Painted,Repairs,Papering,Replaced,Cleaned';
            OptionMembers = No, Landlord, "Sanded/planed", lacquer, Painted, Repairs, Papering, Replaced, Cleaned;
        }
        field(309; Rum3WoodworksCondition; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;
        }
        field(310; Rum3WoodworksRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'No,Landlord,"Sanded/planed",lacquer,Painted,Repairs,Papering,Replaced,Cleaned';
            OptionMembers = No, Landlord, "Sanded/planed", lacquer, Painted, Repairs, Papering, Replaced, Cleaned;
        }
        field(311; Rum3WindowsmvCondition; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;
        }
        field(312; Rum3WindowsRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'No,Landlord,"Sanded/planed",lacquer,Painted,Repairs,Papering,Replaced,Cleaned';
            OptionMembers = No, Landlord, "Sanded/planed", lacquer, Painted, Repairs, Papering, Replaced, Cleaned;
        }
        field(313; Rum3RadiatorCondition; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;
        }
        field(314; Rum3RadiatorRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'No,Landlord,"Sanded/planed",lacquer,Painted,Repairs,Papering,Replaced,Cleaned';
            OptionMembers = No, Landlord, "Sanded/planed", lacquer, Painted, Repairs, Papering, Replaced, Cleaned;
        }
        field(315; Rum3ElCondition; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;
        }
        field(316; Rum3ElRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'No,Landlord,"Sanded/planed",lacquer,Painted,Repairs,Papering,Replaced,Cleaned';
            OptionMembers = No, Landlord, "Sanded/planed", lacquer, Painted, Repairs, Papering, Replaced, Cleaned;
        }
        field(317; Rum3DoorsCondition; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;
        }
        field(318; Rum3DoorsRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'No,Landlord,"Sanded/planed",lacquer,Painted,Repairs,Papering,Replaced,Cleaned';
            OptionMembers = No, Landlord, "Sanded/planed", lacquer, Painted, Repairs, Papering, Replaced, Cleaned;
        }
        field(400; Room4Description; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(401; Rum4CeilingCondition; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;
        }
        field(402; Rum4CeilingRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'No,Landlord,"Sanded/planed",lacquer,Painted,Repairs,Papering,Replaced,Cleaned';
            OptionMembers = No, Landlord, "Sanded/planed", lacquer, Painted, Repairs, Papering, Replaced, Cleaned;
        }
        field(403; Rum4WallsCondition; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;
        }
        field(404; Rum4WallsRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'No,Landlord,"Sanded/planed",lacquer,Painted,Repairs,Papering,Replaced,Cleaned';
            OptionMembers = No, Landlord, "Sanded/planed", lacquer, Painted, Repairs, Papering, Replaced, Cleaned;
        }
        field(405; Rum4FloorsCondition; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;
        }
        field(406; Rum4FloorsRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'No,Landlord,"Sanded/planed",lacquer,Painted,Repairs,Papering,Replaced,Cleaned';
            OptionMembers = No, Landlord, "Sanded/planed", lacquer, Painted, Repairs, Papering, Replaced, Cleaned;
        }
        field(407; Rum4CarpetsCondition; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;
        }
        field(408; Rum4CarpetsRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'No,Landlord,"Sanded/planed",lacquer,Painted,Repairs,Papering,Replaced,Cleaned';
            OptionMembers = No, Landlord, "Sanded/planed", lacquer, Painted, Repairs, Papering, Replaced, Cleaned;
        }
        field(409; Rum4WoodworksCondition; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;
        }
        field(410; Rum4WoodworksRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'No,Landlord,"Sanded/planed",lacquer,Painted,Repairs,Papering,Replaced,Cleaned';
            OptionMembers = No, Landlord, "Sanded/planed", lacquer, Painted, Repairs, Papering, Replaced, Cleaned;
        }
        field(411; Rum4WindowsmvCondition; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;
        }
        field(412; Rum4WindowsRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'No,Landlord,"Sanded/planed",lacquer,Painted,Repairs,Papering,Replaced,Cleaned';
            OptionMembers = No, Landlord, "Sanded/planed", lacquer, Painted, Repairs, Papering, Replaced, Cleaned;
        }
        field(413; Rum4RadiatorCondition; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;
        }
        field(414; Rum4RadiatorRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'No,Landlord,"Sanded/planed",lacquer,Painted,Repairs,Papering,Replaced,Cleaned';
            OptionMembers = No, Landlord, "Sanded/planed", lacquer, Painted, Repairs, Papering, Replaced, Cleaned;
        }
        field(415; Rum4ElCondition; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;
        }
        field(416; Rum4ElRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'No,Landlord,"Sanded/planed",lacquer,Painted,Repairs,Papering,Replaced,Cleaned';
            OptionMembers = No, Landlord, "Sanded/planed", lacquer, Painted, Repairs, Papering, Replaced, Cleaned;
        }
        field(417; Rum4DoorsCondition; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;
        }
        field(418; Rum4DoorsRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'No,Landlord,"Sanded/planed",lacquer,Painted,Repairs,Papering,Replaced,Cleaned';
            OptionMembers = No, Landlord, "Sanded/planed", lacquer, Painted, Repairs, Papering, Replaced, Cleaned;
        }
        field(501; EntreCeilingCondition; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;
        }
        field(502; EntreCeilingRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'No,Landlord,"Sanded/planed",lacquer,Painted,Repairs,Papering,Replaced,Cleaned';
            OptionMembers = No, Landlord, "Sanded/planed", lacquer, Painted, Repairs, Papering, Replaced, Cleaned;
        }
        field(503; EntreWallsCondition; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;
        }
        field(504; EntreWallsRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'No,Landlord,"Sanded/planed",lacquer,Painted,Repairs,Papering,Replaced,Cleaned';
            OptionMembers = No, Landlord, "Sanded/planed", lacquer, Painted, Repairs, Papering, Replaced, Cleaned;
        }
        field(505; EntreFloorsCondition; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;
        }
        field(506; EntreFloorsRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'No,Landlord,"Sanded/planed",lacquer,Painted,Repairs,Papering,Replaced,Cleaned';
            OptionMembers = No, Landlord, "Sanded/planed", lacquer, Painted, Repairs, Papering, Replaced, Cleaned;
        }
        field(507; EntreCarpetsCondition; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;
        }
        field(508; EntreCarpetsRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'No,Landlord,"Sanded/planed",lacquer,Painted,Repairs,Papering,Replaced,Cleaned';
            OptionMembers = No, Landlord, "Sanded/planed", lacquer, Painted, Repairs, Papering, Replaced, Cleaned;
        }
        field(509; EntreWoodworksCondition; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;
        }
        field(510; EntreWoodworksRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'No,Landlord,"Sanded/planed",lacquer,Painted,Repairs,Papering,Replaced,Cleaned';
            OptionMembers = No, Landlord, "Sanded/planed", lacquer, Painted, Repairs, Papering, Replaced, Cleaned;
        }
        field(511; EntreWindowsmvCondition; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;
        }
        field(512; EntreWindowsRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'No,Landlord,"Sanded/planed",lacquer,Painted,Repairs,Papering,Replaced,Cleaned';
            OptionMembers = No, Landlord, "Sanded/planed", lacquer, Painted, Repairs, Papering, Replaced, Cleaned;
        }
        field(513; EntreRadiatorCondition; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;
        }
        field(514; EntreRadiatorRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'No,Landlord,"Sanded/planed",lacquer,Painted,Repairs,Papering,Replaced,Cleaned';
            OptionMembers = No, Landlord, "Sanded/planed", lacquer, Painted, Repairs, Papering, Replaced, Cleaned;
        }
        field(515; EntreElCondition; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;
        }
        field(516; EntreElRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'No,Landlord,"Sanded/planed",lacquer,Painted,Repairs,Papering,Replaced,Cleaned';
            OptionMembers = No, Landlord, "Sanded/planed", lacquer, Painted, Repairs, Papering, Replaced, Cleaned;
        }
        field(517; EntreDoorsCondition; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;
        }
        field(518; EntreDoorsRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'No,Landlord,"Sanded/planed",lacquer,Painted,Repairs,Papering,Replaced,Cleaned';
            OptionMembers = No, Landlord, "Sanded/planed", lacquer, Painted, Repairs, Papering, Replaced, Cleaned;
        }
        field(601; KitchenCeilingCondition; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;
        }
        field(602; KitchenCeilingRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'No,Landlord,"Sanded/planed",lacquer,Painted,Repairs,Papering,Replaced,Cleaned';
            OptionMembers = No, Landlord, "Sanded/planed", lacquer, Painted, Repairs, Papering, Replaced, Cleaned;
        }
        field(603; KitchenWallsCondition; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;
        }
        field(604; KitchenWallsRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'No,Landlord,"Sanded/planed",lacquer,Painted,Repairs,Papering,Replaced,Cleaned';
            OptionMembers = No, Landlord, "Sanded/planed", lacquer, Painted, Repairs, Papering, Replaced, Cleaned;
        }
        field(605; KitchenFloorsCondition; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;
        }
        field(606; KitchenFloorsRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'No,Landlord,"Sanded/planed",lacquer,Painted,Repairs,Papering,Replaced,Cleaned';
            OptionMembers = No, Landlord, "Sanded/planed", lacquer, Painted, Repairs, Papering, Replaced, Cleaned;
        }
        field(607; KitchenCarpetsCondition; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;
        }
        field(608; KitchenCarpetsRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'No,Landlord,"Sanded/planed",lacquer,Painted,Repairs,Papering,Replaced,Cleaned';
            OptionMembers = No, Landlord, "Sanded/planed", lacquer, Painted, Repairs, Papering, Replaced, Cleaned;
        }
        field(609; KitchenWoodworksCondition; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;
        }
        field(610; KitchenWoodworksRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'No,Landlord,"Sanded/planed",lacquer,Painted,Repairs,Papering,Replaced,Cleaned';
            OptionMembers = No, Landlord, "Sanded/planed", lacquer, Painted, Repairs, Papering, Replaced, Cleaned;
        }
        field(611; KitchenWindowsmvCondition; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;
        }
        field(612; KitchenWindowsRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'No,Landlord,"Sanded/planed",lacquer,Painted,Repairs,Papering,Replaced,Cleaned';
            OptionMembers = No, Landlord, "Sanded/planed", lacquer, Painted, Repairs, Papering, Replaced, Cleaned;
        }
        field(613; KitchenRadiatorCondition; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;
        }
        field(614; KitchenRadiatorRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'No,Landlord,"Sanded/planed",lacquer,Painted,Repairs,Papering,Replaced,Cleaned';
            OptionMembers = No, Landlord, "Sanded/planed", lacquer, Painted, Repairs, Papering, Replaced, Cleaned;
        }
        field(615; KitchenElCondition; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;
        }
        field(616; KitchenElRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'No,Landlord,"Sanded/planed",lacquer,Painted,Repairs,Papering,Replaced,Cleaned';
            OptionMembers = No, Landlord, "Sanded/planed", lacquer, Painted, Repairs, Papering, Replaced, Cleaned;
        }
        field(617; KitchenDoorsCondition; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;
        }
        field(618; KitchenDoorsRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'No,Landlord,"Sanded/planed",lacquer,Painted,Repairs,Papering,Replaced,Cleaned';
            OptionMembers = No, Landlord, "Sanded/planed", lacquer, Painted, Repairs, Papering, Replaced, Cleaned;
        }
        field(619; KitchenTilesConditions; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;
        }
        field(620; KitchenTilesRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'No,Landlord,"Sanded/planed",lacquer,Painted,Repairs,Papering,Replaced,Cleaned';
            OptionMembers = No, Landlord, "Sanded/planed", lacquer, Painted, Repairs, Papering, Replaced, Cleaned;
        }
        field(621; KitchenTableCondition; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;
        }
        field(622; KitchenTableRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'No,Landlord,"Sanded/planed",lacquer,Painted,Repairs,Papering,Replaced,Cleaned';
            OptionMembers = No, Landlord, "Sanded/planed", lacquer, Painted, Repairs, Papering, Replaced, Cleaned;
        }
        field(623; KitchenSinkCondition; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;
        }
        field(624; KitchensinkRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'No,Landlord,"Sanded/planed",lacquer,Painted,Repairs,Papering,Replaced,Cleaned';
            OptionMembers = No, Landlord, "Sanded/planed", lacquer, Painted, Repairs, Papering, Replaced, Cleaned;
        }
        field(625; KitchenCabinetsCondition; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;
        }
        field(626; KitchenCabinetsRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'No,Landlord,"Sanded/planed",lacquer,Painted,Repairs,Papering,Replaced,Cleaned';
            OptionMembers = No, Landlord, "Sanded/planed", lacquer, Painted, Repairs, Papering, Replaced, Cleaned;
        }
        field(627; KitchenWatertapsCondition; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;
        }
        field(628; KitchenWatertapsRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'No,Landlord,"Sanded/planed",lacquer,Painted,Repairs,Papering,Replaced,Cleaned';
            OptionMembers = No, Landlord, "Sanded/planed", lacquer, Painted, Repairs, Papering, Replaced, Cleaned;
        }
        field(701; BathroomCeilingCondition; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;
        }
        field(702; BathroomCeilingRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'No,Landlord,"Sanded/planed",lacquer,Painted,Repairs,Papering,Replaced,Cleaned';
            OptionMembers = No, Landlord, "Sanded/planed", lacquer, Painted, Repairs, Papering, Replaced, Cleaned;
        }
        field(703; BathroomWallsCondition; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;
        }
        field(704; BathroomWallsRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'No,Landlord,"Sanded/planed",lacquer,Painted,Repairs,Papering,Replaced,Cleaned';
            OptionMembers = No, Landlord, "Sanded/planed", lacquer, Painted, Repairs, Papering, Replaced, Cleaned;
        }
        field(705; BathroomFloorsCondition; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;
        }
        field(706; BathroomFloorsRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'No,Landlord,"Sanded/planed",lacquer,Painted,Repairs,Papering,Replaced,Cleaned';
            OptionMembers = No, Landlord, "Sanded/planed", lacquer, Painted, Repairs, Papering, Replaced, Cleaned;
        }
        field(707; BathroomCarpetsCondition; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;
        }
        field(708; BathroomCarpetsRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'No,Landlord,"Sanded/planed",lacquer,Painted,Repairs,Papering,Replaced,Cleaned';
            OptionMembers = No, Landlord, "Sanded/planed", lacquer, Painted, Repairs, Papering, Replaced, Cleaned;
        }
        field(709; BathroomWoodworksCondition; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;
        }
        field(710; BathroomWoodworksRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'No,Landlord,"Sanded/planed",lacquer,Painted,Repairs,Papering,Replaced,Cleaned';
            OptionMembers = No, Landlord, "Sanded/planed", lacquer, Painted, Repairs, Papering, Replaced, Cleaned;
        }
        field(711; BathroomWindowsmvCondition; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;
        }
        field(712; BathroomWindowsRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'No,Landlord,"Sanded/planed",lacquer,Painted,Repairs,Papering,Replaced,Cleaned';
            OptionMembers = No, Landlord, "Sanded/planed", lacquer, Painted, Repairs, Papering, Replaced, Cleaned;
        }
        field(713; BathroomRadiatorCondition; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;
        }
        field(714; BathroomRadiatorRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'No,Landlord,"Sanded/planed",lacquer,Painted,Repairs,Papering,Replaced,Cleaned';
            OptionMembers = No, Landlord, "Sanded/planed", lacquer, Painted, Repairs, Papering, Replaced, Cleaned;
        }
        field(715; BathroomElCondition; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;
        }
        field(716; BathroomElRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'No,Landlord,"Sanded/planed",lacquer,Painted,Repairs,Papering,Replaced,Cleaned';
            OptionMembers = No, Landlord, "Sanded/planed", lacquer, Painted, Repairs, Papering, Replaced, Cleaned;
        }
        field(717; BathroomDoorsCondition; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;
        }
        field(718; BathroomDoorsRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'No,Landlord,"Sanded/planed",lacquer,Painted,Repairs,Papering,Replaced,Cleaned';
            OptionMembers = No, Landlord, "Sanded/planed", lacquer, Painted, Repairs, Papering, Replaced, Cleaned;
        }
        field(719; BathroomSinkCondition; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;
        }
        field(720; BathroomSinkRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'No,Landlord,"Sanded/planed",lacquer,Painted,Repairs,Papering,Replaced,Cleaned';
            OptionMembers = No, Landlord, "Sanded/planed", lacquer, Painted, Repairs, Papering, Replaced, Cleaned;
        }
        field(721; BathroomCisternDoorsCondition; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;
        }
        field(722; BathroomCisternRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'No,Landlord,"Sanded/planed",lacquer,Painted,Repairs,Papering,Replaced,Cleaned';
            OptionMembers = No, Landlord, "Sanded/planed", lacquer, Painted, Repairs, Papering, Replaced, Cleaned;
        }
        field(723; BathroomToiletBowlCondition; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;
        }
        field(724; BathroomToiletBowlRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'No,Landlord,"Sanded/planed",lacquer,Painted,Repairs,Papering,Replaced,Cleaned';
            OptionMembers = No, Landlord, "Sanded/planed", lacquer, Painted, Repairs, Papering, Replaced, Cleaned;
        }
        field(725; BathroomBathtopCondition; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;
        }
        field(726; BathroombathTopRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'No,Landlord,"Sanded/planed",lacquer,Painted,Repairs,Papering,Replaced,Cleaned';
            OptionMembers = No, Landlord, "Sanded/planed", lacquer, Painted, Repairs, Papering, Replaced, Cleaned;
        }
        field(727; BathroomShowerCondition; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;
        }
        field(728; BathroomShowerRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'No,Landlord,"Sanded/planed",lacquer,Painted,Repairs,Papering,Replaced,Cleaned';
            OptionMembers = No, Landlord, "Sanded/planed", lacquer, Painted, Repairs, Papering, Replaced, Cleaned;
        }
        field(729; BathroomWaterTapsCondition; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;
        }
        field(730; BathroomWaterTapsRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'No,Landlord,"Sanded/planed",lacquer,Painted,Repairs,Papering,Replaced,Cleaned';
            OptionMembers = No, Landlord, "Sanded/planed", lacquer, Painted, Repairs, Papering, Replaced, Cleaned;
        }
        field(801; ToiletCeilingCondition; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;
        }
        field(802; ToiletCeilingRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'No,Landlord,"Sanded/planed",lacquer,Painted,Repairs,Papering,Replaced,Cleaned';
            OptionMembers = No, Landlord, "Sanded/planed", lacquer, Painted, Repairs, Papering, Replaced, Cleaned;
        }
        field(803; ToiletWallsCondition; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;
        }
        field(804; ToiletWallsRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'No,Landlord,"Sanded/planed",lacquer,Painted,Repairs,Papering,Replaced,Cleaned';
            OptionMembers = No, Landlord, "Sanded/planed", lacquer, Painted, Repairs, Papering, Replaced, Cleaned;
        }
        field(805; ToiletFloorsCondition; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;
        }
        field(806; ToiletFloorsRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'No,Landlord,"Sanded/planed",lacquer,Painted,Repairs,Papering,Replaced,Cleaned';
            OptionMembers = No, Landlord, "Sanded/planed", lacquer, Painted, Repairs, Papering, Replaced, Cleaned;
        }
        field(807; ToiletCarpetsCondition; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;
        }
        field(808; ToiletCarpetsRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'No,Landlord,"Sanded/planed",lacquer,Painted,Repairs,Papering,Replaced,Cleaned';
            OptionMembers = No, Landlord, "Sanded/planed", lacquer, Painted, Repairs, Papering, Replaced, Cleaned;
        }
        field(809; ToiletWoodworksCondition; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;
        }
        field(810; ToiletWoodworksRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'No,Landlord,"Sanded/planed",lacquer,Painted,Repairs,Papering,Replaced,Cleaned';
            OptionMembers = No, Landlord, "Sanded/planed", lacquer, Painted, Repairs, Papering, Replaced, Cleaned;
        }
        field(811; ToiletWindowsmvCondition; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;
        }
        field(812; ToiletWindowsRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'No,Landlord,"Sanded/planed",lacquer,Painted,Repairs,Papering,Replaced,Cleaned';
            OptionMembers = No, Landlord, "Sanded/planed", lacquer, Painted, Repairs, Papering, Replaced, Cleaned;
        }
        field(813; ToiletRadiatorCondition; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;
        }
        field(814; ToiletRadiatorRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'No,Landlord,"Sanded/planed",lacquer,Painted,Repairs,Papering,Replaced,Cleaned';
            OptionMembers = No, Landlord, "Sanded/planed", lacquer, Painted, Repairs, Papering, Replaced, Cleaned;
        }
        field(815; ToiletElCondition; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;
        }
        field(816; ToiletElRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'No,Landlord,"Sanded/planed",lacquer,Painted,Repairs,Papering,Replaced,Cleaned';
            OptionMembers = No, Landlord, "Sanded/planed", lacquer, Painted, Repairs, Papering, Replaced, Cleaned;
        }
        field(817; ToiletDoorsCondition; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;
        }
        field(818; ToiletDoorsRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'No,Landlord,"Sanded/planed",lacquer,Painted,Repairs,Papering,Replaced,Cleaned';
            OptionMembers = No, Landlord, "Sanded/planed", lacquer, Painted, Repairs, Papering, Replaced, Cleaned;
        }
        field(819; ToiletSinkCondition; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;
        }
        field(820; ToiletSinkRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'No,Landlord,"Sanded/planed",lacquer,Painted,Repairs,Papering,Replaced,Cleaned';
            OptionMembers = No, Landlord, "Sanded/planed", lacquer, Painted, Repairs, Papering, Replaced, Cleaned;
        }
        field(821; ToiletCisternDoorsCondition; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;
        }
        field(822; ToiletCisternRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'No,Landlord,"Sanded/planed",lacquer,Painted,Repairs,Papering,Replaced,Cleaned';
            OptionMembers = No, Landlord, "Sanded/planed", lacquer, Painted, Repairs, Papering, Replaced, Cleaned;
        }
        field(823; ToiletToiletBowlCondition; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;
        }
        field(824; ToiletToiletBowlRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'No,Landlord,"Sanded/planed",lacquer,Painted,Repairs,Papering,Replaced,Cleaned';
            OptionMembers = No, Landlord, "Sanded/planed", lacquer, Painted, Repairs, Papering, Replaced, Cleaned;
        }
        field(825; ToiletwaterTapsCondition; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;
        }
        field(826; ToiletWaterTapsRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'No,Landlord,"Sanded/planed",lacquer,Painted,Repairs,Papering,Replaced,Cleaned';
            OptionMembers = No, Landlord, "Sanded/planed", lacquer, Painted, Repairs, Papering, Replaced, Cleaned;
        }
        field(901; StoveYear; Text[10])
        {
            DataClassification = CustomerContent;
        }
        field(902; StoveManufactor; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(903; StoveModel; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(904; StoveCondition; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;
        }
        field(905; StoveRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'None,Repair,Replaced';
            OptionMembers = None, Repair, Replaced;
        }
        field(906; CookYear; Text[10])
        {
            DataClassification = CustomerContent;
        }
        field(907; CookManufactor; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(908; CookModel; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(909; CookCondition; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;
        }
        field(910; CookRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'None,Repair,Replaced';
            OptionMembers = None, Repair, Replaced;
        }
        field(911; OvenYear; Text[10])
        {
            DataClassification = CustomerContent;
        }
        field(912; OvenManufactor; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(913; OvenModel; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(914; OvenCondition; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;
        }
        field(915; OvenRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'None,Repair,Replaced';
            OptionMembers = None, Repair, Replaced;
        }
        field(916; HoodYear; Text[10])
        {
            DataClassification = CustomerContent;
        }
        field(917; HoodManufactor; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(918; HoodStoveModel; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(919; HoodCondition; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;
        }
        field(920; HoodeRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'None,Repair,Replaced';
            OptionMembers = None, Repair, Replaced;
        }
        field(921; FridgeYear; Text[10])
        {
            DataClassification = CustomerContent;
        }
        field(922; FridgeManufactor; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(923; FridgeModel; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(924; FridgeCondition; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;
        }
        field(925; FridgeRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'None,Repair,Replaced';
            OptionMembers = None, Repair, Replaced;
        }
        field(926; FreezerYear; Text[10])
        {
            DataClassification = CustomerContent;
        }
        field(927; FreezerManufactor; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(928; FreezerModel; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(929; FreezerCondition; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;
        }
        field(930; FreezerRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'None,Repair,Replaced';
            OptionMembers = None, Repair, Replaced;
        }
        field(931; DishwasherYear; Text[10])
        {
            DataClassification = CustomerContent;
        }
        field(932; DishwasherManufactor; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(933; DishwasherModel; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(934; DishwasherCondition; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;
        }
        field(935; DishwasherRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'None,Repair,Replaced';
            OptionMembers = None, Repair, Replaced;
        }
        field(936; WasherYear; Text[10])
        {
            DataClassification = CustomerContent;
        }
        field(937; WasherManufactor; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(938; WasherModel; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(939; WasherCondition; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;
        }
        field(940; WasherRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'None,Repair,Replaced';
            OptionMembers = None, Repair, Replaced;
        }
        field(941; DryerYear; Text[10])
        {
            DataClassification = CustomerContent;
        }
        field(942; DryerManufactor; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(943; DryerModel; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(944; DryerCondition; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;
        }
        field(945; DryerRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'None,Repair,Replaced';
            OptionMembers = None, Repair, Replaced;
        }
        field(946; EntryPhoneYear; Text[10])
        {
            DataClassification = CustomerContent;
        }
        field(947; EntryPhoneManufactor; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(948; EntryPhoneModel; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(949; EntryPhoneCondition; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;
        }
        field(950; EntryPhoneRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'None,Repair,Replaced';
            OptionMembers = None, Repair, Replaced;
        }
        field(951; AntennaCondition; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;
        }
        field(952; AntennaRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'None,Repair,Replaced';
            OptionMembers = None, Repair, Replaced;
        }
        field(953; KeyCondition; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing",Refurnished,"Good condition","Bad condition",Worn;
        }
        field(954; KeyRepairs; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'None,Repair,Replaced';
            OptionMembers = None, Repair, Replaced;
        }
        field(980; Phone; Text[20])
        {
            Caption = 'Phone';
            ExtendedDatatype = PhoneNo;
        }
        field(981; Email1; Text[80])
        {
            Caption = 'E-mail';
            ExtendedDatatype = EMail;
        }
        field(982; StartDate; Date)
        {
            Caption = 'Startdate';
        }
        field(983; EndDate; Date)
        {
            Caption = 'Enddate';
        }
    }

    keys
    {
        key(Key1; Occupant)
        {
        }
    }

    fieldgroups
    {
    }

    var
        CompanyInfo: Record "Company Information";
        Property: Record "SVA Property";
        Tenancy: Record "SVA Tenancy";
        OccupantCard: Record "SVA Occupant";
}

