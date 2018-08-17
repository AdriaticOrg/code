table 50100 "VAT Book Column Name"
{
    CaptionML = ENU = 'VAT Book Column Name',
                SRM = 'Naziv kolone knjige PDV-a';
    DrillDownPageID = "VAT Book Column Names";
    LookupPageID = "VAT Book Column Names";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "VAT Book Code"; Code[20])
        {
            CaptionML = ENU = 'VAT Book Code',
                        SRM = 'Šifra knjige PDV-a';
            TableRelation = "VAT Book";
            DataClassification = CustomerContent;
        }
        field(2; "Column No."; Integer)
        {
            Caption = 'Column No.';
            MinValue = 6;
            MaxValue = 20;
            DataClassification = CustomerContent;
        }
        field(3; Description; Text[50])
        {
            CaptionML = ENU = 'Description',
                        SRM = 'Opis';
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

