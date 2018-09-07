pageextension 13062542 "CustLedgEntries-adl" extends "Customer Ledger Entries" //25
{
    layout
    {
        // <adl.24>
        addlast(Control1) {
            field("FAS Sector Code";"FAS Sector Code") {
                ApplicationArea = All;
                Visible = FASEnabled;
            }
            field("KRD Non-Residnet Sector Code";"KRD Non-Residnet Sector Code") {
                ApplicationArea = All;
                Visible =KRDEnabled;
            }    
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