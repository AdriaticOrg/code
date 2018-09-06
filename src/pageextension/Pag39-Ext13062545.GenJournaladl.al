pageextension 13062545 "GenJournal-adl" extends "General Journal" //39
{
    layout
    {
        addlast(Control1) {
        // <adl.24>
            field("FAS Instrument Code";"FAS Instrument Code") {
                ApplicationArea = All;
                Visible = FASEnabled;
            }
            field("FAS Sector Code";"FAS Sector Code") {
                ApplicationArea = All;
                Visible = FASEnabled;
            }
            field("Bal. FAS Instrument Code";"Bal. FAS Instrument Code") {
                ApplicationArea = All;
                Visible = FASEnabled;
            }
            field("Bal. FAS Sector Code";"Bal. FAS Sector Code") {
                ApplicationArea = All;
                Visible = FASEnabled;
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
    
    // <adl.24>
    trigger OnOpenPage()
    begin
        RepSIMgt.GetReporSIEnabled(FASEnabled,KRDEnabled,BSTEnabled);
    end;
    var
        RepSIMgt:Codeunit "Reporting SI Mgt.";
        FASEnabled:Boolean;
        KRDEnabled:Boolean;
        BSTEnabled:Boolean;
    // </adl.24>
}