pageextension 13062536 "VATPostingSetup-Adl" extends "VAT Posting Setup"  //472
{
    layout
    {
        addafter("Purch. VAT Unreal. Account")
        {
            // <adl.10>
            field("Purch VAT Postponed Account-Adl"; "Purch VAT Postponed Account-Adl")
            {
                ApplicationArea = All;
            }
            field("Sales VAT Postponed Account-Adl"; "Sales VAT Postponed Account-Adl")
            {
                ApplicationArea = All;
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
        // <adl.22>
        addlast(Control1) {
            field("VIES Goods Sales";"VIES Goods Sales") {
                ApplicationArea = All;
            }
            field("VIES Service Sales";"VIES Service Sales") {
                ApplicationArea = All;
            }
        }
        // </adl.22>
    }
}