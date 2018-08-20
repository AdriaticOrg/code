pageextension 50102 "VAT Entries-adl" extends "VAT Entries" //315
{
    layout
    {
        addafter("Posting Date")
        {
            field("VAT Date-adl"; "VAT Date-adl")
            {
                ApplicationArea = All;
                Importance = Additional;
            }
        }
    }
}