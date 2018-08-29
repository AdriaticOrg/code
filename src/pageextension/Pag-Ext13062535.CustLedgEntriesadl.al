pageextension 13062535 "CustLedgEntries-adl" extends "Customer Ledger Entries"
{
    layout
    {
        addlast(Control1) {
            field("FAS Sector Code";"FAS Sector Code") {
                ApplicationArea = All;
            }
            field("FAS Non-Residnet Sector Code";"FAS Non-Residnet Sector Code") {
                ApplicationArea = All;
            }    
            field("FAS Affiliation Type";"FAS Affiliation Type") {
                ApplicationArea = All;
            }
            field("FAS Claim/Liability";"FAS Claim/Liability") {
                ApplicationArea = All;
            }
            field("FAS Instrument Type";"FAS Instrument Type") {
                ApplicationArea = All;
            }
            field("FAS Maturity";"FAS Maturity") {
                ApplicationArea = All;
            }     
            field("FAS Country/Region Code";"FAS Country/Region Code") {
                ApplicationArea = All;
            }               
            field("FAS Other Changes";"FAS Other Changes") {
                ApplicationArea = all;
            }
        }
        
    }
    
    actions
    {
    }
}