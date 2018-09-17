table 13062664 "KRD Sector-Adl"
{
    Caption = 'KRD Sector';
    LookupPageId = 13062665;

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
            TableRelation = IF (Type = CONST (Total)) "KRD Sector-Adl".Code;
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
        field(9; "Show Credit/Debit"; Boolean)
        {
            Caption = 'Show Credit/Debit';
            DataClassification = SystemMetadata;
        }
        field(20; "Index Code"; Code[10])
        {
            Caption = 'Index Code';
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

