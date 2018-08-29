pageextension 13062527 "SalesCreditMemo-Adl" extends "Sales Credit Memo" //44
{
    layout
    {
        addafter("Posting Date")
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