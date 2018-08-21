pageextension 50107 "PostedPurchaseCreditMemo-adl" extends "Posted Purchase Credit Memo"  //140
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