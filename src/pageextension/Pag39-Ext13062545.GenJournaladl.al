pageextension 13062545 "GenJournal-adl" extends "General Journal" //39
{
    layout
    {
        addlast(Control1) {
        // <adl.24>
            field("FAS Instrument Code";"FAS Instrument Code") {
                ApplicationArea = All;
            }
            field("FAS Sector Code";"FAS Sector Code") {
                ApplicationArea = All;
            }
            field("Bal. FAS Instrument Code";"Bal. FAS Instrument Code") {
                ApplicationArea = All;
            }
            field("Bal. FAS Sector Code";"Bal. FAS Sector Code") {
                ApplicationArea = All;
            }
	    // </adl.24>
	    
	    // <adl.28>
            field("Original Document Amount (LCY)"; "Original Document Amount (LCY)")
            {
                ApplicationArea = All;
                Caption = 'Original Document Amount (LCY)';
            }
            field("Original VAT Amount (LCY)"; "Original VAT Amount (LCY)")
            {
                ApplicationArea = All;
                Caption = 'Original VAT Amount (LCY)';
            }
        // </adl.28>
        }
    }
    
    actions
    {
    }
}