tableextension 13062538 "Vendor-Adl" extends Vendor //23
{
    fields
    {
        // <adl.24>
        field(13062641; "FAS Sector Code-Adl"; Code[10])
        {
            Caption = 'FAS Sector Code';
            DataClassification = SystemMetadata;
            TableRelation = "FAS Sector" where ("Type" = const (Posting));
        }
        // </adl.24>
        // <adl.25>
        field(13062661; "KRD Non-Residnet Sector Code-Adl"; Code[10])
        {
            Caption = 'KRD Non-Resident Sector Code';
            DataClassification = SystemMetadata;
            TableRelation = "FAS Sector" where ("Type" = const (Posting));
        }
        field(13062662; "KRD Affiliation Type-Adl"; Code[10])
        {
            Caption = 'KRD Affiliation Type';
            DataClassification = SystemMetadata;
            TableRelation = "KRD Code".Code where ("Type" = const ("Affiliation Type"));
        }
        // </adl.25>
    }
}

