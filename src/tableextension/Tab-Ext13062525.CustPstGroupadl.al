tableextension 13062525 "CustPstGroup-adl" extends "Customer Posting Group"
{
    fields {
        field(13062661; "KRD Affiliation Type"; Code[10])
        {
            Caption = 'KRD Affiliation Type';
            DataClassification = ToBeClassified;
        }
        field(13062662; "KRD Instrument Type"; Code[10])
        {
            Caption = 'KRD Instrument Type';
            DataClassification = ToBeClassified;
        }
        field(13062663; "KRD Maturity"; Code[10])
        {
            Caption = 'KRD Maturity';
            DataClassification = ToBeClassified;
        }        
        field(13062664; "KRD Claim/Liability"; Option)
        {
            OptionMembers = " ","Claim","Liability";
            Caption = 'KRD Claim/Liability';
            DataClassification = ToBeClassified;
        }        
    }
}