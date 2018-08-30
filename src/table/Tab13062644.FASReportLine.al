table 13062644 "FAS Report Line"
{
    Caption = 'FAS Report Line';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1;"Document No."; Code[20])
        {
            Caption = '"Document No."';
            TableRelation = "FAS Report Header"."No.";
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
        field(10; "AOP Code"; Code[10])
        {
            Caption = 'AOP Code';
            DataClassification = ToBeClassified;
        }
        field(11; "Sector Code"; Code[10])
        {
            Caption = 'Sector Code';
            TableRelation = "FAS Sector";
            DataClassification = ToBeClassified;                        
        }
        field(12; "Instrument Code"; Code[10])
        {
            TableRelation = "FAS Instrument";
            Caption = 'Instrument Code';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                Instrument:Record "FAS Instrument";
            begin
                if Instrument.get("Instrument Code") then begin
                    Description := Instrument.Description;
                    "AOP Code" := Instrument."AOP Code";
                end else
                    Clear(Description);                
            end;
        }
        
        field(15; "Amount"; Decimal)
        {
            Caption = 'Amount';
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
    
}