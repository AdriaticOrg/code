tableextension 13062527 "GenJournalLine-Adl" extends "Gen. Journal Line" // 81
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
    }
}