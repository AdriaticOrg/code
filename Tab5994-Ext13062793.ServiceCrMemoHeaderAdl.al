tableextension 13062793 "Service Cr.Memo Header-Adl" extends "Service Cr.Memo Header" //5994
{
    fields
    {
        field(13062781;"Fisc. Subject";Boolean)
        {
            Editable = false;
        }
        field(13062782;"Fisc. No. Series";Code[20])
        {
            Editable = false;
            TableRelation = "No. Series";
        }
        field(13062783;"Fisc. Terminal";Text[30])
        {
            Editable = false;
            TableRelation = "Fiscalization Terminal-ADL";
        }
        field(13062784;"Fisc. Location Code";Code[10])
        {
            Editable = false;
            TableRelation = "Fiscalization Location-ADL";
        }

        field(13062785;"Full Fisc. Doc. No.";Code[20])
        {
            Editable = false;
            
        }
        field(13062786;"Fisc. Date";Date)
        {
            Editable = false;
            
        }
        field(13062787;"Fisc Time";Time)
        {
            Editable = false;
            
        }
        field(13062788;"Posting TimeStamp";DateTime)
        {
            Editable = false;
            
        }
    }
}