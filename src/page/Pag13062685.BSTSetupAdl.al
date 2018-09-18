page 13062685 "BST Setup-Adl"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "BST Setup-Adl";
    Caption = 'BST Setup';

    layout
    {
        area(Content)
        {
            group(BST)
            {
                Caption = 'BST';
                field("BST Report No. Series"; "BST Report No. Series")
                {
                    ApplicationArea = All;
                }
                field("BST Prep. By User ID"; "BST Prep. By User ID")
                {
                    ApplicationArea = All;
                }
                field("BST Resp. User ID"; "BST Resp. User ID")
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
            action("Adjust BST on Entries")
            {
                Caption = 'Adjust BST on Entries';
                ApplicationArea = All;
                Image = Suggest;

                trigger OnAction()
                begin
                    Report.RunModal(Report::"Adjust BST on Entries-Adl");
                end;
            }
        }
    }
}