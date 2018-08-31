tableextension 13062542 "GenJournalLine-Adl" extends "Gen. Journal Line" // 81
{
    fields
    {
        // <adl.6>
        field(13062525; "VAT Date-Adl"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'VAT Date';
            Editable = False;
        }
        // </adl.6>
        // <adl.10>
        field(13062526; "Postponed VAT-Adl"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Postponed VAT';
            OptionMembers = "Realized VAT","Postponed VAT";
        }
        // </adl.10>
        // <adl.24>
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
        field(13062643;"Bal. FAS Instrument Code";Code[10])
        {
            Caption = 'Bal. FAS Instrument Code';
            DataClassification = ToBeClassified;
            TableRelation = "FAS Instrument";
        }
        field(13062644;"Bal. FAS Sector Code";Code[10])
        {
            Caption = 'Bal. FAS Sector Code';
            DataClassification = ToBeClassified;
            TableRelation = "FAS Sector";
        }        
        // </adl.24>
    }
}