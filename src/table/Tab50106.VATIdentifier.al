table 50106 "VAT Identifier"
{

    CaptionML = ENU = 'VAT Identifier',
                SRM = 'Identifikator za PDV';
    DrillDownPageID = "VAT Identifiers";
    LookupPageID = "VAT Identifiers";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[10])
        {
            CaptionML = ENU = 'Code',
                        SRM = 'Šifra';
            NotBlank = true;
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[250])
        {
            CaptionML = ENU = 'Description',
                        SRM = 'Opis';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Code") { }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Code", Description) { }
    }
}

