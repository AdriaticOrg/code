codeunit 13062811 "Adl Core"
{
    Permissions = tabledata 13062811 = rm,
                  tabledata 13062660 = rm;
    procedure FeatureEnabled(Feature: Option Core,VAT,RepHR,RepRS,RepSI,FAS,KRD,BST,VIES,EUCustoms,"Unpaid Receivables"): Boolean
    var
        //ReportSISetup: Record "Reporting_SI Setup";
        CoreSetup: Record "CoreSetup-Adl";
    begin
        with CoreSetup do begin
            if not Get() or not "ADL Enabled" then exit(false);

            if (Feature = Feature::Core) and "ADL Enabled" then exit(true);

            if (Feature = Feature::VAT) and "VAT Enabled" then exit(true);

            if (Feature = Feature::RepHR) and "Rep HR Enabled" then exit(true);
            if (Feature = Feature::RepRS) and "Rep RS Enabled" then exit(true);
            if (Feature = Feature::RepSI) and "Rep SI Enabled" then exit(true);

            if (Feature = Feature::FAS) and "FAS Enabled" then exit(true);
            if (Feature = Feature::KRD) and "KRD Enabled" then exit(true);
            if (Feature = Feature::BST) and "BST Enabled" then exit(true);
            if (Feature = Feature::VIES) and "VIES Enabled" then exit(true);

            if (Feature = Feature::EUCustoms) and "EU Customs" then exit(true);
            if (Feature = Feature::"Unpaid Receivables") and CoreSetup."Unpaid Receivables Enabled" then exit(true);
        end;

        exit(false);
    end;
}