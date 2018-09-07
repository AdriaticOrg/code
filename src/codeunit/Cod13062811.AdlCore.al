codeunit 13062811 "Adl Core"
{
    Permissions = tabledata 13062811 = rm,
                  tabledata 13062660 = rm;
    procedure FeatureEnabled(Feature: Option VAT,FAS,KRD,BST,VIES): Boolean
    var
        //ReportSISetup: Record "Reporting_SI Setup";
        CoreSetup: Record "CoreSetup-Adl";
    begin
        if not CoreSetup.Get() or not CoreSetup."ADL Enabled" then exit(false);

        if (Feature = Feature::VAT) and CoreSetup."VAT Enabled" then exit(true);
        if (Feature = Feature::FAS) and CoreSetup."FAS Enabled" then exit(true);
        if (Feature = Feature::KRD) and CoreSetup."KRD Enabled" then exit(true);
        if (Feature = Feature::BST) and CoreSetup."BST Enabled" then exit(true);
        if (Feature = Feature::VIES) and CoreSetup."VIES Enabled" then exit(true);

        exit(false);
    end;
}