tableextension 13062533 "VAT Posting Setup-Adl" extends "VAT Posting Setup"  //325
{
    fields
    {
        // <adl.10>
        field(13062525; "Purch VAT Postponed Account-Adl"; Code[20])
        {
            Caption = 'Purch VAT Postponed Account';
            DataClassification = SystemMetadata;
        }
        field(13062526; "Sales VAT Postponed Account-Adl"; Code[20])
        {
            Caption = 'Sales VAT Postponed Account';
            DataClassification = SystemMetadata;
        }
        // <adl.13>
        field(13062551; "VAT % (informative)-Adl"; Decimal)
        {
            Caption = 'VAT % (informative)';
            DataClassification = SystemMetadata;
            DecimalPlaces = 0 : 2;
        }
        // </adl.13>
        // </adl.10>
        //<adl.11>
        field(13062527; "VAT % (retrograde)-Adl"; Decimal)
        {
            Caption = 'VAT % (retrograde)';
            MinValue = 0;
            MaxValue = 100;
            DecimalPlaces = 0 : 5;
            DataClassification = SystemMetadata;
        }
        //</adl.11>
        // <adl.22>
        field(13062601; "VIES Goods Sales-Adl"; Boolean)
        {
            Caption = 'VIES Goods Sales';
            DataClassification = SystemMetadata;
        }
        field(13062602; "VIES Service Sales-Adl"; Boolean)
        {
            Caption = 'VIES Service Sales';
            DataClassification = SystemMetadata;
        }
        // </adl.22>          
    }
}