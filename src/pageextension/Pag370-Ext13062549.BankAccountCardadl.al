pageextension 13062549 "BankAccountCard-adl" extends "Bank Account Card" //370
{
    layout
    {
        addlast(General) {
            // <adl.24>
            field("FAS Sector Code";"FAS Sector Code") {
                ApplicationArea = All;
            }
            field ("FAS Instrument Code";"FAS Instrument Code") {
                ApplicationArea = All;
            }
            // </adl.24>
        }         
    }
    
    actions
    {
    }
}