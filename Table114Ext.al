tableextension 13062616 Table114Ext extends "Sales Cr.Memo Header"
{
    fields
    {
        field(13051858;"Fisc. Subject";Boolean)
        {
            Editable = false;

        }
        field(13051859;"Fisc. No. Series";Code[20])
        {
            Editable = false;
            TableRelation = "No. Series";
        }
        field(13051860;"Fisc. Terminal";Text[30])
        {
            Editable = false;
            TableRelation = "Fiscalization Terminal-ADL";
        }
        field(13051861;"Fisc. Location Code";Code[10])
        {
            Editable = false;
            TableRelation = "Fiscalization Location-ADL";
        }

        field(13051863;"Full Fisc. Doc. No.";Code[20])
        {
            Editable = false;
            
        }
        field(13051864;"Fisc. Date";Date)
        {
            Editable = false;
            
        }
        field(13051865;"Fisc Time";Time)
        {
            Editable = false;
            
        }
        field(13051866;"Posting TimeStamp";DateTime)
        {
            Editable = false;
            
        }
    }
}