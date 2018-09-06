page 13062623 "PDO Reports"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "PDO Report Header";
    Editable = false;
    CardPageId = "PDO Report";
    Caption = 'PDO Reports';
    
    layout
    {
        area(Content)
        {
            repeater(Group) {
                field("No.";"No.") {
                    ApplicationArea = All;
                }
                field("Period Start Date";"Period Start Date") {
                    ApplicationArea = All;
                }
                field("Period End Date";"Period End Date") {
                    ApplicationArea = All;
                }
                field("User ID";"User ID") {
                    ApplicationArea = All;
                }

            }
        }
    }    
}