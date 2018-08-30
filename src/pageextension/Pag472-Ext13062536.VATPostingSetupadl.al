pageextension 13062536 "VATPostingSetup-Adl" extends "VAT Posting Setup"  //472
{
    layout
    {
        addafter("Purch. VAT Unreal. Account")
        {
            field("Purch VAT Postponed Account-Adl"; "Purch VAT Postponed Account-Adl")
            {
                ApplicationArea = All;
            }
            field("Sales VAT Postponed Account-Adl"; "Sales VAT Postponed Account-Adl")
            {
                ApplicationArea = All;
            }
        }
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
    }
}