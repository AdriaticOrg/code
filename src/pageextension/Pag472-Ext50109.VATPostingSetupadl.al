<<<<<<< HEAD
pageextension 50109 "VATPostingSetup-adl" extends "VAT Posting Setup"  //472
{
    layout
    {
        addlast(Content){
            field("Purch VAT Postponed Account -adl"; "Purch VAT Postponed Account -adl")
            {
                ApplicationArea = All;
            }
            field("Sales VAT Postponed Account -adl"; "Sales VAT Postponed Account -adl")
            {
                ApplicationArea = All;
            }
        }
    }
    
=======
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

>>>>>>> 45ddf7001e34a5b2d46ca0060252286904df8923
}