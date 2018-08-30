tableextension 13062525 "Sales Header-Adl" extends "Sales Header" //36
{
    fields
    {
        field(13062525; "VAT Date-Adl"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'VAT Date';
            trigger OnValidate()
            begin
                if "VAT Date-Adl" <> "Posting Date" then
                    "Postponed VAT-Adl" := "Postponed VAT-Adl"::"Postponed VAT"
                else
                    "Postponed VAT-Adl" := "Postponed VAT-Adl"::"Realized VAT";
            end;
        }
        field(13062526; "Postponed VAT-Adl"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Postponed VAT';
            OptionMembers = "Realized VAT","Postponed VAT";
        }
    }

}