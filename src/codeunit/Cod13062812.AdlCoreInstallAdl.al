codeunit 13062812 "Adl Core Install-Adl"
{
    Subtype = Install;

    trigger OnInstallAppPerCompany()
    var
        myAppInfo: ModuleInfo;
    begin
        ApplyEvaluationClassificationsForPrivacy();

        if myAppInfo.DataVersion() = Version.Create(0, 0, 0, 0) then
            HandleFreshInstall()
        else
            HandleReinstall();
    end;


    local procedure HandleFreshInstall();
    var
    //ADLInitialize: Codeunit "Wizard Initialize-adl";
    begin
        //ADLInitialize.Run();
        SetApplicationArea();
    end;

    local procedure HandleReinstall();
    begin
        SetApplicationArea();
    end;

    procedure SetApplicationArea()
    var
        ApplicationAreaSetup: Record "Application Area Setup";
        ExperienceTierSetup: Record "Experience Tier Setup";
        ApplicationAreaMgmtFacade: Codeunit "Application Area Mgmt. Facade";
    begin
        if not ExperienceTierSetup.Get(CompanyName()) then begin
            ExperienceTierSetup.Init();
            ExperienceTierSetup."Company Name" := CopyStr(CompanyName(), 1, 30);
            ExperienceTierSetup.Insert();
        end;
        ExperienceTierSetup.Init();
        ExperienceTierSetup."Company Name" := CopyStr(CompanyName(), 1, 30);
        ExperienceTierSetup.Custom := true;
        ExperienceTierSetup.Modify();
        if not ApplicationAreaSetup.Get(CompanyName()) then begin
            ApplicationAreaSetup.Init();
            ApplicationAreaSetup."Company Name" := CopyStr(CompanyName(), 1, 30);
            ApplicationAreaSetup.Insert();
        end;
        ApplicationAreaSetup."Company Name" := CopyStr(CompanyName(), 1, 30);
        ApplicationAreaSetup."Adl BST" := true;
        ApplicationAreaSetup."Adl FAS" := true;
        ApplicationAreaSetup."Adl KRD" := true;
        ApplicationAreaSetup."Adl Unpaid Receivables" := true;
        ApplicationAreaSetup."Adl Forced CreditDebit" := true;
        ApplicationAreaSetup."Adl VAT" := true;
        ApplicationAreaSetup."Adl VIES" := true;
        ApplicationAreaSetup."Adl PDO" := true;
        ApplicationAreaSetup.Modify();
        ApplicationAreaMgmtFacade.SetupApplicationArea();
    end;

    procedure ApplyEvaluationClassificationsForPrivacy()
    var
        Company: Record Company;
        //DataClassificationMgt: Codeunit "Data Classification Mgt.";
    begin
        Company.Get(CompanyName());
        if not Company."Evaluation Company" then
            exit;
        //TODO:: Data Clasification - check sensitive data
        //DataClassificationMgt.SetTableFieldsToNormal();
        // DataClassificationMgt.SetFieldToPersonal();
    end;


}