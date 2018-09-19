tableextension 13062541 "User Setup-Adl" extends "User Setup" //91
{
    fields
    {
        // <adl.24>
        field(13062641; "Reporting Name-Adl"; Text[100])
        {
            Caption = 'Reporting Name';
            DataClassification = EndUserIdentifiableInformation;
        }
        field(13062642; "Reporting Email-Adl"; text[100])
        {
            Caption = 'Reporting Email';
            DataClassification = EndUserIdentifiableInformation;
        }
        field(13062643; "Reporting Position-Adl"; Text[100])
        {
            Caption = 'Reporting Position';
            DataClassification = SystemMetadata;
        }
        field(13062644; "Reporting Phone-Adl"; Text[30])
        {
            Caption = 'Reporting Phone';
            DataClassification = EndUserIdentifiableInformation;
        }
        // </adl.24>
        // <adl.27>
        field(13062731; "Posting Responsible Person-Adl"; Code[50])
        {
            Caption = 'Posting Responsible Person';
            TableRelation = "User Setup"."User ID";
            DataClassification = EndUserIdentifiableInformation;
        }
        field(13062732; "Posting Approver-Adl"; Code[50])
        {
            Caption = 'Posting Approver';
            TableRelation = "User Setup"."User ID";
            DataClassification = EndUserIdentifiableInformation;
        }
        // </adl.27>
        // <adl.20>
        field(13062781;"Operator Tax Number-Adl";Text[30])
        {
            DataClassification = SystemMetadata;            
        }
        // </adl.20>
    }
}