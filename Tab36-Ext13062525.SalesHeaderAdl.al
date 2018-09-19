tableextension 13062525 "Sales Header-Adl" extends "Sales Header" //36
{
    fields
    {
        field(13062781;"Fisc. Subject";Boolean)
        {

        }
        field(13062782;"Fisc. No. Series";Code[20])
        {
            TableRelation = "No. Series";
        }
        field(13062783;"Fisc. Terminal";Text[30])
        {
            TableRelation = "Fiscalization Terminal-ADL";
        }
        field(13062784;"Fisc. Location Code";Code[10])
        {
            TableRelation = "Fiscalization Location-ADL";
        }
        field(13062785;"Full Fisc. Doc. No.";Code[20])
        {
            
        }
    }
}

