pageextension 13062530 "GenJournal-adl" extends "General Journal"
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