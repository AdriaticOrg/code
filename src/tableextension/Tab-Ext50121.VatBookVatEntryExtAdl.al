tableextension 50121 "Vat Book Vat Entry Ext.-Adl" extends "VAT Entry"
{
    fields
    {
        field(50121; "Postponed VAT-Adl"; Option)
        {
            OptionMembers = "Realized VAT", "Postponed VAT", "Advance VAT";
            OptionCaption = 'Realized VAT,Postponed VAT,Advance VAT';
            Caption = 'Postponed VAT';
            DataClassification = CustomerContent;
        }
        field(50122; "VAT Identifier-Adl"; Code[10])
        {
            Caption = 'VAT Identifier';
            DataClassification = CustomerContent;
            TableRelation = "VAT Identifier-Adl";
        }
        field(50123; "VAT Amount (retro.)-Adl"; Decimal)
        {
            Caption = 'VAT Amount (retro.)';
            DataClassification = CustomerContent;
            BlankZero = true;
        }
        field(50124; "VAT Base (retro.)-Adl"; Decimal)
        {
            Caption = 'VAT Base (retro.)';
            DataClassification = CustomerContent;
            BlankZero = true;
        }
        field(50125; "VAT Date-Adl"; Date)
        {
            Caption = 'VAT Date';
            DataClassification = CustomerContent;
        }
    }

}