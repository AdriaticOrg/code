tableextension 13062532 "VATEntry-Adl" extends "VAT Entry" //254
{
    fields
    {
        // <adl.10>
        field(13062526; "Postponed VAT-Adl"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Postponed VAT';
            OptionMembers = "Realized VAT","Postponed VAT";
        }
        // </adl.10>
        // <adl.14>
        field(13062592; "VAT Identifier-Adl"; Code[10])
        {
            Caption = 'VAT Identifier';
            DataClassification = CustomerContent;
            TableRelation = "VAT Identifier-Adl";
        }
        // </adl.14>
        // <adl.11>
        field(13062593; "VAT Amount (retro.)-Adl"; Decimal)
        {
            Caption = 'VAT Amount (retro.)';
            DataClassification = CustomerContent;
            BlankZero = true;
        }
        field(13062594; "VAT Base (retro.)-Adl"; Decimal)
        {
            Caption = 'VAT Base (retro.)';
            DataClassification = CustomerContent;
            BlankZero = true;
        }
        // </adl.11>
        // <adl.22>
        field(13062601; "VAT Correction Date"; Date)
        {
            Caption = 'VAT Correction Date';
            DataClassification = ToBeClassified;
        } 
        field(13062602; "EU Customs Procedure"; Boolean)
        {
            Caption = 'EU Customs Procedure';
            DataClassification = ToBeClassified;
        }     
        // </adl.22>         
    }
}