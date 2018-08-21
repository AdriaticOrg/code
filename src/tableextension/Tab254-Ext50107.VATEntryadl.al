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
            Caption = 'Postponed VAT';
            OptionMembers = "Realized VAT","Postponed VAT";
        }
    }
}