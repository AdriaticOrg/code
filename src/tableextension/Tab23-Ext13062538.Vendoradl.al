tableextension 13062538 "Vendor-adl" extends Vendor //23
{
    fields
    {
        // <adl.24>
        field(13062641;"FAS Sector Code";Code[10])
        {
            Caption = 'FAS Sector Code';
            DataClassification = ToBeClassified;
            TableRelation = "FAS Sector";
        }
        // </adl.24>
        // <adl.25>
        field(13062661;"KRD Non-Residnet Sector Code";Code[10])
        {
            Caption = 'KRD Non-Resident Sector Code';
            DataClassification = ToBeClassified;
            TableRelation = "FAS Sector";
        }
        // </adl.25>
    }
}

