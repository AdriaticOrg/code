pageextension 13062525 "SalesOrder-Adl" extends "Sales Order" //42
{
    layout
    {
        addafter("Posting Date")
        {
            field("VAT Date-Adl"; "VAT Date-Adl")
            {
                ApplicationArea = All;
            }
            field("Postponed VAT-Adl"; "Postponed VAT-Adl")
            {
                ApplicationArea = All;
            }
        }
    }
}