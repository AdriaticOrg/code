tableextension 13062530 "PurchaseInvHeader-Adl" extends "Purch. Inv. Header"  //122
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