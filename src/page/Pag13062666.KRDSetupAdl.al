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
                }
                field("KRD Resp. User ID"; "KRD Resp. User ID")
                {
                    ApplicationArea = All;
                }
                field("KRD Prep. By User ID"; "KRD Prep. By User ID")
                {
                    ApplicationArea = All;
                }
                field("Default KRD Affiliation Type"; "Default KRD Affiliation Type")
                {
                    ApplicationArea = All;
                }
                field("KRD Blank LCY Code"; "KRD Blank LCY Code")
                {
                    ApplicationArea = All;
                }
                field("KRD Blank LCY Num."; "KRD Blank LCY Num.")
                {
                    ApplicationArea = All;
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