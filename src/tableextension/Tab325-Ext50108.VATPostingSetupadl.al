<<<<<<< HEAD
tableextension 50108 "VATPostingSetup-adl" extends "VAT Posting Setup"  //325
{
    fields
    {
        field(50000; "Purch VAT Postponed Account -adl"; Code[20])
        {
            Caption = 'Purch VAT Postponed Account';
        }
        field(50001; "Sales VAT Postponed Account -adl"; Code[20])
        {
=======
tableextension 50108 "VATPostingSetup-adl" extends "VAT Posting Setup" //325
{
    fields
    {
        field(50100; "Sales VAT Postponed Account-adl"; Code[20])
        {
            DataClassification = ToBeClassified;
>>>>>>> 45ddf7001e34a5b2d46ca0060252286904df8923
            Caption = 'Sales VAT Postponed Account';
        }
    }
}