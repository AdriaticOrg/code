table 13062645 "FAS Setup-Adl"
{
    Caption = 'FAS Setup';
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
        CoreSetup.EnableFeature(CoreSetup."ADL Features"::FAS);
    end;

    trigger OnDelete()
    var
        CoreSetup: Record "CoreSetup-Adl";
    begin
        CoreSetup.DisableFeature(CoreSetup."ADL Features"::FAS);
    end;
}