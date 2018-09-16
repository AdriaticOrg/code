tableextension 13062557 "General Ledger Setup-Adl" extends "General Ledger Setup" //98
{
    fields
    {
        // <adl.27>
        field(13062731; "Global Posting Resp. Person-Adl"; Code[50])
        {
            Caption = 'Global Posting Responsible Person';
            TableRelation = "User Setup"."User ID";
            DataClassification = EndUserIdentifiableInformation;
        }
        field(13062732; "Global Posting Approver-Adl"; Code[50])
        {
            Caption = 'Global Posting Approver';
            TableRelation = "User Setup"."User ID";
            DataClassification = EndUserIdentifiableInformation;
        }
        // </adl.27>

    }
}