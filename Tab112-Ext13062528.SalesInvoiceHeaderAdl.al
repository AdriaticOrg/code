tableextension 13062528 "Sales Invoice Header-Adl" extends "Sales Invoice Header" //112
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
        field(13062786;"Fisc. Date-Adl";Date)
        {
            Editable = false;
            DataClassification = SystemMetadata;            
        }
        field(13062787;"Fisc Time-Adl";Time)
        {
            Editable = false;
            DataClassification = SystemMetadata;            
        }
        field(13062788;"Posting TimeStamp-Adl";DateTime)
        {
            Editable = false;
            DataClassification = SystemMetadata;            
        }
        // </adl.20>    
    }
}