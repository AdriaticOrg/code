table 13062582 "Goods Return Type-Adl"
{

    Caption = 'Goods Return Type';
    DrillDownPageID = "Goods Return Types-Adl";
    LookupPageID = "Goods Return Types-Adl";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(11; "VAT Bus. Posting Group"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'VAT Business Posting Group';
            TableRelation = "VAT Business Posting Group";
        }
        field(12; "VAT Prod. Posting Group"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'VAT Product Posting Group';
            TableRelation = "VAT Product Posting Group";
        }
        field(13; "New VAT Prod. Posting Group"; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'New VAT Product Posting Group';
            TableRelation = "VAT Product Posting Group";
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