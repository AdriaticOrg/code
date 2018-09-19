page 13062666 "KRD Setup-Adl"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "KRD Setup-Adl";
    Caption = 'KRD Setup';

    layout
    {
        area(Content)
        {
            group(KRD)
            {
                Caption = 'KRD';
                field("KRD Report No. Series"; "KRD Report No. Series")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies KRD Report No. Series';
                }
                field("KRD Resp. User ID"; "KRD Resp. User ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies KRD Resp. User ID';
                }
                field("KRD Prep. By User ID"; "KRD Prep. By User ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies KRD Prep. By User ID';
                }
                field("Default KRD Affiliation Type"; "Default KRD Affiliation Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies Default KRD Affiliation Type';
                }
                field("KRD Blank LCY Code"; "KRD Blank LCY Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies KRD Blank LCY Code';
                }
                field("KRD Blank LCY Num."; "KRD Blank LCY Num.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies KRD Blank LCY Num.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Adjust KRD on Entries")
            {
                Caption = 'Adjust KRD on Entries';
                ApplicationArea = All;
                Image = Suggest;

                trigger OnAction()
                begin
                    Report.RunModal(Report::"Adjust KRD on Entries-Adl");
                end;
            }
        }
    }
}
