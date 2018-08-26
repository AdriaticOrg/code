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
        
        field(20;"KRD Report No. Series";Code[20]) {
            Caption = 'KRD Report No. Series';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
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