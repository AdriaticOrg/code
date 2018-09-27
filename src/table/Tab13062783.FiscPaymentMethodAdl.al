table 13062783 "Fisc. Payment Method-Adl"
{
    // <adl.20>
    Caption = 'Fiscalization Payment Method';
    LookupPageId = "Fisc. Payment Methods-Adl";
    DrillDownPageId = "Fisc. Payment Methods-Adl";
    DataClassification = SystemMetadata;

    fields
    {
        field(1; Code; Code[10])
        {
            Caption = 'Code';
            DataClassification = SystemMetadata;
        }
        field(2; Description; Text[30])
        {
            Caption = 'Description';
            DataClassification = SystemMetadata;
        }
        field(3; "Official Code"; Code[1])
        {
            Caption = 'Official Code';
            DataClassification = SystemMetadata;
        }
        field(4; "Subject to Fiscalization"; Boolean)
        {
            Caption = 'Subject to Fiscalization';
            DataClassification = SystemMetadata;
        }
        field(5; "Multiple Payment Methods"; Boolean)
        {
            Caption = 'Multiple Payment Methods';
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
    }
    // </adl.20>
}