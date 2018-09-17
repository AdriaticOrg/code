table 13062783 "Fisc. Payment Method-Adl"
{
    LookupPageId = "Fisc. Payment Methods-ADL";
    DrillDownPageId = "Fisc. Payment Methods-ADL";
    DataClassification = CustomerContent;
    
    fields
    {
        field(1;Code; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(2;Description; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(3;"Official Code"; Code[1])
        {
            DataClassification = CustomerContent;
        }
        field(4;"Subject to Fiscalization"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(5;"Multiple Payment Methods"; Boolean)
        {
            DataClassification = CustomerContent;
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