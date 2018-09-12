table 13062602 "Fiscalization Terminal-ADL"
{
    DataClassification = SystemMetadata;
    fields
    {
        field(1;"Fisc. Terminal Code"; Text[30])
        {
            NotBlank = True;
            Description = 'Terminal Code';
            DataClassification = SystemMetadata;
        }

       field(2;Name; Text[30])
        {
            DataClassification = SystemMetadata;
        }
        
       field(3;"Fisc. No. Series"; code[20])
        {   
            TableRelation = "No. Series";
            DataClassification = SystemMetadata;
            trigger Onvalidate()
            var FiscTerminal : Record "Fiscalization Terminal-ADL";
            Text001: TextConst ENU='Serial No. %1 is already used for Room %2 and Cash Desk %3.';
            begin
                FiscTerminal.SETFILTER("Fisc. Terminal Code",'<>%1',"Fisc. Terminal Code");
                FiscTerminal.SETRANGE("Fisc. No. Series","Fisc. No. Series");
                IF FiscTerminal.FINDFIRST THEN
                ERROR(Text001,"Fisc. No. Series",FiscTerminal."Fisc. Location Code",FiscTerminal."Fisc. Terminal Code");
            end;
        }
       field(4;"Fisc. Location Code"; code[10])
        {
            TableRelation = "Fiscalization Location-ADL";
            DataClassification = SystemMetadata;
        }
       field(5;"User ID"; code[50])
        {
            TableRelation = "User Setup";
            DataClassification = SystemMetadata;
        }
       field(6;"Computer Name"; text[50])
        {
            trigger OnValidate()
            var 
              FiscalizationSetup: Record "Fiscalization Setup-ADL"; 
              FiscalizationTerminal: Record "Fiscalization Terminal-ADL";
              Text002: TextConst ENU='Computer is already assigned to Cash Desk.';
            begin
                //"Computer Name" := FiscDataMan.GetComputerName;
                FiscalizationSetup.GET;
                CASE TRUE OF
                // SI
                FiscalizationSetup.CountryCodeSI:
                    BEGIN
                    FiscalizationTerminal.SETRANGE("Computer Name","Computer Name");
                    IF FiscalizationTerminal.FINDFIRST THEN
                        ERROR(Text002);
                    END;
                // HR
                FiscalizationSetup.CountryCodeHR:
                    BEGIN
                    END;
                END;
            end;
            
        }
       field(7;"Creation Date"; Date)
        {
            Editable = False;
            DataClassification = SystemMetadata;
        }
        field(8;"Creation Time"; Time)
        {
            Editable = False;
            DataClassification = SystemMetadata;
        }
    }
    
    keys
    {
        key(PK; "Fisc. Terminal Code","Fisc. Location Code","User ID")
        {
            Clustered = true;
        }
        key(SK;Name)
        {

        }
    }
    
    var FiscalizationSetup: Record "Fiscalization Setup-ADL"; 
    trigger OnInsert()
    begin
        "Creation Date" := TODAY;
        "Creation Time" := Time;
        FiscalizationSetup.GET;
        CASE TRUE OF
        // SI
        FiscalizationSetup.CountryCodeSI:
            BEGIN
            END;
        // HR
        FiscalizationSetup.CountryCodeHR:
            BEGIN
        //    "User ID" := USERID;
            END;
        END;
    end;
    
    trigger OnModify()
    begin
       "Creation Date" := TODAY;
        "Creation Time" := TIME;
        CASE TRUE OF
        // SI
        FiscalizationSetup.CountryCodeSI:
            BEGIN
            END;
        // HR
        FiscalizationSetup.CountryCodeHR:
            BEGIN
            "User ID" := USERID;
            END;
        END; 
    end;
    
    trigger OnDelete()
    begin
        
    end;
    
    trigger OnRename()
    begin
        
    end;
    
}