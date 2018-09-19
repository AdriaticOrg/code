pageextension 13062781 "Sales Quote-Adl" extends "Sales Quote" //41
{
    layout
    {
        // <adl.20>
        addafter("Shipping and Billing")
        {
            group(Fiscalization)
            {
                field("Fisc. Subject-Adl";"Fisc. Subject-Adl")
                {
                ApplicationArea = All;
                }
                field("Fisc. No. Series-Adl";"Fisc. No. Series-Adl")
                {
                ApplicationArea = All;
                }
                field("Fisc. Terminal-Adl";"Fisc. Terminal-Adl")
                {
                ApplicationArea = All;
                }
                field("Fisc. Location Code-Adl";"Fisc. Location Code-Adl")
                {
                ApplicationArea = All;
                }

                field("Full Fisc. Doc. No.-Adl";"Full Fisc. Doc. No.-Adl")
                {
                ApplicationArea = All;
                }
            }
        }
        // </adl.20>
    }
}