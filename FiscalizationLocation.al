table 13062603 "Fiscalization Location-ADL"
{
    DataClassification = ToBeClassified;
    LookupPageId = "Fisc. Location List-ADL";
    DrillDownPageId = "Fisc. Location List-ADL";
    fields
    {
        field(1;"Fisc. Location Code"; Code[10])
        {
            NotBlank = True;
            DataClassification = CustomerContent;
            
        }
        
        field(2;"Fisc. Street"; text[100])
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                ValidateFiscData;
            end;
        }
        field(3;"Fisc. House Number"; text[4])
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                ValidateFiscData;
            end;            
        }
        field(4;"Fisc. House Number Appendix"; text[4])
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                ValidateFiscData;
            end;            
        }
        field(5;"Fisc. Settlement"; Text[35])
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                ValidateFiscData;
            end;            
        }
        field(6;"Fisc. City/Municipality"; Text[35])
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                ValidateFiscData;
            end;            
        }
        field(7;"Fisc. Post Code"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Post Code";  
            trigger OnValidate()
            var PostCode : Record "Post Code";
            begin
                ValidateFiscData;
                PostCode.SETRANGE(Code,"Fisc. Post Code");
                IF PostCode.FINDFIRST THEN BEGIN
                  "Fisc. City/Municipality" := PostCode.City;
                END;
            end;  
        }
        field(8;"Fisc. Location Description"; Text[100])
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                ValidateFiscData;
            end;               
        }
        field(9;"Working Hours"; Text[100])
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                ValidateFiscData;
            end;              
        }
        field(10;"Date Of Application"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(11;"Fisc. No. Series"; Code[20])
        {
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
        field(12;"Fisc. Active"; Boolean)
        {
            Description = 'Active';
            DataClassification = CustomerContent;
        }
        field(13;"Creation Date"; Date)
        {
            Editable = False;
            DataClassification = CustomerContent;
        }
        field(14;"Creation Time"; Time)
        {
            Editable = False;
            DataClassification = CustomerContent;
        }
        field(15;"User ID"; Code[50])
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(16;"Ending Date"; Date)
        {
            Editable = false;
            DataClassification = CustomerContent;
        }
    }
    
    keys
    {
        key(PK; "Fisc. Location Code")
        {
            Clustered = true;
        }
    }
    
    var
        myInt: Integer;
    
    trigger OnInsert()
    begin
        "Creation Date" := TODAY;
        "Creation Time" := TIME;
        "User ID" := UserId();
    end;
    
    trigger OnModify()
    begin
        
    end;
    
    trigger OnDelete()
    begin
        
    end;
    
    trigger OnRename()
    begin
        ERROR('');
    end;
    
    procedure ValidateFiscData();
    var
      Text001: TextConst ENU='If you change this value location must be resubmited to provider. Do you wish to continue';
    begin
      IF (((Rec."Fisc. Street"<>xRec."Fisc. Street") OR
            (Rec."Fisc. House Number"<>xRec."Fisc. House Number") OR
            (Rec."Fisc. House Number Appendix"<>xRec."Fisc. House Number Appendix") OR
            (Rec."Fisc. Settlement"<>xRec."Fisc. Settlement") OR
            (Rec."Fisc. City/Municipality"<>xRec."Fisc. City/Municipality") OR
            (Rec."Fisc. Post Code"<>xRec."Fisc. Post Code") OR
            (Rec."Fisc. Location Description"<>xRec."Fisc. Location Description") OR
            (Rec."Working Hours"<>xRec."Working Hours")) AND
            (Rec."Fisc. Active"))
        THEN BEGIN
            IF GUIALLOWED THEN
                IF NOT CONFIRM(Text001,FALSE) THEN BEGIN
                    Rec:=xRec;
                    EXIT;
                END;
            "Fisc. Active":=FALSE;
        END;
    end;
}