table 13062665 "KRD Setup-Adl"
{
    DataClassification = SystemMetadata;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
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
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        CoreSetup: Record "CoreSetup-Adl";
    begin
        CoreSetup.EnableFeature(CoreSetup."ADL Features"::KRD);
    end;

    trigger OnDelete()
    var
        CoreSetup: Record "CoreSetup-Adl";
    begin
        CoreSetup.DisableFeature(CoreSetup."ADL Features"::KRD);
    end;
}