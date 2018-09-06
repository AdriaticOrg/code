codeunit 13062610 "Fisc. Management SI-ADL"
{
    Permissions = TableData "Sales Invoice Header"=rimd,TableData "Sales Cr.Memo Header"=rimd;
    trigger OnRun()
    begin
        
    end;
    
    var
        xmlFile : File;
        FileName : Text;
    procedure FiscSetupExists() : Boolean
    var
      FiscalizationSetup : Record "Fiscalization Setup-ADL";
    begin
        EXIT(FiscalizationSetup.GET);
    end;
    procedure GetFiscSubject(FiscPaymentMethodCode : Code[20]) : Boolean
    var 
        FiscPaymentMethod : Record "Fisc. Payment Method-ADL";
    begin
    IF ((FiscPaymentMethodCode<>'') AND (FiscPaymentMethod.GET(FiscPaymentMethodCode))) THEN
      EXIT(FiscPaymentMethod."Subject to Fiscalization")
    ELSE
      EXIT(FALSE);
    end;

    procedure GetFiscLocationCodeMapping(prmLocationCode : Code[10]) : Code[10]
    var Location : Record Location;
        FiscLocation : Code[10]; 
        LocMap : Record "Fiscalization Loc. Mapping-ADL";
    
    begin
        IF Location.GET(prmLocationCode) THEN BEGIN
        LocMap.SETRANGE("Location Code",Location.Code);
        IF ((LocMap.COUNT=1) AND (LocMap.FINDFIRST)) THEN
            FiscLocation := LocMap."Fisc. Location Code";
        END;

        EXIT(FiscLocation);
    end;


    procedure GetFiscWholesaleTerminalLoc(PrmFiscLocCode : Code[20]) : Text
    var TerminalCode : Text;
        WholesaleTerminal : Record "Fiscalization Terminal-ADL";

    begin
        // Rewrite as needed, ie. add more filters
        TerminalCode := '';

        WholesaleTerminal.SETRANGE("Fisc. Location Code",PrmFiscLocCode);
        WholesaleTerminal.SETRANGE("User ID",USERID);
        IF (WholesaleTerminal.FINDFIRST AND (WholesaleTerminal.COUNT=1)) THEN
        TerminalCode := WholesaleTerminal."Fisc. Terminal Code";

        // Only one terminal per location must be fund, if multiple terminals per location user must select terminal manualy.

        EXIT(TerminalCode);
    end;

    procedure GetFiscNoSeriesMapp(VAR Rec : Record "Sales Header") : Code[10]
    var NoSeriesCode : Code[10];
        FiscLocation : Record "Fiscalization Location-ADL";
        FiscTerminal : Record "Fiscalization Terminal-ADL";
        FiscSetup : Record "Fiscalization Setup-ADL";
    begin
        FiscSetup.GET();
        FiscSetup.TESTFIELD("Source of No. Series");

        NoSeriesCode := '';

        IF (FiscSetup."Source of No. Series" =FiscSetup."Source of No. Series"::"Fiscalization Location") THEN
        BEGIN
        IF FiscLocation.GET(Rec."Fisc. Location Code") THEN BEGIN
            FiscLocation.TESTFIELD("Fisc. No. Series");
            NoSeriesCode := FiscLocation."Fisc. No. Series";
        END;
        END;

        IF (FiscSetup."Source of No. Series" =FiscSetup."Source of No. Series"::"Fiscalization Terminal") THEN
        BEGIN
        //  IF FiscTerminal.GET(prmSalesHeader."Fisc. Terminal") THEN BEGIN
        //IF FiscTerminal.GET(prmSalesHeader."Fisc. Terminal",prmSalesHeader."Fisc. Location Code") THEN BEGIN
            IF Rec."Fisc. Terminal" <> '' THEN BEGIN
            FiscTerminal.GET(Rec."Fisc. Terminal", Rec."Fisc. Location Code",USERID);

            FiscTerminal.TESTFIELD("Fisc. No. Series");
            NoSeriesCode := FiscTerminal."Fisc. No. Series";
            END;
        //  END;
        END;
        EXIT(NoSeriesCode);
    end;
}