pageextension 13062537 "VATPostingSetupCard-Adl" extends "VAT Posting Setup Card"  //473
{
    layout
    {
        addafter("Purch. VAT Unreal. Account")
        {
            field("Purch VAT Postponed Account-Adl"; "Purch VAT Postponed Account-Adl")
            {
                ApplicationArea = All;
            }
        }
        addafter("Sales VAT Unreal. Account")
        {
            field("Sales VAT Postponed Account-Adl"; "Sales VAT Postponed Account-Adl")
            {
                ApplicationArea = All;
            }
        }
    }
}