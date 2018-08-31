tableextension 13062528 "Sales Invoice Header-Adl" extends "Sales Invoice Header" //112
{
    fields
    {
        // <adl.6>
        field(13062525; "VAT Date-Adl"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'VAT Date';
        }
        // </adl.6>
        // <adl.10>
        field(13062526; "Postponed VAT-Adl"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Postponed VAT';
            OptionMembers = "Realized VAT","Postponed VAT";
        }
        // </adl.10>
    }
}