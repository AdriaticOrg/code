table 13062601 "Fiscalization Setup-ADL"  
{
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1;"Primary Key"; code [10])
        {
            DataClassification = SystemMetadata;
            
        }
        field(2;Active; Boolean)
        {
            DataClassification = SystemMetadata;
            trigger OnValidate()
            var ActiveSession :Record "Active Session";
            begin
                IF Active THEN BEGIN
                    ActiveSession.GET(SERVICEINSTANCEID, SESSIONID);
                    "Service Name" := ActiveSession."Server Computer Name";
                    "Service Instance" := ActiveSession."Server Instance Name";
                    "Database Name" := ActiveSession."Database Name";
                END;
            end;             
        }

        field(3;"In VAT Register"; Boolean)
        {
            DataClassification = SystemMetadata;
            
        }
        field(6;"Start Date"; Date)
        {
            DataClassification = SystemMetadata;
            
        }
        field(7;"End Date"; Date)
        {
            DataClassification = SystemMetadata;
            
        }
        field(8;"Default Fiscalization Location"; code[10])
        {
            DataClassification = SystemMetadata;
            TableRelation = "Fiscalization Location-ADL";
        }
        field(9;"Default Fiscalization Terminal"; Text[30])
        {
            DataClassification = SystemMetadata;
            TableRelation = "Fiscalization Terminal-ADL";
        }
        field(10;Operator; Option)
        { 
            OptionMembers = " ",User,Salesperson,"Company Official";
            DataClassification = SystemMetadata;
            
        }
        field(11;"Source of No. Series"; Option)
        {
            OptionMembers = " ","Fiscalization Location","Fiscalization Terminal";
            DataClassification = SystemMetadata;
            
        }
        field(12;"Show Web Service Messages"; Boolean)
        {
            DataClassification = SystemMetadata;
            
        }
        field(13;"Send Data Automaticaly"; Boolean)
        {
            DataClassification = SystemMetadata;
            
        }
        field(14;"Test on Posting"; Boolean)
        {
            DataClassification = SystemMetadata;
            
        }
        field(15;"Service Name"; Text[250])
        {
            DataClassification = SystemMetadata;
            
        }
        field(16;"Service Instance"; Text[250])
        {
            DataClassification = SystemMetadata;
            
        }
        field(17;"Database Name"; Text[250])
        {
            DataClassification = SystemMetadata;
            
        }
        field(18;"Reference URI"; Text[10])
        {
            ValuesAllowed = 'test','data';
            DataClassification = SystemMetadata;
            
        }
        field(19;"TimeOut WEB Service (s)"; Integer)
        {
            InitValue = 4;
            MinValue = 4;
            MaxValue = 15;
            DataClassification = SystemMetadata;
            
        }
        field(20;"Send All Fisc Doc"; Boolean)
        {
            DataClassification = SystemMetadata;
            
        }
        field(21;"VAT Ident.-Exempt"; Text[30])
        {
            DataClassification = SystemMetadata;
            
        }
        field(22;"VAT Ident.-Non-taxable trans."; Text[30])
        {
            DataClassification = SystemMetadata;
            
        }
        field(23;"VAT Ident.-Reversed tax"; Text[30])
        {
            DataClassification = SystemMetadata;
            
        }
        field(24;"VAT Ident.-Other taxes"; Text[30])
        {
            DataClassification = SystemMetadata;
            
        }
        field(25;"Allow Fiscalization on Server"; Boolean)
        {
            DataClassification = SystemMetadata;
            
        }

    }
    
    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
    
    var
        myInt: Integer;
    
    trigger OnInsert()
    begin
        
    end;
    
    trigger OnModify()
    begin
        
    end;
    
    trigger OnDelete()
    begin
        
    end;
    
    trigger OnRename()
    begin
        
    end;
    procedure IsActive() Active:Boolean;
    begin
        IF READPERMISSION THEN
            IF GET THEN
              EXIT(Active);
    end;

procedure IsVisible() Active:Boolean;
    begin
      IF READPERMISSION THEN BEGIN
        IF NOT GET THEN
          EXIT(FALSE)
        ELSE
          EXIT(Active);
      END ELSE BEGIN
        EXIT(FALSE);
      END;
    end;

    procedure SendDataAutomatically() Active:Boolean;
    var ActiveSession: Record "Active Session";
    begin
      IF READPERMISSION THEN
        IF GET THEN BEGIN
          IF Active THEN BEGIN
            IF ActiveSession.GET(SERVICEINSTANCEID, SESSIONID) THEN;
              IF NOT (("Service Name" = ActiveSession."Server Computer Name") AND
                    ("Service Instance" = ActiveSession."Server Instance Name") AND
                    ("Database Name" = ActiveSession."Database Name"))
              THEN
                EXIT(FALSE);
          END;
            EXIT(Active);
        END;
    end;

    procedure GetCountryCode() Code:Code[10];
    var CompanyInformation: Record "Company Information";
    begin
        CompanyInformation.GET;
        CompanyInformation.TESTFIELD("Country/Region Code");
        EXIT(CompanyInformation."Country/Region Code");
    end;

    procedure CountryCodeSI() Boolean:Boolean;
    begin
      EXIT(GetCountryCode = 'SI');
    end;

    procedure CountryCodeHR() Boolean:Boolean;
    begin
      EXIT(GetCountryCode = 'HR');
    end;

    procedure CountryCodeRS() Boolean:Boolean;
    begin
      EXIT(GetCountryCode = 'RS');
    end;
}