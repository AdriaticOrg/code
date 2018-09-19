table 13062684 "BST Setup-Adl"
{
    Caption = 'BST Setup';
    DataClassification = SystemMetadata;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = SystemMetadata;
        }
        field(30; "BST Report No. Series"; Code[20])
        {
            Caption = 'BST Report No. Series';
            DataClassification = SystemMetadata;
            TableRelation = "No. Series";
        }
        field(32; "BST Resp. User ID"; Text[100])
        {
            Caption = 'BST Resp. User ID';
            TableRelation = "User Setup";
            DataClassification = SystemMetadata;
        }
        field(35; "BST Prep. By User ID"; Text[100])
        {
            Caption = 'BST Prep. By User ID';
            TableRelation = "User Setup";
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        CoreSetup: Record "CoreSetup-Adl";
    begin
        CoreSetup.EnableFeature(CoreSetup."ADL Features"::BST);
    end;

    trigger OnDelete()
    var
        CoreSetup: Record "CoreSetup-Adl";
    begin
        CoreSetup.DisableFeature(CoreSetup."ADL Features"::BST);
    end;
}