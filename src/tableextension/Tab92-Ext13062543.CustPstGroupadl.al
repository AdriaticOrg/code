tableextension 13062543 "CustPstGroup-adl" extends "Customer Posting Group" //92
{
    fields {
        // <adl.25>
        field(13062662; "KRD Instrument Type"; Code[10])
        {
            Caption = 'KRD Instrument Type';
            DataClassification = ToBeClassified;
            TableRelation = "KRD Code".Code where ("Type" = const("Instrument Type"));
        }
        field(13062663; "KRD Maturity"; Code[10])
        {
            Caption = 'KRD Maturity';
            DataClassification = ToBeClassified;
            TableRelation = "KRD Code".Code where ("Type" = const(Maturity));
        }        
        field(13062664; "KRD Claim/Liability"; Option)
        {
            OptionMembers = " ","Claim","Liability";
            Caption = 'KRD Claim/Liability';
            DataClassification = ToBeClassified;
        }  
        // </adl.25>      
    }
}