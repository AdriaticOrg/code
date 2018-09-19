codeunit 13062781 "Fisc. Management-Adl"
{
    Permissions = TableData "Sales Invoice Header" = rimd, TableData "Sales Cr.Memo Header" = rimd;
    trigger OnRun()
    begin
    end;

    procedure FiscSetupExists(): Boolean
    var
        FiscalizationSetup: Record "Fiscalization Setup-Adl";
    begin
        EXIT(FiscalizationSetup.GET());
    end;

    procedure GetFiscSubject(FiscPaymentMethodCode: Code[20]): Boolean
    var
        FiscPaymentMethod: Record "Fisc. Payment Method-Adl";
    begin
        IF ((FiscPaymentMethodCode <> '') AND (FiscPaymentMethod.GET(FiscPaymentMethodCode))) THEN
            EXIT(FiscPaymentMethod."Subject to Fiscalization")
        ELSE
            EXIT(FALSE);
    end;

    procedure GetFiscLocationCodeMapping(prmLocationCode: Code[10]): Code[10]
    var
        Location: Record Location;
        LocMap: Record "Fiscalization Loc. Mapping-Adl";
        FiscLocation: Code[10];
    begin
        IF Location.GET(prmLocationCode) THEN BEGIN
            LocMap.SETRANGE("Location Code", Location.Code);
            IF ((LocMap.COUNT() = 1) AND (LocMap.FINDFIRST())) THEN
                FiscLocation := LocMap."Fisc. Location Code";
        END;
        EXIT(FiscLocation);
    end;


    procedure GetFiscWholesaleTerminalLoc(PrmFiscLocCode: Code[20]): Text
    var
        WholesaleTerminal: Record "Fiscalization Terminal-Adl";
        TerminalCode: Text;
    begin
        // Rewrite as needed, ie. add more filters
        TerminalCode := '';

        WholesaleTerminal.SETRANGE("Fisc. Location Code", PrmFiscLocCode);
        WholesaleTerminal.SETRANGE("User ID", USERID());
        IF (WholesaleTerminal.FINDFIRST() AND (WholesaleTerminal.COUNT() = 1)) THEN
            TerminalCode := WholesaleTerminal."Fisc. Terminal Code";

        // Only one terminal per location must be fund, if multiple terminals per location user must select terminal manualy.

        EXIT(TerminalCode);
    end;
}