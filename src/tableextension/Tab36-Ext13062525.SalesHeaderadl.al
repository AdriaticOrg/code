tableextension 13062525 "Sales Header-adl" extends "Sales Header" //36
{
    fields
    {
        field(13062525; "VAT Date-adl"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'VAT Date';
            trigger OnValidate()
            begin
                if "VAT Date-adl" <> "Posting Date" then
                    "Postponed VAT-adl" := "Postponed VAT-adl"::"Postponed VAT"
                else
                    "Postponed VAT-adl" := "Postponed VAT-adl"::"Realized VAT";
            end;
        }
        field(13062526; "Postponed VAT-adl"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Postponed VAT';
            OptionMembers = "Realized VAT","Postponed VAT";
        }
    }

}