pageextension 13062537 "VATPostingSetupCard-Adl" extends "VAT Posting Setup Card"  //473
{
    layout
    {
        addafter("Purch. VAT Unreal. Account")
        {
            // <adl.10>
            field("Purch VAT Postponed Account-Adl"; "Purch VAT Postponed Account-Adl")
            {
                ApplicationArea = All;
                TableRelation = "G/L Account";
            }
            // </adl.10>
        }
        addafter("Sales VAT Unreal. Account")
        {
            // <adl.10>
            field("Sales VAT Postponed Account-Adl"; "Sales VAT Postponed Account-Adl")
            {
                ApplicationArea = All;
                TableRelation = "G/L Account";
            }
            // </adl.10>
        }
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
    }
}