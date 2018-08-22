tableextension 50105 "PurchCrMemoHdr-adl" extends "Purch. Cr. Memo Hdr."  //124
{
    fields
    {
        field(50000; "VAT Date-adl"; Date)
        {
            Caption = 'VAT Date';
        }
        field(50001; "Postponed VAT-adl"; Option)
        {
            Caption = 'Postponed VAT';
            OptionMembers = "Realized VAT","Postponed VAT";
        }
    }
}