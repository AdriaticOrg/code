tableextension 13062533 "VATPostingSetup-Adl" extends "VAT Posting Setup"  //325
{
    fields
    {
        field(13062525; "Purch VAT Postponed Account-Adl"; Code[20])
        {
            Caption = 'Purch VAT Postponed Account';
        }
        field(13062526; "Sales VAT Postponed Account-Adl"; Code[20])
        {
            Caption = 'Sales VAT Postponed Account';
        }
    }
}