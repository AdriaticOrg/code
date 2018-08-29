pageextension 13062535 "VATEntries-Adl" extends "VAT Entries"  //315
{
    layout
    {
        addafter("Posting Date")
        {
            field("VAT Date-Adl"; "VAT Date-Adl")
            {
                ApplicationArea = All;
            }
            field("Postponed VAT-Adl"; "Postponed VAT-Adl")
            {
                ApplicationArea = All;
            }
        }
    }
}