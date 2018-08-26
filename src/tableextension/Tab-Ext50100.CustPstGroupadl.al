tableextension 50100 "CustPstGroup-adl" extends "Customer Posting Group"
{
    fields {
        field(50100; "FAS Affiliation Type"; Code[10])
        {
            Caption = 'FAS Affiliation Type';
            DataClassification = ToBeClassified;
        }
        field(50101; "FAS Instrument Type"; Code[10])
        {
            Caption = 'FAS Instrument Type';
            DataClassification = ToBeClassified;
        }
        field(50102; "FAS Maturity"; Code[10])
        {
            Caption = 'FAS Maturity';
            DataClassification = ToBeClassified;
        }        
        field(59103; "FAS Claim/Liability"; Option)
        {
            OptionMembers = " ","Claim","Liability";
            Caption = 'FAS Claim/Liability';
            DataClassification = ToBeClassified;
        }        
    }
}