<<<<<<< HEAD
pageextension 50108 "VATEntries-adl" extends "VAT Entries"  //315
{
    layout
    {
        addafter("Posting Date"){
         field("VAT Date -adl"; "VAT Date -adl")
            {
                ApplicationArea = All;
            }
        field("Postponed VAT -adl"; "Postponed VAT -adl")
            {
                ApplicationArea = All;
            }
        }
    }
    
=======
pageextension 50108 "VATEntries-adl" extends "VAT Entries" //315
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
>>>>>>> 45ddf7001e34a5b2d46ca0060252286904df8923
}