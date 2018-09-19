table 13062783 "Fisc. Payment Method-Adl"
{
    // <adl.20>
    LookupPageId = "Fisc. Payment Methods-ADL";
    DrillDownPageId = "Fisc. Payment Methods-ADL";
    DataClassification = SystemMetadata;
    
    fields
    {
        field(1;Code; Code[10])
        {
            DataClassification = SystemMetadata;
        }
        field(2;Description; Text[30])
        {
            DataClassification = SystemMetadata;
        }
        field(3;"Official Code"; Code[1])
        {
            DataClassification = SystemMetadata;
        }
        field(4;"Subject to Fiscalization"; Boolean)
        {
            DataClassification = SystemMetadata;
        }
        field(5;"Multiple Payment Methods"; Boolean)
        {
            DataClassification = SystemMetadata;
        }
    }
    
    keys
    {
        key(PK; Code)
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
    // </adl.20>
}