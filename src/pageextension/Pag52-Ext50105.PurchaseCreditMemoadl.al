pageextension 50105 "PurchaseCreditMemo-adl" extends "Purchase Credit Memo"  //52
{
    layout
    {
        addlast(General)
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