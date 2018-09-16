tableextension 13062535 "G/L Entry-Adl" extends "G/L Entry" //17
{
    fields
    {
        // <adl.24>
        field(13062641; "FAS Instrument Code-Adl"; Code[10])
        {
            Caption = 'FAS Instrument Code';
            DataClassification = SystemMetadata;
            TableRelation = "FAS Instrument-Adl" where ("Type" = const (Posting));
        }
        field(13062642; "FAS Sector Code-Adl"; Code[10])
        {
            Caption = 'FAS Sector Code';
            DataClassification = SystemMetadata;
            TableRelation = "FAS Sector-Adl" where ("Type" = const (Posting));
        }
        field(13062643; "FAS Type-Adl"; Option)
        {
            Caption = 'FAS Type';
            OptionMembers = " ",Assets,Liabilities;
            OptionCaption = ' ,Assets,Liabilities';
            DataClassification = SystemMetadata;
        }
        // </adl.24>
        // <adl.26>
        field(13062681; "BST Code-Adl"; Code[10])
        {
            Caption = 'BST Code';
            DataClassification = SystemMetadata;
            TableRelation = "BST Code-Adl" where ("Type" = const (Posting));
        }
        // </adl.26>
    }

    keys
    {
        // <adl.24>
        key(FAS; "FAS Type-Adl", "FAS Instrument Code-Adl", "FAS Sector Code-Adl") { }
        // </adl.24>
    }

    // <adl.24>
    procedure CopyFASFields(BankAccount: Record "Bank Account")
    begin
        "FAS Instrument Code-Adl" := BankAccount."FAS Instrument Code-Adl";
        "FAS Sector Code-Adl" := BankAccount."FAS Sector Code-Adl";
    end;
    // </adl.24>
}

