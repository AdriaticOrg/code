table 13062742 "Overdue and Uncol. Buffer-adl"
{
    Caption = 'Overdue and Uncollected Recievables Buffer';

    fields
    {
        field(1; "VAT Registration Type"; Integer)
        {
            Caption = 'VAT Registration Type';
        }
        field(2; "VAT Registration No."; Code[20])
        {
            Caption = 'VAT Registration No.';
        }
        field(3; "Line Type"; Integer)
        {
            Caption = 'Line Type';
        }
        field(4; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(5; "Customer Name"; Text[50])
        {
            Caption = 'Customer Name';
        }
        field(6; "Invoice Line No."; Integer)
        {
            Caption = 'Invoice Line No.';
        }
        field(7; "Invoice No."; Code[20])
        {
            Caption = 'Invoice No.';
        }
        field(8; "Document Date"; Date)
        {
            Caption = 'Document Date';
        }
        field(9; "Due Date"; Date)
        {
            Caption = 'Due Date';
        }
        field(10; "No. of Overdue Days"; Integer)
        {
            Caption = 'No. of Overdue Days';
        }
        field(11; "Invoice Amount without VAT"; Decimal)
        {
            Caption = 'Invoice Amount without VAT';
        }
        field(12; "VAT Amount"; Decimal)
        {
            Caption = 'VAT Amount';
        }
        field(13; "Invoice Amount Incl. VAT"; Decimal)
        {
            Caption = 'Invoice Amount Incl. VAT';
        }
        field(14; "Paid Amount"; Decimal)
        {
            Caption = 'Paid Amount';
        }
        field(15; "Unpaid Amount"; Decimal)
        {
            Caption = 'Unpaid Amount';
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