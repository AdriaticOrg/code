/**********************************************************************************************

###  NOT FOR MEARGING! ###  Transfered from VATDate branch for needed references on this branch

***********************************************************************************************/

tableextension 50104 "PurchaseInvHeader-adl" extends "Purch. Inv. Header"  //122
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