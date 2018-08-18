tableextension 50102 "VAT Entry-adl" extends "VAT Entry" // 254
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