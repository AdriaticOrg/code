pageextension 13062534 "PostedPurchaseCreditMemo-adl" extends "Posted Purchase Credit Memo"  //140
{
    layout
    {
        addlast(General)
        {
            field("VAT Date -adl"; "VAT Date-adl")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Postponed VAT -adl"; "Postponed VAT-adl")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
    }
}