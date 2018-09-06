tableextension 13062528 "Sales Invoice Header-Adl" extends "Sales Invoice Header" //112
{
    fields
    {
        // <adl.6>
        field(13062525; "VAT Date-Adl"; Date)
        {
            Caption = 'VAT Date';
            DataClassification = ToBeClassified;
        }
        // </adl.6>
        // <adl.10>
        field(13062526; "Postponed VAT-Adl"; Option)
        {
            Caption = 'Postponed VAT';
            OptionMembers = "Realized VAT","Postponed VAT";
            DataClassification = ToBeClassified;
        }
        // </adl.10>
        // <adl.22>
        field(13062602; "EU Customs Procedure"; Boolean)
        {
            Caption = 'EU Customs Procedure';
            DataClassification = ToBeClassified;
        }                 
        // </adl.22>          
    }
}