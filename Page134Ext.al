pageextension 13062630 Page134Ext extends "Posted Sales Credit Memo"
{
    layout
    {
        addafter("Shipping and Billing")
        {
            group(Fiscalization)
            {
                field("Fisc. Subject";"Fisc. Subject")
                {
                ApplicationArea = All;
                }
                field("Fisc. No. Series";"Fisc. No. Series")
                {
                ApplicationArea = All;
                }
                field("Fisc. Terminal";"Fisc. Terminal")
                {
                ApplicationArea = All;
                }
                field("Fisc. Location Code";"Fisc. Location Code")
                {
                ApplicationArea = All;
                }
                field("Fisc. Doc. No.";"Fisc. Doc. No.")
                {
                ApplicationArea = All;
                }
                field("Full Fisc. Doc. No.";"Full Fisc. Doc. No.")
                {
                ApplicationArea = All;
                }
                field("Posting TimeStamp";"Posting TimeStamp")
                {
                ApplicationArea = All;
                }
            }
        }
    }
}