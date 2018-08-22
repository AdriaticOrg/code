pageextension 50102 "PostedSalesCreditMemo-adl" extends "Posted Sales Credit Memo" //134
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