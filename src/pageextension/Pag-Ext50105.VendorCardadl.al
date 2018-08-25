pageextension 50105 "VendorCard-adl" extends "Vendor Card"
{
    layout
    {
        addlast(Invoicing) {
            field("FAS Sector Code";"FAS Sector Code") {
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