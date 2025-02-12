table 50020 "SVA PostCode"
{
    DataClassification = CustomerContent;
    
    fields
    {
        field(1;PostCode;Text[10])
        {
            DataClassification = CustomerContent;            
        }
        field(2;Country;Text[10])
        {
            DataClassification = CustomerContent;            
        }
        field(3;City;Text[100])
        {
            DataClassification = CustomerContent;            
        }


    }
    
    keys
    {
        key(Key1; PostCode)
        {
            Clustered = true;
        }
    }
      
}