tableextension 50101 "Gen. Journal Line-adl" extends "Gen. Journal Line" // 81
{
    fields
    {
        field(50100; "VAT Date-adl"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'VAT Date';
            Editable = False;
        }
    }
}