table 13062596 "VAT Book View Formula-Adl"
{

    Caption = 'VAT Book View Line';
    DrillDownPageID = "VAT Book View Formula-Adl";
    LookupPageID = "VAT Book View Formula-Adl";
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
            TableRelation = "VAT Book Group Identifier-Adl"."VAT Identifier" where ("VAT Book Code" = field ("VAT Book Code"), "VAT Book Group Code" = field ("VAT Book Group Code"));
            DataClassification = CustomerContent;
        }
        field(4; "Column No."; Integer)
        {
            Caption = 'Column No.';
            MinValue = 1;
            DataClassification = CustomerContent;
        }
        field(5; "Operator1"; Option)
        {
            Caption = 'Operator 1';
            OptionCaption = ' ,+,-';
            OptionMembers = " ","+","-";
            DataClassification = CustomerContent;
        }
        field(6; "Value1"; Option)
        {
            Caption = 'Value 1';
            OptionCaption = ' ,Base Amount,VAT Amount,Amount Inc. VAT,Base Amount(retro.),Unrealizied Base,Unrealized Amount,Unrealized Amount Inc. VAT,VAT Retro,Amount Inc. VAT(retro)';
            OptionMembers = " ","Base Amount","VAT Amount","Amount Inc. VAT","Base Amount(retro.)","Unrealizied Base","Unrealized Amount","Unrealized Amount Inc. VAT","VAT Retro","Amount Inc. VAT(retro)";
            DataClassification = CustomerContent;
        }
        field(7; "Operator2"; Option)
        {
            Caption = 'Operator 2';
            OptionCaption = ' ,+,-';
            OptionMembers = " ","+","-";
            DataClassification = CustomerContent;
        }
        field(8; "Value2"; Option)
        {
            Caption = 'Value 2';
            OptionCaption = ' ,Base Amount,VAT Amount,Amount Inc. VAT,Base Amount(retro.),Unrealizied Base,Unrealized Amount,Unrealized Amount Inc. VAT,VAT Retro,Amount Inc. VAT(retro)';
            OptionMembers = " ","Base Amount","VAT Amount","Amount Inc. VAT","Base Amount(retro.)","Unrealizied Base","Unrealized Amount","Unrealized Amount Inc. VAT","VAT Retro","Amount Inc. VAT(retro)";
            DataClassification = CustomerContent;
        }

        field(9; "Condition"; Text[250])
        {
            Caption = 'Condition';
            DataClassification = CustomerContent;
        }

        field(10; "ConditionBlob"; Blob)
        {
            Caption = 'ConditonBlob';
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(Key1; "VAT Book Code", "VAT Book Group Code", "VAT Identifier", "Column No.") { }
    }

    procedure SetFiltersForVATEntry()
    var
        TempBlob: Record TempBlob temporary;
        RequestPageParametersHelper: Codeunit "Request Page Parameters Helper";
        FilterPageBuilder1: FilterPageBuilder;
        RecRef: RecordRef;
        Filters: Text;
        TOutStream: OutStream;
        TitleLbl: Label 'Please choose VAT Entry filter';
    begin
        RecRef.Open(Database::"VAT Entry");

        IF not RequestPageParametersHelper.BuildDynamicRequestPage(FilterPageBuilder1, '~', Database::"VAT Entry") then
            exit;

        FilterPageBuilder1.PageCaption := TitleLbl;
        if not FilterPageBuilder1.RUNMODAL() then
            exit;

        Filters := RequestPageParametersHelper.GetViewFromDynamicRequestPage(FilterPageBuilder1, '', Database::"VAT Entry");

        TempBlob.Init();
        TempBlob.Blob.CreateOutStream(TOutStream);
        TOutStream.WriteText(Filters);

        RequestPageParametersHelper.ConvertParametersToFilters(RecRef, TempBlob);
        Condition := CopyStr(RecRef.GetFilters(), 1, MAXSTRLEN(Condition));
        ConditionBlob := TempBlob.Blob;
    end;

    procedure SetVATEntryFilters(var VATEntry: Record "VAT Entry");
    var
        TempBlob: Record TempBlob temporary;
        RequestPageParametersHelper: Codeunit "Request Page Parameters Helper";
        RecRef: RecordRef;
    begin
        RecRef.Open(Database::"VAT Entry");
        CalcFields(ConditionBlob);
        if ConditionBlob.Length() = 0 then
            exit;

        TempBlob.Init();
        TempBlob.Blob := ConditionBlob;

        RequestPageParametersHelper.ConvertParametersToFilters(RecRef, TempBlob);
        VATEntry.FilterGroup(10);
        VATEntry.SetView(RecRef.GetView());
        VATEntry.FilterGroup(0);
    end;
}

