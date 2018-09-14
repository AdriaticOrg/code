pageextension 13062786 Page44Ext extends "Sales Credit Memo"
{
    layout
    {
        addafter(Billing)
        {
            group(Fiscalization)
            {
                field("Fisc. Subject";"Fisc. Subject")
                {

                }
                field("Fisc. No. Series";"Fisc. No. Series")
                {

                }
                field("Fisc. Terminal";"Fisc. Terminal")
                {

                }
                field("Fisc. Location Code";"Fisc. Location Code")
                {

                }

                field("Full Fisc. Doc. No.";"Full Fisc. Doc. No.")
                {

                }
            }
        }
    }
}