pageextension 13062549 "BankAccountCard-adl" extends "Bank Account Card" //370
{
    layout
    {
        addlast(General) {
            // <adl.24>
            field("FAS Sector Code";"FAS Sector Code") {
                ApplicationArea = All;
                Visible = FASEnabled;
            }
            field ("FAS Instrument Code";"FAS Instrument Code") {
                ApplicationArea = All;
                Visible = FASEnabled;
            }
            // </adl.24>
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