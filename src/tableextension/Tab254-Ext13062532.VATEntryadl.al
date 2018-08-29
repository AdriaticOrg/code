tableextension 13062532 "VATEntry-Adl" extends "VAT Entry" //254
{
    fields
    {
        field(13062525; "VAT Date-Adl"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'VAT Date';
            Editable = False;
        }
        field(13062526; "Postponed VAT-Adl"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Postponed VAT';
            OptionMembers = "Realized VAT","Postponed VAT";
        }

        field(13062592; "VAT Identifier-Adl"; Code[10])
        {
            Caption = 'VAT Identifier';
            DataClassification = CustomerContent;
            TableRelation = "VAT Identifier-Adl";
        }

        field(13062593; "VAT Amount (retro.)-Adl"; Decimal)
        {
            Caption = 'VAT Amount (retro.)';
            DataClassification = CustomerContent;
            BlankZero = true;
        }
        field(13062594; "VAT Base (retro.)-Adl"; Decimal)
        {
            Caption = 'VAT Base (retro.)';
            DataClassification = CustomerContent;
            BlankZero = true;
        }

    }
}