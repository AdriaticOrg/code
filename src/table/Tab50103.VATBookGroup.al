table 50103 "VAT Book Group"
{

    CaptionML = ENU = 'VAT Book Group',
                SRM = 'Grupa knjige PDV-a';
    DrillDownPageID = "VAT Book Groups";
    LookupPageID = "VAT Book Groups";
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
        field(2; "Code"; Code[20])
        {
            CaptionML = ENU = 'Code',
                        SRM = 'Šifra';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                "Book Link Code" := "VAT Book Code" + '_' + Code;
            end;
        }
        field(3; Description; Text[250])
        {
            CaptionML = ENU = 'Description',
                        SRM = 'Opis';
            DataClassification = CustomerContent;
        }
        field(4; "Group Type"; Option)
        {
            CaptionML = ENU = 'Group Type',
                        SRM = 'Vrsta grupe';
            OptionCaptionML = ENU = 'VAT Entries,Total',
                              SRM = 'Stavke PDV-a,Zbir';
            OptionMembers = "VAT Entries", Total;
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                if "Group Type" = "Group Type"::"VAT Entries" then
                    Totaling := '';
            end;
        }
        field(5; Totaling; Text[250])
        {
            CaptionML = ENU = 'Totaling',
                        SRM = 'Sabiranje';
            DataClassification = CustomerContent;

            trigger OnLookup();
            var
                VATBookGroupsPage: Page "VAT Book Groups";
                VATBookGroup: Record "VAT Book Group";
            begin
                if "Group Type" = "Group Type"::"VAT Entries" then
                    exit;
                //VATBookGroup.SetRange("VAT Book Code","VAT Book Code");
                VATBookGroup.SetCurrentKey("Book Link Code");
                VATBookGroupsPage.SETTABLEVIEW(VATBookGroup);
                VATBookGroupsPage.LookupMode(true);
                if (VATBookGroupsPage.RunModal = ACTION::LookupOK) then
                    Totaling := VATBookGroupsPage.GetSelectionFilter;
                Modify;
            end;

        }
        field(6; "Book Link Code"; Code[41])
        {
            CaptionML = ENU = 'Book Link Code',
                        SRM = 'Šifra veze';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(7; "Tag Name"; Text[100])
        {
            CaptionML = ENU = 'Tag Name',
                        SRM = 'Naziv taga';
            DataClassification = CustomerContent;
        }
                field(8; "Include Columns"; Text[250])
        {

            CaptionML = ENU = 'Include Columns',
                        SRM = 'Uključi kolone';

            trigger OnLookup();
            var
                VATBookColumnName: Record "VAT Book Column Name";
                VATBookColumnNames: Page "VAT Book Column Names";
                VATBookColumnNameFilter: Text;
            begin
                VATBookColumnName.SETRANGE("VAT Book Code", "VAT Book Code");
                if VATBookColumnName.FINDSET then begin
                    VATBookColumnNames.SetTableView(VATBookColumnName);
                    VATBookColumnNames.LookupMode(TRUE);
                    if VATBookColumnNames.RunModal = "Action"::LookupOK then begin
                        VATBookColumnNames.SetSelection(VATBookColumnName);
                        VATBookColumnNameFilter := '';
                        VATBookColumnName.MARKEDONLY(TRUE);
                        if VATBookColumnName.FINDSET then begin
                            repeat
                                if VATBookColumnNameFilter = '' then
                                    VATBookColumnNameFilter := FORMAT(VATBookColumnName."Column No.")
                                else
                                    VATBookColumnNameFilter += '|' + FORMAT(VATBookColumnName."Column No.");
                            until VATBookColumnName.NEXT = 0;
                        "Include Columns" := VATBookColumnNameFilter;
                        end;
                    end;
                end;
            end;
        }
    }

    keys
    {
        key(Key1; "VAT Book Code", "Code") { }
        key(Key2; "Book Link Code") { }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "VAT Book Code", "Code", Description) { }
    }

    trigger OnDelete();
    begin
        VATBookGroupIdentifier.SetRange("VAT Book Code", "VAT Book Code");
        VATBookGroupIdentifier.SetRange("VAT Book Group Code", Code);
        VATBookGroupIdentifier.DELETEALL(true);
    end;

    var
        VATBookGroupIdentifier: Record "VAT Book Group Identifier";
}

