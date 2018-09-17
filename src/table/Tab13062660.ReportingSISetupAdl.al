table 13062660 "Reporting SI Setup-Adl"
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
            TableRelation = "FAS Sector-Adl" where ("Type" = const (Posting));
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
            TableRelation = "KRD Code-Adl".Code where ("Type" = const ("Affiliation Type"));
        }
        field(22; "KRD Resp. User ID"; Text[100])
        {
            Caption = 'KRD Resp. User ID';
            TableRelation = "User Setup";
            DataClassification = SystemMetadata;
        }
        field(23; "KRD Blank LCY Code"; Code[20])
        {
            Caption = 'KRD Blank LCY Code';
            DataClassification = SystemMetadata;
        }
        field(24; "KRD Blank LCY Num."; Text[10])
        {
            Caption = 'KRD Blank LCY Num.';
            DataClassification = SystemMetadata;
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
        field(43; "Default VIES Country"; Option)
        {
            Caption = 'Default VIES Country';
            OptionMembers = " ",Slovenia,Croatia;
            OptionCaption = ' ,Slovenia,Croatia';
            DataClassification = SystemMetadata;

            trigger OnValidate()
            begin
                clear("Default VIES Type");
            end;
        }
        field(44; "Default VIES Type"; Option)
        {
            OptionMembers = " ",ZP,"PDV-S";
            OptionCaption = ' ,ZP,PDV-S';
            Caption = 'Default VIES Type';
            DataClassification = SystemMetadata;

            trigger OnValidate()
            begin
                if "Default VIES Type" <> "Default VIES Type"::" " then
                    TestField("Default VIES Country", "Default VIES Country"::Croatia);
            end;
        }
        field(45; "VIES Prep. By User ID"; Text[100])
        {
            Caption = 'VIES Prep. By User ID';
            TableRelation = "User Setup";
            DataClassification = SystemMetadata;
        }
        field(46; "VIES Company Branch Code"; Text[30])
        {
            Caption = 'VIES Company Branch Code';
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
        field(53; "PDO VAT Ident. Filter Code"; Code[20])
        {
            Caption = 'PDO VAT Ident. Filter Code ';
            DataClassification = SystemMetadata;
            TableRelation = "VAT Identifier-Adl";
            ValidateTableRelation = false;
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