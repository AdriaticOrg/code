pageextension 13062529 "VendorCard-adl" extends "Vendor Card"
{
    layout
    {
        addlast(Invoicing) {
            field("FAS Sector Code";"FAS Sector Code") {
                ApplicationArea = All;
            }
            field("FAS Non-Residnet Sector Code";"FAS Non-Residnet Sector Code") {
                ApplicationArea = All;
            }
        } 
    }
    
    actions
    {

        // Add changes to page actions here
    }
    
    var
        myInt: Integer;
}