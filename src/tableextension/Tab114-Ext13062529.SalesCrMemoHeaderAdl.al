tableextension 13062529 "Sales Cr.Memo Header-Adl" extends "Sales Cr.Memo Header" //114
{
    fields
    {
        // <adl.6>
        field(13062525; "VAT Date-Adl"; Date)
        {
            Caption = 'VAT Date';
            DataClassification = SystemMetadata;
        }
        // </adl.6>
        // <adl.10>
        field(13062526; "Postponed VAT-Adl"; Option)
        {
            Caption = 'Postponed VAT';
            DataClassification = SystemMetadata;
            OptionMembers = "Realized VAT","Postponed VAT";
        }
        // </adl.10>
        // <adl.18>
        field(13062581; "Goods Return Type-Adl"; Code[10])
        {
            DataClassification = SystemMetadata;
            Caption = 'Goods Return Type';
            TableRelation = "Goods Return Type-Adl";
        }
        // </adl.18>
        // <adl.22>
        field(13062601; "VAT Correction Date-Adl"; Date)
        {
            Caption = 'VAT Correction Date';
            DataClassification = SystemMetadata;
        }
        field(13062602; "EU Customs Procedure-Adl"; Boolean)
        {
            Caption = 'EU Customs Procedure';
            DataClassification = SystemMetadata;
        }
        // </adl.22>    
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