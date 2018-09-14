tableextension 13062615 Table112Ext extends "Sales Invoice Header"
{
    fields
    {
        field(13062525;"Fisc. Subject";Boolean)
        {
            Editable = false;
        }
        field(13062526;"Fisc. No. Series";Code[20])
        {
            Editable = false;
            TableRelation = "No. Series";
        }
        field(13062527;"Fisc. Terminal";Text[30])
        {
            Editable = false;
            TableRelation = "Fiscalization Terminal-ADL";
        }
        field(13062528;"Fisc. Location Code";Code[10])
        {
            Editable = false;
            TableRelation = "Fiscalization Location-ADL";
        }

        field(13062529;"Full Fisc. Doc. No.";Code[20])
        {
            Editable = false;
            
        }
        field(13062530;"Fisc. Date";Date)
        {
            Editable = false;
            
        }
        field(13062531;"Fisc Time";Time)
        {
            Editable = false;
            
        }
        field(13062532;"Posting TimeStamp";DateTime)
        {
            Editable = false;
            
        }
    }
}