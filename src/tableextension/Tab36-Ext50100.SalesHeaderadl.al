tableextension 50100 "Sales Header-adl" extends "Sales Header" //36
{
    fields
    {
        field(50100; "VAT Date-adl"; Date)
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
        field(50101; "Postponed VAT-adl"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Postponed VAT';
            OptionMembers = "Realized VAT","Postponed VAT";
        }
    }

}