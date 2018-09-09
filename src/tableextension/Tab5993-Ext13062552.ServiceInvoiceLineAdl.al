tableextension 13062552 "Service Invoice Line-Adl" extends "Service Invoice Line"  //5993
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