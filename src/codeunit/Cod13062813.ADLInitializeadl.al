codeunit 13062813 "ADL Initialize-adl"
{
    trigger OnRun()
    begin
        if CoreSetupExists() then
            exit;
        RunWizardIfSetupDoesNotExist();
    end;

    procedure InitSetup(var CoreSetup: Record "CoreSetup-adl");
    begin
        if CoreSetup.Get() then
            exit;
        CoreSetup.Init();
        CoreSetup.Insert();
    end;

    local procedure CoreSetupExists(): Boolean;
    var
        CoreSetup: Record "CoreSetup-adl";
    begin
        exit(CoreSetup.Get());
    end;

    local procedure RunWizardIfSetupDoesNotExist();
    var
        CoreSetup: Record "CoreSetup-adl";
    begin
        if CoreSetup.Get() then
            exit;

        Page.RunModal(PAGE::"ADL Setup Wizard-adl");
        if CoreSetup.Get() then
            Commit();
    end;
}