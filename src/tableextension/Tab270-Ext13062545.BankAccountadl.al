tableextension 13062545 "BankAccount-adl" extends "Bank Account" //270
{

    fields
    {
        // <adl.24> 
        field(13062641;"FAS Instrument Code";Code[10])
        {
            Caption = 'FAS Instrument Code';
            DataClassification = ToBeClassified;
            TableRelation = "FAS Instrument" where ("Type"=const(Posting));
        }
        field(13062642;"FAS Sector Code";Code[10])
        {
            Caption = 'FAS Sector Code';
            DataClassification = ToBeClassified;
            TableRelation = "FAS Sector" where ("Type"=const(Posting));
        }
        // </adl.24> 
    }
}

