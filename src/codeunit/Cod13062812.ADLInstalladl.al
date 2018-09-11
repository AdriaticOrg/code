codeunit 13062812 "ADL Install-adl"
{
    Subtype = Install;

    trigger OnInstallAppPerCompany()
    var
        myAppInfo: ModuleInfo;
    begin
        ApplyEvaluationClassificationsForPrivacy();

        if myAppInfo.DataVersion() = Version.Create(1, 0, 0, 0) then
            HandleFreshInstall()
        else
            HandleReinstall();
    end;

    local procedure HandleFreshInstall();
    var
        ADLInitialize: Codeunit "ADL Initialize-adl";
    begin
        ADLInitialize.Run();
    end;

    local procedure HandleReinstall();
    begin

    end;

    procedure ApplyEvaluationClassificationsForPrivacy()
    var
        Company: Record Company;
        CoreSetup: Record "CoreSetup-Adl";
        DataClassificationMgt: Codeunit "Data Classification Mgt.";
    begin
        Company.Get(CompanyName());
        if not Company."Evaluation Company" then
            exit;

        //TODO:: Data Clasification
        //DataClassificationMgt.SetTableFieldsToNormal(Database::"CoreSetup-Adl");
        // DataClassificationMgt.SetFieldToPersonal(Database::"CoreSetup-Adl", CoreSetup.FieldNo(""));
    end;


}