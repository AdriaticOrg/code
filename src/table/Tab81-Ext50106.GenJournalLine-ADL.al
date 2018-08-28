/**********************************************************************************************

###  NOT FOR MEARGING! ###  Transfered from VATDate branch for needed references on this branch

***********************************************************************************************/
tableextension 50106 "GenJournalLine-adl" extends "Gen. Journal Line" // 81
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
            Caption = 'Postponed VAT';
            OptionMembers = "Realized VAT","Postponed VAT";
        }
    }
}