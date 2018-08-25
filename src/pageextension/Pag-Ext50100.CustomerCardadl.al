pageextension 50100 "CustomerCard-adl" extends "Customer Card"
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