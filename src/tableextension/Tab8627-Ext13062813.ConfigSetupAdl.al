tableextension 13062813 "Config. Setup-Adl" extends "Config. Setup" //8627
{
    fields
    {
        field(13062811; "ADL Enabled-Adl"; Boolean)
        {
            Caption = 'ADL Enabled';
            DataClassification = SystemMetadata;
        }
        field(13062812; "VAT Enabled-Adl"; Boolean)
        {
            Caption = 'VAT Enabled';
            DataClassification = SystemMetadata;
        }
        field(13062816; "FAS Enabled-Adl"; Boolean)
        {
            Caption = 'FAS Enabled';
            DataClassification = SystemMetadata;
        }
        field(13062817; "KRD Enabled-Adl"; Boolean)
        {
            Caption = 'KRD Enabled';
            DataClassification = SystemMetadata;
        }
        field(13062818; "BST Enabled-Adl"; Boolean)
        {
            Caption = 'BST Enabled';
            DataClassification = SystemMetadata;
        }
        field(13062819; "VIES Enabled-Adl"; Boolean)
        {
            Caption = 'VIES Enabled';
            DataClassification = SystemMetadata;
        }
        field(13062820; "Unpaid Receivables Enabled-Adl"; Boolean)
        {
            Caption = 'Unpaid Receivables Enabled';
            DataClassification = SystemMetadata;
        }
        field(13062821; "PDO Enabled-Adl"; Boolean)
        {
            Caption = 'Unpaid Receivables Enabled';
            DataClassification = SystemMetadata;
        }
        field(13062822; "Forced Credit/Debit Enabled-Adl"; Boolean)
        {
            Caption = 'Unpaid Receivables Enabled';
            DataClassification = SystemMetadata;
        }
    }

    procedure CopyCoreSetupInfo()
    var
        CoreSetup: Record "CoreSetup-Adl";
    begin
        if not CoreSetup.get() then begin
            CoreSetup.Init();
            CoreSetup.Insert()
        end;

        CoreSetup."ADL Enabled" := "ADL Enabled-Adl";
        CoreSetup."BST Enabled" := "BST Enabled-Adl";
        CoreSetup."FAS Enabled" := "FAS Enabled-Adl";
        CoreSetup."KRD Enabled" := "KRD Enabled-Adl";
        CoreSetup."Unpaid Receivables Enabled" := "Unpaid Receivables Enabled-Adl";
        CoreSetup."Forced Credit/Debit Enabled" := "Forced Credit/Debit Enabled-Adl";
        CoreSetup."VAT Enabled" := "VAT Enabled-Adl";
        CoreSetup."VIES Enabled" := "VIES Enabled-Adl";
        CoreSetup."PDO Enabled" := "PDO Enabled-Adl";
        CoreSetup.modify();
        Commit();
    end;
}