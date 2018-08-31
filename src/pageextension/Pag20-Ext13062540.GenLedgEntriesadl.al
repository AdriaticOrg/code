pageextension 13062540 "GenLedgEntries-adl" extends "General Ledger Entries"  //20
{
    layout
    {
        // <adl.24>
        addlast(Control1) {
            field("FAS Instrument Code";"FAS Instrument Code") {
                ApplicationArea = All;
            }
            field("FAS Sector Code";"FAS Sector Code") {
                ApplicationArea = All;
            }
            // <adl.26>
            field("BST Code";"BST Code") {
                ApplicationArea = All;
            }
            // <adl.26>
        }
        // </adl.24>
    }
    
    actions
    {
    }
}