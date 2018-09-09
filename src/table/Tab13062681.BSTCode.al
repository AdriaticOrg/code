table 13062681 "BST Code"
{
    DataClassification = SystemMetadata;
    LookupPageId = 13062681;
    Caption = 'BST Code';

    fields
    {
        field(1; Code; Code[10])
        {
            Caption = 'Code';
            DataClassification = SystemMetadata;
        }
        field(2; "Serial Num."; Code[20])
        {
            Caption = 'Serial Num.';
            DataClassification = SystemMetadata;
        }
        field(3; "Description"; Text[100])
        {
            Caption = 'Description';
            DataClassification = SystemMetadata;
        }
        field(4; Totaling; Text[80])
        {
            Caption = 'Totaling';
            DataClassification = SystemMetadata;
        }
        field(5; "Type"; Option)
        {
            Caption = 'Type';
            OptionMembers = "Posting","Total";
            DataClassification = SystemMetadata;
        }
        field(6; "Indentation"; Integer)
        {
            Caption = 'Indentation';
            DataClassification = SystemMetadata;
        }

    }

    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
    }

}