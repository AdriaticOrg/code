pageextension 13062548 "UserSetup-adl" extends "User Setup" //119
{
    layout
    {
        // <adl.24>
        addlast(Control1) {
            field("Reporting_SI Name";"Reporting_SI Name") {
                ApplicationArea = All;
            }
            field("Reporting_SI Email";"Reporting_SI Email") {
                ApplicationArea = All;
            }
            field("Reporting_SI Phone";"Reporting_SI Phone") {
                ApplicationArea = All;
            }
            field("Reporting_SI Position";"Reporting_SI Position") {
                ApplicationArea = All;
            }
            // <adl.27>
            field("Posting Approver";"Posting Approver") {
                ApplicationArea = All;
            }
            field("Posting Responsible Person";"Posting Responsible Person") {
                ApplicationArea = All;
            }
            // </adl.27>
        }
        // </adl.24>
    }
    
    actions
    {
    }
}