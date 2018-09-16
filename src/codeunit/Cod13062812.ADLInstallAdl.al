codeunit 13062812 "ADL Install-Adl"
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
        ADLInitialize: Codeunit "Wizard Initialize-Adl";
    begin
        ADLInitialize.Run();
    end;

    local procedure HandleReinstall();
    begin

    end;

    procedure ApplyEvaluationClassificationsForPrivacy()
    var
        Company: Record Company;
        // DataClassificationMgt: Codeunit "Data Classification Mgt.";
    begin
        Company.Get(CompanyName());
        if not Company."Evaluation Company" then
            exit;

        // TODO:: Data Clasification - check sensitive data
        // DataClassificationMgt.SetTableFieldsToNormal();
        // DataClassificationMgt.SetFieldToPersonal();
    end;


}