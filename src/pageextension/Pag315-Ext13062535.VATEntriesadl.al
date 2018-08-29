pageextension 13062535 "VATEntries-Adl" extends "VAT Entries"  //315
{
    layout
    {
        addafter("Posting Date")
        {
            field("Postponed VAT-Adl"; "Postponed VAT-Adl")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
        addafter(Amount)
        {
            field("VAT Identifier"; "VAT Identifier-Adl")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
    }
}