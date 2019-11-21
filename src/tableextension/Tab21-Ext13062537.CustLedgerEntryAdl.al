tableextension 13062537 "Cust. Ledger Entry-Adl" extends "Cust. Ledger Entry" //21
{
    fields
    {
        // <adl.25>
        field(13062661; "KRD Affiliation Type-Adl"; Code[10])
        {
            Caption = 'KRD Affiliation Type';
            DataClassification = SystemMetadata;
            TableRelation = "KRD Code-Adl".Code where ("Type" = const ("Affiliation Type"));
        }
        field(13062662; "KRD Instrument Type-Adl"; Code[10])
        {
            Caption = 'KRD Instrument Type';
            DataClassification = SystemMetadata;
            TableRelation = "KRD Code-Adl".Code where ("Type" = const ("Instrument Type"));
        }
        field(13062663; "KRD Maturity-Adl"; Code[10])
        {
            Caption = 'KRD Maturity';
            DataClassification = SystemMetadata;
            TableRelation = "KRD Code-Adl".Code where ("Type" = const (Maturity));
        }
        field(13062664; "KRD Claim/Liability-Adl"; Option)
        {
            OptionMembers = " ","Claim","Liability";
            Caption = 'KRD Claim/Liability';
            DataClassification = SystemMetadata;
        }
        field(13062665; "KRD Non-Res. Sector Code-Adl"; Code[10])
        {
            Caption = 'KRD Non-Resident Sector Code';
            DataClassification = SystemMetadata;
            TableRelation = "KRD Sector-Adl" where ("Type" = const (Posting));
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
            TableRelation = "FAS Sector-Adl" where ("Type" = const (Posting));
        }
        // </adl.24>
        // <adl.20>    
        field(13062781; "Full Fisc. Doc. No.-Adl"; Code[20])
        {
            Caption = 'Full Fisc. Doc. No.';
            DataClassification = SystemMetadata;
        }
        // </adl.20> 
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
        KRDSetup: Record "KRD Setup-Adl";
    begin
        "KRD Country/Region Code-Adl" := Customer."Country/Region Code";
        "KRD Non-Res. Sector Code-Adl" := Customer."KRD Non-Res. Sector Code-Adl";
        "KRD Affiliation Type-Adl" := Customer."KRD Affiliation Type-Adl";

        if ("KRD Affiliation Type-Adl" = '') and KRDSetup.Get() then
            "KRD Affiliation Type-Adl" := KRDSetup."Default KRD Affiliation Type";
    end;

    procedure CopyKRDFields(CustPstgGrp: Record "Customer Posting Group")
    begin
        "KRD Instrument Type-Adl" := CustPstgGrp."KRD Instrument Type-Adl";
        "KRD Claim/Liability-Adl" := CustPstgGrp."KRD Claim/Liability-Adl";
        "KRD Maturity-Adl" := CustPstgGrp."KRD Maturity-Adl";
    end;
    // </adl.25>
}