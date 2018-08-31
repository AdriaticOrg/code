pageextension 13062550 "General Ledger Setup-adl" extends "General Ledger Setup" //118
{
    layout
    {
        // <adl.27>
        addlast(General) {
            field("Global Posting Approver";"Global Posting Approver") {
                ApplicationArea = All;
            }
            field("Global Posting Resp. Person";"Global Posting Resp. Person") {
                ApplicationArea = All;
            }
        }
        // </adl.27>
    }
    
    actions
    {
    }
}