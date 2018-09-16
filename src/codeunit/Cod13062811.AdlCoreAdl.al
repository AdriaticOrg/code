codeunit 13062811 "Adl Core-Adl"
{
    Permissions = tabledata 13062811 = rm,
                  tabledata 13062660 = rm;
    procedure FeatureEnabled(Feature: Option Core,VAT,RepHR,RepRS,RepSI,FAS,KRD,BST,VIES,UnpaidReceivables,ForcedCreditDebit): Boolean
    var
        CoreSetup: Record "CoreSetup-Adl";
    begin
        with CoreSetup do begin
            if not Get() or not "ADL Enabled" then exit(false);

            case Feature of
                Feature::Core:
                    exit("ADL Enabled");
                Feature::VAT:
                    exit("VAT Enabled");
                Feature::RepSI:
                    exit("Rep SI Enabled");
                Feature::RepHR:
                    exit("Rep HR Enabled");
                Feature::RepRS:
                    exit("Rep RS Enabled");
                Feature::FAS:
                    exit("FAS Enabled");
                Feature::KRD:
                    exit("KRD Enabled");
                Feature::BST:
                    exit("BST Enabled");
                Feature::VIES:
                    exit("VIES Enabled");
                Feature::UnpaidReceivables:
                    exit("Unpaid Receivables Enabled");
                Feature::ForcedCreditDebit:
                    exit("Forced Credit/Debit Enabled");
            end;
        end;

        exit(false);
    end;

    procedure TrimmedUserID50(): Text[50]
    begin
        EXIT(CopyStr(UserId(), 1, 50));
    end;
}