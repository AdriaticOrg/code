pageextension 50101 "PostedSalesInvoice-adl" extends "Posted Sales Invoice" //132
{
    layout
    {
        addafter("Posting Date")
        {
            field("VAT Date-adl"; "VAT Date-adl")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Postponed VAT-adl"; "Postponed VAT-adl")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
    }
}