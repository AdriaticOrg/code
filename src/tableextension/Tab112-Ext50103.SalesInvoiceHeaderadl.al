tableextension 50103 "Sales Invoice Header-adl" extends "Sales Invoice Header" //112
{
    fields
    {
        field(50100; "VAT Date-adl"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'VAT Date';
        }
    }
}