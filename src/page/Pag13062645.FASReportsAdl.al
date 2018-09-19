page 13062645 "FAS Reports-Adl"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "FAS Report Header-Adl";
    Editable = false;
    CardPageId = "FAS Report-Adl";
    Caption = 'FAS Reports';

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'TODO: Tooltip - Reporting';
                }
                field("Period Start Date"; "Period Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'TODO: Tooltip - Reporting';
                }
                field("Period End Date"; "Period End Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'TODO: Tooltip - Reporting';
                }
                field("User ID"; "User ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'TODO: Tooltip - Reporting';
                }

            }
        }
    }
}