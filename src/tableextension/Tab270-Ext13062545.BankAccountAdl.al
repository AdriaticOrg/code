tableextension 13062545 "Bank Account-Adl" extends "Bank Account" //270
{

    fields
    {
        // <adl.24> 
        field(13062641; "FAS Instrument Code-Adl"; Code[10])
        {
            Caption = 'FAS Instrument Code';
            DataClassification = SystemMetadata;
            TableRelation = "FAS Instrument-Adl" where ("Type" = const (Posting));
        }
        field(13062642; "FAS Sector Code-Adl"; Code[10])
        {
            Caption = 'FAS Sector Code';
            DataClassification = SystemMetadata;
            TableRelation = "FAS Sector-Adl" where ("Type" = const (Posting));
        }
        // </adl.24> 
    }
}

