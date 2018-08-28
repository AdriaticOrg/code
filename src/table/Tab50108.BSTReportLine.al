table 50108 "BST Report Line"
{
    Caption = 'BST Report Line';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1;"Document No."; Code[20])
        {
            Caption = '"Document No."';
            TableRelation = "FAS Report Header"."No.";
            DataClassification = ToBeClassified;
        }
        field(2; "Line No"; Integer)
        {
            Caption = 'Line No';
            DataClassification = ToBeClassified;
        }
        field(4; "BST Code"; Code[10])
        {
            Caption = 'BST Code';
            DataClassification = ToBeClassified;
            TableRelation = "BST Code";
        }
        
        field(5; "Description"; Text[120])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(10; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(11; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            DataClassification = ToBeClassified;
            TableRelation = "Country/Region";
        }
        field(12; "Country/Region No."; Integer)
        {
            Caption = 'Country/Region No.';
            DataClassification = ToBeClassified;
        }                
        
        field(20; "Income Amount"; Decimal)
        {
            Caption = 'Income Amount';
            DataClassification = ToBeClassified;
        }
        field(21; "Expense Amount"; Decimal)
        {
            Caption = 'Expense Amount';
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