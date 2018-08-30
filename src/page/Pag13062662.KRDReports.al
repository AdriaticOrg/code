page 13062662 "KRD Reports"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "KRD Report Header";
    Editable = false;
    CardPageId = "KRD Report";
    Caption = 'KRD Reports';
    
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
    
    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;
                
                trigger OnAction()
                begin
                    
                end;
            }
        }
    }
}