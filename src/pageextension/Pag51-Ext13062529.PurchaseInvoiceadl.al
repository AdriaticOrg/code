pageextension 13062529 "PurchaseInvoice-Adl" extends "Purchase Invoice"  //51
{
    layout
    {
        addlast(General)
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