pageextension 50109 "VATPostingSetup-adl" extends "VAT Posting Setup" //472
{
    layout
    {
        addafter("Sales VAT Account")
        {
            field("Sales VAT Postponed Account-adl"; "Sales VAT Postponed Account-adl")
            {
                ApplicationArea = All;
                Importance = Additional;
            }
        }
    }

}