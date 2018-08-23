tableextension 50109 "tableextension50109" extends "G/L Account" 
{

    fields
    {
        field(50100;"FAS Instrument Code";Code[10])
        {
            Caption = 'FAS Instrument Code';
            DataClassification = ToBeClassified;
            TableRelation = "FAS Instrument";
        }
        field(50101;"FAS Sector Code";Code[10])
        {
            Caption = 'FAS Sector Code';
            DataClassification = ToBeClassified;
            TableRelation = "FAS Sector";
        }
        field(50102;"FAS Account";Boolean)
        {
            Caption = 'FAS Account';
            DataClassification = ToBeClassified;
        }
        field(50103;"FAS Sector Posting";Option)
        {
            Caption = 'FAS Sector Posting';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Code Mandatory,Same Code,No Code';
            OptionMembers = " ","Code Mandatory","Same Code","No Code";
        }
        field(50104;"FAS Instrument Posting";Option)
        {
            Caption = 'FAS Sector Posting';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Code Mandatory,Same Code,No Code';
            OptionMembers = " ","Code Mandatory","Same Code","No Code";
        }
    }
}

