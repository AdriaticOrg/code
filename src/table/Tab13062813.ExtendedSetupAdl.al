table 13062597 "VAT Setup-Adl"
{
    Caption = 'VAT Setup';
    DataClassification = SystemMetadata;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = SystemMetadata;
        }
        field(13062525; "Use VAT Output Date-Adl"; Boolean)
        {
            Caption = 'Use VAT Output Date';
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
        CoreSetup.EnableFeature("ADLFeatures-Adl"::VAT);
    end;

    trigger OnDelete()
    var
        CoreSetup: Record "CoreSetup-Adl";
    begin
        CoreSetup.DisableFeature("ADLFeatures-Adl"::VAT);
    end;
}