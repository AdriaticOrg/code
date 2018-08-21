pageextension 50104 "PurchaseInvoice-adl" extends "Purchase Invoice"  //51
{
    layout
    {
        addlast(General){
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
    
}