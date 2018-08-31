pageextension 13062546 "CustPstGroups-adl" extends "Customer Posting Groups" //110
{
    layout
    {
        addlast(Control1) {
            // <adl.25>
            field("KRD Claim/Liability";"KRD Claim/Liability") {
                ApplicationArea = All;
            }
            field("KRD Instrument Type";"KRD Instrument Type") {
                ApplicationArea = All;
            }
            field("KRD Maturity";"KRD Maturity") {
                ApplicationArea = All;
            }
            // </adl.25>
        }
        
    }
    
    actions
    {
    }
}