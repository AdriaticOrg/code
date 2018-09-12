tableextension 13062537 "Cust. Ledger Entry-Adl" extends "Cust. Ledger Entry" //21
{
    fields
    {
        // <adl.25>
        field(13062661; "KRD Affiliation Type-Adl"; Code[10])
        {
            Caption = 'KRD Affiliation Type';
            DataClassification = SystemMetadata;
            TableRelation = "KRD Code".Code where ("Type" = const ("Affiliation Type"));
        }
        field(13062662; "KRD Instrument Type-Adl"; Code[10])
        {
            Caption = 'KRD Instrument Type';
            DataClassification = SystemMetadata;
            TableRelation = "KRD Code".Code where ("Type" = const ("Instrument Type"));
        }
        field(13062663; "KRD Maturity-Adl"; Code[10])
        {
            Caption = 'KRD Maturity';
            DataClassification = SystemMetadata;
            TableRelation = "KRD Code".Code where ("Type" = const (Maturity));
        }
        field(13062664; "KRD Claim/Liability-Adl"; Option)
        {
            OptionMembers = " ","Claim","Liability";
            Caption = 'KRD Claim/Liability';
            DataClassification = SystemMetadata;
        }
        field(13062665; "KRD Non-Residnet Sector Code-Adl"; Code[10])
        {
            Caption = 'KRD Non-Resident Sector Code';
            DataClassification = SystemMetadata;
            TableRelation = "FAS Sector" where ("Type" = const (Posting));
        }
        field(13062666; "KRD Country/Region Code-Adl"; Code[10])
        {
            Caption = 'KRD Country/Region Code';
            DataClassification = SystemMetadata;
            TableRelation = "Country/Region";
        }
        field(13062667; "KRD Other Changes-Adl"; Boolean)
        {
            Caption = 'KRD Other Changes';
            DataClassification = SystemMetadata;
        }
        // </adl.25>
        // <adl.24>
        field(13062641; "FAS Sector Code-Adl"; Code[10])
        {
            Caption = 'FAS Sector Code';
            DataClassification = SystemMetadata;
            TableRelation = "FAS Sector" where ("Type" = const (Posting));
        }
        // </adl.24>
    }
    // <adl.24>
    procedure CopyFASFields(Customer: Record Customer)
    begin
        "FAS Sector Code-Adl" := Customer."FAS Sector Code-Adl";
    end;
    // </adl.24>
    // <adl.25>
    procedure CopyKRDFields(Customer: Record Customer)
    var
        ReportSISetup: Record "Reporting_SI Setup";
    begin
        "KRD Country/Region Code-Adl" := Customer."Country/Region Code";
        "KRD Non-Residnet Sector Code-Adl" := Customer."KRD Non-Residnet Sector Code-Adl";
        "KRD Affiliation Type-Adl" := Customer."KRD Affiliation Type-Adl";

        if ("KRD Affiliation Type-Adl" = '') and ReportSISetup.Get() then
            "KRD Affiliation Type-Adl" := ReportSISetup."Default KRD Affiliation Type";
    end;

    procedure CopyKRDFields(CustPstgGrp: Record "Customer Posting Group")
    begin
        "KRD Instrument Type-Adl" := CustPstgGrp."KRD Instrument Type-Adl";
        "KRD Claim/Liability-Adl" := CustPstgGrp."KRD Claim/Liability-Adl";
        "KRD Maturity-Adl" := CustPstgGrp."KRD Maturity-Adl";
    end;
    // </adl.25>
}