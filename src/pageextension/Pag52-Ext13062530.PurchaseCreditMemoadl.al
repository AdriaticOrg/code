pageextension 13062530 "PurchaseCreditMemo-Adl" extends "Purchase Credit Memo"  //52
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