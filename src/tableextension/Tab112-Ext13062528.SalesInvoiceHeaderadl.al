tableextension 13062528 "Sales Invoice Header-Adl" extends "Sales Invoice Header" //112
{
    fields
    {
        field(13062525; "VAT Date-Adl"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'VAT Date';
        }
        field(13062526; "Postponed VAT-Adl"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Postponed VAT';
            OptionMembers = "Realized VAT","Postponed VAT";
        }
    }
}