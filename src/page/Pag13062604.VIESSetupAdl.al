page 13062604 "VIES Setup-Adl"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "VIES Setup-Adl";
    Caption = 'VIES  Setup';

    layout
    {
        area(Content)
        {
            group(VIES)
            {
                Caption = 'VIES';
                field("Default VIES Country"; "Default VIES Country")
                {
                    ApplicationArea = All;
                }
                field("Default VIES Type"; "Default VIES Type")
                {
                    ApplicationArea = All;
                    Editable = "Default VIES Country" = "Default VIES Country"::Croatia;
                }
                field("VIES Company Branch Code"; "VIES Company Branch Code")
                {
                    ApplicationArea = All;
                }
                field("VIES Report No. Series"; "VIES Report No. Series")
                {
                    ApplicationArea = All;
                }
                field("VIES Prep. By User ID"; "VIES Prep. By User ID")
                {
                    ApplicationArea = All;
                }
                field("VIES Resp. User ID"; "VIES Resp. User ID")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}