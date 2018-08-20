tableextension 50105 "VAT Posting Setup-adl" extends "VAT Posting Setup" //325
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