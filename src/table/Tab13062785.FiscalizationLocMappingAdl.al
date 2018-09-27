table 13062785 "Fiscalization Loc. Mapping-Adl"
{
    // <adl.20>
    Caption = 'Fiscalization Location Mapping';
    DataClassification = SystemMetadata;

    fields
    {
        field(1; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location;
            NotBlank = true;
            DataClassification = SystemMetadata;
        }
        field(2; "Fisc. Location Code"; Code[10])
        {
            Caption = 'Fisc. Location Code';
            TableRelation = "Fiscalization Location-Adl";
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(PK; "Location Code", "Fisc. Location Code")
        {
            Clustered = true;
        }
    }
    // </adl.20>
}