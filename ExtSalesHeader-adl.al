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
                "VAT Date-adl" := "Posting Date";
            end;
        }
    }
}