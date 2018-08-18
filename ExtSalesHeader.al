tableextension 50100 "Sales Header-adl" extends "Sales Header" //36
{
    fields
    {
        field(50100; "VAT Date-adl"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'VAT Date';
        }
    }

    var
        myInt: Integer;
}