tableextension 13062531 "PurchCrMemoHdr-Adl" extends "Purch. Cr. Memo Hdr."  //124
{
    fields
    {
        field(13062525; "VAT Date-Adl"; Date)
        {
            Caption = 'VAT Date';
        }
        field(13062526; "Postponed VAT-Adl"; Option)
        {
            Caption = 'Postponed VAT';
            OptionMembers = "Realized VAT","Postponed VAT";
        }
    }
}