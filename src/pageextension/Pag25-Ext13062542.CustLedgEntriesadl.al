pageextension 13062542 "CustLedgEntries-adl" extends "Customer Ledger Entries" //25
{
    layout
    {
        // <adl.24>
        addlast(Control1) {
            field("FAS Sector Code";"FAS Sector Code") {
                ApplicationArea = All;
            }
            field("FAS Non-Residnet Sector Code";"KRD Non-Residnet Sector Code") {
                ApplicationArea = All;
            }    
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