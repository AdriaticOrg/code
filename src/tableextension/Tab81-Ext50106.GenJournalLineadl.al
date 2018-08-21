tableextension 50106 "GenJournalLine-adl" extends "Gen. Journal Line"  //81
{
    fields
    {
        field(50000; "VAT Date -adl"; Date)
        {
            Caption = 'VAT Date';
        }
        field(50001; "Postponed VAT -adl"; Option)
        {
            Caption = 'Postponed VAT';
            OptionMembers = "Realized VAT","Postponed VAT";
        }
    }
}