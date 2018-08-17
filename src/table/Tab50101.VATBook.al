table 50101 "VAT Book"
{

    CaptionML = ENU = 'VAT Book',
                SRM = 'Knjiga PDV-a';
    DataCaptionFields = "Code", Description;
    DrillDownPageID = "VAT Books";
    LookupPageID = "VAT Books";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[20])
        {
            CaptionML = ENU = 'Code',
                        SRM = 'Šifra';
            NotBlank = true;
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[250])
        {
            CaptionML = ENU = 'Description',
                        SRM = 'Opis';
            DataClassification = CustomerContent;
        }
        field(3; "Include in XML"; Boolean)
        {
            CaptionML = ENU = 'Include in XML',
                        SRM = 'Uključi u XML';
            DataClassification = CustomerContent;
        }
        field(4; "Sorting Appearance"; Code[20])
        {
            CaptionML = ENU = 'Sorting Appearance',
                        SRM = 'Redosled sortiranja';
            DataClassification = CustomerContent;
        }
        field(5; "Tag Name"; Text[30])
        {
            CaptionML = ENU = 'Tag Name',
                        SRM = 'Naziv taga';
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
        VATReportColumnName.DeleteAll;

        VATBookGroup.SetRange("VAT Book Code", Code);
        VATBookGroup.DeleteAll(true);
    end;

    var
        VATReportColumnName: Record "VAT Book Column Name";
        VATBookGroup: Record "VAT Book Group";
}

