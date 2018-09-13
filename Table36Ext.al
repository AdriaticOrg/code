tableextension 13062612 Table36Ext extends "Sales Header"
{
    fields
    {
        field(13051858;"Fisc. Subject";Boolean)
        {

        }
        field(13051859;"Fisc. No. Series";Code[20])
        {
            TableRelation = "No. Series";
        }
        field(13051860;"Fisc. Terminal";Text[30])
        {
            TableRelation = "Fiscalization Terminal-ADL";
        }
        field(13051861;"Fisc. Location Code";Code[10])
        {
            TableRelation = "Fiscalization Location-ADL";
        }
        field(13051863;"Full Fisc. Doc. No.";Code[20])
        {
            
        }
    }
}

