pageextension 50100 "CustomerCard-adl" extends "Customer Card"
{
    layout
    {
        addlast(General) {
            field("FAS Sector Code";"FAS Sector Code") {
                ApplicationArea = All;

            }
        }    
    }
        
    actions
    {    

        addfirst(Reporting) {
            action (ShowSct) {
                ApplicationArea = All;
                RunObject = page "FAS Instruments";
            }

        }

        addlast(Navigation) {
            action("Show Sectors") {
                RunObject = page "FAS Sectors";
            }
        }
    }
    
    var
        myInt: Integer;
}