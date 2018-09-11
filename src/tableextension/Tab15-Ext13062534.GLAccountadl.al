tableextension 13062534 "G/L Account-Adl" extends "G/L Account"  //15
{
    fields
    {
        // <adl.24>
        field(13062641; "FAS Instrument Code-Adl"; Code[10])
        {
            Caption = 'FAS Instrument Code';
            DataClassification = SystemMetadata;
            TableRelation = "FAS Instrument" where ("Type" = const (Posting));
        }
        field(13062642; "FAS Sector Code-Adl"; Code[10])
        {
            Caption = 'FAS Sector Code';
            DataClassification = SystemMetadata;
            TableRelation = "FAS Sector" where ("Type" = const (Posting));
        }
        field(13062643; "FAS Account-Adl"; Boolean)
        {
            Caption = 'FAS Account';
            DataClassification = SystemMetadata;
        }
        field(13062644; "FAS Sector Posting-Adl"; Option)
        {
            Caption = 'FAS Sector Posting';
            DataClassification = SystemMetadata;
            OptionCaption = ' ,Code Mandatory,Same Code,No Code';
            OptionMembers = " ","Code Mandatory","Same Code","No Code";
        }
        field(13062645; "FAS Instrument Posting-Adl"; Option)
        {
            Caption = 'FAS Instrument Posting';
            DataClassification = SystemMetadata;
            OptionCaption = ' ,Code Mandatory,Same Code,No Code';
            OptionMembers = " ","Code Mandatory","Same Code","No Code";
        }
        field(13062646; "FAS Type-Adl"; Option)
        {
            Caption = 'FAS Type';
            OptionMembers = " ",Assets,Liabilities;
            OptionCaption = ' ,Assets,Liabilities';
            DataClassification = SystemMetadata;
        }

        // </adl.24>
        // <adl.26>
        field(13062681; "BST Value Posting-Adl"; Option)
        {
            OptionMembers = " ","None","Credit","Debit","Both";
            OptionCaption = ' ,None,Credit,Debit,Both';
            Caption = 'BST Value Posting';
            DataClassification = SystemMetadata;
        }
        field(13062682; "BST Code-Adl"; Code[10])
        {
            Caption = 'BST Code';
            DataClassification = SystemMetadata;
            TableRelation = "BST Code" where (Type = const (Posting));
        }
        // </adl.26>
    }
}

