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
        // <adl.13>
        addafter("VAT %")
        {
            field("VAT % (Informative)-Adl"; "VAT % (Informative)-Adl")
            {
                ApplicationArea = All;
            }
        }
        // </adl.13>
        // <adl.22>
        addlast(Control1)
        {
            field("VIES Goods Sales"; "VIES Goods Sales")
            {
                ApplicationArea = All;
            }
            field("VIES Service Sales"; "VIES Service Sales")
            {
                ApplicationArea = All;
            }
        }
        // </adl.22>
    }
}