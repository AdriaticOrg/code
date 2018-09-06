pageextension 13062544 "VendLedgEntries-adl" extends "Vendor Ledger Entries" //29
{
    layout
    {
        // <adl.24>
        addlast(Control1) {
            field("FAS Sector Code";"FAS Sector Code") {
                ApplicationArea = All;
                Visible = FASEnabled;
            }
            // <adl.25>
            field("KRD Non-Residnet Sector Code";"KRD Non-Residnet Sector Code") {
                ApplicationArea = All;
                Visible = KRDEnabled;
            }    
            // </adl.25>
            field("KRD Affiliation Type";"KRD Affiliation Type") {
                ApplicationArea = All;
                Visible = KRDEnabled;
            }
            field("KRD Claim/Liability";"KRD Claim/Liability") {
                ApplicationArea = All;
                Visible = KRDEnabled;
            }
            field("KRD Instrument Type";"KRD Instrument Type") {
                ApplicationArea = All;
                Visible = KRDEnabled;
            }
            field("KRD Maturity";"KRD Maturity") {
                ApplicationArea = All;
                Visible = KRDEnabled;
            }     
            field("KRD Country/Region Code";"KRD Country/Region Code") {
                ApplicationArea = All;
                Visible = KRDEnabled;
            }               
            field("KRD Other Changes";"KRD Other Changes") {
                ApplicationArea = all;
                Visible = KRDEnabled;
            }
        }
        // </adl.24>
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