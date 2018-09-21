codeunit 60530 "SVA Estate MF"
{
    // Diverse småkørsler on the run


    trigger OnRun();
    begin
        Sublines.RESET;
        //Sublines.SETRANGE(Type, 6);
        IF Sublines.FINDSET() THEN BEGIN
          REPEAT
          CosttypeEstate.RESET();
          CosttypeEstate.SETRANGE(CosttypeEstate.Costtype,Sublines."Cost Types");
          IF CosttypeEstate.FIND('-') THEN BEGIN
              Sublines.Type := CosttypeEstate.Type;
              Sublines.MODIFY();
              END;
          UNTIL Sublines.NEXT = 0;
          END;
    end;

    var
        OcTrans : Record "SVA Occupant Trans";
        CosttypeEstate : Record "SVA Cost type Estate";
        LedTable : Record "G/L Account";
        Occupant : Record "SVA Occupant";
        Tenancy : Record "SVA Tenancy";
        Salesline : Record "Sales Line";
        Sublines : Record "SVA Subscription Lines";
}

