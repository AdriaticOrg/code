pageextension 13062535 "VATEntries-Adl" extends "VAT Entries"  //315
{
    layout
    {
        addafter("Posting Date")
        {
            // <adl.10>
            field("Postponed VAT-Adl"; "Postponed VAT-Adl")
            {
                ApplicationArea = All;
                Editable = false;
            }
            // </adl.10>
        }
        addafter(Amount)
        {
            // <adl.14>
            field("VAT Identifier"; "VAT Identifier-Adl")
            {
                ApplicationArea = All;
                //Editable = false;
                TableRelation = "VAT Identifier-Adl";
            }
            // </adl.14>
        }
    }
}