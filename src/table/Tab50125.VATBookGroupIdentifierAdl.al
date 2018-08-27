table 50125 "VAT Book Group Identifier-Adl"
{
    Caption = 'VAT Book Group Identifier';
    DrillDownPageID = "VAT Book Group Identifiers-Adl";
    LookupPageID = "VAT Book Group Identifiers-Adl";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "VAT Book Code"; Code[20])
        {
            Caption = 'VAT Book Code';
            TableRelation = "VAT Book-Adl";
            DataClassification = CustomerContent;
        }
        field(2; "VAT Book Group Code"; Code[20])
        {
            Caption = 'VAT Book Group Code';
            NotBlank = true;
            TableRelation = "VAT Book Group-Adl".Code where ("VAT Book Code" = field ("VAT Book Code"));
            DataClassification = CustomerContent;
        }
        field(3; "VAT Identifier"; Code[10])
        {
            Caption = 'VAT Identifier';
            TableRelation = "VAT Identifier-Adl";
            DataClassification = CustomerContent;
        }
        field(4; Description; Text[250])
        {
            CalcFormula = Lookup ("VAT Identifier-Adl".Description where (Code = field ("VAT Identifier")));
            Caption = 'Description';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "VAT Book Code", "VAT Book Group Code", "VAT Identifier") { }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "VAT Book Code", "VAT Book Group Code", "VAT Identifier") { }
    }

    trigger OnDelete();
    begin
        VATBookViewFormula.SetRange("VAT Book Code", "VAT Book Code");
        VATBookViewFormula.SetRange("VAT Book Group Code", "VAT Book Group Code");
        VATBookViewFormula.SetRange("VAT Identifier", "VAT Identifier");
        VATBookViewFormula.DELETEALL;
    end;

    var
        VATBookViewFormula: Record "VAT Book View Formula-Adl";
}

