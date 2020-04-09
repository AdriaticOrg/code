tableextension 13062814 "Application Area Setup-Adl" extends "Application Area Setup" //9178
{
    fields
    {
        field(13062812; "VAT-Adl"; Boolean)
        {
            Caption = 'VAT';
            DataClassification = SystemMetadata;
        }
        field(13062816; "FAS-Adl"; Boolean)
        {
            Caption = 'FAS';
            DataClassification = SystemMetadata;
        }
        field(13062817; "KRD-Adl"; Boolean)
        {
            Caption = 'KRD';
            DataClassification = SystemMetadata;
        }
        field(13062818; "BST-Adl"; Boolean)
        {
            Caption = 'BST';
            DataClassification = SystemMetadata;
        }
        field(13062819; "VIES-Adl"; Boolean)
        {
            Caption = 'VIES';
            DataClassification = SystemMetadata;
        }
        field(13062820; "Unpaid Receivables-Adl"; Boolean)
        {
            Caption = 'Unpaid Receivables';
            DataClassification = SystemMetadata;
        }
        field(13062822; "PDO-Adl"; Boolean)
        {
            Caption = 'PDO Enabled';
            DataClassification = SystemMetadata;
        }
        field(13062823; "Forced CreditDebit-Adl"; Boolean)
        {
            Caption = 'Forced Credit/Debit Enabled';
            DataClassification = SystemMetadata;
        }
    }

}
