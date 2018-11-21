table 50010 "SVA MovingIn Status"
//Caption checked
{
    Caption = 'Moving in status';
    fields
    {
        field(10; Occupant; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "SVA Occupant".Number;
            Caption = 'Occupant';

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
                        "Address (new)" := Tenancy.Address1;
                        PostCode := Tenancy."Post Code";
                        City := Tenancy.City;
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
            Caption = 'Name';
        }
        field(12; Name2; Text[50])
        {
            Caption = 'Name 2';
            DataClassification = CustomerContent;
        }
        field(13; "Address (new)"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Address';
        }
        field(14; PostCode; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Postcode';
        }
        field(15; City; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'City';

        }
        field(16; TenancyNo; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Tenancy no.';
        }
        field(17; TenancyAddress; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Address';
        }
        field(18; TenancyPostCode; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Postcode';
        }
        field(19; TenancyCity; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'City';
        }
        field(20; LandlordName; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Landlord';
        }
        field(21; landlordAddress; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Address';
        }
        field(22; LandlordPostCode; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Postcode';
        }
        field(23; Landlordcity; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'City';
        }
        field(24; Representative; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Representative';
        }
        field(30; BebrepProperty; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Has the property a tenantgroup?';
        }
        field(31; BebrepInd; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Tenantgroup representative summoned';
        }
        field(32; BebrepTilstede; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Is tenant representative present?';
        }
        field(33; BebrepName; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Name';
        }
        field(34; BebrepEmail; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Email';
        }
        field(35; BebrepKopi; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Has tenant representative got a copy?';
        }
        field(100; Room1Description; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Description (place)';
        }
        field(101; Rum1CeilingCondition; Option)
        {
            Caption = 'Ceiling condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;

        }
        field(102; Rum1CeilingRepairs; Option)
        {
            Caption = 'Ceiling repairs';
            DataClassification = CustomerContent;
            OptionCaption = 'No,Tenant,Landlord';
            OptionMembers = No, Tenant, Landlord;
        }
        field(103; Rum1WallsCondition; Option)
        {
            Caption = 'Walls condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;
        }
        field(104; Rum1WallsRepairs; Option)
        {
            Caption = 'Wall repairs';
            DataClassification = CustomerContent;
            OptionCaption = 'No,Tenant,Landlord';
            OptionMembers = No, Tenant, Landlord;
        }
        field(105; Rum1FloorsCondition; Option)
        {
            Caption = 'Floor condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;
        }
        field(106; Rum1FloorsRepairs; Option)
        {
            Caption = 'Floor repairs';
            DataClassification = CustomerContent;
            OptionCaption = 'No,Tenant,Landlord';
            OptionMembers = No, Tenant, Landlord;
        }
        field(107; Rum1CarpetsCondition; Option)
        {
            Caption = 'Carpets condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;
        }
        field(108; Rum1CarpetsRepairs; Option)
        {
            Caption = 'Carpets repairs';
            DataClassification = CustomerContent;
            OptionCaption = 'No,Tenant,Landlord';
            OptionMembers = No, Tenant, Landlord;
        }
        field(109; Rum1WoodworksCondition; Option)
        {
            Caption = 'Woodwork condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;
        }
        field(110; Rum1WoodworksRepairs; Option)
        {
            Caption = 'Woodworks repairs';
            DataClassification = CustomerContent;
            OptionCaption = 'No,Tenant,Landlord';
            OptionMembers = No, Tenant, Landlord;
        }
        field(111; Rum1WindowsmvCondition; Option)
        {
            Caption = 'Windows etc condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;
        }
        field(112; Rum1WindowsRepairs; Option)
        {
            Caption = 'Windows etc. repairs';
            DataClassification = CustomerContent;
            OptionCaption = 'No,Tenant,Landlord';
            OptionMembers = No, Tenant, Landlord;
        }
        field(113; Rum1RadiatorCondition; Option)
        {
            Caption = 'Radiators condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;
        }
        field(114; Rum1RadiatorRepairs; Option)
        {
            Caption = 'Radiators repairs';
            DataClassification = CustomerContent;
            OptionCaption = 'No,Tenant,Landlord';
            OptionMembers = No, Tenant, Landlord;
        }
        field(115; Rum1ElCondition; Option)
        {
            Caption = 'Electricity condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;
        }
        field(116; Rum1ElRepairs; Option)
        {
            Caption = 'Electric parts repairs';
            DataClassification = CustomerContent;
            OptionCaption = 'No,Tenant,Landlord';
            OptionMembers = No, Tenant, Landlord;
        }
        field(117; Rum1DoorsCondition; Option)
        {
            Caption = 'Doors condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;
        }
        field(118; Rum1DoorsRepairs; Option)
        {
            Caption = 'Doors repairs';
            DataClassification = CustomerContent;
            OptionCaption = 'No,Tenant,Landlord';
            OptionMembers = No, Tenant, Landlord;
        }
        field(200; Room2Description; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Description (place)';
        }
        field(201; Rum2CeilingCondition; Option)
        {
            Caption = 'Ceiling condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;
        }
        field(202; Rum2CeilingRepairs; Option)
        {
            Caption = 'Ceiling repairs';
            DataClassification = CustomerContent;
            OptionCaption = 'No,Tenant,Landlord';
            OptionMembers = No, Tenant, Landlord;
        }
        field(203; Rum2WallsCondition; Option)
        {
            Caption = 'Walls condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;
        }
        field(204; Rum2WallsRepairs; Option)
        {
            Caption = 'Wall repairs';
            DataClassification = CustomerContent;
            OptionCaption = 'No,Tenant,Landlord';
            OptionMembers = No, Tenant, Landlord;
        }
        field(205; Rum2FloorsCondition; Option)
        {
            Caption = 'Floor condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;
        }
        field(206; Rum2FloorsRepairs; Option)
        {
            Caption = 'Floor repairs';
            DataClassification = CustomerContent;
            OptionCaption = 'No,Tenant,Landlord';
            OptionMembers = No, Tenant, Landlord;
        }
        field(207; Rum2CarpetsCondition; Option)
        {
            Caption = 'Carpets condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;
        }
        field(208; Rum2CarpetsRepairs; Option)
        {
            Caption = 'Carpets repairs';
            DataClassification = CustomerContent;
            OptionCaption = 'No,Tenant,Landlord';
            OptionMembers = No, Tenant, Landlord;
        }
        field(209; Rum2WoodworksCondition; Option)
        {
            Caption = 'Woodwork condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;
        }
        field(210; Rum2WoodworksRepairs; Option)
        {
            Caption = 'Woodworks repairs';
            DataClassification = CustomerContent;
            OptionCaption = 'No,Tenant,Landlord';
            OptionMembers = No, Tenant, Landlord;
        }
        field(211; Rum2WindowsmvCondition; Option)
        {
            Caption = 'Windows etc condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;
        }
        field(212; Rum2WindowsRepairs; Option)
        {
            Caption = 'Windows etc. repairs';
            DataClassification = CustomerContent;
            OptionCaption = 'No,Tenant,Landlord';
            OptionMembers = No, Tenant, Landlord;
        }
        field(213; Rum2RadiatorCondition; Option)
        {
            Caption = 'Radiators condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;
        }
        field(214; Rum2RadiatorRepairs; Option)
        {
            Caption = 'Radiators repairs';
            DataClassification = CustomerContent;
            OptionCaption = 'No,Tenant,Landlord';
            OptionMembers = No, Tenant, Landlord;
        }
        field(215; Rum2ElCondition; Option)
        {
            Caption = 'Electricity condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;
        }
        field(216; Rum2ElRepairs; Option)
        {
            Caption = 'Electric parts repairs';
            DataClassification = CustomerContent;
            OptionCaption = 'No,Tenant,Landlord';
            OptionMembers = No, Tenant, Landlord;
        }
        field(217; Rum2DoorsCondition; Option)
        {
            Caption = 'Doors condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;
        }
        field(218; Rum2DoorsRepairs; Option)
        {
            Caption = 'Doors repairs';
            DataClassification = CustomerContent;
            OptionCaption = 'No,Tenant,Landlord';
            OptionMembers = No, Tenant, Landlord;
        }
        field(300; Room3Description; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Description (place)';
        }
        field(301; Rum3CeilingCondition; Option)
        {
            Caption = 'Ceiling condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;
        }
        field(302; Rum3CeilingRepairs; Option)
        {
            Caption = 'Ceiling repairs';
            DataClassification = CustomerContent;
            OptionCaption = 'No,Tenant,Landlord';
            OptionMembers = No, Tenant, Landlord;
        }
        field(303; Rum3WallsCondition; Option)
        {
            Caption = 'Walls condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;
        }
        field(304; Rum3WallsRepairs; Option)
        {
            Caption = 'Wall repairs';
            DataClassification = CustomerContent;
            OptionCaption = 'No,Tenant,Landlord';
            OptionMembers = No, Tenant, Landlord;
        }
        field(305; Rum3FloorsCondition; Option)
        {
            Caption = 'Floor condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;
        }
        field(306; Rum3FloorsRepairs; Option)
        {
            Caption = 'Floor repairs';
            DataClassification = CustomerContent;
            OptionCaption = 'No,Tenant,Landlord';
            OptionMembers = No, Tenant, Landlord;
        }
        field(307; Rum3CarpetsCondition; Option)
        {
            Caption = 'Carpets condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;
        }
        field(308; Rum3CarpetsRepairs; Option)
        {
            Caption = 'Carpets repairs';
            DataClassification = CustomerContent;
            OptionCaption = 'No,Tenant,Landlord';
            OptionMembers = No, Tenant, Landlord;
        }
        field(309; Rum3WoodworksCondition; Option)
        {
            Caption = 'Woodwork condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;
        }
        field(310; Rum3WoodworksRepairs; Option)
        {
            Caption = 'Woodworks repairs';
            DataClassification = CustomerContent;
            OptionCaption = 'No,Tenant,Landlord';
            OptionMembers = No, Tenant, Landlord;
        }
        field(311; Rum3WindowsmvCondition; Option)
        {
            Caption = 'Windows etc condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;
        }
        field(312; Rum3WindowsRepairs; Option)
        {
            Caption = 'Windows etc. repairs';
            DataClassification = CustomerContent;
            OptionCaption = 'No,Tenant,Landlord';
            OptionMembers = No, Tenant, Landlord;
        }
        field(313; Rum3RadiatorCondition; Option)
        {
            Caption = 'Radiators condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;
        }
        field(314; Rum3RadiatorRepairs; Option)
        {
            Caption = 'Radiators repairs';
            DataClassification = CustomerContent;
            OptionCaption = 'No,Tenant,Landlord';
            OptionMembers = No, Tenant, Landlord;
        }
        field(315; Rum3ElCondition; Option)
        {
            Caption = 'Electricity condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;
        }
        field(316; Rum3ElRepairs; Option)
        {
            Caption = 'Electric parts repairs';
            DataClassification = CustomerContent;
            OptionCaption = 'No,Tenant,Landlord';
            OptionMembers = No, Tenant, Landlord;
        }
        field(317; Rum3DoorsCondition; Option)
        {
            Caption = 'Doors condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;
        }
        field(318; Rum3DoorsRepairs; Option)
        {
            Caption = 'Doors repairs';
            DataClassification = CustomerContent;
            OptionCaption = 'No,Tenant,Landlord';
            OptionMembers = No, Tenant, Landlord;
        }
        field(400; Room4Description; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Description (place)';
        }
        field(401; Rum4CeilingCondition; Option)
        {
            Caption = 'Ceiling condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;
        }
        field(402; Rum4CeilingRepairs; Option)
        {
            Caption = 'Ceiling repairs';
            DataClassification = CustomerContent;
            OptionCaption = 'No,Tenant,Landlord';
            OptionMembers = No, Tenant, Landlord;
        }
        field(403; Rum4WallsCondition; Option)
        {
            Caption = 'Walls condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;
        }
        field(404; Rum4WallsRepairs; Option)
        {
            Caption = 'Wall repairs';
            DataClassification = CustomerContent;
            OptionCaption = 'No,Tenant,Landlord';
            OptionMembers = No, Tenant, Landlord;
        }
        field(405; Rum4FloorsCondition; Option)
        {
            Caption = 'Floor condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;
        }
        field(406; Rum4FloorsRepairs; Option)
        {
            Caption = 'Floor repairs';
            DataClassification = CustomerContent;
            OptionCaption = 'No,Tenant,Landlord';
            OptionMembers = No, Tenant, Landlord;
        }
        field(407; Rum4CarpetsCondition; Option)
        {
            Caption = 'Carpets condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;
        }
        field(408; Rum4CarpetsRepairs; Option)
        {
            Caption = 'Carpets repairs';
            DataClassification = CustomerContent;
            OptionCaption = 'No,Tenant,Landlord';
            OptionMembers = No, Tenant, Landlord;
        }
        field(409; Rum4WoodworksCondition; Option)
        {
            Caption = 'Woodwork condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;
        }
        field(410; Rum4WoodworksRepairs; Option)
        {
            Caption = 'Woodworks repairs';
            DataClassification = CustomerContent;
            OptionCaption = 'No,Tenant,Landlord';
            OptionMembers = No, Tenant, Landlord;
        }
        field(411; Rum4WindowsmvCondition; Option)
        {
            Caption = 'Windows etc condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;
        }
        field(412; Rum4WindowsRepairs; Option)
        {
            Caption = 'Windows etc. repairs';
            DataClassification = CustomerContent;
            OptionCaption = 'No,Tenant,Landlord';
            OptionMembers = No, Tenant, Landlord;
        }
        field(413; Rum4RadiatorCondition; Option)
        {
            Caption = 'Radiators condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;
        }
        field(414; Rum4RadiatorRepairs; Option)
        {
            Caption = 'Radiators repairs';
            DataClassification = CustomerContent;
            OptionCaption = 'No,Tenant,Landlord';
            OptionMembers = No, Tenant, Landlord;
        }
        field(415; Rum4ElCondition; Option)
        {
            Caption = 'Electricity condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;
        }
        field(416; Rum4ElRepairs; Option)
        {
            Caption = 'Electric parts repairs';
            DataClassification = CustomerContent;
            OptionCaption = 'No,Tenant,Landlord';
            OptionMembers = No, Tenant, Landlord;
        }
        field(417; Rum4DoorsCondition; Option)
        {
            Caption = 'Doors condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;
        }
        field(418; Rum4DoorsRepairs; Option)
        {
            Caption = 'Doors repairs';
            DataClassification = CustomerContent;
            OptionCaption = 'No,Tenant,Landlord';
            OptionMembers = No, Tenant, Landlord;
        }
        field(501; EntreCeilingCondition; Option)
        {
            Caption = 'Ceiling condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;
        }
        field(502; EntreCeilingRepairs; Option)
        {
            Caption = 'Ceiling repairs';
            DataClassification = CustomerContent;
            OptionCaption = 'No,Tenant,Landlord';
            OptionMembers = No, Tenant, Landlord;
        }
        field(503; EntreWallsCondition; Option)
        {
            Caption = 'Walls condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;
        }
        field(504; EntreWallsRepairs; Option)
        {
            Caption = 'Wall repairs';
            DataClassification = CustomerContent;
            OptionCaption = 'No,Tenant,Landlord';
            OptionMembers = No, Tenant, Landlord;
        }
        field(505; EntreFloorsCondition; Option)
        {
            Caption = 'Floor condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;
        }
        field(506; EntreFloorsRepairs; Option)
        {
            Caption = 'Floor repairs';
            DataClassification = CustomerContent;
            OptionCaption = 'No,Tenant,Landlord';
            OptionMembers = No, Tenant, Landlord;
        }
        field(507; EntreCarpetsCondition; Option)
        {
            Caption = 'Carpets condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;
        }
        field(508; EntreCarpetsRepairs; Option)
        {
            Caption = 'Carpets repairs';
            DataClassification = CustomerContent;
            OptionCaption = 'No,Tenant,Landlord';
            OptionMembers = No, Tenant, Landlord;
        }
        field(509; EntreWoodworksCondition; Option)
        {
            Caption = 'Woodwork condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;
        }
        field(510; EntreWoodworksRepairs; Option)
        {
            Caption = 'Woodworks repairs';
            DataClassification = CustomerContent;
            OptionCaption = 'No,Tenant,Landlord';
            OptionMembers = No, Tenant, Landlord;
        }
        field(511; EntreWindowsmvCondition; Option)
        {
            Caption = 'Windows etc condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;
        }
        field(512; EntreWindowsRepairs; Option)
        {
            Caption = 'Windows etc. repairs';
            DataClassification = CustomerContent;
            OptionCaption = 'No,Tenant,Landlord';
            OptionMembers = No, Tenant, Landlord;
        }
        field(513; EntreRadiatorCondition; Option)
        {
            Caption = 'Radiators condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;
        }
        field(514; EntreRadiatorRepairs; Option)
        {
            Caption = 'Radiators repairs';
            DataClassification = CustomerContent;
            OptionCaption = 'No,Tenant,Landlord';
            OptionMembers = No, Tenant, Landlord;
        }
        field(515; EntreElCondition; Option)
        {
            Caption = 'Electricity condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;
        }
        field(516; EntreElRepairs; Option)
        {
            Caption = 'Electric parts repairs';
            DataClassification = CustomerContent;
            OptionCaption = 'No,Tenant,Landlord';
            OptionMembers = No, Tenant, Landlord;
        }
        field(517; EntreDoorsCondition; Option)
        {
            Caption = 'Doors condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;
        }
        field(518; EntreDoorsRepairs; Option)
        {
            Caption = 'Doors repairs';
            DataClassification = CustomerContent;
            OptionCaption = 'No,Tenant,Landlord';
            OptionMembers = No, Tenant, Landlord;
        }
        field(601; KitchenCeilingCondition; Option)
        {
            Caption = 'Ceiling condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;
        }
        field(602; KitchenCeilingRepairs; Option)
        {
            Caption = 'Ceiling repairs';
            DataClassification = CustomerContent;
            OptionCaption = 'No,Tenant,Landlord';
            OptionMembers = No, Tenant, Landlord;
        }
        field(603; KitchenWallsCondition; Option)
        {
            Caption = 'Walls condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;
        }
        field(604; KitchenWallsRepairs; Option)
        {
            Caption = 'Wall repairs';
            DataClassification = CustomerContent;
            OptionCaption = 'No,Tenant,Landlord';
            OptionMembers = No, Tenant, Landlord;
        }
        field(605; KitchenFloorsCondition; Option)
        {
            Caption = 'Floor condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;
        }
        field(606; KitchenFloorsRepairs; Option)
        {
            Caption = 'Floor repairs';
            DataClassification = CustomerContent;
            OptionCaption = 'No,Tenant,Landlord';
            OptionMembers = No, Tenant, Landlord;
        }
        field(607; KitchenCarpetsCondition; Option)
        {
            Caption = 'Carpets condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;
        }
        field(608; KitchenCarpetsRepairs; Option)
        {
            Caption = 'Carpets repairs';
            DataClassification = CustomerContent;
            OptionCaption = 'No,Tenant,Landlord';
            OptionMembers = No, Tenant, Landlord;
        }
        field(609; KitchenWoodworksCondition; Option)
        {
            Caption = 'Woodwork condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;
        }
        field(610; KitchenWoodworksRepairs; Option)
        {
            Caption = 'Woodworks repairs';
            DataClassification = CustomerContent;
            OptionCaption = 'No,Tenant,Landlord';
            OptionMembers = No, Tenant, Landlord;
        }
        field(611; KitchenWindowsmvCondition; Option)
        {
            Caption = 'Windows etc condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;
        }
        field(612; KitchenWindowsRepairs; Option)
        {
            Caption = 'Windows etc. repairs';
            DataClassification = CustomerContent;
            OptionCaption = 'No,Tenant,Landlord';
            OptionMembers = No, Tenant, Landlord;
        }
        field(613; KitchenRadiatorCondition; Option)
        {
            Caption = 'Radiators condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;
        }
        field(614; KitchenRadiatorRepairs; Option)
        {
            Caption = 'Radiators repairs';
            DataClassification = CustomerContent;
            OptionCaption = 'No,Tenant,Landlord';
            OptionMembers = No, Tenant, Landlord;
        }
        field(615; KitchenElCondition; Option)
        {
            Caption = 'Electricity condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;
        }
        field(616; KitchenElRepairs; Option)
        {
            Caption = 'Electric parts repairs';
            DataClassification = CustomerContent;
            OptionCaption = 'No,Tenant,Landlord';
            OptionMembers = No, Tenant, Landlord;
        }
        field(617; KitchenDoorsCondition; Option)
        {
            Caption = 'Doors condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;
        }
        field(618; KitchenDoorsRepairs; Option)
        {
            Caption = 'Doors repairs';
            DataClassification = CustomerContent;
            OptionCaption = 'No,Tenant,Landlord';
            OptionMembers = No, Tenant, Landlord;
        }
        field(619; KitchenTilesConditions; Option)
        {
            Caption = 'Tiles condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;
        }
        field(620; KitchenTilesRepairs; Option)
        {
            Caption = 'Tiles repairs';
            DataClassification = CustomerContent;
            OptionCaption = 'No,Tenant,Landlord';
            OptionMembers = No, Tenant, Landlord;
        }
        field(621; KitchenTableCondition; Option)
        {
            Caption = 'Table condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;
        }
        field(622; KitchenTableRepairs; Option)
        {
            Caption = 'Table repairs';
            DataClassification = CustomerContent;
            OptionCaption = 'No,Tenant,Landlord';
            OptionMembers = No, Tenant, Landlord;
        }
        field(623; KitchenSinkCondition; Option)
        {
            Caption = 'Sink condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;
        }
        field(624; KitchensinkRepairs; Option)
        {
            Caption = 'Sink repairs';
            DataClassification = CustomerContent;
            OptionCaption = 'No,Tenant,Landlord';
            OptionMembers = No, Tenant, Landlord;
        }
        field(625; KitchenCabinetsCondition; Option)
        {
            Caption = 'Kitchen cabinets condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;
        }
        field(626; KitchenCabinetsRepairs; Option)
        {
            Caption = 'Kitchen cabinets repair';
            DataClassification = CustomerContent;
            OptionCaption = 'No,Tenant,Landlord';
            OptionMembers = No, Tenant, Landlord;
        }
        field(627; KitchenWatertapsCondition; Option)
        {
            Caption = 'Watertaps condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;
        }
        field(628; KitchenWatertapsRepairs; Option)
        {
            Caption = 'Water taps repairs';
            DataClassification = CustomerContent;
            OptionCaption = 'No,Tenant,Landlord';
            OptionMembers = No, Tenant, Landlord;
        }
        field(701; BathroomCeilingCondition; Option)
        {
            Caption = 'Ceiling condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;
        }
        field(702; BathroomCeilingRepairs; Option)
        {
            Caption = 'Ceiling repairs';
            DataClassification = CustomerContent;
            OptionCaption = 'No,Tenant,Landlord';
            OptionMembers = No, Tenant, Landlord;
        }
        field(703; BathroomWallsCondition; Option)
        {
            Caption = 'Walls condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;
        }
        field(704; BathroomWallsRepairs; Option)
        {
            Caption = 'Wall repairs';
            DataClassification = CustomerContent;
            OptionCaption = 'No,Tenant,Landlord';
            OptionMembers = No, Tenant, Landlord;
        }
        field(705; BathroomFloorsCondition; Option)
        {
            Caption = 'Floor condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;
        }
        field(706; BathroomFloorsRepairs; Option)
        {
            Caption = 'Floor repairs';
            DataClassification = CustomerContent;
            OptionCaption = 'No,Tenant,Landlord';
            OptionMembers = No, Tenant, Landlord;
        }
        field(707; BathroomCarpetsCondition; Option)
        {
            Caption = 'Carpets condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;
        }
        field(708; BathroomCarpetsRepairs; Option)
        {
            Caption = 'Carpets repairs';
            DataClassification = CustomerContent;
            OptionCaption = 'No,Tenant,Landlord';
            OptionMembers = No, Tenant, Landlord;
        }
        field(709; BathroomWoodworksCondition; Option)
        {
            Caption = 'Woodwork condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;
        }
        field(710; BathroomWoodworksRepairs; Option)
        {
            Caption = 'Woodworks repairs';
            DataClassification = CustomerContent;
            OptionCaption = 'No,Tenant,Landlord';
            OptionMembers = No, Tenant, Landlord;
        }
        field(711; BathroomWindowsmvCondition; Option)
        {
            Caption = 'Windows etc condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;
        }
        field(712; BathroomWindowsRepairs; Option)
        {
            Caption = 'Windows etc. repairs';
            DataClassification = CustomerContent;
            OptionCaption = 'No,Tenant,Landlord';
            OptionMembers = No, Tenant, Landlord;
        }
        field(713; BathroomRadiatorCondition; Option)
        {
            Caption = 'Radiators condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;
        }
        field(714; BathroomRadiatorRepairs; Option)
        {
            Caption = 'Radiators repairs';
            DataClassification = CustomerContent;
            OptionCaption = 'No,Tenant,Landlord';
            OptionMembers = No, Tenant, Landlord;
        }
        field(715; BathroomElCondition; Option)
        {
            Caption = 'Electricity condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;
        }
        field(716; BathroomElRepairs; Option)
        {
            Caption = 'Electric parts repairs';
            DataClassification = CustomerContent;
            OptionCaption = 'No,Tenant,Landlord';
            OptionMembers = No, Tenant, Landlord;
        }
        field(717; BathroomDoorsCondition; Option)
        {
            Caption = 'Doors condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;
        }
        field(718; BathroomDoorsRepairs; Option)
        {
            Caption = 'Doors repairs';
            DataClassification = CustomerContent;
            OptionCaption = 'No,Tenant,Landlord';
            OptionMembers = No, Tenant, Landlord;
        }
        field(719; BathroomSinkCondition; Option)
        {
            Caption = 'Sink condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;
        }
        field(720; BathroomSinkRepairs; Option)
        {
            Caption = 'Sink repairs';
            DataClassification = CustomerContent;
            OptionCaption = 'No,Tenant,Landlord';
            OptionMembers = No, Tenant, Landlord;
        }
        field(721; BathroomCisternDoorsCondition; Option)
        {
            Caption = 'Cistern condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;
        }
        field(722; BathroomCisternRepairs; Option)
        {
            Caption = 'Cistern repairs';
            DataClassification = CustomerContent;
            OptionCaption = 'No,Tenant,Landlord';
            OptionMembers = No, Tenant, Landlord;
        }
        field(723; BathroomToiletBowlCondition; Option)
        {
            Caption = 'Toiletbowl condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;
        }
        field(724; BathroomToiletBowlRepairs; Option)
        {
            Caption = 'Toiletbowl repairs';
            DataClassification = CustomerContent;
            OptionCaption = 'No,Tenant,Landlord';
            OptionMembers = No, Tenant, Landlord;
        }
        field(725; BathroomBathtopCondition; Option)
        {
            Caption = 'Bathtop condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;
        }
        field(726; BathroombathTopRepairs; Option)
        {
            Caption = 'Bathtop repairs';
            DataClassification = CustomerContent;
            OptionCaption = 'No,Tenant,Landlord';
            OptionMembers = No, Tenant, Landlord;
        }
        field(727; BathroomShowerCondition; Option)
        {
            Caption = 'Shower condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;
        }
        field(728; BathroomShowerRepairs; Option)
        {
            Caption = 'Shower repairs';
            DataClassification = CustomerContent;
            OptionCaption = 'No,Tenant,Landlord';
            OptionMembers = No, Tenant, Landlord;
        }
        field(729; BathroomWaterTapsCondition; Option)
        {
            Caption = 'Watertaps condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;
        }
        field(730; BathroomWaterTapsRepairs; Option)
        {
            Caption = 'Watertaps repairs';
            DataClassification = CustomerContent;
            OptionCaption = 'No,Tenant,Landlord';
            OptionMembers = No, Tenant, Landlord;
        }
        field(801; ToiletCeilingCondition; Option)
        {
            Caption = 'Ceiling condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;
        }
        field(802; ToiletCeilingRepairs; Option)
        {
            Caption = 'Ceiling repairs';
            DataClassification = CustomerContent;
            OptionCaption = 'No,Tenant,Landlord';
            OptionMembers = No, Tenant, Landlord;
        }
        field(803; ToiletWallsCondition; Option)
        {
            Caption = 'Walls condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;
        }
        field(804; ToiletWallsRepairs; Option)
        {
            Caption = 'Wall repairs';
            DataClassification = CustomerContent;
            OptionCaption = 'No,Tenant,Landlord';
            OptionMembers = No, Tenant, Landlord;
        }
        field(805; ToiletFloorsCondition; Option)
        {
            Caption = 'Floor condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;
        }
        field(806; ToiletFloorsRepairs; Option)
        {
            Caption = 'Floor repairs';
            DataClassification = CustomerContent;
            OptionCaption = 'No,Tenant,Landlord';
            OptionMembers = No, Tenant, Landlord;
        }
        field(807; ToiletCarpetsCondition; Option)
        {
            Caption = 'Carpets condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;
        }
        field(808; ToiletCarpetsRepairs; Option)
        {
            Caption = 'Carpets repairs';
            DataClassification = CustomerContent;
            OptionCaption = 'No,Tenant,Landlord';
            OptionMembers = No, Tenant, Landlord;
        }
        field(809; ToiletWoodworksCondition; Option)
        {
            Caption = 'Woodwork condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;
        }
        field(810; ToiletWoodworksRepairs; Option)
        {
            Caption = 'Woodworks repairs';
            DataClassification = CustomerContent;
            OptionCaption = 'No,Tenant,Landlord';
            OptionMembers = No, Tenant, Landlord;
        }
        field(811; ToiletWindowsmvCondition; Option)
        {
            Caption = 'Windows etc condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;
        }
        field(812; ToiletWindowsRepairs; Option)
        {
            Caption = 'Windows etc. repairs';
            DataClassification = CustomerContent;
            OptionCaption = 'No,Tenant,Landlord';
            OptionMembers = No, Tenant, Landlord;
        }
        field(813; ToiletRadiatorCondition; Option)
        {
            Caption = 'Radiators condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;
        }
        field(814; ToiletRadiatorRepairs; Option)
        {
            Caption = 'Radiators repairs';
            DataClassification = CustomerContent;
            OptionCaption = 'No,Tenant,Landlord';
            OptionMembers = No, Tenant, Landlord;
        }
        field(815; ToiletElCondition; Option)
        {
            Caption = 'Electricity condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;
        }
        field(816; ToiletElRepairs; Option)
        {
            Caption = 'Electric parts repairs';
            DataClassification = CustomerContent;
            OptionCaption = 'No,Tenant,Landlord';
            OptionMembers = No, Tenant, Landlord;
        }
        field(817; ToiletDoorsCondition; Option)
        {
            Caption = 'Doors condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;
        }
        field(818; ToiletDoorsRepairs; Option)
        {
            Caption = 'Doors repairs';
            DataClassification = CustomerContent;
            OptionCaption = 'No,Tenant,Landlord';
            OptionMembers = No, Tenant, Landlord;
        }
        field(819; ToiletSinkCondition; Option)
        {
            Caption = 'Sink condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;
        }
        field(820; ToiletSinkRepairs; Option)
        {
            Caption = 'Sink repairs';
            DataClassification = CustomerContent;
            OptionCaption = 'No,Tenant,Landlord';
            OptionMembers = No, Tenant, Landlord;
        }
        field(821; ToiletCisternDoorsCondition; Option)
        {
            Caption = 'Cistern condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;
        }
        field(822; ToiletCisternRepairs; Option)
        {
            Caption = 'Cistern repairs';
            DataClassification = CustomerContent;
            OptionCaption = 'No,Tenant,Landlord';
            OptionMembers = No, Tenant, Landlord;
        }
        field(823; ToiletToiletBowlCondition; Option)
        {
            Caption = 'Toiletbowl condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;
        }
        field(824; ToiletToiletBowlRepairs; Option)
        {
            Caption = 'Toiletbowl repairs';
            DataClassification = CustomerContent;
            OptionCaption = 'No,Tenant,Landlord';
            OptionMembers = No, Tenant, Landlord;
        }
        field(825; ToiletwaterTapsCondition; Option)
        {
            Caption = 'Watertaps condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;
        }
        field(826; ToiletWaterTapsRepairs; Option)
        {
            Caption = 'Watertaps repairs';
            DataClassification = CustomerContent;
            OptionCaption = 'No,Tenant,Landlord';
            OptionMembers = No, Tenant, Landlord;
        }
        field(901; StoveYear; Text[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Year';
        }
        field(902; StoveManufactor; Text[30])
        {
            Caption = 'Manufactor';
            DataClassification = CustomerContent;
        }
        field(903; StoveModel; Text[30])
        {
            Caption = 'Model';
            DataClassification = CustomerContent;
        }
        field(904; StoveCondition; Option)
        {
            Caption = 'Stove condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;
        }
        field(905; StoveRepairs; Option)
        {
            Caption = 'Stove repairs';
            DataClassification = CustomerContent;
            OptionCaption = 'None,Repair,Replaced';
            OptionMembers = None, Repair, Replaced;
        }
        field(906; CookYear; Text[10])
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
        }
        field(907; CookManufactor; Text[30])
        {
            Caption = 'Manufactor';
            DataClassification = CustomerContent;
        }
        field(908; CookModel; Text[30])
        {
            Caption = 'Model';
            DataClassification = CustomerContent;
        }
        field(909; CookCondition; Option)
        {
            Caption = 'Cook condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;
        }
        field(910; CookRepairs; Option)
        {
            Caption = 'Cook repairs';
            DataClassification = CustomerContent;
            OptionCaption = 'None,Repair,Replaced';
            OptionMembers = None, Repair, Replaced;
        }
        field(911; OvenYear; Text[10])
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
        }
        field(912; OvenManufactor; Text[30])
        {
            Caption = 'Manufactor';
            DataClassification = CustomerContent;
        }
        field(913; OvenModel; Text[30])
        {
            Caption = 'Model';
            DataClassification = CustomerContent;
        }
        field(914; OvenCondition; Option)
        {
            Caption = 'Oven condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;
        }
        field(915; OvenRepairs; Option)
        {
            Caption = 'Oven repairs';
            DataClassification = CustomerContent;
            OptionCaption = 'None,Repair,Replaced';
            OptionMembers = None, Repair, Replaced;
        }
        field(916; HoodYear; Text[10])
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
        }
        field(917; HoodManufactor; Text[30])
        {
            Caption = 'Manufactor';
            DataClassification = CustomerContent;
        }
        field(918; HoodStoveModel; Text[30])
        {
            Caption = 'Model';
            DataClassification = CustomerContent;
        }
        field(919; HoodCondition; Option)
        {
            Caption = 'Hood condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;
        }
        field(920; HoodeRepairs; Option)
        {
            Caption = 'Hood repairs';
            DataClassification = CustomerContent;
            OptionCaption = 'None,Repair,Replaced';
            OptionMembers = None, Repair, Replaced;
        }
        field(921; FridgeYear; Text[10])
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
        }
        field(922; FridgeManufactor; Text[30])
        {
            Caption = 'Manufactor';
            DataClassification = CustomerContent;
        }
        field(923; FridgeModel; Text[30])
        {
            Caption = 'Model';
            DataClassification = CustomerContent;
        }
        field(924; FridgeCondition; Option)
        {
            Caption = 'Fridge condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;
        }
        field(925; FridgeRepairs; Option)
        {
            Caption = 'Fridge repairs';
            DataClassification = CustomerContent;
            OptionCaption = 'None,Repair,Replaced';
            OptionMembers = None, Repair, Replaced;
        }
        field(926; FreezerYear; Text[10])
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
        }
        field(927; FreezerManufactor; Text[30])
        {
            Caption = 'Manufactor';
            DataClassification = CustomerContent;
        }
        field(928; FreezerModel; Text[30])
        {
            Caption = 'Model';
            DataClassification = CustomerContent;
        }
        field(929; FreezerCondition; Option)
        {
            Caption = 'Freezer condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;
        }
        field(930; FreezerRepairs; Option)
        {
            Caption = 'Freezer repairs';
            DataClassification = CustomerContent;
            OptionCaption = 'None,Repair,Replaced';
            OptionMembers = None, Repair, Replaced;
        }
        field(931; DishwasherYear; Text[10])
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
        }
        field(932; DishwasherManufactor; Text[30])
        {
            Caption = 'Manufactor';
            DataClassification = CustomerContent;
        }
        field(933; DishwasherModel; Text[30])
        {
            Caption = 'Model';
            DataClassification = CustomerContent;
        }
        field(934; DishwasherCondition; Option)
        {
            Caption = 'Dishwasher condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;
        }
        field(935; DishwasherRepairs; Option)
        {
            Caption = 'Dishwasher repairs';
            DataClassification = CustomerContent;
            OptionCaption = 'None,Repair,Replaced';
            OptionMembers = None, Repair, Replaced;
        }
        field(936; WasherYear; Text[10])
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
        }
        field(937; WasherManufactor; Text[30])
        {
            Caption = 'Manufactor';
            DataClassification = CustomerContent;
        }
        field(938; WasherModel; Text[30])
        {
            Caption = 'Model';
            DataClassification = CustomerContent;
        }
        field(939; WasherCondition; Option)
        {
            Caption = 'Washer condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;
        }
        field(940; WasherRepairs; Option)
        {
            Caption = 'Washer repairs';
            DataClassification = CustomerContent;
            OptionCaption = 'None,Repair,Replaced';
            OptionMembers = None, Repair, Replaced;
        }
        field(941; DryerYear; Text[10])
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
        }
        field(942; DryerManufactor; Text[30])
        {
            Caption = 'Manufactor';
            DataClassification = CustomerContent;
        }
        field(943; DryerModel; Text[30])
        {
            Caption = 'Model';
            DataClassification = CustomerContent;
        }
        field(944; DryerCondition; Option)
        {
            Caption = 'Dryer condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;
        }
        field(945; DryerRepairs; Option)
        {
            Caption = 'Dryer repairs';
            DataClassification = CustomerContent;
            OptionCaption = 'None,Repair,Replaced';
            OptionMembers = None, Repair, Replaced;
        }
        field(946; EntryPhoneYear; Text[10])
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
        }
        field(947; EntryPhoneManufactor; Text[30])
        {
            Caption = 'Manufactor';
            DataClassification = CustomerContent;
        }
        field(948; EntryPhoneModel; Text[30])
        {
            Caption = 'Model';
            DataClassification = CustomerContent;
        }
        field(949; EntryPhoneCondition; Option)
        {
            Caption = 'entryphone condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;
        }
        field(950; EntryPhoneRepairs; Option)
        {
            Caption = 'Entryphone repairs';
            DataClassification = CustomerContent;
            OptionCaption = 'None,Repair,Replaced';
            OptionMembers = None, Repair, Replaced;
        }
        field(951; AntennaCondition; Option)
        {
            Caption = 'Antenna condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;
        }
        field(952; AntennaRepairs; Option)
        {
            Caption = 'Antenna repairs';
            DataClassification = CustomerContent;
            OptionCaption = 'None,Repair,Replaced';
            OptionMembers = None, Repair, Replaced;
        }
        field(953; KeyCondition; Option)
        {
            Caption = 'Key condition';
            DataClassification = CustomerContent;
            OptionCaption = 'Not existing,Refurnished,Good condition,Bad condition,Worn';
            OptionMembers = "Not existing", Refurnished, "Good condition", "Bad condition", Worn;
        }
        field(954; KeyRepairs; Option)
        {
            Caption = 'Key repairs';
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

