pageextension 50110 "SalesInvoice-adl" extends "Sales Invoice" //43
{
    layout
    {
        addafter("Posting Date")
        {
            field("VAT Date-adl"; "VAT Date-adl")
            {
                ApplicationArea = All;
            }
            field("Postponed VAT-adl"; "Postponed VAT-adl")
            {
                ApplicationArea = All;
            }
        }
    }

}