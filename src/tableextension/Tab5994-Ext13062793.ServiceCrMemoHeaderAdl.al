tableextension 13062793 "Service Cr.Memo Header-Adl" extends "Service Cr.Memo Header" //5994
{
    fields
    // <adl.20>
    {
        field(13062781; "Fisc. Subject-Adl"; Boolean)
        {
            Caption = 'Fisc. Subject';
            Editable = false;
            DataClassification = SystemMetadata;
        }
        field(13062782; "Fisc. No. Series-Adl"; Code[20])
        {
            Caption = 'Fisc. No. Series';
            Editable = false;
            TableRelation = "No. Series";
            DataClassification = SystemMetadata;
        }
        field(13062783; "Fisc. Terminal-Adl"; Text[30])
        {
            Caption = 'Fisc. Terminal';
            Editable = false;
            TableRelation = "Fiscalization Terminal-Adl";
            DataClassification = SystemMetadata;
        }
        field(13062784; "Fisc. Location Code-Adl"; Code[10])
        {
            Caption = 'Fisc. Location Code';
            Editable = false;
            TableRelation = "Fiscalization Location-Adl";
            DataClassification = SystemMetadata;
        }

        field(13062785; "Full Fisc. Doc. No.-Adl"; Code[20])
        {
            Caption = 'Full Fisc. Doc. No.';
            Editable = false;
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