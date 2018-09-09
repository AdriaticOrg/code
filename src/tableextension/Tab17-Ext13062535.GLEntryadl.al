tableextension 13062535 "GLEntry-adl" extends "G/L Entry" //17
{
    fields
    {
        // <adl.24>
        field(13062641; "FAS Instrument Code"; Code[10])
        {
            Caption = 'FAS Instrument Code';
            DataClassification = SystemMetadata;
            TableRelation = "FAS Instrument" where ("Type" = const (Posting));
        }
        field(13062642; "FAS Sector Code"; Code[10])
        {
            Caption = 'FAS Sector Code';
            DataClassification = SystemMetadata;
            TableRelation = "FAS Sector" where ("Type" = const (Posting));
        }
        field(13062643; "FAS Type"; Option)
        {
            Caption = 'FAS Type';
            OptionMembers = " ",Assets,Liabilities;
            OptionCaption = ' ,Assets,Liabilities';
            DataClassification = SystemMetadata;
        }
        // </adl.24>
        // <adl.26>
        field(13062681; "BST Code"; Code[10])
        {
            Caption = 'BST Code';
            DataClassification = SystemMetadata;
            TableRelation = "BST Code" where ("Type" = const (Posting));
        }
        // </adl.26>
    }
    // <adl.24>
    procedure CopyFASFields(BankAccount: Record "Bank Account")
    begin
        "FAS Instrument Code" := BankAccount."FAS Instrument Code";
        "FAS Sector Code" := BankAccount."FAS Sector Code";
    end;
    // </adl.24>
}

