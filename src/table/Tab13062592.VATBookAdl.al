table 13062592 "VAT Book-Adl"
{

    Caption = 'VAT Book';
    DataCaptionFields = "Code", Description;
    DrillDownPageID = "VAT Books-Adl";
    LookupPageID = "VAT Books-Adl";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[20])
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
        field(3; "Include in XML"; Boolean)
        {
            Caption = 'Include in XML';
            DataClassification = CustomerContent;
        }
        field(4; "Sorting Appearance"; Code[20])
        {
            Caption = 'Sorting Appearance';
            DataClassification = CustomerContent;
        }
        field(5; "Tag Name"; Text[30])
        {
            Caption = 'Tag Name';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Code") { }
        key(Key2; "Sorting Appearance") { }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Code", Description) { }
    }

    trigger OnDelete();
    begin
        VATReportColumnName.SetRange("VAT Book Code", Code);
        VATReportColumnName.DeleteAll();

        VATBookGroup.SetRange("VAT Book Code", Code);
        VATBookGroup.DeleteAll(true);
    end;

    var
        VATReportColumnName: Record "VAT Book Column Name-Adl";
        VATBookGroup: Record "VAT Book Group-Adl";
}

