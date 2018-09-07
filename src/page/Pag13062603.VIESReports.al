page 13062603 "VIES Reports"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "VIES Report Header";
    Editable = false;
    CardPageId = "VIES Report";
    Caption = 'VIES Reports';
    
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