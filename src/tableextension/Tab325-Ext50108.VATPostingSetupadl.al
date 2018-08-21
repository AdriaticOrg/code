tableextension 50108 "VATPostingSetup-adl" extends "VAT Posting Setup" //325
{
    fields
    {
        field(50100; "Sales VAT Postponed Account-adl"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Sales VAT Postponed Account';
        }
    }
}