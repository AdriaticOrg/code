tableextension 13062612 Table36Ext extends "Sales Header"
{
    fields
    {
        field(13062525;"Fisc. Subject";Boolean)
        {

        }
        field(13062526;"Fisc. No. Series";Code[20])
        {
            TableRelation = "No. Series";
        }
        field(13062527;"Fisc. Terminal";Text[30])
        {
            TableRelation = "Fiscalization Terminal-ADL";
        }
        field(13062528;"Fisc. Location Code";Code[10])
        {
            TableRelation = "Fiscalization Location-ADL";
        }
        field(13062529;"Full Fisc. Doc. No.";Code[20])
        {
            
        }
    }
}

