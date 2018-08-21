pageextension 50106 "PostedPurchaseInvoice-adl" extends "Posted Purchase Invoice"  //138
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