tableextension 13062529 "Customer-adl" extends Customer 
{
    fields
    {
        field(13062641;"FAS Sector Code";Code[10])
        {
            Caption = 'FAS Sector Code';
            DataClassification = ToBeClassified;
            TableRelation = "FAS Sector";
        }
        field(13062661;"KRD Non-Residnet Sector Code";Code[10])
        {
            Caption = 'KRD Non-Resident Sector Code';
            DataClassification = ToBeClassified;
            TableRelation = "FAS Sector";
        }
    }
}

