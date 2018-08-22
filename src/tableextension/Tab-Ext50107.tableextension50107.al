tableextension 50107 "tableextension50107" extends Customer 
{
    // version NAVW111.00.00.23572

    fields
    {
        field(50101;"FAS Sector Code";Code[10])
        {
            Caption = 'FAS Sector Code';
            DataClassification = ToBeClassified;
            TableRelation = "FAS Sector";
        }
    }
}

