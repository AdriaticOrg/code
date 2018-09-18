codeunit 13062818 "Application Area Mgmt-Adl"
{
    procedure IsUnpaidReceivablesApplicationAreaEnabled(): Boolean
    var
        ApplicationAreaSetup: Record "Application Area Setup";
        ApplicationAreaMgmtFacade: Codeunit "Application Area Mgmt. Facade";
    begin
        if ApplicationAreaMgmtFacade.GetApplicationAreaSetupRecFromCompany(ApplicationAreaSetup, CompanyName()) then
            exit(ApplicationAreaSetup."Adl Unpaid Receivables");
    end;

    procedure IsFASApplicationAreaEnabled(): Boolean
    var
        ApplicationAreaSetup: Record "Application Area Setup";
        ApplicationAreaMgmtFacade: Codeunit "Application Area Mgmt. Facade";
    begin
        if ApplicationAreaMgmtFacade.GetApplicationAreaSetupRecFromCompany(ApplicationAreaSetup, CompanyName()) then
            exit(ApplicationAreaSetup."Adl FAS");
    end;

    procedure IsBSTApplicationAreaEnabled(): Boolean
    var
        ApplicationAreaSetup: Record "Application Area Setup";
        ApplicationAreaMgmtFacade: Codeunit "Application Area Mgmt. Facade";
    begin
        if ApplicationAreaMgmtFacade.GetApplicationAreaSetupRecFromCompany(ApplicationAreaSetup, CompanyName()) then
            exit(ApplicationAreaSetup."Adl BST");
    end;

    procedure IsKRDApplicationAreaEnabled(): Boolean
    var
        ApplicationAreaSetup: Record "Application Area Setup";
        ApplicationAreaMgmtFacade: Codeunit "Application Area Mgmt. Facade";
    begin
        if ApplicationAreaMgmtFacade.GetApplicationAreaSetupRecFromCompany(ApplicationAreaSetup, CompanyName()) then
            exit(ApplicationAreaSetup."Adl KRD");
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
                ApplicationAreaSetup."Adl Unpaid Receivables" := true;
            if CoreSetup."KRD Enabled" then
                ApplicationAreaSetup."Adl KRD" := true;
            if CoreSetup."BST Enabled" then
                ApplicationAreaSetup."Adl BST" := true;
            if CoreSetup."FAS Enabled" then
                ApplicationAreaSetup."Adl FAS" := true;

            //TODO:: ...and some more...
            ApplicationAreaSetup.Modify();
            ApplicationAreaMgmtFacade.SetupApplicationArea();
        end;
    end;

    procedure EnableUnpaidReceivableApplicationArea()
    var
        ApplicationAreaSetup: Record "Application Area Setup";
        ExperienceTierSetup: Record "Experience Tier Setup";
        ApplicationAreaMgmtFacade: Codeunit "Application Area Mgmt. Facade";
    begin
        if ExperienceTierSetup.Get(CompanyName()) then;
        if not ExperienceTierSetup.Custom then             //Set this to Custom in Isnall CU
            exit;
        if ApplicationAreaMgmtFacade.GetApplicationAreaSetupRecFromCompany(ApplicationAreaSetup, CompanyName()) then begin
            ApplicationAreaSetup."Adl Unpaid Receivables" := true;
            ApplicationAreaSetup.Modify();
            ApplicationAreaMgmtFacade.SetupApplicationArea();
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Application Area Mgmt. Facade", 'OnSetExperienceTier', '', false, false)]
    local procedure EnableADLCoreAppAreaOnSetExperienceTier(ExperienceTierSetup: record 9176; var TempApplicationAreaSetup: record 9178 temporary; var ApplicationAreasSet: boolean)
    begin
        TempApplicationAreaSetup."Adl Unpaid Receivables" := true;
        TempApplicationAreaSetup."Adl BST" := true;
        TempApplicationAreaSetup."Adl KRD" := true;
        TempApplicationAreaSetup."Adl FAS" := true;
        //...
    end;
}