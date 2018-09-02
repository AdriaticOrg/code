table 13062681 "BST Code"
{
    DataClassification = ToBeClassified;
    LookupPageId = 13062681;
    Caption = 'BST Code';
    
    fields
    {
        field(1;Code;Code[10])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
        }
        field(2; "Serial Num."; Code[20])
        {
            Caption = 'Serial Num.';
            DataClassification = ToBeClassified;
        }
        field(3; "Description"; Text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(4; Totaling; Text[80])
        {
            Caption = 'Totaling';
            DataClassification = ToBeClassified;
        }
        field(5; "Type"; Option)
        {
            Caption = 'Type';
            OptionMembers = "Posting","Total";
            DataClassification = ToBeClassified;
        }
        field(6; "Indentation"; Integer)
        {
            Caption = 'Indentation';
            DataClassification = ToBeClassified;
        }                        
        
    }
    
    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
    }
    
}