table 13062663 "KRD Code"
{
    DataClassification = ToBeClassified;
    LookupPageId = 13062664;
    Caption = 'KRD Code';
    
    fields
    {
        field(1; "Type"; Option)
        {
            Caption = 'Type';
            OptionMembers = "Affiliation Type","Instrument Type",Maturity;
            OptionCaption = 'Affiliation Type,Instrument Type,Maturity';
            DataClassification = ToBeClassified;
        }
        field(2; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
        }
        field(3; "Description"; Text[250])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }        
    }
    
    keys
    {
        key(PK; "Type","Code")
        {
            Clustered = true;
        }
    }
    
}