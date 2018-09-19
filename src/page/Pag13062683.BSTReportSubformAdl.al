page 13062683 "BST Report Subform-Adl"
{
    PageType = ListPart;
    UsageCategory = Administration;
    SourceTable = "BST Report Line-Adl";
    AutoSplitKey = true;
    Caption = 'BST Report Subform';

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("BST Code"; "BST Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'TODO: Tooltip - Reporting';
                }
                field("BST Serial No."; "BST Serial No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'TODO: Tooltip - Reporting';
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'TODO: Tooltip - Reporting';
                }
                field("Country/Region Code"; "Country/Region Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'TODO: Tooltip - Reporting';
                }
                field("Country/Region No."; "Country/Region No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'TODO: Tooltip - Reporting';
                }
                field("Income Amount"; "Income Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'TODO: Tooltip - Reporting';
                }
                field("Expense Amount"; "Expense Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'TODO: Tooltip - Reporting';
                }
            }
        }
    }
}