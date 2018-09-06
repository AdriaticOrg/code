table 13062622 "PDO Report Line"
{
    Caption = 'PDO Report Line';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1;"Document No."; Code[20])
        {
            Caption = '"Document No."';
            TableRelation = "PDO Report Header"."No.";
            DataClassification = ToBeClassified;
        }
        field(2; "Line No"; Integer)
        {
            Caption = 'Line No';
            DataClassification = ToBeClassified;
        }
        field(5; "Description"; Text[120])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(10; "Type"; Option)
        {
            Caption = 'Type';
            OptionMembers = New,Correction;
            OptionCaption = 'New,Correction';
            DataClassification = ToBeClassified;
        }
        field(14; "Applies-to Report No."; Code[20])
        {
            Caption = 'Applies-to Report No.';
            DataClassification = ToBeClassified;
        }
        field(20; "Period Year"; Integer)
        {
            Caption = 'Period Year';
            DataClassification = ToBeClassified;
        }
        field(21; "Period Round"; Integer)
        {
            Caption = 'Period Round';
            DataClassification = ToBeClassified;
        }
        
        field(24; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            DataClassification = ToBeClassified;
            TableRelation = "Country/Region";

            trigger OnValidate()
            var
                Country: Record "Country/Region";
            begin
                if Country.get("Country/Region Code") then
                    "Country/Region No." := Country."Numeric Code"
                else
                    clear("Country/Region No.");
            end;
        }
        field(25; "Country/Region No."; code[10])
        {
            Caption = 'Country/Region No.';
            DataClassification = ToBeClassified;
        }      
        field(30; "VAT Registration No."; Text[20])
        {
            Caption = 'VAT Registration No.';
            DataClassification = ToBeClassified;
        }       
        field(45; "Amount (LCY)"; Decimal)
        {
            Caption = 'Amount (LCY)';
            DataClassification = ToBeClassified;
        }                                
    }
    
    keys
    {
        key(PK; "Document No.","Line No")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        TestHeadStatusOpen();
    end;

    trigger OnModify()
    begin
        TestHeadStatusOpen();
    end;    

    trigger OnDelete()
    begin
        TestHeadStatusOpen();
    end;

    local procedure TestHeadStatusOpen()  
    var
        PDORepHead:Record "PDO Report Header";      
    begin
        PDORepHead.TestStatusOpen("Document No.");
    end;
    
}