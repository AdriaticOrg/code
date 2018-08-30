pageextension 13062547 "VendPstGroups-adl" extends "Vendor Posting Groups" //111
{
    layout
    {
        addlast(Control1) {
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
        }   
        
    }
    
    actions
    {
    }
}