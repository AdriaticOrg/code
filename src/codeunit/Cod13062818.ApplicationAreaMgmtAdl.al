codeunit 13062818 "Application Area Mgmt-Adl"
{
    procedure IsUnpaidReceivablesApplicationAreaEnabled(): Boolean
    var
        ApplicationAreaSetup: Record "Application Area Setup";
        ApplicationAreaMgmtFacade: Codeunit "Application Area Mgmt. Facade";
    begin
        if ApplicationAreaMgmtFacade.GetApplicationAreaSetupRecFromCompany(ApplicationAreaSetup, CompanyName()) then
            exit(ApplicationAreaSetup."Unpaid Receivables Adl");
    end;

    procedure IsFASApplicationAreaEnabled(): Boolean
    var
        ApplicationAreaSetup: Record "Application Area Setup";
        ApplicationAreaMgmtFacade: Codeunit "Application Area Mgmt. Facade";
    begin
        if ApplicationAreaMgmtFacade.GetApplicationAreaSetupRecFromCompany(ApplicationAreaSetup, CompanyName()) then
            exit(ApplicationAreaSetup."FAS Adl");
    end;

    procedure IsBSTApplicationAreaEnabled(): Boolean
    var
        ApplicationAreaSetup: Record "Application Area Setup";
        ApplicationAreaMgmtFacade: Codeunit "Application Area Mgmt. Facade";
    begin
        if ApplicationAreaMgmtFacade.GetApplicationAreaSetupRecFromCompany(ApplicationAreaSetup, CompanyName()) then
            exit(ApplicationAreaSetup."BST Adl");
    end;

    procedure IsKRDApplicationAreaEnabled(): Boolean
    var
        ApplicationAreaSetup: Record "Application Area Setup";
        ApplicationAreaMgmtFacade: Codeunit "Application Area Mgmt. Facade";
    begin
        if ApplicationAreaMgmtFacade.GetApplicationAreaSetupRecFromCompany(ApplicationAreaSetup, CompanyName()) then
            exit(ApplicationAreaSetup."KRD Adl");
    end;

    procedure EnableDisableAdlCoreApplicationArea()
    var
        CoreSetup: Record "CoreSetup-Adl";
        ApplicationAreaSetup: Record "Application Area Setup";
        ExperienceTierSetup: Record "Experience Tier Setup";
        ApplicationAreaMgmtFacade: Codeunit "Application Area Mgmt. Facade";
    begin
        if ExperienceTierSetup.Get(CompanyName()) then;
        if not ExperienceTierSetup.Custom then             //Set this to Custom in Isnall CU
            exit;
        if ApplicationAreaMgmtFacade.GetApplicationAreaSetupRecFromCompany(ApplicationAreaSetup, CompanyName()) then begin
            if CoreSetup."Unpaid Receivables Enabled" then
                ApplicationAreaSetup."Unpaid Receivables Adl" := true
            else
                ApplicationAreaSetup."Unpaid Receivables Adl" := false;

            if CoreSetup."KRD Enabled" then
                ApplicationAreaSetup."KRD Adl" := true
            else
                ApplicationAreaSetup."KRD Adl" := false;

            if CoreSetup."BST Enabled" then
                ApplicationAreaSetup."BST Adl" := true
            else
                ApplicationAreaSetup."BST Adl" := false;

            if CoreSetup."FAS Enabled" then
                ApplicationAreaSetup."FAS Adl" := true
            else
                ApplicationAreaSetup."FAS Adl" := false;

            if CoreSetup."PDO Enabled" then
                ApplicationAreaSetup."PDO Adl" := true
            else
                ApplicationAreaSetup."PDO Adl" := false;

            if CoreSetup."Forced Credit/Debit Enabled" then
                ApplicationAreaSetup."Forced CreditDebit Adl" := true
            else
                ApplicationAreaSetup."Forced CreditDebit Adl" := false;

            if CoreSetup."VAT Enabled" then
                ApplicationAreaSetup."VAT" := true
            else
                ApplicationAreaSetup."VAT" := false;

            if CoreSetup."VIES Enabled" then
                ApplicationAreaSetup."VIES Adl" := true
            else
                ApplicationAreaSetup."VIES Adl" := false;

            ApplicationAreaSetup.Modify();
            ApplicationAreaMgmtFacade.SetupApplicationArea();
            ApplicationAreaMgmtFacade.SaveExperienceTierCurrentCompany(ExperienceTierSetup.FieldCaption(Custom));
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
            ApplicationAreaSetup."KRD Adl" := true;
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
            ApplicationAreaSetup."BST Adl" := true;
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
            ApplicationAreaSetup."FAS Adl" := true;
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
            ApplicationAreaSetup."PDO Adl" := true;
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
                ApplicationAreaSetup."Unpaid Receivables Adl" := true
            else
                ApplicationAreaSetup."Unpaid Receivables Adl" := false;
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
            ApplicationAreaSetup."Forced CreditDebit Adl" := true;
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
            ApplicationAreaSetup."VAT Adl" := true;
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
            ApplicationAreaSetup."VIES Adl" := true;
            ApplicationAreaSetup.Modify();
            ApplicationAreaMgmtFacade.SetupApplicationArea();
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Application Area Mgmt. Facade", 'OnSetExperienceTier', '', false, false)]
    local procedure EnableADLCoreAppAreaOnSetExperienceTier(ExperienceTierSetup: record 9176; var TempApplicationAreaSetup: record 9178 temporary; var ApplicationAreasSet: boolean)
    var
        CoreSetup: Record "CoreSetup-Adl";
    begin
        if CoreSetup."BST Enabled" then
            TempApplicationAreaSetup."BST Adl" := true
        else
            TempApplicationAreaSetup."BST Adl" := false;
        if CoreSetup."KRD Enabled" then
            TempApplicationAreaSetup."KRD Adl" := true
        else
            TempApplicationAreaSetup."KRD Adl" := false;
        if CoreSetup."FAS Enabled" then
            TempApplicationAreaSetup."FAS Adl" := true
        else
            TempApplicationAreaSetup."FAS Adl" := false;
        if CoreSetup."PDO Enabled" then
            TempApplicationAreaSetup."PDO Adl" := true
        else
            TempApplicationAreaSetup."PDO Adl" := false;
        if CoreSetup."Forced Credit/Debit Enabled" then
            TempApplicationAreaSetup."Forced CreditDebit Adl" := true
        else
            TempApplicationAreaSetup."Forced CreditDebit Adl" := false;
        if CoreSetup."Unpaid Receivables Enabled" then
            TempApplicationAreaSetup."Unpaid Receivables Adl" := true
        else
            TempApplicationAreaSetup."Unpaid Receivables Adl" := false;
        if CoreSetup."VAT Enabled" then
            TempApplicationAreaSetup."VAT Adl" := true
        else
            TempApplicationAreaSetup."VAT Adl" := false;
        if CoreSetup."VIES Enabled" then
            TempApplicationAreaSetup."VIES Adl" := true
        else
            TempApplicationAreaSetup."VIES Adl" := false;
    end;
}