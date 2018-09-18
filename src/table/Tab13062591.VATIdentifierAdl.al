table 13062591 "VAT Identifier-Adl"
{

    Caption = 'VAT Identifier';
    DrillDownPageID = "VAT Identifiers-Adl";
    LookupPageID = "VAT Identifiers-Adl";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
            DataClassification = CustomerContent;
        }
        field(2; "Description"; Text[250])
        {
            Caption = 'Description';
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

