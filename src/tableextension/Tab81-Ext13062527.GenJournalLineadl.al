tableextension 13062527 "GenJournalLine-adl" extends "Gen. Journal Line" // 81
{
    fields
    {
        field(13062525; "VAT Date-adl"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'VAT Date';
            Editable = False;
        }
        field(13062526; "Postponed VAT-adl"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Postponed VAT';
            OptionMembers = "Realized VAT","Postponed VAT";
        }
    }
}