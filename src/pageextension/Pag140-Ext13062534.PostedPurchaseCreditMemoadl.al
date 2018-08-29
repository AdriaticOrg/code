pageextension 13062534 "PostedPurchaseCreditMemo-Adl" extends "Posted Purchase Credit Memo"  //140
{
    layout
    {
        addlast(General)
        {
            field("VAT Date -Adl"; "VAT Date-Adl")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Postponed VAT -Adl"; "Postponed VAT-Adl")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
    }
}