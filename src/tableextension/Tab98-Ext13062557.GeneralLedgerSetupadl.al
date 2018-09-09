tableextension 13062557 "GeneralLedgerSetup-adl" extends "General Ledger Setup" //98
{
    fields
    {
        // <adl.27>
        field(13062731; "Global Posting Resp. Person"; Code[50])
        {
            Caption = 'Global Posting Responsible Person';
            TableRelation = "User Setup"."User ID";
            DataClassification = EndUserIdentifiableInformation;
        }
        field(13062732; "Global Posting Approver"; Code[50])
        {
            Caption = 'Global Posting Approver';
            TableRelation = "User Setup"."User ID";
            DataClassification = EndUserIdentifiableInformation;
        }
        // </adl.27>

    }
}