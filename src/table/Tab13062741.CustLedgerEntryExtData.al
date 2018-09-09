table 13062741 "Cust.Ledger Entry ExtData-adl"
{
   
    Caption = 'Cust. Ledger Entry Extended Data';

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; "Original Document Amount (LCY)"; Decimal)
        {
            Caption = 'Original Document Amount (LCY)';
        }
        field(3; "Original VAT Amount (LCY)"; Decimal)
        {
            Caption = 'Original VAT Amount (LCY)';
        }
        field(4; "Open Amount (LCY) w/o Unreal."; Decimal)
        {
            Caption = 'Open Amount (LCY) w/o Unrealized Exchange Rate Adjustments';
        }
        field(10; "Is Journal Line"; Boolean)
        {
            Caption = 'Is Journal Line';
        }
        field(11; "Journal Template Name"; Code[10])
        {
            Caption = 'Journal Template Name';
            TableRelation = "Gen. Journal Template";
        }
        field(12; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
            TableRelation = "Gen. Journal Batch".Name WHERE ("Journal Template Name" = FIELD ("Journal Template Name"));
        }
        field(13; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
    }

    keys
    {
        key(Key1; "Entry No.", "Is Journal Line")
        {
        }
        key(Key2; "Journal Template Name", "Journal Batch Name", "Line No.")
        {
        }
    }

    fieldgroups
    {
    }
}

