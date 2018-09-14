tableextension 13062813 "Config. Setup-adl" extends "Config. Setup" //8627
{
    fields
    {
        field(13062811; "ADL Enabled"; Boolean)
        {
            Caption = 'ADL Enabled';
            DataClassification = SystemMetadata;
        }
        field(13062812; "VAT Enabled"; Boolean)
        {
            Caption = 'VAT Enabled';
            DataClassification = SystemMetadata;
        }
        field(13062813; "Rep HR Enabled"; Boolean)
        {
            Caption = 'Rep HR Enabled';
            DataClassification = SystemMetadata;
        }
        field(13062814; "Rep RS Enabled"; Boolean)
        {
            Caption = 'Rep RS Enabled';
            DataClassification = SystemMetadata;
        }
        field(13062815; "Rep SI Enabled"; Boolean)
        {
            Caption = 'Rep SI Enabled';
            DataClassification = SystemMetadata;
        }
        field(13062816; "FAS Enabled"; Boolean)
        {
            Caption = 'FAS Enabled';
            DataClassification = SystemMetadata;
        }
        field(13062817; "KRD Enabled"; Boolean)
        {
            Caption = 'KRD Enabled';
            DataClassification = SystemMetadata;
        }
        field(13062818; "BST Enabled"; Boolean)
        {
            Caption = 'BST Enabled';
            DataClassification = SystemMetadata;
        }
        field(13062819; "VIES Enabled"; Boolean)
        {
            Caption = 'VIES Enabled';
            DataClassification = SystemMetadata;
        }
        field(13062820; "Unpaid Receivables Enabled"; Boolean)
        {
            Caption = 'Unpaid Receivables Enabled';
            DataClassification = SystemMetadata;
        }
        field(13062821; "EU Customs"; Boolean)
        {
            Caption = 'EU Customs';
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

        CoreSetup."ADL Enabled" := "ADL Enabled";
        CoreSetup."BST Enabled" := "BST Enabled";
        CoreSetup."EU Customs" := "EU Customs";
        CoreSetup."FAS Enabled" := "FAS Enabled";
        CoreSetup."KRD Enabled" := "KRD Enabled";
        CoreSetup."Rep HR Enabled" := "Rep HR Enabled";
        CoreSetup."Rep SI Enabled" := "Rep SI Enabled";
        CoreSetup."Rep RS Enabled" := "Rep RS Enabled";
        CoreSetup."Unpaid Receivables Enabled" := "Unpaid Receivables Enabled";
        CoreSetup."VAT Enabled" := "VAT Enabled";
        CoreSetup."VIES Enabled" := "VIES Enabled";

        CoreSetup.modify();
        Commit();
    end;
}