tableextension 13062537 "CustLedgEntry-adl" extends "Cust. Ledger Entry" //21
{
    fields
    {
        // <adl.25>
        field(13062661; "KRD Affiliation Type"; Code[10])
        {
            Caption = 'KRD Affiliation Type';
            DataClassification = SystemMetadata;
            TableRelation = "KRD Code".Code where ("Type" = const ("Affiliation Type"));
        }
        field(13062662; "KRD Instrument Type"; Code[10])
        {
            Caption = 'KRD Instrument Type';
            DataClassification = SystemMetadata;
            TableRelation = "KRD Code".Code where ("Type" = const ("Instrument Type"));
        }
        field(13062663; "KRD Maturity"; Code[10])
        {
            Caption = 'KRD Maturity';
            DataClassification = SystemMetadata;
            TableRelation = "KRD Code".Code where ("Type" = const (Maturity));
        }
        field(13062664; "KRD Claim/Liability"; Option)
        {
            OptionMembers = " ","Claim","Liability";
            Caption = 'KRD Claim/Liability';
            DataClassification = SystemMetadata;
        }
        field(13062665; "KRD Non-Residnet Sector Code"; Code[10])
        {
            Caption = 'KRD Non-Resident Sector Code';
            DataClassification = SystemMetadata;
            TableRelation = "FAS Sector" where ("Type" = const (Posting));
        }
        field(13062666; "KRD Country/Region Code"; Code[10])
        {
            Caption = 'KRD Country/Region Code';
            DataClassification = SystemMetadata;
            TableRelation = "Country/Region";
        }
        field(13062667; "KRD Other Changes"; Boolean)
        {
            Caption = 'KRD Other Changes';
            DataClassification = SystemMetadata;
        }
        // </adl.25>
        // <adl.24>
        field(13062641; "FAS Sector Code"; Code[10])
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
        "FAS Sector Code" := Customer."FAS Sector Code";
    end;
    // </adl.24>
    // <adl.25>
    procedure CopyKRDFields(Customer: Record Customer)
    var
        ReportSISetup: Record "Reporting_SI Setup";
    begin
        "KRD Country/Region Code" := Customer."Country/Region Code";
        "KRD Non-Residnet Sector Code" := Customer."KRD Non-Residnet Sector Code";
        "KRD Affiliation Type" := Customer."KRD Affiliation Type";

        if ("KRD Affiliation Type" = '') and ReportSISetup.Get() then
            "KRD Affiliation Type" := ReportSISetup."Default KRD Affiliation Type";
    end;

    procedure CopyKRDFields(CustPstgGrp: Record "Customer Posting Group")
    begin
        "KRD Instrument Type" := CustPstgGrp."KRD Instrument Type";
        "KRD Claim/Liability" := CustPstgGrp."KRD Claim/Liability";
        "KRD Maturity" := CustPstgGrp."KRD Maturity";
    end;
    // </adl.25>
}