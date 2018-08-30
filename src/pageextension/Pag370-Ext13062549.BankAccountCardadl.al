pageextension 13062549 "BankAccountCard-adl" extends "Bank Account Card" //370
{
    layout
    {
        addlast(General) {
            field("FAS Sector Code";"FAS Sector Code") {
                ApplicationArea = All;
            }
            field ("FAS Instrument Code";"FAS Instrument Code") {
                ApplicationArea = All;
            }
        }         
    }
    
    actions
    {
    }
}