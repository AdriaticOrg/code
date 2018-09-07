pageextension 13062547 "VendPstGroups-adl" extends "Vendor Posting Groups" //111
{
    layout
    {
        // <adl.25>
        addlast(Control1) {
            field("KRD Claim/Liability";"KRD Claim/Liability") {
                ApplicationArea = All;
                Visible = KRDEnabled;
            }
            field("KRD Instrument Type";"KRD Instrument Type") {
                ApplicationArea = All;
                Visible = KRDEnabled;
            }
            field("KRD Maturity";"KRD Maturity") {
                ApplicationArea = All;
                Visible = KRDEnabled;
            }     
        }   
        // </adl.25>
    }
    
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