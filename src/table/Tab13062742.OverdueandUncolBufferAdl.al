table 13062742 "Overdue and Uncol. Buffer-Adl"
{
    Caption = 'Overdue and Uncollected Recievables Buffer';
    Permissions = tabledata 13062742 = rm;

    fields
    {
        field(1; "VAT Registration Type"; Integer)
        {
            Caption = 'VAT Registration Type';
            DataClassification = SystemMetadata;
        }
        field(2; "VAT Registration No."; Code[20])
        {
            Caption = 'VAT Registration No.';
            DataClassification = SystemMetadata;
        }
        field(3; "Line Type"; Integer)
        {
            Caption = 'Line Type';
            DataClassification = SystemMetadata;
        }
        field(4; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = SystemMetadata;
        }
        field(5; "Customer Name"; Text[50])
        {
            Caption = 'Customer Name';
            DataClassification = SystemMetadata;
        }
        field(6; "Invoice Line No."; Integer)
        {
            Caption = 'Invoice Line No.';
            DataClassification = SystemMetadata;
        }
        field(7; "Invoice No."; Code[20])
        {
            Caption = 'Invoice No.';
            DataClassification = SystemMetadata;
        }
        field(8; "Document Date"; Date)
        {
            Caption = 'Document Date';
            DataClassification = SystemMetadata;
        }
        field(9; "Due Date"; Date)
        {
            Caption = 'Due Date';
            DataClassification = SystemMetadata;
        }
        field(10; "No. of Overdue Days"; Integer)
        {
            Caption = 'No. of Overdue Days';
            DataClassification = SystemMetadata;
        }
        field(11; "Invoice Amount without VAT"; Decimal)
        {
            Caption = 'Invoice Amount without VAT';
            DataClassification = SystemMetadata;
        }
        field(12; "VAT Amount"; Decimal)
        {
            Caption = 'VAT Amount';
            DataClassification = SystemMetadata;
        }
        field(13; "Invoice Amount Incl. VAT"; Decimal)
        {
            Caption = 'Invoice Amount Incl. VAT';
            DataClassification = SystemMetadata;
        }
        field(14; "Paid Amount"; Decimal)
        {
            Caption = 'Paid Amount';
            DataClassification = SystemMetadata;
        }
        field(15; "Unpaid Amount"; Decimal)
        {
            Caption = 'Unpaid Amount';
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(Key1; "Line No.")
        {
        }
        key(Key2; "VAT Registration Type", "VAT Registration No.", "Line Type")
        {
        }
    }

    fieldgroups
    {
    }
}