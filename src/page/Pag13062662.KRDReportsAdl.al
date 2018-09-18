page 13062662 "KRD Reports-Adl"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "KRD Report Header-Adl";
    Editable = false;
    CardPageId = "KRD Report-Adl";
    Caption = 'KRD Reports';

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                }
                field("Period Start Date"; "Period Start Date")
                {
                    ApplicationArea = All;
                }
                field("Period End Date"; "Period End Date")
                {
                    ApplicationArea = All;
                }
                field("User ID"; "User ID")
                {
                    ApplicationArea = All;
                }

            }
        }
    }
}