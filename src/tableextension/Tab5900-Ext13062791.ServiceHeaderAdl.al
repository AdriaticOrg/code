tableextension 13062791 "Service Header-Adl" extends "Service Header" //5900
{
    fields
    {
        // <adl.20>
        field(13062781;"Fisc. Subject-Adl";Boolean)
        {
            DataClassification = SystemMetadata;
        }
        field(13062782;"Fisc. No. Series-Adl";Code[20])
        {
            TableRelation = "No. Series";
            DataClassification = SystemMetadata;
        }
        field(13062783;"Fisc. Terminal-Adl";Text[30])
        {
            TableRelation = "Fiscalization Terminal-ADL";
            DataClassification = SystemMetadata;
        }
        field(13062784;"Fisc. Location Code-Adl";Code[10])
        {
            TableRelation = "Fiscalization Location-ADL";
            DataClassification = SystemMetadata;
        }

        field(13062785;"Full Fisc. Doc. No.-Adl";Code[20])
        {
            DataClassification = SystemMetadata;
        }
        // </adl.20>
    }
}