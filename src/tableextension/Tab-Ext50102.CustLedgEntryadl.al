tableextension 50102 "CustLedgEntry-adl" extends "Cust. Ledger Entry"
{
    fields
    {
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
        field(50104;"FAS Non-Residnet Sector Code";Code[10])
        {
            Caption = 'FAS Non-Resident Sector Code';
            DataClassification = ToBeClassified;
            TableRelation = "FAS Sector";
        } 
        field(50105; "FAS Country/Region Code"; Code[10])
        {
            Caption = 'FAS Country/Region Code';
            DataClassification = ToBeClassified;
            TableRelation = "Country/Region";
        }
        field(50106; "FAS Other Changes"; Boolean)
        {
            Caption = 'FAS Other Changes';
            DataClassification = ToBeClassified;
        }
        field(50108;"FAS Sector Code";Code[10])
        {
            Caption = 'FAS Sector Code';
            DataClassification = ToBeClassified;
            TableRelation = "FAS Sector";
        }         
              
        
    }
    
}