pageextension 13062785 "Sales Invoice-Adl" extends "Sales Invoice" //43
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

                field("Full Fisc. Doc. No.";"Full Fisc. Doc. No.")
                {
                ApplicationArea = All;
                }
            }
        }
    }
}