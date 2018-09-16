codeunit 13062813 "Wizard Initialize-Adl"
{
    trigger OnRun()
    begin
        if CoreSetupExists() then
            exit;
        RunWizardIfSetupDoesNotExist();
    end;

    procedure InitSetup(var CoreSetup: Record "CoreSetup-Adl");
    begin
        if CoreSetup.Get() then
            exit;
        CoreSetup.Init();
        CoreSetup.Insert();
    end;

    local procedure CoreSetupExists(): Boolean;
    var
        CoreSetup: Record "CoreSetup-Adl";
    begin
        exit(CoreSetup.Get());
    end;

    local procedure RunWizardIfSetupDoesNotExist();
    var
        CoreSetup: Record "CoreSetup-Adl";
    begin
        if CoreSetup.Get() then
            exit;

        Page.RunModal(PAGE::"Assisted ADL Setup Wizard-Adl");
        if CoreSetup.Get() then
            Commit();
    end;
}