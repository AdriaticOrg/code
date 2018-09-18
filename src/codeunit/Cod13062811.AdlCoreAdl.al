codeunit 13062811 "Adl Core-Adl"
{
    Permissions = tabledata 13062811 = rm;
    procedure FeatureEnabled(Feature: Option Core,VAT,FAS,KRD,BST,VIES,PDO,UnpaidReceivables,ForcedCreditDebit): Boolean
    var
        CoreSetup: Record "CoreSetup-Adl";
    begin
        exit(CoreSetup.FeatureEnabled(Feature));
    end;

    procedure TrimmedUserID50(): Text[50]
    begin
        EXIT(CopyStr(UserId(), 1, 50));
    end;

    procedure EnableFeature(Feature: Option Core,VAT,FAS,KRD,BST,VIES,PDO,UnpaidReceivables,ForcedCreditDebit)
    var
        CoreSetup: Record "CoreSetup-Adl";
    begin
        CoreSetup.EnableFeature(Feature);
    end;

    procedure DisableFeature(Feature: Option Core,VAT,FAS,KRD,BST,VIES,PDO,UnpaidReceivables,ForcedCreditDebit)
    var
        CoreSetup: Record "CoreSetup-Adl";
    begin
        CoreSetup.DisableFeature(Feature);
    end;
}