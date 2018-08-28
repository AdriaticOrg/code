pageextension 50112 "VATPostingSetupCard-adl" extends "VAT Posting Setup Card"  //473
{
    layout
    {
        addafter("Purch. VAT Unreal. Account")
        {
            field("Purch VAT Postponed Account-adl"; "Purch VAT Postponed Account-adl")
            {
                ApplicationArea = All;
            }
        }
         addafter("Sales VAT Unreal. Account")
        {
            field("Sales VAT Postponed Account-adl"; "Sales VAT Postponed Account-adl")
            {
                ApplicationArea = All;
            }
        }
    }
}