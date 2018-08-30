tableextension 13062535 "GLEntry-adl" extends "G/L Entry" //17
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
        field(13062681; "BST Code"; Code[10])
        {
            Caption = 'BST Code';
            DataClassification = ToBeClassified;
            TableRelation = "BST Code";
        }         
    }
}

