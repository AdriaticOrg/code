page 13062624 "PDO Setup-Adl"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "PDO Setup-Adl";
    Caption = 'PDO Setup';

    layout
    {
        area(Content)
        {
            group(PDO)
            {
                Caption = 'PDO';
                field("PDO Report No. Series"; "PDO Report No. Series")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies PDO Report No. Series';
                }
                field("PDO Prep. By User ID"; "PDO Prep. By User ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies PDO Prep. By User ID';
                }
                field("PDO Resp. User ID"; "PDO Resp. User ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies PDO Resp. User ID';
                }
                field("PDO VAT Ident. Filter Code "; "PDO VAT Ident. Filter Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies PDO VAT Ident. Filter Code';
                }
            }
        }
    }
}
