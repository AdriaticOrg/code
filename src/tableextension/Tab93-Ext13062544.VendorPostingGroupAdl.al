tableextension 13062544 "Vendor Posting Group-Adl" extends "Vendor Posting Group" //93
{
    fields
    {
        // <adl.25> 
        field(13062662; "KRD Instrument Type-Adl"; Code[10])
        {
            Caption = 'KRD Instrument Type';
            DataClassification = SystemMetadata;
            TableRelation = "KRD Code-Adl".Code where ("Type" = const ("Instrument Type"));
        }
        field(13062663; "KRD Maturity-Adl"; Code[10])
        {
            Caption = 'KRD Maturity';
            DataClassification = SystemMetadata;
            TableRelation = "KRD Code-Adl".Code where ("Type" = const (Maturity));
        }
        field(13062664; "KRD Claim/Liability-Adl"; Option)
        {
            OptionMembers = " ","Claim","Liability";
            Caption = 'KRD Claim/Liability';
            DataClassification = SystemMetadata;
        }
        // </adl.25>
    }
}