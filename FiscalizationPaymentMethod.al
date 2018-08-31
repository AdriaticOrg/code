table 13062605 "Fisc. Payment Method-ADL"
{
    LookupPageId = "Fisc. Payment Methods-ADL";
    DrillDownPageId = "Fisc. Payment Methods-ADL";
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1;Code; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2;Description; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(3;"Official Code"; Code[1])
        {
            DataClassification = ToBeClassified;
        }
        field(4;"Subject to Fiscalization"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(5;"Multiple Payment Methods"; Boolean)
        {
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
    
}