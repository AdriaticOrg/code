pageextension 13062547 "VendPstGroups-adl" extends "Vendor Posting Groups" //111
{
    layout
    {
        // <adl.25>
        addlast(Control1) {
            field("KRD Claim/Liability";"KRD Claim/Liability") {
                ApplicationArea = All;
            }
            field("KRD Instrument Type";"KRD Instrument Type") {
                ApplicationArea = All;
            }
            field("KRD Maturity";"KRD Maturity") {
                ApplicationArea = All;
            }     
        }   
        // </adl.25>
    }
    
    actions
    {
    }
}