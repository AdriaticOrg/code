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
                ApplicationAreaSetup."Adl Unpaid Receivables" := true
            else
                ApplicationAreaSetup."Adl Unpaid Receivables" := false;

            if CoreSetup."KRD Enabled" then
                ApplicationAreaSetup."Adl KRD" := true
            else
                ApplicationAreaSetup."Adl KRD" := false;

            if CoreSetup."BST Enabled" then
                ApplicationAreaSetup."Adl BST" := true
            else
                ApplicationAreaSetup."Adl BST" := false;

            if CoreSetup."FAS Enabled" then
                ApplicationAreaSetup."Adl FAS" := true
            else
                ApplicationAreaSetup."Adl FAS" := false;

            if CoreSetup."PDO Enabled" then
                ApplicationAreaSetup."Adl PDO" := true
            else
                ApplicationAreaSetup."Adl PDO" := false;

            if CoreSetup."Forced Credit/Debit Enabled" then
                ApplicationAreaSetup."Adl Forced CreditDebit" := true
            else
                ApplicationAreaSetup."Adl Forced CreditDebit" := false;

            if CoreSetup."VAT Enabled" then
                ApplicationAreaSetup."Adl VAT" := true
            else
                ApplicationAreaSetup."Adl VAT" := false;

            if CoreSetup."VIES Enabled" then
                ApplicationAreaSetup."Adl VIES" := true
            else
                ApplicationAreaSetup."Adl VIES" := false;

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
    var
        CoreSetup: Record "CoreSetup-Adl";
    begin
        if CoreSetup."BST Enabled" then
            TempApplicationAreaSetup."Adl BST" := true
        else
            TempApplicationAreaSetup."Adl BST" := false;
        if CoreSetup."KRD Enabled" then
            TempApplicationAreaSetup."Adl KRD" := true
        else
            TempApplicationAreaSetup."Adl KRD" := false;
        if CoreSetup."FAS Enabled" then
            TempApplicationAreaSetup."Adl FAS" := true
        else
            TempApplicationAreaSetup."Adl fas" := false;
        if CoreSetup."PDO Enabled" then
            TempApplicationAreaSetup."Adl PDO" := true
        else
            TempApplicationAreaSetup."Adl pdo" := false;
        if CoreSetup."Forced Credit/Debit Enabled" then
            TempApplicationAreaSetup."Adl Forced CreditDebit" := true
        else
            TempApplicationAreaSetup."Adl Forced CreditDebit" := false;
        if CoreSetup."Unpaid Receivables Enabled" then
            TempApplicationAreaSetup."Adl Unpaid Receivables" := true
        else
            TempApplicationAreaSetup."Adl Unpaid Receivables" := false;
        if CoreSetup."VAT Enabled" then
            TempApplicationAreaSetup."Adl VAT" := true
        else
            TempApplicationAreaSetup."Adl VAT" := false;
        if CoreSetup."VIES Enabled" then
            TempApplicationAreaSetup."Adl VIES" := true
        else
            TempApplicationAreaSetup."Adl VIES" := false;
    end;
}