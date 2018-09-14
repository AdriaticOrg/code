table 13062603 "VIES Report Buffer"
{
    DataClassification = SystemMetadata;
    Caption = 'VIES Report Buffer';

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = SystemMetadata;
        }
        field(2; "Type"; Option)
        {
            Caption = 'Type';
            OptionMembers = New,Correction;
            OptionCaption = 'New,Correction';
            DataClassification = SystemMetadata;
        }
        field(4; "Country/Region Code"; Code[10])
        {
            Caption = '"Country/Region Code"  ';
            DataClassification = SystemMetadata;
        }
        field(6; "VAT Registration No."; Text[20])
        {
            Caption = '"VAT Registration No."';
            DataClassification = SystemMetadata;
        }
        field(8; "Period Year"; Integer)
        {
            Caption = 'Period Year';
            DataClassification = SystemMetadata;
        }
        field(9; "Period Round"; Integer)
        {
            Caption = 'Period Round';
            DataClassification = SystemMetadata;
        }
        field(10; "EU 3-Party Amt."; Decimal)
        {
            Caption = 'EU 3-Party Amt.';
            DataClassification = SystemMetadata;
        }
        field(12; "EU Customs Proc. Amt"; Decimal)
        {
            Caption = 'EU Customs Proc. Amt';
            DataClassification = SystemMetadata;
        }
        field(14; "EU Sales Goods Amt."; Decimal)
        {
            Caption = 'EU Sales Goods Amt.';
            DataClassification = SystemMetadata;
        }
        field(16; "EU Sales Srvc. Amt."; Decimal)
        {
            Caption = 'EU Sales Svc. Amt.';
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }

}