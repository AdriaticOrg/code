pageextension 13062543 "VendorCard-adl" extends "Vendor Card" //26
{
    layout
    {
        // <adl.24>
        addlast(Invoicing) {
            field("FAS Sector Code";"FAS Sector Code") {
                ApplicationArea = All;
            }
            // <adl.25>
            field("KRD Non-Residnet Sector Code";"KRD Non-Residnet Sector Code") {
                ApplicationArea = All;
            }
            // </adl.25>
        } 
        // </adl.24>
    }
    
    actions
    {

        // Add changes to page actions here
    }
}