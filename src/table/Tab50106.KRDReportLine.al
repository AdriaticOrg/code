table 50106 "KRD Report Line"
{
    Caption = 'KRD Report Line';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1;"Document No."; Code[20])
        {
            Caption = '"Document No."';
            TableRelation = "KRD Report Header"."No.";
            DataClassification = ToBeClassified;
        }
        field(2; "Line No"; Integer)
        {
            Caption = 'Line No';
            DataClassification = ToBeClassified;
        }
        field(5; "Description"; Text[120])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }

        field(10; "Affiliation Type"; Code[10])
        {
            Caption = 'Affiliation Type';
            DataClassification = ToBeClassified;
        }
        field(11; "Instrument Type"; Code[10])
        {
            Caption = 'Instrument Type';
            DataClassification = ToBeClassified;
        }
        field(12; "Maturity"; Code[10])
        {
            Caption = 'Maturity';
            DataClassification = ToBeClassified;
        }        
        field(13; "Claim/Liability"; Option)
        {
            OptionMembers = " ","Claim","Liability";
            Caption = 'Claim/Liability';
            DataClassification = ToBeClassified;
        } 
        field(14;"Non-Residnet Sector Code";Code[10])
        {
            Caption = 'Non-Resident Sector Code';
            DataClassification = ToBeClassified;
            TableRelation = "FAS Sector";
        } 
        field(15; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            DataClassification = ToBeClassified;
            TableRelation = "Country/Region";
        }
        field(16; "Country/Region No."; Integer)
        {
            Caption = 'Country/Region No.';
            DataClassification = ToBeClassified;
        }
        field(17; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            DataClassification = ToBeClassified;
        }
        field(18; "Currency No."; Integer)
        {
            Caption = 'Currency No.';
            DataClassification = ToBeClassified;
        }
        field(30; "Opening Balance"; Decimal)
        {
            Caption = 'Opening Balance';
            DataClassification = ToBeClassified;
        }
        field(31; "Increase Amount"; Decimal)
        {
            Caption = 'Increase Amount';
            DataClassification = ToBeClassified;
        }
        field(32; "Decrease Amount"; Decimal)
        {
            Caption = 'Decrease Amount';
            DataClassification = ToBeClassified;
        }
        field(33; "Closing Balance"; Decimal)
        {
            Caption = 'Closing Balance';
            DataClassification = ToBeClassified;
        }                                                
    }
    
    keys
    {
        key(PK; "Document No.","Line No")
        {
            Clustered = true;
        }
    }
    
}