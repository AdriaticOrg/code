table 13062594 "VAT Book Group-Adl"
{

    Caption = 'VAT Book Group';
    DrillDownPageID = "VAT Book Groups-Adl";
    LookupPageID = "VAT Book Groups-Adl";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "VAT Book Code"; Code[20])
        {
            Caption = 'VAT Book Code';
            TableRelation = "VAT Book-Adl";
            DataClassification = CustomerContent;
        }
        field(2; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;

            trigger OnValidate();
            begin
                "Book Link Code" := "VAT Book Code" + '_' + Code;
            end;
        }
        field(3; "Description"; Text[250])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(4; "Group Type"; Option)
        {
            Caption = 'Group Type';
            OptionCaption = 'VAT Entries,Total';
            OptionMembers = "VAT Entries",Total;
            DataClassification = CustomerContent;

            trigger OnValidate();
            var
                VATBookGroupIdentifier: Record "VAT Book Group Identifier-Adl";
            begin
                if "Group Type" = "Group Type"::"VAT Entries" then begin
                    Totaling := '';
                    VATBookGroupIdentifier.SetRange("VAT Book Code", "VAT Book Code");
                    VATBookGroupIdentifier.SetRange("VAT Book Group Code", Code);
                    VATBookGroupIdentifier.DeleteAll(true);
                end;
            end;
        }
        field(5; "Totaling"; Text[250])
        {
            Caption = 'Totaling';
            DataClassification = CustomerContent;

            trigger OnLookup();
            var
                VATBookGroup: Record "VAT Book Group-Adl";
                VATBookGroupsPage: Page "VAT Book Groups-Adl";
            begin
                if "Group Type" = "Group Type"::"VAT Entries" then
                    exit;
                //VATBookGroup.SetRange("VAT Book Code","VAT Book Code");
                VATBookGroup.SetCurrentKey("Book Link Code");
                VATBookGroupsPage.SETTABLEVIEW(VATBookGroup);
                VATBookGroupsPage.LookupMode(true);
                if (VATBookGroupsPage.RunModal() = ACTION::LookupOK) then
                    Totaling := VATBookGroupsPage.GetSelectionFilter();
                Modify();
            end;

        }
        field(6; "Book Link Code"; Code[41])
        {
            Caption = 'Book Link Code';
            Editable = false;
            DataClassification = CustomerContent;
        }
        field(7; "Tag Name"; Text[100])
        {
            Caption = 'Tag Name';
            DataClassification = CustomerContent;
        }
        field(8; "Include Columns"; Text[250])
        {
            Caption = 'Include Columns';
            DataClassification = SystemMetadata;

            trigger OnLookup();
            var
                VATBookColumnName: Record "VAT Book Column Name-Adl";
                VATBookColumnNames: Page "VAT Book Column Names-Adl";
                VATBookColumnNameFilter: Text[250];
            begin
                VATBookColumnName.SETRANGE("VAT Book Code", "VAT Book Code");
                if VATBookColumnName.FINDSET() then begin
                    VATBookColumnNames.SetTableView(VATBookColumnName);
                    VATBookColumnNames.LookupMode(TRUE);
                    if VATBookColumnNames.RunModal() = "Action"::LookupOK then begin
                        VATBookColumnNames.SetSelection(VATBookColumnName);
                        VATBookColumnNameFilter := '';
                        VATBookColumnName.MARKEDONLY(TRUE);
                        if VATBookColumnName.FINDSET() then begin
                            repeat
                                if VATBookColumnNameFilter = '' then
                                    VATBookColumnNameFilter := CopyStr(FORMAT(VATBookColumnName."Column No."), 1, MaxStrLen(VATBookColumnNameFilter))
                                else
                                    VATBookColumnNameFilter += '|' + CopyStr(FORMAT(VATBookColumnName."Column No."), 1, MaxStrLen(VATBookColumnNameFilter));
                            until VATBookColumnName.NEXT() = 0;
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
        VATBookGroupIdentifier: Record "VAT Book Group Identifier-Adl";
}

