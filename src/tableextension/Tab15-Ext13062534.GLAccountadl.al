tableextension 13062534 "GLAccount-adl" extends "G/L Account"  //15
{

    fields
    {
        field(13062641;"FAS Instrument Code";Code[10])
        {
            Caption = 'FAS Instrument Code';
            DataClassification = ToBeClassified;
            TableRelation = "FAS Instrument";
        }
        field(13062642;"FAS Sector Code";Code[10])
        {
            Caption = 'FAS Sector Code';
            DataClassification = ToBeClassified;
            TableRelation = "FAS Sector";
        }
        field(13062643;"FAS Account";Boolean)
        {
            Caption = 'FAS Account';
            DataClassification = ToBeClassified;
        }
        field(13062644;"FAS Sector Posting";Option)
        {
            Caption = 'FAS Sector Posting';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Code Mandatory,Same Code,No Code';
            OptionMembers = " ","Code Mandatory","Same Code","No Code";
        }
        field(13062645;"FAS Instrument Posting";Option)
        {
            Caption = 'FAS Instrument Posting';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Code Mandatory,Same Code,No Code';
            OptionMembers = " ","Code Mandatory","Same Code","No Code";
        }
        field(13062681; "BST Value Posting"; Option)
        {
            OptionMembers = " ","None","Credit","Debit","Both";
            OptionCaption = ' ,None,Credit,Debit,Both';
            Caption = 'BST Value Posting';
            DataClassification = ToBeClassified;
        }
        field(13062682; "BST Code"; Code[10])
        {
            Caption = 'BST Code';
            DataClassification = ToBeClassified;
            TableRelation = "BST Code";
        }                   
    }
}

