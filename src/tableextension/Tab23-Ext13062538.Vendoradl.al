tableextension 13062538 "Vendor-adl" extends Vendor //23
{
    fields
    {
        field(13062641;"FAS Sector Code";Code[10])
        {
            Caption = 'FAS Sector Code';
            DataClassification = ToBeClassified;
            TableRelation = "FAS Sector";
        }
        field(13062661;"FAS Non-Residnet Sector Code";Code[10])
        {
            Caption = 'FAS Non-Resident Sector Code';
            DataClassification = ToBeClassified;
            TableRelation = "FAS Sector";
        }
                
    }
}

