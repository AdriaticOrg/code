pageextension 13062526 "SalesInvoice-Adl" extends "Sales Invoice" //43
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