pageextension 13062535 "VATEntries-adl" extends "VAT Entries"  //315
{
    layout
    {
        addafter("Posting Date")
        {
            field("VAT Date-adl"; "VAT Date-adl")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Postponed VAT-adl"; "Postponed VAT-adl")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
    }
}