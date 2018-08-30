table 13062593 "VAT Book Column Name-Adl"
{
    Caption = 'VAT Book Column Name';
    DrillDownPageID = "VAT Book Column Names-Adl";
    LookupPageID = "VAT Book Column Names-Adl";
    DataClassification = CustomerContent;
    DataCaptionFields = "VAT Book Code", "Column No.";

    fields
    {
        field(1; "VAT Book Code"; Code[20])
        {
            Caption = 'VAT Book Code';
            TableRelation = "VAT Book-Adl";
            DataClassification = CustomerContent;
        }
        field(2; "Column No."; Integer)
        {
            Caption = 'Column No.';
            NotBlank = true;
            DataClassification = CustomerContent;
        }
        field(3; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "VAT Book Code", "Column No.") { }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "VAT Book Code", "Column No.", Description) { }
    }
}

