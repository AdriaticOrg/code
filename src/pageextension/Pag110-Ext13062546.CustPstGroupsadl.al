pageextension 13062546 "CustPstGroups-adl" extends "Customer Posting Groups" //110
{
    layout
    {
        addlast(Control1) {
            // <adl.25>
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
            // </adl.25>
        }
        
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