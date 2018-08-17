table 50105 "VAT Book Group Identifier"
{
    CaptionML = ENU = 'VAT Book Group Identifier',
                SRM = 'Identifikator grupe knjige PDV-a';
    DrillDownPageID = "VAT Book Group Identifiers";
    LookupPageID = "VAT Book Group Identifiers";
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
        field(2; "VAT Book Group Code"; Code[20])
        {
            CaptionML = ENU = 'VAT Book Group Code',
                        SRM = 'Šifra grupe knjige PDV-a';
            NotBlank = true;
            TableRelation = "VAT Book Group".Code where ("VAT Book Code" = field ("VAT Book Code"));
            DataClassification = CustomerContent;
        }
        field(3; "VAT Identifier"; Code[10])
        {
            CaptionML = ENU = 'VAT Identifier',
                        SRM = 'Identifikator za PDV';
            TableRelation = "VAT Identifier";
            DataClassification = CustomerContent;
        }
        field(4; Description; Text[250])
        {
            CalcFormula = Lookup ("VAT Identifier".Description where (Code = field ("VAT Identifier")));
            CaptionML = ENU = 'Description',
                        SRM = 'Opis';
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
        VATBookViewLine.SetRange("VAT Book Code", "VAT Book Code");
        VATBookViewLine.SetRange("VAT Book Group Code", "VAT Book Group Code");
        VATBookViewLine.SetRange("VAT Identifier", "VAT Identifier");
        VATBookViewLine.DELETEALL;
    end;

    var
        VATBookViewLine: Record "VAT Book View Line";
}

