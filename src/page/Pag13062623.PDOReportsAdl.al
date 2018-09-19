page 13062623 "PDO Reports-Adl"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "PDO Report Header-Adl";
    Editable = false;
    CardPageId = "PDO Report-Adl";
    Caption = 'PDO Reports';

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