pageextension 13062544 "VendLedgEntries-adl" extends "Vendor Ledger Entries" //29
{
    layout
    {
        // <adl.24>
        addlast(Control1) {
            field("FAS Sector Code";"FAS Sector Code") {
                ApplicationArea = All;
            }
            // <adl.25>
            field("KRD Non-Residnet Sector Code";"KRD Non-Residnet Sector Code") {
                ApplicationArea = All;
            }    
            // </adl.25>
            field("FAS Affiliation Type";"KRD Affiliation Type") {
                ApplicationArea = All;
            }
            field("FAS Claim/Liability";"KRD Claim/Liability") {
                ApplicationArea = All;
            }
            field("FAS Instrument Type";"KRD Instrument Type") {
                ApplicationArea = All;
            }
            field("FAS Maturity";"KRD Maturity") {
                ApplicationArea = All;
            }     
            field("FAS Country/Region Code";"KRD Country/Region Code") {
                ApplicationArea = All;
            }               
            field("FAS Other Changes";"KRD Other Changes") {
                ApplicationArea = all;
            }
        }
        // </adl.24>
    }
    
    actions
    {
    }
}