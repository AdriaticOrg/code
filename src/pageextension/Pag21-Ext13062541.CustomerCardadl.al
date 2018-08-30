pageextension 13062541 "CustomerCard-adl" extends "Customer Card" //21
{
    layout
    {
        addlast(Invoicing) {
            field("FAS Sector Code";"FAS Sector Code") {
                ApplicationArea = All;
            }
            field("FAS Non-Residnet Sector Code";"KRD Non-Residnet Sector Code") {
                ApplicationArea = All;
            }
        }    
    }
        
    actions
    {    

        addlast(Documents) {  
            action("Show Vendors") {
                RunObject = page "Vendor List";
                ApplicationArea = All;
            }            
        }
    }
    
    var
        myInt: Integer;
}