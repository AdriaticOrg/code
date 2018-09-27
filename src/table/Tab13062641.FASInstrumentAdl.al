table 13062641 "FAS Instrument-Adl"
{
    Caption = 'FAS Instrument';
    LookupPageId = 13062641;

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            DataClassification = SystemMetadata;
            NotBlank = false;
        }
        field(2; "Description"; Text[200])
        {
            Caption = 'Description';
            DataClassification = SystemMetadata;
        }
        field(3; "Type"; Option)
        {
            Caption = 'Type';
            DataClassification = SystemMetadata;
            OptionCaption = 'Posting,Total';
            OptionMembers = Posting,Total;
        }
        field(4; "Totaling"; Text[80])
        {
            Caption = 'Totaling';
            DataClassification = SystemMetadata;
            TableRelation = IF (Type = CONST (Total)) "FAS Instrument-Adl".Code;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                if Type <> Type::Total then FIELDERROR(Type);
            end;
        }
        field(8; "Indentation"; Integer)
        {
            BlankZero = true;
            Caption = 'Indentation';
            DataClassification = SystemMetadata;
        }
        field(20; "AOP Code"; Code[10])
        {
            Caption = 'AOP Code';
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
    }

    fieldgroups
    {
    }
}
