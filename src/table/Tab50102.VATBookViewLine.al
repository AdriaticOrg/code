table 50102 "VAT Book View Line"
{

    CaptionML = ENU = 'VAT Book View Line',
                SRM = 'Red prikaza knjige PDV-a';
    DrillDownPageID = "VAT Book View Lines";
    LookupPageID = "VAT Book View Lines";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "VAT Book Code"; Code[20])
        {
            CaptionML = ENU = 'VAT Book Code',
                        SRM = 'Šifra knjige PDV-a';
            TableRelation = "VAT Book";
            DataClassification = CustomerContent;
        }
        field(2; "VAT Book Group Code"; Code[20])
        {
            CaptionML = ENU = 'VAT Book Group Code',
                        SRM = 'Šifra grupe knjige PDV-a';
            NotBlank = true;
            TableRelation = "VAT Book Group".Code where ("VAT Book Code" = field ("VAT Book Code"));
            DataClassification = CustomerContent;
        }
        field(3; "VAT Identifier"; Code[10])
        {
            CaptionML = ENU = 'VAT Identifier',
                        SRM = 'Identifikator za PDV';
            TableRelation = "VAT Book Group Identifier"."VAT Identifier" where ("VAT Book Code" = field ("VAT Book Code"), "VAT Book Group Code" = field ("VAT Book Group Code"));
            DataClassification = CustomerContent;
        }
        field(4; "Column No."; Option)
        {
            CaptionML = ENU = 'Column No.',
                        SRM = 'Br. kolone';
            OptionCaptionML = ENU = '1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20',
                              SRM = '1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20';
            OptionMembers = "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20";
            DataClassification = CustomerContent;
        }
        field(5; Operator1; Option)
        {
            CaptionML = ENU = 'Operator 1',
                        SRM = 'Operator 1';
            OptionCaptionML = ENU = ' ,+,-',
                              SRM = ' ,+,-';
            OptionMembers = " ", "+", "-";
            DataClassification = CustomerContent;
        }
        field(6; Value1; Option)
        {
            CaptionML = ENU = 'Value 1',
                        SRM = 'Vrednost 1';
            OptionCaptionML = ENU = ' ,Base Amount,VAT Amount,Amount Inc. VAT,Base Amount(retro.),Unrealizied Base,Unrealized Amount,Unrealized Amount Inc. VAT,VAT Retro,Amount Inc. VAT(retro)',
                              SRM = ' ,Iznos osnovice,Iznos PDV-a,Iznos sa PDV-om,Iznos osnovice (retro),Nerealizovani iznos osnovice,Nerealizovani iznos,Nerealizovani iznos sa PDV-om,Retro PDV,Iznos osnovice sa pdv (retro)';
            OptionMembers = " ", "Base Amount", "VAT Amount", "Amount Inc. VAT", "Base Amount(retro.)", "Unrealizied Base", "Unrealized Amount", "Unrealized Amount Inc. VAT", "VAT Retro", "Amount Inc. VAT(retro)";
            DataClassification = CustomerContent;
        }
        field(7; Operator2; Option)
        {
            CaptionML = ENU = 'Operator 2',
                        SRM = 'Operator 2';
            OptionCaptionML = ENU = ' ,+,-',
                              SRM = ' ,+,-';
            OptionMembers = " ", "+", "-";
            DataClassification = CustomerContent;
        }
        field(8; Value2; Option)
        {
            CaptionML = ENU = 'Value 2',
                        SRM = 'Vrednost 2';
            OptionCaptionML = ENU = ' ,Base Amount,VAT Amount,Amount Inc. VAT,Base Amount(retro.),Unrealizied Base,Unrealized Amount,Unrealized Amount Inc. VAT,VAT Retro,Amount Inc. VAT(retro)',
                              SRM = ' ,Iznos osnovice,Iznos PDV-a,Iznos sa PDV-om,Iznos osnovice (retro),Nerealizovani iznos osnovice,Nerealizovani iznos,Nerealizovani iznos sa PDV-om,Retro PDV,Iznos osnovice sa pdv (retro)';
            OptionMembers = " ", "Base Amount", "VAT Amount", "Amount Inc. VAT", "Base Amount(retro.)", "Unrealizied Base", "Unrealized Amount", "Unrealized Amount Inc. VAT", "VAT Retro", "Amount Inc. VAT(retro)";
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "VAT Book Code", "VAT Book Group Code", "VAT Identifier", "Column No.") { }
    }
}

