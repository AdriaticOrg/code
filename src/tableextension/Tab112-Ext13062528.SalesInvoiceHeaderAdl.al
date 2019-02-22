tableextension 13062528 "Sales Invoice Header-Adl" extends "Sales Invoice Header" //112
{
    fields
    {
        // <adl.6>
        field(13062525; "VAT Date-Adl"; Date)
        {
            Caption = 'VAT Date';
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
        // <adl.22>
        field(13062602; "EU Customs Procedure-Adl"; Boolean)
        {
            Caption = 'EU Customs Procedure';
            DataClassification = SystemMetadata;
        }
        // </adl.22>      
        // <adl.20>
        field(13062781; "Fisc. Subject-Adl"; Boolean)
        {
            Caption = 'Fisc. Subject';
            DataClassification = SystemMetadata;
        }
        field(13062782; "Fisc. No. Series-Adl"; Code[20])
        {
            Caption = 'Fisc. No. Series';
            TableRelation = "No. Series";
            DataClassification = SystemMetadata;
        }
        field(13062783; "Fisc. Terminal-Adl"; Text[30])
        {
            Caption = 'Fisc. Terminal';
            TableRelation = "Fiscalization Terminal-Adl";
            DataClassification = SystemMetadata;
        }
        field(13062784; "Fisc. Location Code-Adl"; Code[10])
        {
            Caption = 'Fisc. Location Code';
            TableRelation = "Fiscalization Location-Adl";
            DataClassification = SystemMetadata;
        }
        field(13062785; "Full Fisc. Doc. No.-Adl"; Code[20])
        {
            Caption = 'Full Fisc. Doc. No.';
            DataClassification = SystemMetadata;
        }
        field(13062786; "Fisc. Date-Adl"; Date)
        {
            Caption = 'Fisc. Date';
            Editable = false;
            DataClassification = SystemMetadata;
        }
        field(13062787; "Fisc Time-Adl"; Time)
        {
            Caption = 'Fisc Time';
            Editable = false;
            DataClassification = SystemMetadata;
        }
        field(13062788; "Posting TimeStamp-Adl"; DateTime)
        {
            Caption = 'Posting TimeStamp';
            Editable = false;
            DataClassification = SystemMetadata;
        }
        // </adl.20>    
    }
}