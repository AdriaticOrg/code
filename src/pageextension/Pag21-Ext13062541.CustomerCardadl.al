pageextension 13062541 "CustomerCard-adl" extends "Customer Card" //21
{
    layout
    {
        // <adl.24>
        addlast(Invoicing) {
            field("FAS Sector Code";"FAS Sector Code") {
                ApplicationArea = All;
                Visible = FASEnabled;
            }
            // <adl.25>
            field("KRD Non-Residnet Sector Code";"KRD Non-Residnet Sector Code") {
                ApplicationArea = All;
                Visible = KRDEnabled;
            }
            // <adl.25>
        }    
        // </adl.24>
    }
    // <adl.25>   
    actions
    {    

        addlast(Documents) {  
            action("Show Vendors") {
                RunObject = page "Vendor List";
                ApplicationArea = All;
            }            
        }
    }
    // </adl.25>

    // <adl.24>
    trigger OnOpenPage()
    begin
        RepSIMgt.GetReporSIEnabled(FASEnabled,KRDEnabled,BSTEnabled);
    end;
    var
        RepSIMgt:Codeunit "Reporting SI Mgt.";
        FASEnabled:Boolean;
        KRDEnabled:Boolean;
        BSTEnabled:Boolean;
    // </adl.24>
}