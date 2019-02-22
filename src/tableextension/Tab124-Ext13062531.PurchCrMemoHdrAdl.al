tableextension 13062531 "Purch. Cr. Memo Hdr.-Adl" extends "Purch. Cr. Memo Hdr."  //124
{
    fields
    {
        // <adl.6>
        field(13062525; "VAT Date-Adl"; Date)
        {
            Caption = 'VAT Date';
            DataClassification = SystemMetadata;
        }
        field(13062527; "VAT Output Date-Adl"; Date)
        {
            Caption = 'VAT Output Date';
            DataClassification = SystemMetadata;
        }
        // </adl.6>
        // <adl.10>
        field(13062526; "Postponed VAT-Adl"; Option)
        {
            Caption = 'Postponed VAT';
            OptionMembers = "Realized VAT","Postponed VAT";
            DataClassification = SystemMetadata;
        }
        // </adl.10>
        // <adl.18>
        field(13062581; "Goods Return Type-Adl"; Code[10])
        {
            Caption = 'Goods Return Type';
            TableRelation = "Goods Return Type-Adl";
            DataClassification = SystemMetadata;
        }
        // </adl.18>
    }
}