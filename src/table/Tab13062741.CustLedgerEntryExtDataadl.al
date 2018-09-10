table 13062741 "Cust.Ledger Entry ExtData-adl"
{

    Caption = 'Cust. Ledger Entry Extended Data';

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = SystemMetadata;
        }
        field(2; "Original Document Amount (LCY)"; Decimal)
        {
            Caption = 'Original Document Amount (LCY)';
            DataClassification = SystemMetadata;
        }
        field(3; "Original VAT Amount (LCY)"; Decimal)
        {
            Caption = 'Original VAT Amount (LCY)';
            DataClassification = SystemMetadata;
        }
        field(4; "Open Amount (LCY) w/o Unreal."; Decimal)
        {
            Caption = 'Open Amount (LCY) w/o Unrealized Exchange Rate Adjustments';
            DataClassification = SystemMetadata;
        }
        field(10; "Is Journal Line"; Boolean)
        {
            Caption = 'Is Journal Line';
            DataClassification = SystemMetadata;
        }
        field(11; "Journal Template Name"; Code[10])
        {
            Caption = 'Journal Template Name';
            TableRelation = "Gen. Journal Template";
            DataClassification = SystemMetadata;
        }
        field(12; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
            TableRelation = "Gen. Journal Batch".Name WHERE ("Journal Template Name" = FIELD ("Journal Template Name"));
            DataClassification = SystemMetadata;
        }
        field(13; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = SystemMetadata;
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

