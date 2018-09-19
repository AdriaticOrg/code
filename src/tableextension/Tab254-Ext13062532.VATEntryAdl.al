tableextension 13062532 "VAT Entry-Adl" extends "VAT Entry" //254
{
    fields
    {
        // <adl.10>
        field(13062526; "Postponed VAT-Adl"; Option)
        {
            Caption = 'Postponed VAT';
            OptionMembers = "Realized VAT","Postponed VAT";
            DataClassification = SystemMetadata;
        }
        // </adl.10>
        // <adl.14>
        field(13062592; "VAT Identifier-Adl"; Code[10])
        {
            Caption = 'VAT Identifier';
            DataClassification = SystemMetadata;
            TableRelation = "VAT Identifier-Adl";
        }
        // </adl.14>
        // <adl.11>
        field(13062593; "VAT Amount (retro.)-Adl"; Decimal)
        {
            Caption = 'VAT Amount (retro.)';
            DataClassification = SystemMetadata;
            BlankZero = true;
        }
        field(13062594; "VAT Base (retro.)-Adl"; Decimal)
        {
            Caption = 'VAT Base (retro.)';
            DataClassification = SystemMetadata;
            //BlankZero = true;
        }
        field(13062527; "VAT % (retrograde)-Adl"; Decimal)
        {
            Caption = 'VAT % (retrograde)';
            DataClassification = SystemMetadata;
        }
        // </adl.11>
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
        field(13062781; "Full Fisc. Doc. No.-Adl"; Code[20])
        {
            DataClassification = SystemMetadata;
        }
        // </adl.20>  
    }
    keys
    {
        // <adl.22>
        key(VIES; "VAT Identifier-Adl") { }
        // </adl.22>
    }
}