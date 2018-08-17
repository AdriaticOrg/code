tableextension 50100 "Vat Book Vat Entry Ext." extends "VAT Entry"
{
    fields
    {
        field(50100; "Postponed VAT"; Option)
        {
            OptionMembers = "Realized VAT", "Postponed VAT", "Advance VAT";
            OptionCaption = 'Realized VAT,Postponed VAT,Advance VAT';
            Caption = 'Postponed VAT';
            DataClassification = CustomerContent;
        }
        field(50101; "VAT Identifier"; Code[10])
        {
            Caption = 'VAT Identifier';
            DataClassification = CustomerContent;
            TableRelation = "VAT Identifier";
        }
        field(50102; "VAT Amount (retro.)"; Decimal)
        {
            Caption = 'VAT Amount (retro.)';
            DataClassification = CustomerContent;
            BlankZero = true;
        }
        field(50103; "VAT Base (retro.)"; Decimal)
        {
            Caption = 'VAT Base (retro.)';
            DataClassification = CustomerContent;
            BlankZero = true;
        }
        field(50104; "VAT Date"; Date)
        {
            Caption = 'VAT Date';
            DataClassification = CustomerContent;
        }
    }

}