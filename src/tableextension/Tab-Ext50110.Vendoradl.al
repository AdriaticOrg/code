tableextension 50110 "Vendor-adl" extends Vendor 
{
    fields
    {
        field(50101;"FAS Sector Code";Code[10])
        {
            Caption = 'FAS Sector Code';
            DataClassification = ToBeClassified;
            TableRelation = "FAS Sector";
        }
        field(50102;"FAS Non-Residnet Sector Code";Code[10])
        {
            Caption = 'FAS Non-Resident Sector Code';
            DataClassification = ToBeClassified;
            TableRelation = "FAS Sector";
        }
                
    }
}

