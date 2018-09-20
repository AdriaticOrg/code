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

    procedure EnableAdlCoreApplicationArea(var ConfigSetup: Record "Config. Setup"; Enabled: Boolean)
    var
        ApplicationAreaSetup: Record "Application Area Setup";
        ExperienceTierSetup: Record "Experience Tier Setup";
        ApplicationAreaMgmtFacade: Codeunit "Application Area Mgmt. Facade";
    begin
        if ExperienceTierSetup.Get(CompanyName()) then;
        if not ExperienceTierSetup.Custom then             //Set this to Custom in Isnall CU
            exit;
        if ApplicationAreaMgmtFacade.GetApplicationAreaSetupRecFromCompany(ApplicationAreaSetup, CompanyName()) then begin
            If not ConfigSetup."ADL Enabled-Adl" then exit;
            if ConfigSetup."Unpaid Receivables Enabled-Adl" then
                ApplicationAreaSetup."Adl Unpaid Receivables" := true
            else
                ApplicationAreaSetup."Adl Unpaid Receivables" := false;

            if ConfigSetup."KRD Enabled-Adl" then
                ApplicationAreaSetup."Adl KRD" := true
            else
                ApplicationAreaSetup."Adl KRD" := false;

            if ConfigSetup."BST Enabled-Adl" then
                ApplicationAreaSetup."Adl BST" := true
            else
                ApplicationAreaSetup."Adl BST" := false;

            if ConfigSetup."FAS Enabled-Adl" then
                ApplicationAreaSetup."Adl FAS" := true
            else
                ApplicationAreaSetup."Adl FAS" := false;

            if ConfigSetup."PDO Enabled-Adl" then
                ApplicationAreaSetup."Adl PDO" := true
            else
                ApplicationAreaSetup."Adl PDO" := false;

            if ConfigSetup."Forced Credit/Debit Enabled-Adl" then
                ApplicationAreaSetup."Adl Forced CreditDebit" := true
            else
                ApplicationAreaSetup."Adl Forced CreditDebit" := false;

            if ConfigSetup."VAT Enabled-Adl" then
                ApplicationAreaSetup."Adl VAT" := true
            else
                ApplicationAreaSetup."Adl VAT" := false;

            if ConfigSetup."VIES Enabled-Adl" then
                ApplicationAreaSetup."Adl VIES" := true
            else
                ApplicationAreaSetup."Adl VIES" := false;

            ApplicationAreaSetup.Modify();
            ApplicationAreaMgmtFacade.SetupApplicationArea();
        end;
    end;

    procedure EnableKRDApplicationArea()
    var
        ApplicationAreaSetup: Record "Application Area Setup";
        ExperienceTierSetup: Record "Experience Tier Setup";
        ApplicationAreaMgmtFacade: Codeunit "Application Area Mgmt. Facade";
    begin
        if ExperienceTierSetup.Get(CompanyName()) then;
        if not ExperienceTierSetup.Custom then             //Set this to Custom in Isnall CU
            exit;
        if ApplicationAreaMgmtFacade.GetApplicationAreaSetupRecFromCompany(ApplicationAreaSetup, CompanyName()) then begin
            ApplicationAreaSetup."Adl KRD" := true;
            ApplicationAreaSetup.Modify();
            ApplicationAreaMgmtFacade.SetupApplicationArea();
        end;
    end;

    procedure EnableBSTApplicationArea()
    var
        ApplicationAreaSetup: Record "Application Area Setup";
        ExperienceTierSetup: Record "Experience Tier Setup";
        ApplicationAreaMgmtFacade: Codeunit "Application Area Mgmt. Facade";
    begin
        if ExperienceTierSetup.Get(CompanyName()) then;
        if not ExperienceTierSetup.Custom then             //Set this to Custom in Isnall CU
            exit;
        if ApplicationAreaMgmtFacade.GetApplicationAreaSetupRecFromCompany(ApplicationAreaSetup, CompanyName()) then begin
            ApplicationAreaSetup."Adl BST" := true;
            ApplicationAreaSetup.Modify();
            ApplicationAreaMgmtFacade.SetupApplicationArea();
        end;
    end;

    procedure EnableFASApplicationArea()
    var
        ApplicationAreaSetup: Record "Application Area Setup";
        ExperienceTierSetup: Record "Experience Tier Setup";
        ApplicationAreaMgmtFacade: Codeunit "Application Area Mgmt. Facade";
    begin
        if ExperienceTierSetup.Get(CompanyName()) then;
        if not ExperienceTierSetup.Custom then             //Set this to Custom in Isnall CU
            exit;
        if ApplicationAreaMgmtFacade.GetApplicationAreaSetupRecFromCompany(ApplicationAreaSetup, CompanyName()) then begin
            ApplicationAreaSetup."Adl FAS" := true;
            ApplicationAreaSetup.Modify();
            ApplicationAreaMgmtFacade.SetupApplicationArea();
        end;
    end;

    procedure EnablePDOApplicationArea()
    var
        ApplicationAreaSetup: Record "Application Area Setup";
        ExperienceTierSetup: Record "Experience Tier Setup";
        ApplicationAreaMgmtFacade: Codeunit "Application Area Mgmt. Facade";
    begin
        if ExperienceTierSetup.Get(CompanyName()) then;
        if not ExperienceTierSetup.Custom then             //Set this to Custom in Isnall CU
            exit;
        if ApplicationAreaMgmtFacade.GetApplicationAreaSetupRecFromCompany(ApplicationAreaSetup, CompanyName()) then begin
            ApplicationAreaSetup."Adl PDO" := true;
            ApplicationAreaSetup.Modify();
            ApplicationAreaMgmtFacade.SetupApplicationArea();
        end;
    end;

    procedure EnableUnpaidReceivableApplicationArea(Enable: Boolean)
    var
        ApplicationAreaSetup: Record "Application Area Setup";
        ExperienceTierSetup: Record "Experience Tier Setup";
        ApplicationAreaMgmtFacade: Codeunit "Application Area Mgmt. Facade";
    begin
        if ExperienceTierSetup.Get(CompanyName()) then;
        if not ExperienceTierSetup.Custom then             //Set this to Custom in Isnall CU
            exit;
        if ApplicationAreaMgmtFacade.GetApplicationAreaSetupRecFromCompany(ApplicationAreaSetup, CompanyName()) then begin
            If Enable then
                ApplicationAreaSetup."Adl Unpaid Receivables" := true
            else
                ApplicationAreaSetup."Adl Unpaid Receivables" := false;
            ApplicationAreaSetup.Modify();
            ApplicationAreaMgmtFacade.SetupApplicationArea();
        end;
    end;

    procedure EnableForceDedCredApplicationArea()
    var
        ApplicationAreaSetup: Record "Application Area Setup";
        ExperienceTierSetup: Record "Experience Tier Setup";
        ApplicationAreaMgmtFacade: Codeunit "Application Area Mgmt. Facade";
    begin
        if ExperienceTierSetup.Get(CompanyName()) then;
        if not ExperienceTierSetup.Custom then             //Set this to Custom in Isnall CU
            exit;
        if ApplicationAreaMgmtFacade.GetApplicationAreaSetupRecFromCompany(ApplicationAreaSetup, CompanyName()) then begin
            ApplicationAreaSetup."Adl Forced CreditDebit" := true;
            ApplicationAreaSetup.Modify();
            ApplicationAreaMgmtFacade.SetupApplicationArea();
        end;
    end;

    procedure EnableForceVATApplicationArea()
    var
        ApplicationAreaSetup: Record "Application Area Setup";
        ExperienceTierSetup: Record "Experience Tier Setup";
        ApplicationAreaMgmtFacade: Codeunit "Application Area Mgmt. Facade";
    begin
        if ExperienceTierSetup.Get(CompanyName()) then;
        if not ExperienceTierSetup.Custom then             //Set this to Custom in Isnall CU
            exit;
        if ApplicationAreaMgmtFacade.GetApplicationAreaSetupRecFromCompany(ApplicationAreaSetup, CompanyName()) then begin
            ApplicationAreaSetup."Adl VAT" := true;
            ApplicationAreaSetup.Modify();
            ApplicationAreaMgmtFacade.SetupApplicationArea();
        end;
    end;

    procedure EnableForceVIESApplicationArea()
    var
        ApplicationAreaSetup: Record "Application Area Setup";
        ExperienceTierSetup: Record "Experience Tier Setup";
        ApplicationAreaMgmtFacade: Codeunit "Application Area Mgmt. Facade";
    begin
        if ExperienceTierSetup.Get(CompanyName()) then;
        if not ExperienceTierSetup.Custom then             //Set this to Custom in Isnall CU
            exit;
        if ApplicationAreaMgmtFacade.GetApplicationAreaSetupRecFromCompany(ApplicationAreaSetup, CompanyName()) then begin
            ApplicationAreaSetup."Adl VIES" := true;
            ApplicationAreaSetup.Modify();
            ApplicationAreaMgmtFacade.SetupApplicationArea();
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Application Area Mgmt. Facade", 'OnSetExperienceTier', '', false, false)]
    local procedure EnableADLCoreAppAreaOnSetExperienceTier(ExperienceTierSetup: record 9176; var TempApplicationAreaSetup: record 9178 temporary; var ApplicationAreasSet: boolean)
    begin
        TempApplicationAreaSetup."Adl BST" := true;
        TempApplicationAreaSetup."Adl KRD" := true;
        TempApplicationAreaSetup."Adl FAS" := true;
        TempApplicationAreaSetup."Adl PDO" := true;
        TempApplicationAreaSetup."Adl Forced CreditDebit" := true;
        TempApplicationAreaSetup."Adl Unpaid Receivables" := true;
        TempApplicationAreaSetup."Adl VAT" := true;
        TempApplicationAreaSetup."Adl VIES" := true;
    end;
}