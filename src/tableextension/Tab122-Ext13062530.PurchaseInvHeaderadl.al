tableextension 13062530 "PurchaseInvHeader-adl" extends "Purch. Inv. Header"  //122
{
    fields
    {
        field(13062525; "VAT Date-adl"; Date)
        {
            Caption = 'VAT Date';
        }
        field(13062526; "Postponed VAT-adl"; Option)
        {
            Caption = 'Postponed VAT';
            OptionMembers = "Realized VAT","Postponed VAT";
        }
    }
}