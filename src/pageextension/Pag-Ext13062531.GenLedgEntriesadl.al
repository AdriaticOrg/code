pageextension 13062531 "GenLedgEntries-adl" extends "General Ledger Entries" 
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