tableextension 50104 "Sales Cr.Memo Header-adl" extends "Sales Cr.Memo Header" //114
{
    fields
    {
        field(50100; "VAT Date-adl"; Date)
        {
            Caption = 'VAT Date';
            DataClassification = ToBeClassified;
        }
        field(50101; "Postponed VAT-adl"; Option)
        {
            Caption = 'Postponed VAT';
            DataClassification = ToBeClassified;
            OptionMembers = "Realized VAT","Postponed VAT";
        }
    }
}