table 13062641 "FAS Instrument"
{
    Caption = 'FAS Instrument';
    LookupPageId = 13062641;

    fields
    {
        field(1;"Code";Code[10])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
            NotBlank = false;
        }
        field(2;Description;Text[200])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(3;Type;Option)
        {
            Caption = 'Type';
            DataClassification = ToBeClassified;
            OptionCaption = 'Posting,Total';
            OptionMembers = Posting,Total;
        }
        field(4;Totaling;Text[80])
        {
            Caption = 'Totaling';
            DataClassification = ToBeClassified;
            TableRelation = IF (Type=CONST(Total)) "FAS Instrument".Code;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                if Type<>Type::Total then FIELDERROR(Type);
            end;
        }
        field(8;Indentation;Integer)
        {
            BlankZero = true;
            Caption = 'Indentation';
            DataClassification = ToBeClassified;
        }
        field(20;"AOP Code";Code[10])
        {
            Caption = 'AOP Code';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1;"Code")
        {
        }
    }

    fieldgroups
    {
    }
}

