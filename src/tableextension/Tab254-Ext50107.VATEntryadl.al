<<<<<<< HEAD
tableextension 50107 "VATEntry-adl" extends "VAT Entry"  //254
{
    fields
    {
        field(50000; "VAT Date -adl"; Date)
        {
            Caption = 'VAT Date';
        }
        field(50001; "Postponed VAT -adl"; Option)
        {
=======
tableextension 50107 "VATEntry-adl" extends "VAT Entry" // 254
{
    fields
    {
        field(50100; "VAT Date-adl"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'VAT Date';
            Editable = False;
        }
        field(50101; "Postponed VAT-adl"; Option)
        {
            DataClassification = ToBeClassified;
>>>>>>> 45ddf7001e34a5b2d46ca0060252286904df8923
            Caption = 'Postponed VAT';
            OptionMembers = "Realized VAT","Postponed VAT";
        }
    }
}