pageextension 13062527 "Sales Credit Memo-Adl" extends "Sales Credit Memo" //44
{
    layout
    {
        // <adl.20>
        addafter(Billing)
        {
            group(Fiscalization)
            {
                field("Fisc. Subject-Adl";"Fisc. Subject-Adl")
                {

                }
                field("Fisc. No. Series-Adl";"Fisc. No. Series-Adl")
                {

                }
                field("Fisc. Terminal-Adl";"Fisc. Terminal-Adl")
                {

                }
                field("Fisc. Location Code-Adl";"Fisc. Location Code-Adl")
                {

                }

                field("Full Fisc. Doc. No.-Adl";"Full Fisc. Doc. No.-Adl")
                {

                }
            }
        }
        // </adl.20>
    }
}