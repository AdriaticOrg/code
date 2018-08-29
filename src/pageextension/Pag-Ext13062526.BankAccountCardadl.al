pageextension 13062526 "BankAccountCard-adl" extends "Bank Account Card" //MyTargetPageId
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