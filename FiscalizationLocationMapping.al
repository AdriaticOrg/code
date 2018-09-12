table 13062604 "Fiscalization Loc. Mapping-ADL"
{
    DataClassification = SystemMetadata;
    
    fields
    {
        field(1;"Location Code"; Code[10])
        {
            TableRelation = Location;
            NotBlank = true;
            DataClassification = SystemMetadata;
            
        }
        field(2;"Fisc. Location Code"; Code[10])
        {
            TableRelation = "Fiscalization Location-ADL";
            DataClassification = SystemMetadata;
            
        }

    }
    
    keys
    {
        key(PK; "Location Code","Fisc. Location Code")
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