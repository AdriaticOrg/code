tableextension 13062541 "UserSetup-Adl" extends "User Setup" //91
{
    fields
    {
        // <adl.24>
        field(13062641; "Reporting_SI Name-Adl"; Text[100])
        {
            Caption = 'Reporting_SI Name';
            DataClassification = EndUserIdentifiableInformation;
        }
        field(13062642; "Reporting_SI Email-Adl"; text[100])
        {
            Caption = 'Reporting_SI Email';
            DataClassification = EndUserIdentifiableInformation;
        }
        field(13062643; "Reporting_SI Position-Adl"; Text[100])
        {
            Caption = 'Reporting_SI Position';
            DataClassification = SystemMetadata;
        }
        field(13062644; "Reporting_SI Phone-Adl"; Text[30])
        {
            Caption = 'Reporting_SI Phone';
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
    }
}