pageextension 13062539 "GLAccountCard-adl" extends "G/L Account Card" //17
{
    layout
    {
        // <adl.24>
        addlast(General) {
            field("FAS Account";"FAS Account") {
                ApplicationArea = All;                
            }
            field("FAS Sector Posting";"FAS Sector Posting") {
                ApplicationArea = All;
            }
            field ("FAS Instrument Posting";"FAS Instrument Posting") {
                ApplicationArea = All;
            }
            field("FAS Sector Code";"FAS Sector Code") {
                ApplicationArea = All;
            }
            field ("FAS Instrument Code";"FAS Instrument Code") {
                ApplicationArea = All;
            }
            // <adl.26>
            field("BST Value Posting";"BST Value Posting") {
                ApplicationArea = All;
            }
            field("BST Code";"BST Code") {
                ApplicationArea = All;
            }
            // </adl.26>
        }         
        // </adl.24>
    }
    
    actions
    {
    }
}