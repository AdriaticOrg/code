pageextension 13062540 "General Ledger Entries-Adl" extends "General Ledger Entries"  //20
{
    layout
    {
        addlast(Control1)
        {
            // <adl.20>
            field("Full Fisc. Doc. No.-Adl"; "Full Fisc. Doc. No.-Adl")
            {
                ApplicationArea = All;
            }
            // </adl.20>
        }
    }

}