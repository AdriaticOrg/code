pageextension 50109 "VATPostingSetup-adl" extends "VAT Posting Setup"  //472
{
    layout
    {
        addlast(Content)
        {
            field("Purch VAT Postponed Account-adl"; "Purch VAT Postponed Account-adl")
            {
                ApplicationArea = All;
            }
            field("Sales VAT Postponed Account-adl"; "Sales VAT Postponed Account-adl")
            {
                ApplicationArea = All;
            }
        }
    }
}