/**********************************************************************************************

###  NOT FOR MEARGING! ###  Transfered from VATDate branch for needed references on this branch

***********************************************************************************************/
tableextension 50108 "VATPostingSetup-adl" extends "VAT Posting Setup"  //325
{
    fields
    {
        field(50000; "Purch VAT Postponed Account-adl"; Code[20])
        {
            Caption = 'Purch VAT Postponed Account';
        }
        field(50001; "Sales VAT Postponed Account-adl"; Code[20])
        {
            Caption = 'Sales VAT Postponed Account';
        }
    }
}