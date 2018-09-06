pageextension 13062536 "VATPostingSetup-Adl" extends "VAT Posting Setup"  //472
{
    layout
    {
        // <adl.14>
        modify("VAT Identifier")
        {
            Visible = false;
        }
        addafter("VAT Identifier")
        {
            field("VAT Identifier-Adl"; "VAT Identifier")
            {
                ApplicationArea = All;
                TableRelation = "VAT Identifier-Adl";
            }
            // <adl.11>
            field("VAT % (retrograde)-Adl"; "VAT % (retrograde)-Adl")
            {
                ApplicationArea = All;
            }
            // </adl.11>
        }
        // </adl.14>
    }
}