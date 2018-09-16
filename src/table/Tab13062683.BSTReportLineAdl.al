table 13062683 "BST Report Line-Adl"
{
    Caption = 'BST Report Line';
    DataClassification = SystemMetadata;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = '"Document No."';
            TableRelation = "BST Report Header-Adl"."No.";
            DataClassification = SystemMetadata;
        }
        field(2; "Line No"; Integer)
        {
            Caption = 'Line No';
            DataClassification = SystemMetadata;
        }
        field(4; "BST Code"; Code[10])
        {
            Caption = 'BST Code';
            DataClassification = SystemMetadata;
            TableRelation = "BST Code-Adl" where ("Type" = const (Posting));

            trigger OnValidate()
            var
                BSTCode: Record "BST Code-Adl";
            begin
                if BSTCode.get("BST Code") then begin
                    "BST Serial No." := BSTCode."Serial Num.";
                    Description := BSTCode.Description;
                end;
            end;
        }

        field(5; "Description"; Text[120])
        {
            Caption = 'Description';
            DataClassification = SystemMetadata;
        }
        field(10; "BST Serial No."; Code[20])
        {
            Caption = 'BST Serial No.';
            DataClassification = SystemMetadata;
        }
        field(11; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            DataClassification = SystemMetadata;
            TableRelation = "Country/Region";

            trigger OnValidate()
            var
                Country: Record "Country/Region";
            begin
                if Country.get("Country/Region Code") then
                    "Country/Region No." := Country."Numeric Code-Adl"
                else
                    clear("Country/Region No.");
            end;
        }
        field(12; "Country/Region No."; Code[10])
        {
            Caption = 'Country/Region No.';
            DataClassification = SystemMetadata;
        }

        field(20; "Income Amount"; Decimal)
        {
            Caption = 'Income Amount';
            DataClassification = SystemMetadata;
        }
        field(21; "Expense Amount"; Decimal)
        {
            Caption = 'Expense Amount';
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(PK; "Document No.", "Line No")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        TestHeadStatusOpen();
    end;

    trigger OnModify()
    begin
        TestHeadStatusOpen();
    end;

    trigger OnDelete()
    begin
        TestHeadStatusOpen();
    end;

    local procedure TestHeadStatusOpen()
    var
        BSTRepHead: Record "BST Report Header-Adl";
    begin
        BSTRepHead.TestStatusOpen("Document No.");
    end;
}