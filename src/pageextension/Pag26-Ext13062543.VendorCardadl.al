pageextension 13062543 "VendorCard-adl" extends "Vendor Card" //26
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