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
        field(11;"FAS Resp. Name";Text[100]) {
            Caption = 'FAS Resp. Name';
            DataClassification = ToBeClassified;            
        }
        field(12; "FAS Resp. Email"; text[100])
        {
            Caption = 'FAS Resp. Email';
            DataClassification = ToBeClassified;
        }
        field(13; "FAS Resp. Position"; Text[100])
        {
            Caption = 'FAS Resp. Position';
            DataClassification = ToBeClassified;
        }
        field(14; "FAS Resp. Phone"; Text[30])
        {
            Caption = 'FAS Resp. Phone';
            DataClassification = ToBeClassified;
        }

        field(15;"FAS Prep. By Name";Text[100]) {
            Caption = 'FAS Prep. By Name';
            DataClassification = ToBeClassified;            
        }
        field(16; "FAS Prep. By Email"; text[100])
        {
            Caption = 'FAS Prep. By Email';
            DataClassification = ToBeClassified;
        }
        field(17; "FAS Prep. By Position"; Text[100])
        {
            Caption = 'FAS Prep. By Position';
            DataClassification = ToBeClassified;
        }
        field(18; "FAS Prep. By Phone"; Text[30])
        {
            Caption = 'FAS Resp. Phone';
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