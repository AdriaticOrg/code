table 13062623 "PDO Setup-Adl"
{
    DataClassification = SystemMetadata;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
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
        field(53; "PDO VAT Ident. Filter Code"; Code[100])
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