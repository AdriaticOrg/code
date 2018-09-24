tableextension 13062791 "Service Header-Adl" extends "Service Header" //5900
{
    fields
    {
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
        // </adl.20>
    }
}