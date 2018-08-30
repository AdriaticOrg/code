tableextension 13062542 "GenJournalLine-Adl" extends "Gen. Journal Line" // 81
{
    fields
    {
        field(13062525; "VAT Date-Adl"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'VAT Date';
            Editable = False;
        }
        field(13062526; "Postponed VAT-Adl"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Postponed VAT';
            OptionMembers = "Realized VAT","Postponed VAT";
        }
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
    }
}