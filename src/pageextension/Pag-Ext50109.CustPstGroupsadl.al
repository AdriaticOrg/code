pageextension 50109 "CustPstGroups-adl" extends "Customer Posting Groups"
{
    layout
    {
        addlast(Control1) {
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

        }
        
    }
    
    actions
    {
    }
}