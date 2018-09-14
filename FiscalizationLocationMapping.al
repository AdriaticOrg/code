table 13062785 "Fiscalization Loc. Mapping-ADL"
{
    DataClassification = CustomerContent;
    
    fields
    {
        field(1;"Location Code"; Code[10])
        {
            TableRelation = Location;
            NotBlank = true;
            DataClassification = CustomerContent;
            
        }
        field(2;"Fisc. Location Code"; Code[10])
        {
            TableRelation = "Fiscalization Location-ADL";
            DataClassification = CustomerContent;
            
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