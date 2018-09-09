tableextension 13062554 "VAT Amount Line-Adl" extends "VAT Amount Line"  //290
{
    fields
    {
        // <adl.13>
        field(13062551; "VAT % (informative)-Adl"; Decimal)
        {
            DataClassification = SystemMetadata;
            Caption = 'VAT % (informative)';
        }
        // </adl.13>
    }

}