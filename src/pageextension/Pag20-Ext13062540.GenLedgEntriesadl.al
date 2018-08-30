pageextension 13062540 "GenLedgEntries-adl" extends "General Ledger Entries"  //20
{
    layout
    {
        addlast(Control1) {
            field("FAS Instrument Code";"FAS Instrument Code") {
                ApplicationArea = All;
            }
            field("FAS Sector Code";"FAS Sector Code") {
                ApplicationArea = All;
            }
        }
        
    }
    
    actions
    {
    }
}