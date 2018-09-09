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
    }

    keys
    {
        key(PK; "Code") { }
    }
}