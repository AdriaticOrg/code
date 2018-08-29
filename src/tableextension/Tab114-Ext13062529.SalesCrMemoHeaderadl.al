tableextension 13062529 "Sales Cr.Memo Header-adl" extends "Sales Cr.Memo Header" //114
{
    fields
    {
        field(13062525; "VAT Date-adl"; Date)
        {
            Caption = 'VAT Date';
            DataClassification = ToBeClassified;
        }
        field(13062526; "Postponed VAT-adl"; Option)
        {
            Caption = 'Postponed VAT';
            DataClassification = ToBeClassified;
            OptionMembers = "Realized VAT","Postponed VAT";
        }
    }
}