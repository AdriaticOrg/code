table 13062813 "Extended Setup-Adl"
{
    Caption = 'Adriatic Extended Setup';
    DataClassification = SystemMetadata;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = SystemMetadata;
        }
        field(13062525; "VATEnabled-Adl"; Boolean)
        {
            Caption = 'Enable Adriatic VAT Extension';
            DataClassification = SystemMetadata;
        }
        field(13062526; "Use VAT Output Date-Adl"; Boolean)
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
}