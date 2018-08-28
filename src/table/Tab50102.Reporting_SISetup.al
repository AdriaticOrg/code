table 50102 "Reporting_SI Setup"
{
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1;"Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = ToBeClassified;
        }
        field(10;"FAS Report No. Series";Code[20]) {
            Caption = 'FAS Report No. Series';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(12;"FAS Resp. User ID";Text[100]) {
            Caption = 'FAS Resp. User ID';
            TableRelation = "User Setup";
            DataClassification = ToBeClassified;            
        }
        
        field(15;"FAS Prep. By User ID";Text[100]) {
            Caption = 'FAS Prep. By User ID';
            TableRelation = "User Setup";
            DataClassification = ToBeClassified;            
        }

        field(16; "Budget User Code"; Code[10])
        {
            Caption = 'Budget User Code';
            DataClassification = ToBeClassified;
        }    
        field(17; "Company Sector Code"; Code[10])
        {
            Caption = 'Company Sector Code';
            TableRelation = "FAS Sector";
            DataClassification = ToBeClassified;                        
        }    
        
        field(20;"KRD Report No. Series";Code[20]) {
            Caption = 'KRD Report No. Series';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }     
        field(22;"KRD Resp. User ID";Text[100]) {
            Caption = 'KRD Resp. User ID';
            TableRelation = "User Setup";
            DataClassification = ToBeClassified;            
        }
        
        field(25;"KRD Prep. By User ID";Text[100]) {
            Caption = 'KRD Prep. By User ID';
            TableRelation = "User Setup";
            DataClassification = ToBeClassified;            
        }   

        field(30; "BST Report No. Series"; Code[20])
        {
            Caption = 'BST Report No. Series';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(32;"BST Resp. User ID";Text[100]) {
            Caption = 'BST Resp. User ID';
            TableRelation = "User Setup";
            DataClassification = ToBeClassified;            
        }
        
        field(35;"BST Prep. By User ID";Text[100]) {
            Caption = 'BST Prep. By User ID';
            TableRelation = "User Setup";
            DataClassification = ToBeClassified;            
        }         
        
        field(19;"FAS Director User ID";Text[100]) {
            Caption = 'FAS Director User ID';
            TableRelation = "User Setup";
            DataClassification = ToBeClassified;            
        }            
            
    }
    
    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
    
}