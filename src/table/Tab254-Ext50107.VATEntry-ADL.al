/**********************************************************************************************

###  NOT FOR MEARGING! ###  Transfered from VATDate branch for needed references on this branch

***********************************************************************************************/
tableextension 50107 "VATEntry-adl" extends "VAT Entry" //254
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
        field(50102; "VAT Identifier-adl"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'VAT Identifier';
            OptionMembers = "Realized VAT","Postponed VAT";
        }
    }

    
    keys{
        key("key1-adl";"Vat Date-adl") {}
    }
}