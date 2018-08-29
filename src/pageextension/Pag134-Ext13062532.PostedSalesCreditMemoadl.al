pageextension 13062532 "PostedSalesCreditMemo-Adl" extends "Posted Sales Credit Memo" //134
{
    layout
    {
        addafter("Posting Date")
        {
            field("VAT Date-Adl"; "VAT Date-Adl")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Postponed VAT-Adl"; "Postponed VAT-Adl")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
    }
}