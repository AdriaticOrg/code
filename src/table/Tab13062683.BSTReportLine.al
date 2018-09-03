table 13062683 "BST Report Line"
{
    Caption = 'BST Report Line';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = '"Document No."';
            TableRelation = "BST Report Header"."No.";
            DataClassification = ToBeClassified;
        }
        field(2; "Line No"; Integer)
        {
            Caption = 'Line No';
            DataClassification = ToBeClassified;
        }
        field(4; "BST Code"; Code[10])
        {
            Caption = 'BST Code';
            DataClassification = ToBeClassified;
            TableRelation = "BST Code" where ("Type"=const(Posting));

            trigger OnValidate()
            var
                BSTCode: Record "BST Code";
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
            DataClassification = ToBeClassified;
        }
        field(10; "BST Serial No."; Code[20])
        {
            Caption = 'BST Serial No.';
            DataClassification = ToBeClassified;
        }
        field(11; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            DataClassification = ToBeClassified;
            TableRelation = "Country/Region";

            trigger OnValidate()
            var
                Country: Record "Country/Region";
            begin
                if Country.get("Country/Region Code") then
                    "Country/Region No." := Country."Numeric Code"
                else
                    clear("Country/Region No.");
            end;
        }
        field(12; "Country/Region No."; Code[10])
        {
            Caption = 'Country/Region No.';
            DataClassification = ToBeClassified;
        }

        field(20; "Income Amount"; Decimal)
        {
            Caption = 'Income Amount';
            DataClassification = ToBeClassified;
        }
        field(21; "Expense Amount"; Decimal)
        {
            Caption = 'Expense Amount';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Document No.", "Line No")
        {
            Clustered = true;
        }
    }

}