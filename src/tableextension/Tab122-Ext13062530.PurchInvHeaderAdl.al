tableextension 13062530 "Purch. Inv. Header-Adl" extends "Purch. Inv. Header"  //122
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
            OptionCaption = 'Realized VAT,Postponed VAT';
            DataClassification = SystemMetadata;
        }
        // </adl.10>
    }
}