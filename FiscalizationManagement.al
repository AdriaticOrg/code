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
}