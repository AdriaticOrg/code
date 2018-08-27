table 50126 "VAT Book View Formula-Adl"
{

    Caption = 'VAT Book View Line';
    DrillDownPageID = "VAT Book View Formula-Adl";
    LookupPageID = "VAT Book View Formula-Adl";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "VAT Book Code"; Code[20])
        {
            Caption = 'VAT Book Code';
            TableRelation = "VAT Book-Adl";
            DataClassification = CustomerContent;
        }
        field(2; "VAT Book Group Code"; Code[20])
        {
            Caption = 'VAT Book Group Code';
            NotBlank = true;
            TableRelation = "VAT Book Group-Adl".Code where ("VAT Book Code" = field ("VAT Book Code"));
            DataClassification = CustomerContent;
        }
        field(3; "VAT Identifier"; Code[10])
        {
            Caption = 'VAT Identifier';
            TableRelation = "VAT Book Group Identifier-Adl"."VAT Identifier" where ("VAT Book Code" = field ("VAT Book Code"), "VAT Book Group Code" = field ("VAT Book Group Code"));
            DataClassification = CustomerContent;
        }
        field(4; "Column No."; Integer)
        {
            Caption = 'Column No.';
            MinValue = 1;
            MaxValue = 20;
            DataClassification = CustomerContent;
        }
        field(5; Operator1; Option)
        {
            Caption = 'Operator 1';
            OptionCaption = ' ,+,-';
            OptionMembers = " ", "+", "-";
            DataClassification = CustomerContent;
        }
        field(6; Value1; Option)
        {
            Caption = 'Value 1';
            OptionCaption = ' ,Base Amount,VAT Amount,Amount Inc. VAT,Base Amount(retro.),Unrealizied Base,Unrealized Amount,Unrealized Amount Inc. VAT,VAT Retro,Amount Inc. VAT(retro)';
            OptionMembers = " ", "Base Amount", "VAT Amount", "Amount Inc. VAT", "Base Amount(retro.)", "Unrealizied Base", "Unrealized Amount", "Unrealized Amount Inc. VAT", "VAT Retro", "Amount Inc. VAT(retro)";
            DataClassification = CustomerContent;
        }
        field(7; Operator2; Option)
        {
            Caption = 'Operator 2';
            OptionCaption = ' ,+,-';
            OptionMembers = " ", "+", "-";
            DataClassification = CustomerContent;
        }
        field(8; Value2; Option)
        {
            Caption = 'Value 2';
            OptionCaption = ' ,Base Amount,VAT Amount,Amount Inc. VAT,Base Amount(retro.),Unrealizied Base,Unrealized Amount,Unrealized Amount Inc. VAT,VAT Retro,Amount Inc. VAT(retro)';
            OptionMembers = " ", "Base Amount", "VAT Amount", "Amount Inc. VAT", "Base Amount(retro.)", "Unrealizied Base", "Unrealized Amount", "Unrealized Amount Inc. VAT", "VAT Retro", "Amount Inc. VAT(retro)";
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "VAT Book Code", "VAT Book Group Code", "VAT Identifier", "Column No.") { }
    }
}

