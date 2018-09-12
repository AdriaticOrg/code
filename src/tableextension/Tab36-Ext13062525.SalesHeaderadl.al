tableextension 13062525 "Sales Header-Adl" extends "Sales Header" //36
{
    fields
    {
        // <adl.6>
        field(13062525; "VAT Date-Adl"; Date)
        {
            Caption = 'VAT Date';
            DataClassification = SystemMetadata;
            trigger OnValidate()
            begin
                if "VAT Date-Adl" <> "Posting Date" then
                    "Postponed VAT-Adl" := "Postponed VAT-Adl"::"Postponed VAT"
                else
                    "Postponed VAT-Adl" := "Postponed VAT-Adl"::"Realized VAT";
            end;
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
            DataClassification = SystemMetadata;
            Caption = 'Postponed VAT';
            OptionMembers = "Realized VAT","Postponed VAT";
        }
        // </adl.10>
        // <adl.18>
        field(13062581; "Goods Return Type-Adl"; Code[10])
        {
            DataClassification = SystemMetadata;
            Caption = 'Goods Return Type';
            TableRelation = "Goods Return Type-Adl";
        }
        // </adl.18>
        // <adl.22>
        field(13062601; "VAT Correction Date-Adl"; Date)
        {
            Caption = 'VAT Correction Date';
            DataClassification = SystemMetadata;
        }
        field(13062602; "EU Customs Procedure-Adl"; Boolean)
        {
            Caption = 'EU Customs Procedure';
            DataClassification = SystemMetadata;
        }
        // </adl.22>    
    }

}