table 13062663 "KRD Code-Adl"
{
    DataClassification = SystemMetadata;
    LookupPageId = 13062664;
    Caption = 'KRD Code';

    fields
    {
        field(1; "Type"; Option)
        {
            Caption = 'Type';
            OptionMembers = "Affiliation Type","Instrument Type",Maturity;
            OptionCaption = 'Affiliation Type,Instrument Type,Maturity';
            DataClassification = SystemMetadata;
        }
        field(2; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = SystemMetadata;
        }
        field(3; "Description"; Text[250])
        {
            Caption = 'Description';
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(PK; "Type", "Code")
        {
            Clustered = true;
        }
    }

}