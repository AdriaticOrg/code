pageextension 13062536 "VATPostingSetup-adl" extends "VAT Posting Setup"  //472
{
    layout
    {
        addafter("Purch. VAT Unreal. Account")
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