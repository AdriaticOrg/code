/**********************************************************************************************

###  NOT FOR MEARGING! ###  Transfered from VATDate branch for needed references on this branch

***********************************************************************************************/
tableextension 50103 "PurchaseHeader-adl" extends "Purchase Header"  //38
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