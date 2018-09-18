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
        field(13062813; "Rep HR Enabled-Adl"; Boolean)
        {
            Caption = 'Rep HR Enabled';
            DataClassification = SystemMetadata;
        }
        field(13062814; "Rep RS Enabled-Adl"; Boolean)
        {
            Caption = 'Rep RS Enabled';
            DataClassification = SystemMetadata;
        }
        field(13062815; "Rep SI Enabled-Adl"; Boolean)
        {
            Caption = 'Rep SI Enabled';
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
        field(13062821; "EU Customs-Adl"; Boolean)
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

        CoreSetup."ADL Enabled" := "ADL Enabled-Adl";
        CoreSetup."BST Enabled" := "BST Enabled-Adl";
        CoreSetup."EU Customs" := "EU Customs-Adl";
        CoreSetup."FAS Enabled" := "FAS Enabled-Adl";
        CoreSetup."KRD Enabled" := "KRD Enabled-Adl";
        CoreSetup."Rep HR Enabled" := "Rep HR Enabled-Adl";
        CoreSetup."Rep SI Enabled" := "Rep SI Enabled-Adl";
        CoreSetup."Rep RS Enabled" := "Rep RS Enabled-Adl";
        CoreSetup."Unpaid Receivables Enabled" := "Unpaid Receivables Enabled-Adl";
        CoreSetup."VAT Enabled" := "VAT Enabled-Adl";
        CoreSetup."VIES Enabled" := "VIES Enabled-Adl";

        CoreSetup.modify();
        Commit();
    end;
}