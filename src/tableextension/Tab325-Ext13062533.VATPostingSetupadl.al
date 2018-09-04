tableextension 13062533 "VATPostingSetup-Adl" extends "VAT Posting Setup"  //325
{
    fields
    {
        // <adl.10>
        field(13062525; "Purch VAT Postponed Account-Adl"; Code[20])
        {
            Caption = 'Purch VAT Postponed Account';
        }
        field(13062526; "Sales VAT Postponed Account-Adl"; Code[20])
        {
            Caption = 'Sales VAT Postponed Account';
        }
        field(13062551; "VAT % (informative)-Adl"; Decimal)
        {
            Caption = 'VAT % (informative)';
        }
        // </adl.10>
        // <adl.22>
        field(13062601; "VIES Goods Sales"; Boolean)
        {
            Caption = 'VIES Goods Sales';
            DataClassification = ToBeClassified;
        }
        field(13062602; "VIES Service Sales"; Boolean)
        {
            Caption = 'VIES Service Sales';
            DataClassification = ToBeClassified;
        }                
        // </adl.22>          
    }
}