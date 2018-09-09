tableextension 13062536 "Customer-adl" extends Customer //18
{
    fields
    {
        // <adl.24>
        field(13062641; "FAS Sector Code"; Code[10])
        {
            Caption = 'FAS Sector Code';
            DataClassification = SystemMetadata;
            TableRelation = "FAS Sector" where ("Type" = const (Posting));
        }
        // </adl.24>
        // <adl.25>
        field(13062661; "KRD Non-Residnet Sector Code"; Code[10])
        {
            Caption = 'KRD Non-Resident Sector Code';
            DataClassification = SystemMetadata;
            TableRelation = "FAS Sector" where ("Type" = const (Posting));
        }
        field(13062662; "KRD Affiliation Type"; Code[10])
        {
            Caption = 'KRD Affiliation Type';
            DataClassification = SystemMetadata;
            TableRelation = "KRD Code".Code where ("Type" = const ("Affiliation Type"));
        }
        // </adl.25>
    }
}
