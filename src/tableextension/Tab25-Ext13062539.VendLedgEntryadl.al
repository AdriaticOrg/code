tableextension 13062539 "VendLedgEntry-adl" extends "Vendor Ledger Entry" //25
{
    fields
    {
        // <adl.25>
        field(13062661; "KRD Affiliation Type"; Code[10])
        {
            Caption = 'KRD Affiliation Type';
            DataClassification = ToBeClassified;
            TableRelation = "KRD Code".Code where ("Type" = const("Affiliation Type"));
        }
        field(13062662; "KRD Instrument Type"; Code[10])
        {
            Caption = 'KRD Instrument Type';
            DataClassification = ToBeClassified;
            TableRelation = "KRD Code".Code where ("Type" = const("Instrument Type"));
        }
        field(13062663; "KRD Maturity"; Code[10])
        {
            Caption = 'KRD Maturity';
            DataClassification = ToBeClassified;
            TableRelation = "KRD Code".Code where ("Type" = const(Maturity));
        }        
        field(13062664; "KRD Claim/Liability"; Option)
        {
            OptionMembers = " ","Claim","Liability";
            Caption = 'KRD Claim/Liability';
            DataClassification = ToBeClassified;
        }   
        field(13062665;"KRD Non-Residnet Sector Code";Code[10])
        {
            Caption = 'KRD Non-Resident Sector Code';
            DataClassification = ToBeClassified;
            TableRelation = "FAS Sector";
        }
        field(13062666; "KRD Country/Region Code"; Code[10])
        {
            Caption = 'KRD Country/Region Code';
            DataClassification = ToBeClassified;
            TableRelation = "Country/Region";
        }   
        field(13062667; "KRD Other Changes"; Boolean)
        {
            Caption = 'KRD Other Changes';
            DataClassification = ToBeClassified;
        }      
        // </adl.25>
        // <adl.24>
        field(13062641;"FAS Sector Code";Code[10])
        {
            Caption = 'FAS Sector Code';
            DataClassification = ToBeClassified;
            TableRelation = "FAS Sector";
        }
        // </adl.24>
    }
}