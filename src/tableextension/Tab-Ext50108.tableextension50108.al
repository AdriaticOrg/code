tableextension 50108 "tableextension50108" extends "G/L Entry" 
{
    // version NAVW111.00.00.23572

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
    }
}
