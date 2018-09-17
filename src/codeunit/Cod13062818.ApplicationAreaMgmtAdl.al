codeunit 13062818 "Application Area Mgmt-Adl"
{
    procedure IsUnpaidReceivablesApplicationAreaEnabled(): Boolean
    var
        ApplicationAreaSetup: Record "Application Area Setup";
        ApplicationAreaMgmtFacade: Codeunit "Application Area Mgmt. Facade";
    begin
        if ApplicationAreaMgmtFacade.GetApplicationAreaSetupRecFromCompany(ApplicationAreaSetup, CompanyName()) then
            exit(ApplicationAreaSetup."Unpaid Receivables Enabled Adl");
    end;

    procedure IsFASApplicationAreaEnabled(): Boolean
    var
        ApplicationAreaSetup: Record "Application Area Setup";
        ApplicationAreaMgmtFacade: Codeunit "Application Area Mgmt. Facade";
    begin
        if ApplicationAreaMgmtFacade.GetApplicationAreaSetupRecFromCompany(ApplicationAreaSetup, CompanyName()) then
            exit(ApplicationAreaSetup."FAS Enabled Adl");
    end;

    procedure IsBSTApplicationAreaEnabled(): Boolean
    var
        ApplicationAreaSetup: Record "Application Area Setup";
        ApplicationAreaMgmtFacade: Codeunit "Application Area Mgmt. Facade";
    begin
        if ApplicationAreaMgmtFacade.GetApplicationAreaSetupRecFromCompany(ApplicationAreaSetup, CompanyName()) then
            exit(ApplicationAreaSetup."BST Enabled Adl");
    end;

    procedure IsKRDApplicationAreaEnabled(): Boolean
    var
        ApplicationAreaSetup: Record "Application Area Setup";
        ApplicationAreaMgmtFacade: Codeunit "Application Area Mgmt. Facade";
    begin
        if ApplicationAreaMgmtFacade.GetApplicationAreaSetupRecFromCompany(ApplicationAreaSetup, CompanyName()) then
            exit(ApplicationAreaSetup."KRD Enabled Adl");
    end;

    procedure EnableAdlCoreApplicationArea(CoreSetup: Record "CoreSetup-Adl")
    var
        ApplicationAreaSetup: Record "Application Area Setup";
        ExperienceTierSetup: Record "Experience Tier Setup";

        ApplicationAreaMgmtFacade: Codeunit "Application Area Mgmt. Facade";
    begin
        if ExperienceTierSetup.Get(CompanyName()) then;
        if not ExperienceTierSetup.Custom then             //Set this to Custom in Isnall CU
            exit;
        if ApplicationAreaMgmtFacade.GetApplicationAreaSetupRecFromCompany(ApplicationAreaSetup, CompanyName()) then begin
            if CoreSetup."Unpaid Receivables Enabled" then
                ApplicationAreaSetup."Unpaid Receivables Enabled Adl" := true;
            if CoreSetup."KRD Enabled" then
                ApplicationAreaSetup."KRD Enabled Adl" := true;
            if CoreSetup."BST Enabled" then
                ApplicationAreaSetup."BST Enabled Adl" := true;
            if CoreSetup."FAS Enabled" then
                ApplicationAreaSetup."FAS Enabled Adl" := true;

            //TODO:: ...and some more...
            ApplicationAreaSetup.Modify();
            ApplicationAreaMgmtFacade.SetupApplicationArea();
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Application Area Mgmt. Facade", 'OnSetExperienceTier', '', false, false)]
    local procedure EnableADLCoreAppAreaOnSetExperienceTier(ExperienceTierSetup: record 9176; var TempApplicationAreaSetup: record 9178 temporary; var ApplicationAreasSet: boolean)
    begin
        TempApplicationAreaSetup."Unpaid Receivables Enabled Adl" := true;
        TempApplicationAreaSetup."BST Enabled Adl" := true;
        TempApplicationAreaSetup."KRD Enabled Adl" := true;
        TempApplicationAreaSetup."FAS Enabled Adl" := true;
        //...
    end;
}