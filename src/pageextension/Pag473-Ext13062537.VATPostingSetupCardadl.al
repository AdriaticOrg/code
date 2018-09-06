pageextension 13062537 "VATPostingSetupCard-Adl" extends "VAT Posting Setup Card"  //473
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
        addafter("Tax Category")
        {
            // <adl.11>
            field("VAT % (retrograde)-Adl"; "VAT % (retrograde)-Adl")
            {
                ApplicationArea = All;
            }
            // </adl.11>
        }
    }
}