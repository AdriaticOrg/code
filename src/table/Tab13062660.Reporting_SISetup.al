table 13062660 "Reporting_SI Setup"
{
    DataClassification = SystemMetadata;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = SystemMetadata;
        }
        field(10; "FAS Report No. Series"; Code[20])
        {
            Caption = 'FAS Report No. Series';
            DataClassification = SystemMetadata;
            TableRelation = "No. Series";
        }
        field(13; "FAS Enabled"; Boolean)
        {
            Caption = 'FAS Enabled';
            DataClassification = SystemMetadata;
            //TODO: removal planned for V0.2 branch
            //NOTE: do not rename or remove fields on a daily basis
            //ObsoleteState = Removed;
            //ObsoleteReason = 'moved to core setup';
        }

        field(12; "FAS Resp. User ID"; Text[100])
        {
            Caption = 'FAS Resp. User ID';
            TableRelation = "User Setup";
            DataClassification = SystemMetadata;
        }

        field(15; "FAS Prep. By User ID"; Text[100])
        {
            Caption = 'FAS Prep. By User ID';
            TableRelation = "User Setup";
            DataClassification = SystemMetadata;
        }

        field(16; "Budget User Code"; Code[10])
        {
            Caption = 'Budget User Code';
            DataClassification = SystemMetadata;
        }
        field(17; "Company Sector Code"; Code[10])
        {
            Caption = 'Company Sector Code';
            TableRelation = "FAS Sector" where ("Type" = const (Posting));
            DataClassification = SystemMetadata;
        }
        field(19; "FAS Director User ID"; Text[100])
        {
            Caption = 'FAS Director User ID';
            TableRelation = "User Setup";
            DataClassification = SystemMetadata;
        }
        field(20; "KRD Report No. Series"; Code[20])
        {
            Caption = 'KRD Report No. Series';
            DataClassification = SystemMetadata;
            TableRelation = "No. Series";
        }
        field(21; "Default KRD Affiliation Type"; Code[10])
        {
            Caption = 'Default KRD Affiliation Type';
            DataClassification = SystemMetadata;
            TableRelation = "KRD Code".Code where ("Type" = const ("Affiliation Type"));
        }
        field(22; "KRD Resp. User ID"; Text[100])
        {
            Caption = 'KRD Resp. User ID';
            TableRelation = "User Setup";
            DataClassification = SystemMetadata;
        }
        field(23; "KRD Enabled"; Boolean)
        {
            Caption = 'KRD Enabled';
            DataClassification = SystemMetadata;
            //TODO: removal planned for V0.2 branch
            //NOTE: do not rename or remove fields on a daily basis
            //ObsoleteState = Removed;
            //ObsoleteReason = 'moved to core setup';
        }

        field(25; "KRD Prep. By User ID"; Text[100])
        {
            Caption = 'KRD Prep. By User ID';
            TableRelation = "User Setup";
            DataClassification = SystemMetadata;
        }

        field(30; "BST Report No. Series"; Code[20])
        {
            Caption = 'BST Report No. Series';
            DataClassification = SystemMetadata;
            TableRelation = "No. Series";
        }
        field(32; "BST Resp. User ID"; Text[100])
        {
            Caption = 'BST Resp. User ID';
            TableRelation = "User Setup";
            DataClassification = SystemMetadata;
        }
        field(33; "BST Enabled"; Boolean)
        {
            Caption = 'BST Enabled';
            DataClassification = SystemMetadata;
            //TODO: removal planned for V0.2 branch
            //NOTE: do not rename or remove fields on a daily basis
            //ObsoleteState = Removed;
            //ObsoleteReason = 'moved to core setup';
        }

        field(35; "BST Prep. By User ID"; Text[100])
        {
            Caption = 'BST Prep. By User ID';
            TableRelation = "User Setup";
            DataClassification = SystemMetadata;
        }
        field(40; "VIES Report No. Series"; Code[20])
        {
            Caption = 'VIES Report No. Series';
            DataClassification = SystemMetadata;
            TableRelation = "No. Series";
        }
        field(42; "VIES Resp. User ID"; Text[100])
        {
            Caption = 'VIES Resp. User ID';
            TableRelation = "User Setup";
            DataClassification = SystemMetadata;
        }
        field(43; "VIES Enabled"; Boolean)
        {
            Caption = 'VIES Enabled';
            DataClassification = SystemMetadata;
            //TODO: removal planned for V0.2 branch
            //NOTE: do not rename or remove fields on a daily basis
            //ObsoleteState = Removed;
            //ObsoleteReason = 'moved to core setup';
        }
        field(45; "VIES Prep. By User ID"; Text[100])
        {
            Caption = 'VIES Prep. By User ID';
            TableRelation = "User Setup";
            DataClassification = SystemMetadata;
        }
        field(50; "PDO Report No. Series"; Code[20])
        {
            Caption = 'PDO Report No. Series';
            DataClassification = SystemMetadata;
            TableRelation = "No. Series";
        }
        field(52; "PDO Resp. User ID"; Text[100])
        {
            Caption = 'PDO Resp. User ID';
            TableRelation = "User Setup";
            DataClassification = SystemMetadata;
        }

        field(55; "PDO Prep. By User ID"; Text[100])
        {
            Caption = 'PDO Prep. By User ID';
            TableRelation = "User Setup";
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }

}