table 13062811 "CoreSetup-Adl"
{
    Caption = 'ADL CoreSetup';
    DataClassification = SystemMetadata;

    fields
    {
        //NOTE: fields here should be set during assisted setup
        // maintained automatically ( when handling specific feature setup )
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            DataClassification = SystemMetadata;
        }
        field(2; "ADL Enabled"; Boolean)
        {
            Caption = 'ADL Enabled';
            DataClassification = SystemMetadata;
        }
        field(3; "VAT Enabled"; Boolean)
        {
            Caption = 'VAT Enabled';
            DataClassification = SystemMetadata;
        }
        field(13; "FAS Enabled"; Boolean)
        {
            Caption = 'FAS Enabled';
            DataClassification = SystemMetadata;
        }
        field(23; "KRD Enabled"; Boolean)
        {
            Caption = 'KRD Enabled';
            DataClassification = SystemMetadata;
        }
        field(33; "BST Enabled"; Boolean)
        {
            Caption = 'BST Enabled';
            DataClassification = SystemMetadata;
        }
        field(43; "VIES Enabled"; Boolean)
        {
            Caption = 'VIES Enabled';
            DataClassification = SystemMetadata;
        }
        field(53; "Unpaid Receivables Enabled"; Boolean)
        {
            Caption = 'Unpaid Receivables Enabled';
            DataClassification = SystemMetadata;
        }
        field(63; "PDO Enabled"; Boolean)
        {
            Caption = 'PDO Enabled';
            DataClassification = SystemMetadata;
        }
        field(73; "FISC Enabled"; Boolean)
        {
            Caption = 'FISC Enabled';
            DataClassification = SystemMetadata;
        }
        field(200; "Forced Credit/Debit Enabled"; Boolean)
        {
            Caption = 'Forced Credit/Debit Enabled';
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(PK; "Code") { }
    }

    procedure FeatureEnabled(Feature: enum "ADLFeatures-Adl"): Boolean
    begin
        if not ReadPermission() then exit(false);
        if not Get() then exit(false);
        if not "ADL Enabled" then exit(false);

        case Feature of
            Feature::Core:
                exit("ADL Enabled");
            Feature::VAT:
                exit("VAT Enabled");
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
            Feature::FISC:
                exit("FISC Enabled");
        end;

        exit(false);
    end;

    procedure EnableFeature(Feature: enum "ADLFeatures-Adl")
    begin
        EnableOrDisableFeature(Feature, true);
    end;

    procedure DisableFeature(Feature: enum "ADLFeatures-Adl")
    begin
        EnableOrDisableFeature(Feature, false);
    end;

    procedure EnableOrDisableFeature(Feature: enum "ADLFeatures-Adl"; EnableFeature: Boolean)
    begin
        if not Get() then Insert();

        case Feature of
            Feature::Core:
                "ADL Enabled" := EnableFeature;
            Feature::VAT:
                "VAT Enabled" := EnableFeature;
            Feature::FAS:
                "FAS Enabled" := EnableFeature;
            Feature::KRD:
                "KRD Enabled" := EnableFeature;
            Feature::BST:
                "BST Enabled" := EnableFeature;
            Feature::VIES:
                "VIES Enabled" := EnableFeature;
            Feature::UnpaidReceivables:
                "Unpaid Receivables Enabled" := EnableFeature;
            Feature::ForcedCreditDebit:
                "Forced Credit/Debit Enabled" := EnableFeature;
            Feature::FISC:
                "FISC Enabled" := EnableFeature;
        end;

        Modify();
    end;
}