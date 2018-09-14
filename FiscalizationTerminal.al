table 13062602 "Fiscalization Terminal-ADL"
{
    DataClassification = CustomerContent;
    fields
    {
        field(1;"Fisc. Terminal Code"; Text[30])
        {
            NotBlank = True;
            Description = 'Terminal Code';
            DataClassification = CustomerContent;
        }

       field(2;Name; Text[30])
        {
            DataClassification = CustomerContent;
        }
        
       field(3;"Fisc. No. Series"; code[20])
        {   
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
            trigger Onvalidate()
            var 
                FiscTerminal : Record "Fiscalization Terminal-ADL";
                Err001Txt: TextConst ENU='Serial No. %1 is already used for Room %2 and Cash Desk %3.';
            begin
                FiscTerminal.SETFILTER("Fisc. Terminal Code",'<>%1',"Fisc. Terminal Code");
                FiscTerminal.SETRANGE("Fisc. No. Series","Fisc. No. Series");
                IF FiscTerminal.FINDFIRST() THEN
                    ERROR(Err001txt,"Fisc. No. Series",FiscTerminal."Fisc. Location Code",FiscTerminal."Fisc. Terminal Code");

            end;
        }
       field(4;"Fisc. Location Code"; code[10])
        {
            TableRelation = "Fiscalization Location-ADL";
            DataClassification = CustomerContent;
        }
       field(5;"User ID"; code[50])
        {
            TableRelation = "User Setup";
            DataClassification = CustomerContent;
        }

       field(7;"Creation Date"; Date)
        {
            Editable = False;
            DataClassification = CustomerContent;
        }
        field(8;"Creation Time"; Time)
        {
            Editable = False;
            DataClassification = CustomerContent;
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
        "Creation Date" := TODAY();
        "Creation Time" := Time();
    end;
    
    trigger OnModify()
    begin
       "Creation Date" := TODAY();
        "Creation Time" := TIME();
        CASE TRUE OF
        // HR
        FiscalizationSetup.CountryCodeHR:
            "User ID" := USERID;
        END; 
    end;
    
    trigger OnDelete()
    begin
        
    end;
    
    trigger OnRename()
    begin
        
    end;
}