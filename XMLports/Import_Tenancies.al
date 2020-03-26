xmlport 50069 "SVA Import Tenancies"
{
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = WINDOWS;

    schema
    {
        textelement(Root)
        {
            tableelement("SVA Tenancy";"SVA Tenancy")
            {
                XmlName = 'Tenancies';
                
                fieldattribute(Number;"SVA Tenancy".Number)
                {
                }
                fieldattribute(Property;"SVA Tenancy".PropertyNo)
                {
                }
                fieldattribute(Name;"SVA Tenancy".Name)
                {
                }
                fieldattribute(Address1;"SVA Tenancy".Address1)
                {
                }
                fieldattribute(Address2;"SVA Tenancy".Address2)
                {
                }
                fieldattribute(Postcode;"SVA Tenancy"."Post Code")
                {
                }
                fieldattribute(City;"SVA Tenancy".City)
                {
                }
                fieldattribute("AreaTotal";"SVA Tenancy".AreaTotal)
                {
                }
                fieldattribute(Rooms;"SVA Tenancy".Rooms)
                {
                }
                fieldattribute(Type;"SVA Tenancy".Type)
                {
                }
                fieldattribute(PeriodYear;"SVA Tenancy".PeriodYear) //k
                {
                }
                fieldattribute(Apartment; "SVA Tenancy".TypeA9_1_Apartment)
                {

                }
                fieldattribute(Room; "SVA Tenancy".TypeA9_1_Room)
                {

                }
                fieldattribute(Condem; "SVA Tenancy".TypeA9_1_Condominium)
                {

                }
                fieldattribute(HousingGp; "SVA Tenancy".TypeA9_1_HousingCoop)
                {

                }
                fieldattribute(Other; "SVA Tenancy".TypeA9_1_OtherT) //16
                {

                }
                fieldattribute(OtherTekst; "SVA Tenancy".TypeA9_1_OtherTTxt)
                {

                }
                fieldattribute(Garage;"SVA Tenancy".TypeA9_1_Garage)
                {

                }
                fieldattribute(Loft;"SVA Tenancy".TypeA9_1_Attic) //s
                {

                }
                fieldattribute(Indflytningssyn;"SVA Tenancy".TypeA9_7_InspecionIn)
                {

                }
                fieldattribute(Vedl;"SVA Tenancy".TypeA9_8_maintainceInsideTenan)
                {

                }
                fieldattribute(Komfur;"SVA Tenancy".TypeA9_9_Stove)
                {

                }
                fieldattribute(Køleskab;"SVA Tenancy".TypeA9_9_Fridge)
                {

                }
                fieldattribute(emhætte;"SVA Tenancy".TypeA9_9_Hood)
                {

                }
                fieldattribute(Opvaskemaskine;"SVA Tenancy".TypeA9_9_dishwasher)
                {

                }
                fieldattribute(Vaskemaskine;"SVA Tenancy".TypeA9_9_Washer)
                {

                }
                fieldattribute(tøretumbler;"SVA Tenancy".TypeA9_9_Dryer)
                {

                }
                fieldattribute(elpaneler;"SVA Tenancy".TypeA9_9_ElectricPanels)
                {

                }
                fieldattribute(elqty;"SVA Tenancy".TypeA9_9_El_qty)
                {

                }
                fieldattribute(Vandvarme;"SVA Tenancy".TypeA9_9_WaterHeater)
                {

                }
                fieldattribute(Waterheaterqty;"SVA Tenancy".TypeA9_9_WaterHeater_qty)
                {
                }
                fieldattribute(Tom1;"SVA Tenancy".TypeA9_9_Other1Text)
                {

                }
                fieldattribute(Tom2;"SVA Tenancy".TypeA9_9_Other2Text)
                {
                    
                }
                fieldattribute(Tom3;"SVA Tenancy".TypeA9_9_Other3Text)
                {
                    
                }

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
    trigger OnPostXmlPort();
    begin
        Message('Lejemål er indlæst');
    end;

}

