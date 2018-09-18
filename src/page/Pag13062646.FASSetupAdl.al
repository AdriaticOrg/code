page 13062646 "FAS Setup-Adl"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "FAS Setup-Adl";
    Caption = 'FAS Setup';

    layout
    {
        area(Content)
        {
            group(FAS)
            {
                Caption = 'FAS';
                field("FAS Report No. Series"; "FAS Report No. Series")
                {
                    ApplicationArea = All;
                }
                field("FAS Resp. User ID"; "FAS Resp. User ID")
                {
                    ApplicationArea = All;
                }
                field("FAS Prep. By User ID"; "FAS Prep. By User ID")
                {
                    ApplicationArea = All;
                }
                field("FAS Director User ID"; "FAS Director User ID")
                {
                    ApplicationArea = All;
                }
                field("Budget User Code"; "Budget User Code")
                {
                    ApplicationArea = All;
                }
                field("Company Sector Code"; "Company Sector Code")
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
            action("Adjust FAS on Entries")
            {
                Caption = 'Adjust FAS on Entries';
                ApplicationArea = All;
                Image = Suggest;

                trigger OnAction()
                begin
                    report.RunModal(Report::"Adjust FAS on Entries-Adl");
                end;
            }
        }
    }
}