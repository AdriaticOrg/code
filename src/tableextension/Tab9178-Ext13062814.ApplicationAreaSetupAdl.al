tableextension 13062814 "Application Area Setup-Adl" extends "Application Area Setup" //9178
{
    fields
    {
        field(13062812; "Adl VAT"; Boolean)
        {
            Caption = 'VAT';
            DataClassification = SystemMetadata;
        }
        field(13062816; "Adl FAS"; Boolean)
        {
            Caption = 'FAS';
            DataClassification = SystemMetadata;
        }
        field(13062817; "Adl KRD"; Boolean)
        {
            Caption = 'KRD';
            DataClassification = SystemMetadata;
        }
        field(13062818; "Adl BST"; Boolean)
        {
            Caption = 'BST';
            DataClassification = SystemMetadata;
        }
        field(13062819; "Adl VIES"; Boolean)
        {
            Caption = 'VIES';
            DataClassification = SystemMetadata;
        }
        field(13062820; "Adl Unpaid Receivables"; Boolean)
        {
            Caption = 'Unpaid Receivables';
            DataClassification = SystemMetadata;
        }
        field(13062822; "Adl PDO"; Boolean)
        {
            Caption = 'PDO Enabled';
            DataClassification = SystemMetadata;
        }
        field(13062823; "Adl Forced CreditDebit"; Boolean)
        {
            Caption = 'Forced Credit/Debit Enabled';
            DataClassification = SystemMetadata;
        }
    }

}
